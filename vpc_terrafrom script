# AWS provider
provider "aws" {
  region = "ap-south-1"  
  access_key = ""
  secret_key = ""
}

# Creati VPC
resource "aws_vpc" "my_vpc" {
  cidr_block = "10.0.0.0/16"  
  enable_dns_support = true
  enable_dns_hostnames = true
}

# Create subnet
resource "aws_subnet" "my_subnet" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = "10.0.1.0/24"  
  availability_zone = "ap-south-1a"  

# Create security group
resource "aws_security_group" "my_security_group" {
  vpc_id = aws_vpc.my_vpc.id
  name   = "my-security-group"
  
  // Ingress rules (allow inbound traffic)
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] 
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  
  }

  // Egress rules (allow outbound traffic)
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"] 
  }
}
