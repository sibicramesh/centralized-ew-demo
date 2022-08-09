resource "cloudngfwaws_rulestack" "rs" {
  name  = var.rulestack
  scope = "Local"
  profile_config {}
}

resource "cloudngfwaws_security_rule" "rule" {
  rulestack = cloudngfwaws_rulestack.rs.name
  priority  = 1
  name      = "${var.name_prefix}-rule"
  rule_list = "LocalRule"
  source {
    cidrs = ["any"]
  }
  destination {
    cidrs = ["any"]
  }
  applications = ["any"]
  protocol     = "any"
  category {}
  action  = "Allow"
  logging = "true"
}

resource "cloudngfwaws_commit_rulestack" "rs-commit" {
  rulestack = cloudngfwaws_rulestack.rs.name
}

resource "cloudngfwaws_ngfw" "firewall" {
  name          = var.name
  vpc_id        = var.vpc_id
  endpoint_mode = "ServiceManaged"
  timeouts {
    create = "25m"
  }
  subnet_mapping {
    subnet_id = var.subnet
  }
  rulestack = cloudngfwaws_rulestack.rs.name

  tags = {
    Name = var.name
  }

  depends_on = [
    cloudngfwaws_commit_rulestack.rs-commit
  ]
}
