#!/bin/bash
set -eux

# Update and basic hardening
dnf -y update || yum -y update || true

# Ensure passwordless SSH only (no password auth)
sed -i 's/^#\?PasswordAuthentication.*/PasswordAuthentication no/' /etc/ssh/sshd_config
sed -i 's/^#\?PermitRootLogin.*/PermitRootLogin prohibit-password/' /etc/ssh/sshd_config
systemctl restart sshd || systemctl restart ssh

# Install fail2ban
dnf -y install fail2ban || yum -y install epel-release && yum -y install fail2ban || true
systemctl enable fail2ban --now || true
