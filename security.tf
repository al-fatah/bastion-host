# Bastion SG: allow SSH ONLY from your IP; allow egress anywhere
resource "aws_security_group" "bastion" {
  name        = "${var.project_name}-bastion-sg"
  description = "Bastion security group"
  vpc_id      = aws_vpc.this.id

  ingress {
    description = "SSH from your IP"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.allowed_ssh_cidr]
  }

  egress {
    description = "Allow all egress"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = { Name = "${var.project_name}-bastion-sg" }
}

# Private server SG: allow SSH ONLY from bastion SG
resource "aws_security_group" "private" {
  name        = "${var.project_name}-private-sg"
  description = "Private server SG"
  vpc_id      = aws_vpc.this.id

  ingress {
    description              = "SSH from bastion SG"
    from_port                = 22
    to_port                  = 22
    protocol                 = "tcp"
    security_groups          = [aws_security_group.bastion.id]
  }

  egress {
    description = "Allow all egress (for updates, etc.)"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = { Name = "${var.project_name}-private-sg" }
}
