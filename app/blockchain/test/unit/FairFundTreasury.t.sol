// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import {Test, console} from "forge-std/Test.sol";
import {FairFundTreasury} from "../../src/FairFundTreasury.sol";
import {MockERC20} from "../../src/mocks/MockERC20.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import {DeployMockERC20} from "../../script/mocks/DeployMockERC20.s.sol";

contract FairFundTreasuryTest is Test {
    FairFundTreasury treasury;
    MockERC20 mockToken;

    address[] payees;
    uint256[] shares = [1, 1];
    address alice = address(0x1);
    address bob = address(0x2);

    event PayeeAdded(address account, uint256 shares);
    event PaymentReleased(address to, uint256 amount);
    event ERC20PaymentReleased(IERC20 indexed token, address to, uint256 amount);
    event PaymentReceived(address from, uint256 amount);

    function setUp() public {
        DeployMockERC20 deployMockERC20 = new DeployMockERC20();
        payees.push(alice);
        payees.push(bob);
        (mockToken,) = deployMockERC20.run();
        treasury = new FairFundTreasury(payees, shares);
        vm.deal(address(treasury), 10 ether);
        mockToken.mint(address(treasury), 1000e18);
    }

    // Constructor Tests
    function testRevertsIfPayeesSharesLengthMismatch() public {
        address[] memory invalidPayees = new address[](1);
        uint256[] memory invalidShares = new uint256[](2);
        vm.expectRevert(FairFundTreasury.FairFundTreasury__PayeesAndSharesLengthMismatch.selector);
        new FairFundTreasury(invalidPayees, invalidShares);
    }

    function testRevertsIfNoPayees() public {
        address[] memory emptyPayees;
        uint256[] memory emptyShares;
        vm.expectRevert(FairFundTreasury.FairFundTreasury__NoPayees.selector);
        new FairFundTreasury(emptyPayees, emptyShares);
    }

    // Payee Management Tests
    function testInitialSharesDistribution() public view {
        assertEq(treasury.totalShares(), 2);
        assertEq(treasury.shares(alice), 1);
        assertEq(treasury.shares(bob), 1);
    }

    // ETH Payment Tests
    function testEthRelease() public {
        uint256 initialBalance = alice.balance;
        vm.prank(alice);
        treasury.release(payable(alice));

        assertEq(alice.balance - initialBalance, 5 ether);
        assertEq(treasury.released(alice), 5 ether);
        assertEq(treasury.totalReleased(), 5 ether);
    }

    function testRevertsIfNoSharesOrPaymentDue() public {
        vm.expectRevert(FairFundTreasury.FairFundTreasury__AccountHasNoShares.selector);
        treasury.release(payable(address(0x3)));

        vm.prank(alice);
        treasury.release(payable(alice)); // First release
        vm.expectRevert(FairFundTreasury.FairFundTreasury__AccountIsNotDuePayment.selector);
        vm.prank(alice);
        treasury.release(payable(alice)); // Second attempt
    }

    // ERC20 Payment Tests
    function testERC20Release() public {
        uint256 initialBalance = mockToken.balanceOf(alice);
        vm.prank(alice);
        treasury.release(mockToken, alice);

        assertEq(mockToken.balanceOf(alice) - initialBalance, 500e18);
        assertEq(treasury.released(mockToken, alice), 500e18);
        assertEq(treasury.totalReleased(mockToken), 500e18);
    }

    function testPaymentReleasedEvent() public {
        vm.expectEmit(true, false, false, false);
        emit PaymentReleased(alice, 5 ether);
        vm.prank(alice);
        treasury.release(payable(alice));
    }

    // Edge Cases
    function testMultipleFundingDeposits() public {
        vm.deal(address(treasury), address(treasury).balance + 10 ether); // Additional 10 ETH
        vm.prank(alice);
        treasury.release(payable(alice));
        assertEq(alice.balance, 10 ether); // 5 + 5 from two deposits
    }

    function testPartialWithdrawals() public {
        vm.prank(alice);
        treasury.release(payable(alice)); // Withdraw 5 ETH
        vm.deal(address(treasury), address(treasury).balance + 5 ether); // New deposit
        vm.prank(alice);
        treasury.release(payable(alice)); // Withdraw 2.5 ETH
        assertEq(alice.balance, 7.5 ether);
    }

    function testReceivedFunctionEmitsEvent() public {
        vm.deal(alice, 1 ether);
        vm.prank(alice);
        vm.deal(address(this), 1 ether);
        vm.expectEmit(false, false, false, true);
        emit PaymentReceived(alice, 1 ether);
        (bool success, ) = address(treasury).call{value: 1 ether}("");

        assertTrue(success);
    }

    function testGetPayeeByIndex() public {
        address firstPayee = treasury.payee(0);
        address secondPayee = treasury.payee(1);

        assertEq(firstPayee, alice);
        assertEq(secondPayee, bob);
    }

    function testReleasableReturnsAmount() public {
        uint256 releasableForAlice = treasury.releasable(alice);

        assertEq(releasableForAlice, 5 ether);
    }

    function testReleasableERC20ReturnsAmount() public {
        uint256 releasableForAlice = treasury.releasable(mockToken, alice);

        assertEq(releasableForAlice, 500e18);
    }

    function testRevertWhenAccountHasNoShares_ERC20() public {
        address randomUser = address(0x3);
        vm.expectRevert(FairFundTreasury.FairFundTreasury__AccountHasNoShares.selector);
        treasury.release(mockToken, randomUser);
    }

    function testRevertWhenNoPaymentDue_ERC20() public {
        vm.prank(alice);
        treasury.release(mockToken, alice);

        vm.prank(alice);
        vm.expectRevert(FairFundTreasury.FairFundTreasury__AccountIsNotDuePayment.selector);
        treasury.release(mockToken, alice);
    }

    function testRevertIfPayeeIsZeroAddress() public {
        address[] memory _payees = new address[](1);
        uint256[] memory _shares = new uint256[](1);
        _payees[0] = address(0);
        _shares[0] = 1;
        vm.expectRevert(FairFundTreasury.FairFundTreasury__AccountIsTheZeroAddress.selector);
        new FairFundTreasury(_payees, _shares);
    }

    function testRevertIfZeroShares() public {
        address[] memory _payees = new address[](1);
        uint256[] memory _shares = new uint256[](1);
        _payees[0] = alice;
        _shares[0] = 0;
        vm.expectRevert(FairFundTreasury.FairFundTreasury__SharesAreZero.selector);
        new FairFundTreasury(_payees, _shares);
    }

    function testRevertIfAccountAlredyHasShares() public {
        address[] memory _payees = new address[](2);
        uint256[] memory _shares = new uint256[](2);
        _payees[0] = alice;
        _payees[1] = alice;
        _shares[0] = 1;
        _shares[1] = 1;
        vm.expectRevert(FairFundTreasury.FairFundTreasury__AccountAlreadyHasShares.selector);
        new FairFundTreasury(_payees, _shares);
    }
}