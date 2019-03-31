# Here are the AWS security groups are defined
#
# the controllers allow inbound TCP:80/443
# the jumpbox allows inbound TCP:22
#
# All outbound traffic is allowed
# All local traffic is allowed

resource "aws_security_group" "ctrlsg" {
  description = "Allow incoming connections to the Avi GUI"
  vpc_id      = "${aws_vpc.101_vpc.id}"

  tags {
    Name = "${var.id}_ctrlsg"
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["${var.vpc_cidr}"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "jumpsg" {
  description = "Allow incoming connections to the lab jumpbox."
  vpc_id      = "${aws_vpc.101_vpc.id}"

  tags {
    Name = "${var.id}_jumpsg"
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["${var.vpc_cidr}"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
