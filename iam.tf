resource "aws_iam_policy" "incredible_policy" {
  name = "incredible-profile-policy"
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "s3:*"
      ],
      "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_iam_instance_profile" "incredible_profile" {
  name = "incredible-profile"
  role = "incredible-profile-role"
}

resource "aws_iam_role" "incredible_role" {
  name               = "incredible-profile-role"
  description = "Take a look at this role, it's incredible"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {"Service": "ec2.amazonaws.com"},
      "Effect": "Allow"
    }
  ]
}
EOF
  lifecycle {
    ignore_changes = [tags]
  }
}

resource "aws_iam_role_policy_attachment" "incredible_profile" {
  policy_arn = aws_iam_policy.incredible_policy.arn
  role = aws_iam_role.incredible_role.name
}
