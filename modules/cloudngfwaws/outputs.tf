output "firewall_endpoint_id" {
  value = cloudngfwaws_ngfw.firewall.status[0].attachment[0].endpoint_id
}

output "firewall_endpoint_service_name" {
  value = cloudngfwaws_ngfw.firewall.endpoint_service_name
}
