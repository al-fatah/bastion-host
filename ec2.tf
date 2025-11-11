# User data scripts for basic hardening + fail2ban
data "template_file" "bastion_user_data" {
  template = file("${path.module}/user_data/bastion.sh")
}

data "template_file" "private_user_data" {
  template = file("${path.module}/user_data/private.sh")
}

resource "aws_instance" "bastion" {
  ami                         = data.aws_ami.al2023.id
  instance_type               = var.bastion_instance_type
  subnet_id                   = aws_subnet.public.id
  associate_public_ip_address = true
  key_name                    = aws_key_pair.bastion.key_name
  vpc_security_group_ids      = [aws_security_group.bastion.id]
  user_data                   = data.template_file.bastion_user_data.rendered

  tags = {
    Name = "${var.project_name}-bastion"
    Role = "bastion"
  }
}

resource "aws_instance" "private" {
  ami                    = data.aws_ami.al2023.id
  instance_type          = var.private_instance_type
  subnet_id              = aws_subnet.private.id
  key_name               = aws_key_pair.private.key_name
  vpc_security_group_ids = [aws_security_group.private.id]
  user_data              = data.template_file.private_user_data.rendered

  # NO public IP (implicit: private subnet)
  associate_public_ip_address = false

  tags = {
    Name = "${var.project_name}-private"
    Role = "private"
  }
}
