module "vpc" {
  source     = "./modules/vpc"
  name       = "central-services"
  env_code   = "d"
  cidr_block = "192.168.0.0/22"

  # network slice up see: https://www.davidc.net/sites/default/subnets/subnets.html?network=192.168.0.0&mask=22&division=19.3d431
  private_app_subnets = [
    "192.168.3.192/28" #us-east-1a #BAD?
  ]
  public_subnets = [
    "192.168.3.208/28" #us-east-1a #BAD?
  ]
  private_data_subnets = [
    "192.168.3.224/28" #us-east-1a #BAD?
  ]

  # reserved capacity: 192.168.3.240/28

  include_nat             = false

  tags                    = {
    ProjectId = "the-greatest-project-123"
    FixedItself = "true" # They don't fix themselves
  }
}
