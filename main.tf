# Define provider (AWS)
provider "aws" {
  region = "us-east-1"  # Change to your desired AWS region
}
resource "aws_instance" "demo-server" {
  ami           = "ami-04a81a99f5ec58529"
  instance_type = "t2.micro"

# Create VPC
resource "aws_vpc" "demo-vpc" {
  cidr_block = "10.10.0.0/16"
}

# Create internet gateway
resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.my_vpc.id
}

# Create public subnet
resource "aws_subnet" "demo-subnet" {
  vpc_id     = aws_vpc.demo-vpc.id
  cidr_block = "10.10.1.0/24"

  tags = {
    Name = "demo-subnet"
  }
}

# Create private subnet
resource "aws_subnet" "private_subnet" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-east-1b"  # Change availability zone if needed

  tags = {
    Name = "PrivateSubnet"
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
    Name = "PublicRouteTable"
  }
}

# Associate public subnet with the public route table
resource "aws_route_table_association" "public_subnet_association" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_route_table.id
}

# Create EC2 instances
resource "aws_instance" "public_instance" {
  ami             = "ami-04a81a99f5ec58529"  # Replace with your desired AMI ID
  instance_type   = "t2.micro"
  subnet_id       = aws_subnet.public_subnet.id
  associate_public_ip_address = true  # Ensure instance gets a public IP

  tags = {
    Name = "PublicInstance"
  }
}

resource "aws_instance" "private_instance" {
  ami           = "ami-04a81a99f5ec58529"  # Replace with your desired AMI ID
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.private_subnet.id

  tags = {
    Name = "PrivateInstance"
  }
}
