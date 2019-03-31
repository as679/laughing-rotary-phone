# Specifies the details for the base infrastructure such as VPC and subnets
# https://www.terraform.io/docs/providers/aws/

resource "aws_vpc" "101_vpc" {
  cidr_block = "${var.vpc_cidr}"

  tags {
    Name  = "${var.id}_vpc"
    Owner = "${var.owner}"
  }
}

resource "aws_subnet" "pubnet" {
  vpc_id            = "${aws_vpc.101_vpc.id}"
  cidr_block        = "${cidrsubnet(var.vpc_cidr, 8, 0)}"
  availability_zone = "${lookup(var.aws_az, var.aws_region)}"

  tags {
    Name  = "${var.id}_VIP_network"
    Owner = "${var.owner}"
  }
}

resource "aws_subnet" "privnet" {
  vpc_id            = "${aws_vpc.101_vpc.id}"
  cidr_block        = "${cidrsubnet(var.vpc_cidr, 8, 1)}"
  availability_zone = "${lookup(var.aws_az, var.aws_region)}"

  tags {
    Name  = "${var.id}_server_network"
    Owner = "${var.owner}"
  }
}

resource "aws_subnet" "mgmtnet" {
  vpc_id            = "${aws_vpc.101_vpc.id}"
  cidr_block        = "${cidrsubnet(var.vpc_cidr, 8, 2)}"
  availability_zone = "${lookup(var.aws_az, var.aws_region)}"

  tags {
    Name  = "${var.id}_management_network"
    Owner = "${var.owner}"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = "${aws_vpc.101_vpc.id}"

  tags {
    Name  = "${var.id}_igw"
    Owner = "${var.owner}"
  }
}

resource "aws_route_table" "pubrt" {
  vpc_id = "${aws_vpc.101_vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.igw.id}"
  }

  tags {
    Name  = "${var.id}_pubrt"
    Owner = "${var.owner}"
  }
}

resource "aws_route_table_association" "pubrta" {
  subnet_id      = "${aws_subnet.pubnet.id}"
  route_table_id = "${aws_route_table.pubrt.id}"
}
