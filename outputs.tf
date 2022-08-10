output "aws_region" {
  value = var.region
}

output "instance_vm_ssh_1_public_ip" {
  value = module.aws.public_ip
}

output "instance_vm_1_private_ip_1" {
  value = module.aws.private_ip_1
}

output "instance_vm_2_private_ip_2" {
  value = module.aws.private_ip_2
}
