#BAD?
module "my_bucket" {
  source = "./modules/s3_module/"
  acl = "private" #BAD?
  aws_service_name = "s3" #BAD?
  bucket_name = "the-great-bucket"
  owner_id = "arn::iam/me" #BAD?
}