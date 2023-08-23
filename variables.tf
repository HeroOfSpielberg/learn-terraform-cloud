variable "region" {
  description = "AWS region"
  default     = "us-west-2"
}

variable "instance_type" {
  description = "Type of EC2 instance to provision"
  default     = "t2.micro"
}

variable "instance_name" {
  description = "EC2 instance name"
  default     = "Provisioned by Terraform"
}

# Specify the ID of the existing Subnet
variable "existing_subnet_id" {
  description = "Pat Subnet"
  default = "subnet-00d9e809f429989ae"
}