# Decentralized Security Access Control System

A comprehensive blockchain-based security access control system built with Clarity smart contracts for the Stacks blockchain. This system provides secure, transparent, and auditable access control for facilities with emergency override capabilities.

## 🏗️ System Architecture

The system consists of five interconnected smart contracts:

### 1. Facility Verification Contract (`facility-verification.clar`)
- **Purpose**: Validates and manages secure facilities
- **Key Features**:
    - Register new facilities with security levels (1-5)
    - Verify facilities through authorized personnel
    - Track facility ownership and metadata
    - Location and security level management

### 2. Access Management Contract (`access-management.clar`)
- **Purpose**: Manages facility access control permissions
- **Key Features**:
    - Grant/revoke access permissions
    - Set facility managers
    - Permission levels (1-3) with expiration
    - Time-based access control

### 3. Credential Verification Contract (`credential-verification.clar`)
- **Purpose**: Verifies access credentials and identity
- **Key Features**:
    - Issue digital credentials
    - Verify credential validity
    - Revoke compromised credentials
    - Authorized issuer management

### 4. Audit Trail Contract (`audit-trail.clar`)
- **Purpose**: Maintains comprehensive access control audit trails
- **Key Features**:
    - Log all access attempts
    - Track permission changes
    - Immutable audit records
    - Authorized logger system

### 5. Emergency Override Contract (`emergency-override.clar`)
- **Purpose**: Manages emergency access overrides
- **Key Features**:
    - Create time-limited emergency overrides
    - Multi-level emergency authorities
    - Single-use override tokens
    - Comprehensive override tracking

## 🚀 Getting Started

### Prerequisites
- Stacks blockchain node or testnet access
- Clarity CLI tools
- Node.js and npm for testing

### Installation

1. Clone the repository:
   \`\`\`bash
   git clone <repository-url>
   cd security-access-control
   \`\`\`

2. Install dependencies:
   \`\`\`bash
   npm install
   \`\`\`

3. Run tests:
   \`\`\`bash
   npm test
   \`\`\`

### Deployment

Deploy contracts to Stacks testnet:
\`\`\`bash
clarinet deploy --testnet
\`\`\`

## 📋 Usage Examples

### Register a New Facility
\`\`\`clarity
(contract-call? .facility-verification register-facility
"Main Office"
"123 Business St, City"
u3)
\`\`\`

### Grant Access Permission
\`\`\`clarity
(contract-call? .access-management grant-access
'SP1234...USER
u1
u2
u1000)
\`\`\`

### Issue a Credential
\`\`\`clarity
(contract-call? .credential-verification issue-credential
0x1234...
'SP1234...USER
u1
u5000
"Employee ID Card")
\`\`\`

### Create Emergency Override
\`\`\`clarity
(contract-call? .emergency-override create-emergency-override
u1
"Fire emergency evacuation"
u100)
\`\`\`

## 🔒 Security Features

- **Multi-layered Access Control**: Combines facility verification, credentials, and permissions
- **Time-based Permissions**: All access grants have expiration times
- **Immutable Audit Trail**: All actions are permanently recorded
- **Emergency Protocols**: Secure emergency override system
- **Authorized Personnel**: Only verified authorities can perform critical actions

## 🧪 Testing

The system includes comprehensive tests using Vitest:

\`\`\`bash
npm run test
\`\`\`

Test coverage includes:
- Contract deployment and initialization
- Access permission workflows
- Credential lifecycle management
- Emergency override scenarios
- Audit trail verification

## 📊 Contract Interactions

### Permission Levels
- **Level 1**: Basic access (common areas)
- **Level 2**: Restricted access (offices, meeting rooms)
- **Level 3**: High security access (server rooms, vaults)

### Security Levels (Facilities)
- **Level 1**: Public areas
- **Level 2**: Office spaces
- **Level 3**: Restricted areas
- **Level 4**: High security zones
- **Level 5**: Maximum security areas

## 🔧 Configuration

### Environment Variables
- `STACKS_NETWORK`: Network configuration (testnet/mainnet)
- `CONTRACT_DEPLOYER`: Deployer address
- `FACILITY_MANAGER`: Default facility manager

### Contract Constants
Each contract defines error codes and operational constants that can be customized during deployment.

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Write tests for new functionality
4. Ensure all tests pass
5. Submit a pull request

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 🆘 Support

For support and questions:
- Create an issue in the repository
- Contact the development team
- Check the documentation wiki

## 🔄 Version History

- **v1.0.0**: Initial release with core functionality
- **v1.1.0**: Enhanced emergency override system
- **v1.2.0**: Improved audit trail capabilities

---

Built with ❤️ using Clarity and the Stacks blockchain.

