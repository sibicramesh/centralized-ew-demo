variable "name" {
  description = "Name of the firewall"
  type        = string
  default     = "firewall"
}

variable "rulestack" {
  description = "Local rulestack name to use for this firewall"
  type        = string
  default     = "rulestack"
}

variable "subnet" {
  description = "Subnet to use for this firewall"
  type        = string
}

variable "vpc_id" {
  description = "ID of the VPC to use for this firewall"
  type        = string
}

variable "availability_zone" {
  description = "AWS availability zone to use"
  type        = string
  default     = "us-west-2a"
}

variable "name_prefix" {
  description = "Name prefix used while creating resources"
  type        = string
  default     = "sibi"
}
