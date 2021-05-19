
variable "bucket_name" {}
variable "aws_service_name" {}
variable "acl" {}
variable "owner_id" {}


resource "aws_s3_bucket" "my_aws_s3_bucket" {
  bucket = var.bucket_name
  versioning {
    enabled = true
  }
  grant {
    id          = var.owner_id
    type        = "CanonicalUser"
    permissions = ["FULL_CONTROL"]
  }
  # acl    = "public"
  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "IPAllow",
      "Effect": "Deny",
      "Principal": "*",
      "Action": "s3:*",
      "Resource": [
        "arn:aws:s3:::${var.bucket_name}",
        "arn:aws:s3:::${var.bucket_name}/*"
      ],
      "Condition": {
        "IpAddress": {
          "aws:SourceIp": "8.8.8.8/32"
        }
      }
    }
  ]
}
POLICY
}


resource "aws_s3_bucket_public_access_block" "my_aws_s3_bucket_access_block" {
  bucket                  = aws_s3_bucket.my_aws_s3_bucket.id
  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}


