output "aws_region" {
  value = var.region
}

output "instance_vm_1_public_ip_1" {
  value = module.aws.public_ip_1
}

output "instance_vm_1_private_ip_1" {
  value = module.aws.private_ip_1
}

output "instance_vm_2_public_ip_2" {
  value = module.aws.public_ip_2
}

output "instance_vm_2_private_ip_2" {
  value = module.aws.private_ip_2
}
