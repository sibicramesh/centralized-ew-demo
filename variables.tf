variable "region" {
  description = "AWS region to use"
  type        = string
}

variable "availability_zone" {
  description = "AWS availability zone to use"
  type        = string
}

variable "host" {
  description = "Hostname of the API"
  type        = string
}

variable "lfa_arn" {
  description = "The ARN allowing firewall admin permissions"
  type        = string
}

variable "lra_arn" {
  description = "The ARN allowing rulestack admin permissions"
  type        = string
}

variable "name_prefix" {
  description = "Name prefix used while creating resources"
  type        = string
}
