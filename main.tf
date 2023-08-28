provider "aws" {
  region = var.region
}

data "aws_ami" "windows_22" {
  most_recent = true

/*
  filter {
    name   = "ami"
    values = ["ami-07e70003c665fb5f3"]
  }
*/

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["801119661308"] # Canonical
}


data "aws_security_group" "patopa_security_group" {
  filter {
    name = "PATOPAWindowsDCSecurityGroup"
    values = ["*nodes*"]
  }
  
  filter {
    name = "vpc-id"
    values = [var.vpc_id]
  }
}

# Create an EC2 instance using the defined subnet and VPC
resource "aws_instance" "windows_22" {
  ami                         = "ami-07e70003c665fb5f3"
  instance_type               = var.instance_type
  subnet_id                   = var.existing_subnet_id
  associate_public_ip_address = true
  key_name                    = "pat-opa-aws-servers"
  vpc_security_group_ids      = [daws_security_group.patopa_security_group.id]

  tags = {
    Name = var.instance_name
  }
}
