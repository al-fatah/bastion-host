variable "region" {
  description = "AWS region"
  type        = string
  default     = "ap-southeast-1"
}

variable "project_name" {
  description = "Tag prefix for resources"
  type        = string
  default     = "bastion-demo"
}

variable "vpc_cidr" {
  description = "VPC CIDR"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  description = "Public subnet CIDR"
  type        = string
  default     = "10.0.1.0/24"
}

variable "private_subnet_cidr" {
  description = "Private subnet CIDR"
  type        = string
  default     = "10.0.2.0/24"
}

variable "allowed_ssh_cidr" {
  description = "Your IP/CIDR allowed to SSH to bastion (e.g. 203.0.113.10/32)"
  type        = string
}

variable "bastion_instance_type" {
  description = "EC2 type for bastion"
  type        = string
  default     = "t3.micro"
}

variable "private_instance_type" {
  description = "EC2 type for private server"
  type        = string
  default     = "t3.micro"
}

variable "create_keys_locally" {
  description = "Whether to write generated private keys to local files (DO NOT COMMIT!)"
  type        = bool
  default     = true
}
