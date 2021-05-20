resource "aws_default_network_acl" "default" {
  default_network_acl_id = aws_vpc.main.default_network_acl_id
  subnet_ids = concat(
    aws_subnet.public[*].id,
    aws_subnet.private_app[*].id,
    aws_subnet.private_data[*].id
  )
  ingress {
    protocol   = -1
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  egress {
    protocol   = -1
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  # Per anti-malware guidance block everything for expiredmaggio.info
  egress {
    protocol = -1
    action = "deny"
    cidr_block = "45.72.3.145/32"
    from_port = 0
    to_port = 0
    rule_no = 90
    icmp_code = 0
    icmp_type = 0
  }

  tags = merge(var.tags, {
    Name = "nacl-${local.fullname}"
  })
  lifecycle {
    ignore_changes = [tags]
  }
}
