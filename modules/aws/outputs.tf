output "firewall_vpc_id" {
  value = aws_vpc.firewall.id
}

output "firewall_subnet_id" {
  value = aws_subnet.subnet_firewall.id
}

output "firewall_ngfw_subnet_id" {
  value = aws_subnet.subnet_firewall_ngfw.id
}

output "public_ip_1" {
  value = aws_instance.vm_1.public_ip
}

output "private_ip_1" {
  value = aws_instance.vm_1.private_ip
}

output "public_ip_2" {
  value = aws_instance.vm_2.public_ip
}

output "private_ip_2" {
  value = aws_instance.vm_2.private_ip
}
