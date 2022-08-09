variable "ssh_key" {
  description = "Name of the ssh key in AWS"
  type        = string
  default     = "sibi-dev"
}

variable "ami" {
  description = "AMI to use for the instances"
  type        = string
  default     = "ami-0cea098ed2ac54925"
}

variable "instance_type" {
  description = "Instance type to use for the instances"
  type        = string
  default     = "t2.small"
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
