#!/usr/bin/env bash
let count=`grep student_count terraform.tfvars | awk '{print $3}'`
idx=0
for i in `seq $count`; do
  echo -n "Student$i: "
  terraform state show aws_instance.ctrl[$idx] | grep 'public_ip ' | awk '{print $3}'
  ((idx++))
done
let count=`grep server_count terraform.tfvars | awk '{print $3}'`
idx=0
for i in `seq $count`; do
  echo -n "Server$i: "
  terraform state show aws_instance.server[$idx] | grep 'private_ip ' | awk '{print $3}'
  ((idx++))
done
echo -n "Jumpbox: "
terraform state show aws_instance.jump | grep 'public_ip ' | awk '{print $3}'
echo -n "Jumpbox [private]: "
terraform state show aws_instance.jump | grep 'private_ip ' | awk '{print $3}'
