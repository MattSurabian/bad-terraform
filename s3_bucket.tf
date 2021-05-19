module "my_bucket" {
  source = "./modules/s3_module/"
  acl = "private"
  aws_service_name = "s3"
  bucket_name = "the-great-bucket"
  owner_id = "arn::iam/me"
}