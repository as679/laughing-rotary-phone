# Terraform definition for the lab servers
#

data "template_file" "server_userdata" {
  count    = "${var.server_count}"
  template = "${file("${path.module}/userdata/server.userdata")}"

  vars {
    hostname = "server${count.index + 1}.lab"
    jump_ip  = "${aws_instance.jump.private_ip}"
    number   = "${count.index + 1}"
  }
}
resource "aws_instance" "server" {
  count                  = "${var.server_count}"
  ami                    = "${lookup(var.ami_centos, var.aws_region)}"
  availability_zone      = "${lookup(var.aws_az, var.aws_region)}"
  instance_type          = "${var.flavour_centos}"
  key_name               = "${var.key}"
  vpc_security_group_ids = ["${aws_security_group.jumpsg.id}"]
  subnet_id              = "${aws_subnet.privnet.id}"
  private_ip             = "${format("%s%d", cidrhost(aws_subnet.privnet.cidr_block,2) , count.index +1 )}"
  source_dest_check      = false
  user_data              = "${data.template_file.server_userdata.*.rendered[count.index]}"
  depends_on             = ["aws_instance.jump"]

  tags {
    Name  = "server${count.index + 1}"
    Owner = "${var.owner}"
    Lab_Group = "servers"
    Lab_Name = "server${count.index + 1}.lab"
    Lab_Timezone = "${var.lab_timezone}"
  }

  root_block_device {
    volume_type           = "standard"
    volume_size           = "${var.vol_size_centos}"
    delete_on_termination = "true"
  }
}
