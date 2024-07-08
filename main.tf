# Define provider (AWS)
provider "aws" {
  region = "us-east-1"  # Change to your desired AWS region
}
# Create EC2 instances
resource "aws_instance" "demo-server" {
  ami           = "ami-04a81a99f5ec58529"
  instance_type = "t2.micro"
  subnet_id = aws_subnet.demo-subnet.id
  vpc_security_group_ids = [aws_security_group.demo-secgrp.id]
}

# Create VPC
resource "aws_vpc" "demo-vpc" {
  cidr_block = "10.10.0.0/16"
}

# Create internet gateway
resource "aws_route_table" "demo-rt" {
  vpc_id = aws_vpc.demo-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_route_table.demo-rt.id
  }

    tags = {
    Name = "demo-rt"
  }
}

# Create public subnet
resource "aws_subnet" "demo-subnet" {
  vpc_id     = aws_vpc.demo-vpc.id
  cidr_block = "10.10.1.0/24"

  tags = {
    Name = "demo-subnet"
  }
}

# Create route table for public subnet
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_igw.id
  }

  tags = {
    Name = "public_route_table"
  }
}

# Associate public subnet with the public route table
resource "aws_route_table_association" "demo-rt_assosiation" {
  subnet_id      = aws_subnet.demo-subnet.id
  route_table_id = aws_route_table.public_route_table.id
}
# Security group
resource "aws_security_group" "demo-secgrp" {
  name        = "demo-secgrp"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.demo-vpc.id

ingress {
    description  = "TLS from VPC"
    from port = 22
    to_port   = 22
    protocol  = "tcp"
    cide_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
}

egress {
  from port     = 0
  to_port       = 0
protocol         = "-1"
cidr_blocks     =  ["0.0.0.0/0"]
ipv6_cidr_blocks = ["::/0"]

}
}

