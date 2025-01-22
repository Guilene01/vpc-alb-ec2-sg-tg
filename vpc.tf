# VPC definition
resource "aws_vpc" "alb-vpc" {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name = "alb-vpc"
  }
}

# Create private subnets
resource "aws_subnet" "private1" {
  availability_zone = "us-east-1a"
  vpc_id            = aws_vpc.alb-vpc.id
  cidr_block        = "10.0.1.0/24"
}

resource "aws_subnet" "private2" {
  availability_zone = "us-east-1b"
  vpc_id            = aws_vpc.alb-vpc.id
  cidr_block        = "10.0.2.0/24"
}

# Create public subnets
resource "aws_subnet" "public1" {
  availability_zone       = "us-east-1a"
  vpc_id                  = aws_vpc.alb-vpc.id
  cidr_block              = "10.0.3.0/24"
  map_public_ip_on_launch = true
}

resource "aws_subnet" "public2" {
  availability_zone       = "us-east-1b"
  vpc_id                  = aws_vpc.alb-vpc.id
  cidr_block              = "10.0.4.0/24"
  map_public_ip_on_launch = true
}

# Create an Internet Gateway for public internet access
resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.alb-vpc.id
}

# Elastic IP for NAT Gateway
resource "aws_eip" "eip1" {}

# Create NAT Gateway in public subnet
resource "aws_nat_gateway" "albnat" {
  allocation_id = aws_eip.eip1.id
  subnet_id     = aws_subnet.public1.id
}

# Create a route table for public subnets
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.alb-vpc.id

  # Route for public subnets to the Internet Gateway
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_igw.id
  }
}

# Route table association for public subnets
resource "aws_route_table_association" "pub1" {
  subnet_id      = aws_subnet.public1.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "pub2" {
  subnet_id      = aws_subnet.public2.id
  route_table_id = aws_route_table.public.id
}

# Create a route table for private subnets (routes through NAT Gateway)
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.alb-vpc.id

  # Route for private subnets to the NAT Gateway
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.albnat.id
  }
}

# Route table association for private subnets
resource "aws_route_table_association" "priv1" {
  subnet_id      = aws_subnet.private1.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "priv2" {
  subnet_id      = aws_subnet.private2.id
  route_table_id = aws_route_table.private.id
}
