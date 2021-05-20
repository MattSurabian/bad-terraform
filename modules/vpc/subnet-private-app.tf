resource "aws_subnet" "private_app" {
  count                   = length(var.private_app_subnets)
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.private_app_subnets[count.index]
  availability_zone       = local.azs[count.index]
  map_public_ip_on_launch = false
  tags = merge(var.tags, {
    Name                              = "sub-priv-${local.prefix}-${split("-", local.azs[count.index])[2]}-${local.suffix}"
    "kubernetes.io/role/internal-elb" = 1
  })
  lifecycle {
    ignore_changes = [tags]
  }
}

resource "aws_route_table" "private_app" {
  count  = length(var.private_app_subnets)
  vpc_id = aws_vpc.main.id
  tags = merge(var.tags, {
    Name = "rtb-priv-${local.prefix}-${split("-", local.azs[count.index])[2]}-${local.suffix}"
  })
  lifecycle {
    ignore_changes = [tags]
  }
}

resource "aws_route_table_association" "private_app" {
  count          = length(var.private_app_subnets)
  subnet_id      = aws_subnet.private_app[count.index].id
  route_table_id = aws_route_table.private_app[count.index].id
}

resource "aws_eip" "nat" {
  count = var.include_nat == true ? length(var.private_app_subnets) : 0
  vpc   = true
}

resource "aws_nat_gateway" "private_app" {
  count         = var.include_nat == true ? length(var.private_app_subnets) : 0
  allocation_id = aws_eip.nat[count.index].id
  subnet_id     = aws_subnet.public[count.index].id
  depends_on    = [aws_internet_gateway.main]
  tags = merge(var.tags, {
    Name = "nat-priv-${local.prefix}-${split("-", local.azs[count.index])[2]}-${local.suffix}"
  })
  lifecycle {
    ignore_changes = [tags]
  }
}

resource "aws_route" "private_app_gateway" {
  count                  = var.include_nat == true ? length(var.private_app_subnets) : 0
  route_table_id         = aws_route_table.private_app[count.index].id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.private_app[count.index].id
}
