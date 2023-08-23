provider "aws" {
  region = var.region
}

data "aws_ami" "windows" {
  most_recent = true

  filter {
    name   = "name"
    values = ["Windows_Server-2022-English-Full-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

# Specify the ID of the existing Subnet
variable "existing_subnet_id" {
  description = "Pat Subnet"
  default = "subnet-00d9e809f429989ae"
}

# Create an EC2 instance using the defined subnet and VPC
resource "aws_instance" "windows" {
  ami                         = data.aws_ami.windows.id
  instance_type               = var.instance_type
  subnet_id                   = var.existing_subnet_id
  associate_public_ip_address = true

  tags = {
    Name = var.instance_name
  }
}
