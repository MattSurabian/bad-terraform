variable "name" {
}

variable "env_code" {
}

variable "include_nat" {
  type = bool
}

variable tags {
  type    = map
  default = {}
}

variable "cidr_block" {
}

variable "public_subnets" {
  type    = list
  default = []
}

variable "private_app_subnets" {
  type    = list
  default = []
}

variable "private_data_subnets" {
  type    = list
  default = []
}

variable "r53_resolver_rules" {
  type    = list
  default = []
}

locals {
  region     = data.aws_region.current.name
  prefix     = local.region
  suffix     = "${var.env_code}-${var.name}"
  fullname   = "${local.prefix}-${local.suffix}"
  account_id = data.aws_caller_identity.current.account_id
  azs        = data.aws_availability_zones.current.names
}

data "aws_region" "current" {}
data "aws_availability_zones" "current" {}
data "aws_caller_identity" "current" {}
