resource "aws_instance" "vm_1" {
  ami                         = var.ami
  instance_type               = var.instance_type
  key_name                    = var.ssh_key
  subnet_id                   = aws_subnet.subnet_1.id
  security_groups             = [aws_security_group.sg_1.id]
  associate_public_ip_address = "true"
  availability_zone           = var.availability_zone

  tags = {
    Name = "${var.name_prefix}-vm-1"
  }
}

resource "aws_instance" "vm_2" {
  ami                         = var.ami
  instance_type               = var.instance_type
  key_name                    = var.ssh_key
  subnet_id                   = aws_subnet.subnet_2.id
  security_groups             = [aws_security_group.sg_2.id]
  associate_public_ip_address = "true"
  availability_zone           = var.availability_zone

  tags = {
    Name = "${var.name_prefix}-vm-2"
  }
}
