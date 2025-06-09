# This Terraform configuration sets up a VPC and a subnet in AWS.
resource "aws_vpc" "darweesh_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "darweesh-vpc"
  }
}

resource "aws_subnet" "darweesh_subnet" {
  vpc_id                  = aws_vpc.darweesh_vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-2a"
  map_public_ip_on_launch = true
  tags = {
    Name = "darweesh-subnet"
  }
}
resource "aws_internet_gateway" "darweesh_igw" {
  vpc_id = aws_vpc.darweesh_vpc.id
  tags = {
    Name = "darweesh-igw"
  }
}
resource "aws_route_table" "darweesh_route_table" {
  vpc_id = aws_vpc.darweesh_vpc.id
  tags = {
    Name = "darweesh-route-table"
  }
}
resource "aws_security_group" "darweesh_sg" {
  name        = "darweesh-sg"
  description = "Allow SSH and HTTP"
  vpc_id      = aws_vpc.darweesh_vpc.id

 ingress {
    description = "RDP"
    from_port   = 3389
    to_port     = 3389
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # ⚠️ This allows access from anywhere. For production, use your IP only.
  }
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "darweesh-sg"
  }
}
#