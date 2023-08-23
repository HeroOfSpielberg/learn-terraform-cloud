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

# Create an EC2 instance using the defined subnet and VPC
resource "aws_instance" "windows_22" {
  ami                         = ami-07e70003c665fb5f3
  instance_type               = var.instance_type
  subnet_id                   = var.existing_subnet_id
  associate_public_ip_address = true

  tags = {
    Name = var.instance_name
  }
}
