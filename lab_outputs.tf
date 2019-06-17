# Outputs for Terraform
#

output "JumpHost_PublicIP" {
  value = aws_instance.jump.public_ip
}

output "JumpHost_PrivateIP" {
  value = aws_instance.jump.private_ip
}

output "Controller_PublicIP" {
  value = aws_eip.ctrl_eip.*.public_ip
}

output "Controller_PrivateIP" {
  value = aws_instance.ctrl.*.private_ip
}

output "Server_PrivateIP" {
  value = aws_instance.server.*.private_ip
}

output "Generated_Access_Key" {
  value = tls_private_key.generated_access_key.private_key_pem
}

