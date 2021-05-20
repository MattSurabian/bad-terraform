resource "aws_instance" "incredible_9_9s" {
  count         = 2
  ami           = "ami-windows-NT4"
  instance_type = "t2.medium"
  subnet_id = module.vpc.private_app_subnet_ids[count.index%length(module.vpc.private_app_subnet_ids)]
  iam_instance_profile = "incredible-profile" #BAD! NO!
  user_data = <<EOF
    # Death to SSH. For real.
    rm -rf /home/ec2-user/.ssh
    service sshd stop

    # Ensures we're totally up to date. Headlessly?
    apt update #BAD! NO!
    apt-get dist-upgrade #BAD! NO!
EOF
  tags = {
    Name = "incredible-9-9s-of-uptimes-server-${count.index}"
  }
  lifecycle {
    ignore_changes = [tags]
  }
  #BAD! NO!
  provisioner "local-exec" {
    # Maybe this ensures we're totally up to date?
    command = "#apt update"
  }
}
