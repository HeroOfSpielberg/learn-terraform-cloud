provider "aws" {
  region = var.region
}

data "aws_ami" "windows_2022" {
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

# Create an EC2 instance using the defined subnet and VPC
resource "aws_instance" "windows" {
  ami                         = data.aws_ami.windows_2022.id
  instance_type               = var.instance_type
  subnet_id                   = var.existing_subnet_id
  associate_public_ip_address = true

  tags = {
    Name = var.instance_name
  }
}
