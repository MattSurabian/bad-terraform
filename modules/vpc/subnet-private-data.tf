resource "aws_subnet" "private_data" {
  count                   = length(var.private_data_subnets)
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.private_data_subnets[count.index]
  availability_zone       = local.azs[count.index]
  map_public_ip_on_launch = false
  tags = merge(var.tags, {
    Name                              = "sub-priv-data-${local.prefix}-${split("-", local.azs[count.index])[2]}-${local.suffix}"
    "kubernetes.io/role/internal-elb" = 1
  })
  lifecycle {
    ignore_changes = [tags]
  }
}

resource "aws_route_table" "private_data" {
  count  = length(var.private_data_subnets)
  vpc_id = aws_vpc.main.id
  tags = merge(var.tags, {
    Name = "rtb-priv-data-${local.prefix}-${split("-", local.azs[count.index])[2]}-${local.suffix}"
  })
  lifecycle {
    ignore_changes = [tags]
  }
}

resource "aws_route_table_association" "private_data" {
  count          = length(var.private_data_subnets)
  subnet_id      = aws_subnet.private_data[count.index].id
  route_table_id = aws_route_table.private_data[count.index].id
}
