output "bastion_public_ip" {
  description = "Public IP of the bastion host"
  value       = aws_instance.bastion.public_ip
}

output "bastion_private_ip" {
  description = "Private IP of the bastion host"
  value       = aws_instance.bastion.private_ip
}

output "private_server_private_ip" {
  description = "Private IP of the private server"
  value       = aws_instance.private.private_ip
}

output "ssh_config_example" {
  description = "Suggested SSH config entries"
  value = <<EOT
Host bastion
    HostName ${aws_instance.bastion.public_ip}
    User ec2-user
    IdentityFile ./keys/bastion_key.pem

Host private-server
    HostName ${aws_instance.private.private_ip}
    User ec2-user
    ProxyJump bastion
    IdentityFile ./keys/private_key.pem
EOT
}
