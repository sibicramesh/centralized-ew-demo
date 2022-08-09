// Transit gateway.
resource "aws_ec2_transit_gateway" "tgw" {
  default_route_table_association = "disable"
  default_route_table_propagation = "disable"

  tags = {
    Name = "${var.name_prefix}-tgw"
  }
}

// Network config for vpc 1.
resource "aws_internet_gateway" "igw_1" {
  vpc_id = aws_vpc.vpc_1.id

  tags = {
    Name = "${var.name_prefix}-igw-1"
  }
}

resource "aws_subnet" "subnet_1" {
  vpc_id            = aws_vpc.vpc_1.id
  cidr_block        = aws_vpc.vpc_1.cidr_block
  availability_zone = var.availability_zone

  tags = {
    Name = "${var.name_prefix}-subnet-1"
  }
}

resource "aws_route_table" "route_1" {
  vpc_id = aws_vpc.vpc_1.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw_1.id
  }
  route {
    cidr_block         = aws_vpc.vpc_2.cidr_block
    transit_gateway_id = aws_ec2_transit_gateway.tgw.id
  }

  tags = {
    Name = "${var.name_prefix}-route-1"
  }
}

resource "aws_route_table_association" "rs_1" {
  subnet_id      = aws_subnet.subnet_1.id
  route_table_id = aws_route_table.route_1.id
}

resource "aws_security_group" "sg_1" {
  vpc_id = aws_vpc.vpc_1.id
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.name_prefix}-sg-1"
  }
}

// Network config for vpc 2.
resource "aws_internet_gateway" "igw_2" {
  vpc_id = aws_vpc.vpc_2.id

  tags = {
    Name = "${var.name_prefix}-igw-2"
  }
}

resource "aws_subnet" "subnet_2" {
  vpc_id            = aws_vpc.vpc_2.id
  cidr_block        = aws_vpc.vpc_2.cidr_block
  availability_zone = var.availability_zone

  tags = {
    Name = "${var.name_prefix}-subnet-2"
  }
}

resource "aws_route_table" "route_2" {
  vpc_id = aws_vpc.vpc_2.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw_2.id
  }
  route {
    cidr_block         = aws_vpc.vpc_1.cidr_block
    transit_gateway_id = aws_ec2_transit_gateway.tgw.id
  }

  tags = {
    Name = "${var.name_prefix}-route-2"
  }
}

resource "aws_route_table_association" "rs_2" {
  subnet_id      = aws_subnet.subnet_2.id
  route_table_id = aws_route_table.route_2.id
}

resource "aws_security_group" "sg_2" {
  vpc_id = aws_vpc.vpc_2.id
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.name_prefix}-sg-2"
  }
}

// Network config for firewall vpc.
resource "aws_subnet" "subnet_firewall" {
  vpc_id            = aws_vpc.firewall.id
  cidr_block        = "10.3.0.0/17"
  availability_zone = var.availability_zone

  tags = {
    Name = "${var.name_prefix}-subnet-firewall"
  }
}

resource "aws_subnet" "subnet_firewall_ngfw" {
  vpc_id            = aws_vpc.firewall.id
  cidr_block        = "10.3.128.0/17"
  availability_zone = var.availability_zone

  tags = {
    Name = "${var.name_prefix}-subnet-firewall-ngfw"
  }
}

resource "aws_route_table" "route_firewall" {
  vpc_id = aws_vpc.firewall.id
  route {
    cidr_block         = "0.0.0.0/0"
    transit_gateway_id = aws_ec2_transit_gateway.tgw.id
  }

  tags = {
    Name = "${var.name_prefix}-route-firewall"
  }
}

resource "aws_route_table_association" "rs-firewall" {
  subnet_id      = aws_subnet.subnet_firewall.id
  route_table_id = aws_route_table.route_firewall.id
}

resource "aws_security_group" "sg_firewall" {
  vpc_id = aws_vpc.firewall.id
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.name_prefix}-sg-firewall"
  }
}

// Transit gateway attachments
resource "aws_ec2_transit_gateway_vpc_attachment" "tgw_1" {
  vpc_id                                          = aws_vpc.vpc_1.id
  transit_gateway_id                              = aws_ec2_transit_gateway.tgw.id
  subnet_ids                                      = [aws_subnet.subnet_1.id]
  transit_gateway_default_route_table_association = "false"
  transit_gateway_default_route_table_propagation = "false"

  tags = {
    Name = "${var.name_prefix}-tgw_1"
  }
}

resource "aws_ec2_transit_gateway_vpc_attachment" "tgw_2" {
  vpc_id                                          = aws_vpc.vpc_2.id
  transit_gateway_id                              = aws_ec2_transit_gateway.tgw.id
  subnet_ids                                      = [aws_subnet.subnet_2.id]
  transit_gateway_default_route_table_association = "false"
  transit_gateway_default_route_table_propagation = "false"

  tags = {
    Name = "${var.name_prefix}-tgw-2"
  }
}

resource "aws_ec2_transit_gateway_vpc_attachment" "tgw_firewall" {
  vpc_id                                          = aws_vpc.firewall.id
  transit_gateway_id                              = aws_ec2_transit_gateway.tgw.id
  subnet_ids                                      = [aws_subnet.subnet_firewall_ngfw.id]
  transit_gateway_default_route_table_association = "false"
  transit_gateway_default_route_table_propagation = "false"

  tags = {
    Name = "${var.name_prefix}-tgw-firewall"
  }
}

resource "aws_ec2_transit_gateway_route_table" "tgw_fwd" {
  transit_gateway_id = aws_ec2_transit_gateway.tgw.id

  tags = {
    Name = "${var.name_prefix}-tgw-fwd"
  }
}

resource "aws_ec2_transit_gateway_route_table_association" "tgw_fwd_association_1" {
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.tgw_1.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.tgw_fwd.id
}

resource "aws_ec2_transit_gateway_route_table_association" "tgw_fwd_association_2" {
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.tgw_2.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.tgw_fwd.id
}

resource "aws_ec2_transit_gateway_route" "tgw_fwd_rt" {
  destination_cidr_block         = "0.0.0.0/0"
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.tgw_firewall.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.tgw_fwd.id
}

resource "aws_ec2_transit_gateway_route_table" "tgw_bwd" {
  transit_gateway_id = aws_ec2_transit_gateway.tgw.id

  tags = {
    Name = "${var.name_prefix}-tgw-bwd"
  }
}

resource "aws_ec2_transit_gateway_route_table_association" "tgw_bwd_association_firewall" {
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.tgw_firewall.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.tgw_bwd.id
}

resource "aws_ec2_transit_gateway_route" "tgw_bwd_rt_1" {
  destination_cidr_block         = aws_vpc.vpc_1.cidr_block
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.tgw_1.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.tgw_bwd.id
}

resource "aws_ec2_transit_gateway_route" "tgw_bwd_rt_2" {
  destination_cidr_block         = aws_vpc.vpc_2.cidr_block
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.tgw_2.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.tgw_bwd.id
}
