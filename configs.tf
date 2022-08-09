provider "aws" {
  region = var.region
}

provider "cloudngfwaws" {
  region  = var.region
  lfa_arn = var.lfa_arn
  lra_arn = var.lra_arn
  host    = var.host
}
