# This file contains the AMI Ids of the images used for the various instances
#

# This finds the latest Avi AMI
# aws ec2 describe-images --owners 139284885014 --filters Name=name,Values='Avi-Controller-18.2.2*' \
# --region eu-west-1 | jq -r '.Images | sort_by(.CreationDate) | last(.[]).ImageId'

variable "ami_avi_controller" {
  type        = map(string)
  description = "Avi AMI by region updated 07/03/19"

  default = {
    eu-west-1 = "ami-0e81793951f5d3e2d" #18.2.5
    us-east-1 = "ami-07f26188aeeedd5dc" #18.2.5
    us-west-2 = "ami-0ae2dd07fcfd8c1d0" #18.2.5
   }
}

# This finds the latest Centos AMI ID
# aws ec2 describe-images --owners aws-marketplace --filters Name=product-code,Values=aw0evgkw8e5c1q413zgy5pjce \
# --region eu-west-1 | jq -r '.Images | sort_by(.CreationDate) | last(.[]).ImageId'

# NOTE
# Prebuilt packer image is used in labs
variable "ami_centos" {
  type        = map(string)
  description = "CentOS AMI by region updated 10/10/18"

  default = {
    eu-west-1 = "ami-02eb78917d49751ef"
    us-east-1 = "ami-0bf59e996e9d909f9"
    us-west-2 = "ami-041306c20ecd1c23c"
  }
}

