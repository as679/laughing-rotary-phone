# Specifies the details for the base infrastructure such as VPC and subnets
# https://www.terraform.io/docs/providers/aws/

resource "aws_vpc" "avi101_vpc" {
  cidr_block = var.vpc_cidr

  tags = {
    Name  = "${var.id}_vpc"
    Owner = var.owner
  }
}

resource "aws_subnet" "pubnet" {
  vpc_id            = aws_vpc.avi101_vpc.id
  cidr_block        = cidrsubnet(var.vpc_cidr, 8, 0)
  availability_zone = var.aws_az[var.aws_region]

  tags = {
    Name  = "${var.id}_VIP_network"
    Owner = var.owner
  }
}

resource "aws_subnet" "privnet" {
  vpc_id            = aws_vpc.avi101_vpc.id
  cidr_block        = cidrsubnet(var.vpc_cidr, 8, 1)
  availability_zone = var.aws_az[var.aws_region]

  tags = {
    Name  = "${var.id}_server_network"
    Owner = var.owner
  }
}

resource "aws_subnet" "mgmtnet" {
  vpc_id            = aws_vpc.avi101_vpc.id
  cidr_block        = cidrsubnet(var.vpc_cidr, 8, 2)
  availability_zone = var.aws_az[var.aws_region]

  tags = {
    Name  = "${var.id}_management_network"
    Owner = var.owner
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.avi101_vpc.id

  tags = {
    Name  = "${var.id}_igw"
    Owner = var.owner
  }
}

resource "aws_route_table" "pubrt" {
  vpc_id = aws_vpc.avi101_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name  = "${var.id}_pubrt"
    Owner = var.owner
  }
}

resource "aws_route_table_association" "pubrta" {
  subnet_id      = aws_subnet.pubnet.id
  route_table_id = aws_route_table.pubrt.id
}

resource "tls_private_key" "generated_access_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "generated_access_key_pair" {
  key_name   = "${var.id}_${var.aws_region}_${var.key_name}_generated"
  public_key = tls_private_key.generated_access_key.public_key_openssh
}

