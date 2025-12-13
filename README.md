<!-- Don't delete it -->
<div name="readme-top"></div>

<!-- Organization Logo -->
<div align="center" style="display: flex; align-items: center; justify-content: center; gap: 16px;">
  <img alt="Stability Nexus" src="public/stability.svg" width="175">
  <img alt="FairFund Logo" src="public/todo-project-logo.svg" width="175" />
</div>

&nbsp;

<div align="center">

[![Static Badge](https://img.shields.io/badge/Stability_Nexus-FairFund-228B22?style=for-the-badge&labelColor=FFC517)](https://fairfund.stability.nexus/)

</div>

<p align="center">
<a href="https://t.me/StabilityNexus"><img src="https://img.shields.io/badge/Telegram-black?style=flat&logo=telegram&logoColor=white&color=24A1DE"/></a>
&nbsp;&nbsp;
<a href="https://x.com/StabilityNexus"><img src="https://img.shields.io/twitter/follow/StabilityNexus"/></a>
&nbsp;&nbsp;
<a href="https://discord.gg/7jS9qJNjJv"><img src="https://img.shields.io/discord/995968619034984528?style=flat&logo=discord&logoColor=white&label=Discord&labelColor=5865F2&color=57F287"/></a>
&nbsp;&nbsp;
<a href="https://news.stability.nexus/"><img src="https://img.shields.io/badge/Medium-black?style=flat&logo=medium&color=white"/></a>
&nbsp;&nbsp;
<a href="https://linkedin.com/company/stability-nexus"><img src="https://img.shields.io/badge/LinkedIn-black?style=flat&logo=LinkedIn&color=0A66C2"/></a>
&nbsp;&nbsp;
<a href="https://www.youtube.com/@StabilityNexus"><img src="https://img.shields.io/youtube/channel/subscribers/UCZOG4YhFQdlGaLugr_e5BKw?style=flat&logo=youtube&labelColor=FF0000&color=FF0000"/></a>
</p>

---

<div align="center">
<h1>FairFund – Blockchain-based Community Funding Platform</h1>
</div>

FairFund is a blockchain-based platform for community-driven funding.  
Users can deploy funding vaults, deposit funds, vote on proposals, and distribute funds in a decentralized manner.  

---

# 📚 Table of Contents

1. [Introduction](#introduction)  
2. [Technology Stack](#technology-stack)  
3. [Architecture](#architecture)  
4. [Run Locally](#run-locally)  
5. [Usage Guide](#usage-guide)  
6. [Smart Contract Documentation](#smart-contract-documentation)  
7. [Deployment](#deployment)  
8. [Future Improvements](#future-improvements)  
9. [Contributing](#contributing)  
10. [Community](#community)

---

## 📝 Introduction

FairFund is a blockchain-based platform for community-driven funding.  
Users can:

- Deploy funding vaults  
- Deposit and lock funds  
- Create proposals  
- Vote and determine fund distribution  
- Withdraw results transparently  

The platform uses a decentralized voting mechanism to decide which proposals receive funding.

---

## 🛠 Technology Stack

- **Frontend:** Next.js, TailwindCSS, ShadCN UI  
- **Backend:** Next.js API Routes, Prisma ORM, NextAuth, SIWE, Web3Modal  
- **Blockchain:** Foundry, Solidity  
- **Database:** PostgreSQL  
- **Tools:** Wagmi, Viem, React Hook Form  

---

## 🏗 Architecture

![fairfund 1](https://github.com/user-attachments/assets/ce0e7792-2e29-4a8a-8102-880d3974fab0)

---

# 🧪 Run Locally

## Prerequisites

1. **Foundry Setup**  
   Install using: https://getfoundry.sh/

2. **Node.js Setup**  
   Guide: https://nodejs.org/en/learn/getting-started/introduction-to-nodejs

3. **Docker Setup**  
   Guide: https://docs.docker.com/get-started/introduction/

---
### Smart Contracts

1. **Navigate to the Blockchain Directory**:

   ```bash
   cd app/blockchain
   ```

2. **Install Dependencies**:

   ```bash
   forge install
   ```

3. **Run Tests**:

   ```bash
   forge test
   ```

4. **Run Local Anvil Chain**:

   ```bash
   anvil
   ```

5. **Deploy Mock Smart Contracts**:

   ```bash
   make mock-all
   ```

   Note: This will automatically update relevant contract addresses and ABIs for smart contract in web-app folder.

6. **Deploy to the Testnet**: (Optional)
   - Ensure you have a `.env` file set up. You can use `.env.example` as a template.
   - Load the environment variables:
   ```bash
   source .env
   ```
   - Deploy the contract:
   ```bash
   make deploy-sepolia
   ```

### Frontend 

1. **Navigate to the Web App Directory**:

   ```bash
   cd app/web-app
   ```

2. **Install Dependencies**:

   ```bash
   npm install
   ```

3. **Update the environment variables**:
   Create a `.env` file in the `web-app` directory and add all the values. You can use `.env.example` as a template.

   PostgreSQL:

   - If using Docker (with the provided docker-compose.yml), the defaults provided for `POSTGRES_PRISMA_URL` and `POSTGRES_URL_NON_POOLING` provided in .env.example will work.
   - If using a local instance of PostgreSQL, update the `POSTGRES_PRISMA_URL` and `POSTGRES_URL_NON_POOLING` with the correct connection url for the local postgreSQL.

   NextAuth:
   - Generate a secure `NEXTAUTH_SECRET` by running the following command in the terminal

   ```bash
   openssl rand -base64 32
   ```

   - For local development `NEXTAUTH_URL` will be `http://localhost:3000`

5. **To start local instance of postgreSQL database (with docker)**:


   1. Start docker desktop
   2. Run `docker compose up`


6. **Run the Development Server**:


   ```bash
   npm run dev
   ```


7. **Access the Web App**:

   - Open your browser and navigate to `http://localhost:3000`.

## Usage Guide

Our platform supports three types of users: Vault Creators, Proposal Creators, and Voters/Community Members. Here's how each user type can navigate and use the application:

### Vault Creators

https://github.com/user-attachments/assets/16922ace-8cf9-4558-9efe-3829d166e34a

1. **Getting Started**

   - On the landing page, click "Get Started" to access the dashboard
   - Connect your wallet and sign in with Ethereum

2. **Creating a Vault**

   - Click the "Create" button and select "Vault" from the dropdown
   - Choose a space for your vault (multiple vaults can exist in one space)
   - Enter the vault description, token configurations, and funding parameters
   - Review and submit the proposal (requires a wallet transaction)

3. **Optional: Add Funds**

   - After creation, you can immediately add funds to your vault

4. **Vault Management**
   - You'll be redirected to the vault page to view all details

### Proposal Creators

https://github.com/user-attachments/assets/d0ce617f-1ef3-493f-bd53-d1d238027ae6

1. **Getting Started**

   - On the landing page, click "Get Started" to access the dashboard
   - Connect your wallet and sign in with Ethereum

2. **Creating a Proposal**

   - Click the "Create" button and select "Proposal" from the dropdown
   - Search and select the vault you want to create a proposal for
   - Enter the proposal description, minimum and maximum request amounts, and recipient address
   - Review the information and submit

3. **Tracking Proposals**
   - View your created proposals in the "My Activity" page or on the vault details page

### Voters/Community Members

https://github.com/user-attachments/assets/39f4fc81-ac3a-4ec2-9aa3-21594a1eb1e5

1. **Accessing Vaults**

   - On the landing page, click "Get Started" to access the dashboard
   - Click "Spaces" in the navbar to view available spaces
   - Select a space and then choose a vault within that space

2. **Participating in a Vault**

   - On the vault page, register to vote
   - Deposit tokens for distribution
   - Create new proposals (if desired)
   - After the tally date, withdraw remaining funds (if applicable)

3. **Viewing Results**
   - After the tally date, results page will be accessible to view the distribution statistics and other vault-related information

## Smart Contract Documentation

Smart contract documentation can be found [here](/app/blockchain/README.md).

## Deployment

### Test Deployed Instances

- **Smart Contract**: 
   - Mainnets
      - [Polygon Mainnet](https://polygonscan.com/address/0xb6dc3af544303f41478821c0dfb9af57c278cb34)
   - Testnets
      - [ETC Mordor](https://etc-mordor.blockscout.com/address/0x0533670C3CEdbC6c36E0e567265575e15d499ebC)
      - [Polygon Amoy](https://www.oklink.com/amoy/address/0xf4aaaad23abe965ae584d98a95f5802dc142f32d)
- **Frontend**: [FairFund](https://fairfund.stability.nexus)

## Future Improvements

- Add support for multiple blockchains
- Audit smart contracts
- Refactor smart contracts for better readability and extensibility. [detailed issue](https://github.com/StabilityNexus/FairFund/issues/35)
- Implement functionality to sponser gas for voting and proposal creation
- Optimize smart contracts further
- Add comments functionality on proposals page
- Enable editing of space, proposal, and vault descriptions
- Implement moderation functionality for spaces (control who can create vaults and proposals)
- Add ability to delegate moderation functionality to users other than creator of the space
- Implement various fund distribution mechanisms

We welcome additional suggestions! Join our Discord: [Discord Link](https://discord.gg/7jS9qJNjJv)

## Contributing

1. Create an issue on GitHub
2. Discuss your ideas on our project's Discord channel `(#fairfund)` in [Stability Nexus Server](https://discord.gg/7jS9qJNjJv) (if required).
3. Wait for the issue to be assigned to you
4. Fork the repository
5. Set up the project locally using this [Run Locally Guide](#run-locally)
6. Create a new branch following this format: `type/brief-description`
   - Types: `fix`, `feat`, `chore`, `perf`, or `refactor`
   - Example: `feat/add-space-moderation-functionality`
7. Switch to the new branch
8. Make your changes
9. Commit your changes
10. Decide on the scope of the change:  
   - **Small changes** (minor fixes, documentation updates, small UI tweaks) → **Make a pull request directly to `main`**  
   - **Big changes** (new features, major refactors) → **Make a pull request to `develop`** branch
11. Provide a detailed description of your changes in the PR, including videos and images for visible UI changes.


### Important Guidelines

#### Code Quality and Testing
- Take your time to create high-quality PRs - do not commit code hastily
- Ensure all changes are thoroughly tested before submission
- Avoid introducing code smells
- Do not submit untested code as it complicates the review process
- Only include code in the commit that is intentional. Avoid using `git add .` to prevent unintended changes from being committed.

#### Pull Request Rules
- Small frontend changes (< 20 lines) or documentation updates can be submitted without prior assignment
- Unassigned PRs will be closed without review
- Check existing issues and PRs to avoid duplicating efforts
- Tag the maintainer if your PR is unattended for:
  - 1 week for small contributions
  - 2 weeks for larger contributions

#### Timeline and Progress
- Issues should be completed within:
  - 5 days for small tasks
  - 15 days for complex tasks
- Provide regular progress updates in issue/PR comments if work extends beyond expected timeline
- Issues may be reassigned if not completed within the specified timeframe

### Need Help?
If you have questions or need clarification, please ask on [Discord](https://discord.gg/7jS9qJNjJv).

## Community

- [Stability Nexus](https://docs.stability.nexus/)
- [AOSSIE](https://aossie.org/about)

© 2025 The Stable Order


