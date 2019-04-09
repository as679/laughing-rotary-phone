# This file contains the AMI Ids of the images used for the various instances
#

# This finds the latest Avi AMI
# aws ec2 describe-images --owners 139284885014 --filters Name=name,Values='Avi-Controller-18.2.2*' \
# --region eu-west-1 | jq -r '.Images | sort_by(.CreationDate) | last(.[]).ImageId'

variable "ami_avi_controller" {
  type        = "map"
  description = "Avi AMI by region updated 07/03/19"

  default = {
    eu-west-1 = "ami-072e0c55a6dc19cd1" #18.2.2
    us-east-1 = "ami-07b6f43ff7d7dbcff" #18.2.2
    us-west-2 = "ami-0ef13f76789a1223b" #18.2.2
  }
}

# This finds the latest Centos AMI ID
# aws ec2 describe-images --owners aws-marketplace --filters Name=product-code,Values=aw0evgkw8e5c1q413zgy5pjce \
# --region eu-west-1 | jq -r '.Images | sort_by(.CreationDate) | last(.[]).ImageId'

# NOTE
# Prebuilt packer image is used in labs
variable "ami_centos" {
  type        = "map"
  description = "CentOS AMI by region updated 10/10/18"

  default = {
    eu-west-1 = "ami-05bf5629af1a40963"
    us-east-1 = "ami-0e9509b5ed76ece3b"
    us-west-2 = "ami-0eafc8a82f99ba708"
  }
}
