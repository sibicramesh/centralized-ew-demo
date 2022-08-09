module "aws" {
  source = "./modules/aws"

  ssh_key           = "sibi-dev"
  availability_zone = var.availability_zone
  name_prefix       = var.name_prefix
}

module "cloudngfwaws" {
  source = "./modules/cloudngfwaws"

  name              = "${var.name_prefix}-firewall-19"
  rulestack         = "${var.name_prefix}-rulestack-19"
  vpc_id            = module.aws.firewall_vpc_id
  subnet            = module.aws.firewall_subnet_id
  availability_zone = var.availability_zone
  name_prefix       = var.name_prefix

  depends_on = [
    module.aws
  ]
}

// NGFW endpoint route table.
resource "aws_route_table" "route_firewall_ngfw" {
  vpc_id = module.aws.firewall_vpc_id
  route {
    cidr_block      = "0.0.0.0/0"
    vpc_endpoint_id = module.cloudngfwaws.firewall_endpoint_id
  }

  tags = {
    Name = "${var.name_prefix}-route-firewall-ngfw"
  }

  depends_on = [
    module.cloudngfwaws
  ]
}

resource "aws_route_table_association" "rs-firewall-ngfw" {
  subnet_id      = module.aws.firewall_ngfw_subnet_id
  route_table_id = aws_route_table.route_firewall_ngfw.id
}
