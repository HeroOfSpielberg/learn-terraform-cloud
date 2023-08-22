provider "aws" {
  region = var.region
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

# Create a VPC
resource "aws_vpc" "PATOPAVPC" {
  cidr_block = "172.16.0.0/16"
}

# Create a subnet within the VPC
resource "aws_subnet" "PATOPASubnet" {
  vpc_id     = aws_vpc.PATOPAVPC.id
  cidr_block = "172.16.10.0/24"
}
# Create an EC2 instance using the defined subnet and VPC
resource "aws_instance" "ubuntu" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type

 subnet_id                   = aws_subnet.PATOPASubnet.id
 vpc_security_group_ids      = [aws_security_group.vpc-0aec39cf706b365d5.id]
 associate_public_ip_address = true

  tags = {
    Name = var.instance_name
  }
}
