resource "tls_private_key" "bastion" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "tls_private_key" "private" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "bastion" {
  key_name   = "${var.project_name}-bastion-key"
  public_key = tls_private_key.bastion.public_key_openssh
  tags       = { Name = "${var.project_name}-bastion-key" }
}

resource "aws_key_pair" "private" {
  key_name   = "${var.project_name}-private-key"
  public_key = tls_private_key.private.public_key_openssh
  tags       = { Name = "${var.project_name}-private-key" }
}

# Write private keys locally (chmod them after apply)
resource "local_file" "bastion_key_pem" {
  count    = var.create_keys_locally ? 1 : 0
  filename = "${path.module}/keys/bastion_key.pem"
  content  = tls_private_key.bastion.private_key_pem
  file_permission = "0600"
}

resource "local_file" "private_key_pem" {
  count    = var.create_keys_locally ? 1 : 0
  filename = "${path.module}/keys/private_key.pem"
  content  = tls_private_key.private.private_key_pem
  file_permission = "0600"
}
