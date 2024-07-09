# Define provider (AWS)
provider "aws" {
  region = "us-east-1"  # Change to your desired AWS region
}
# Create VPC
resource "aws_vpc" "demo-vpc" {
  cidr_block = "10.10.0.0/16"
}
# Create public subnet
resource "aws_subnet" "demo-subnet" {
  vpc_id     = aws_vpc.demo-vpc.id
  cidr_block = "10.10.1.0/24"

  tags = {
    Name = "demo-subnet"
  }
}
# Create internet gateway
resource "aws_route_table" "demo-igw" {
  vpc_id = aws_vpc.demo-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_route_table.demo-igw.id
  }

    tags = {
    Name = "demo-rt"
  }
}


# Create route table for public subnet
resource "aws_route_table" "demo-rt" {
  vpc_id = aws_vpc.my_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.demo-igw.id
  }
  tags = {
    Name = "demo-rt"
  }
}

# Associate public subnet with the public route table
resource "aws_route_table_association" "demo-rt_assosiation" {
  subnet_id      = aws_subnet.demo-subnet.id
  route_table_id = aws_route_table.demo-rt.id
}
# Security group
resource "aws_security_group" "demo-secgrp" {
  name        = "demo-secgrp"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.demo-vpc.id
}
ingress {
    
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
}

egress {
  from_port     = 0
  to_port       = 0
protocol         = "-1"
cidr_blocks     =  ["0.0.0.0/0"]
ipv6_cidr_blocks = ["::/0"]

}
# Create EC2 instances
resource "aws_instance" "demo-server" {
  ami           = "ami-04a81a99f5ec58529"
  key_name = "jen-ter-private-kp"
  instance_type = "t2.micro"
  availability_zone = "us-east-01"
  subnet_id = aws_subnet.demo-subnet.id
  vpc_security_group_ids = [aws_security_group.demo-secgrp.id]
}


