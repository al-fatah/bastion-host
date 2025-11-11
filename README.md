# Bastion Host + Private Server Terraform Automation (AWS)

## Overview
This Terraform configuration automatically provisions:
- **VPC** with public and private subnets
- **Bastion Host** (public subnet)
- **Private Server** (private subnet)
- **Security groups** enforcing SSH-only access from the bastion
- **Auto-generated SSH keys** (never commit the PEM files)
- **User data scripts** for basic hardening and fail2ban setup

## Usage

### 1. Initialize Terraform
```bash
terraform init
```

### 2. Apply Configuration
Replace with your actual public IP:
```bash
terraform apply -var="allowed_ssh_cidr=203.0.113.10/32" -auto-approve
```

### 3. Outputs
Terraform will output:
- Bastion Public IP
- Private Server Private IP
- Example SSH configuration for `~/.ssh/config`

### 4. Connect
```bash
chmod 600 keys/*.pem
ssh bastion
ssh private-server   # from bastion
# or directly using ProxyJump:
ssh private-server
```

## Security Notes
- Do **not** commit PEM files. Add this to `.gitignore`:
```
keys/
*.pem
.terraform/
terraform.tfstate*
```
- Limit SSH access to your IP only.
- Consider replacing SSH with **AWS SSM Session Manager** later.

## Optional Enhancements
- Add CloudWatch logs for monitoring SSH auth attempts
- Add MFA to the bastion using PAM Google Authenticator
- Automate with CI/CD for IaC deployments
