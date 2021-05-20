output "id" {
  value = aws_vpc.main.id
}

output "cidr_block" {
  value = aws_vpc.main.cidr_block
}

output "name" {
  value = local.fullname
}

output "public_route_table_ids" {
  value = aws_route_table.public[*].id
}

output "private_app_route_table_ids" {
  value = aws_route_table.private_app[*].id
}

output "private_data_route_table_ids" {
  value = aws_route_table.private_data[*].id
}

output "public_subnet_ids" {
  value = aws_subnet.public[*].id
}

output "private_app_subnet_ids" {
  value = aws_subnet.private_app[*].id
}

output "private_data_subnet_ids" {
  value = aws_subnet.private_data[*].id
}

output "public_subnet_cidr_blocks" {
  value = aws_subnet.public[*].cidr_block
}

output "private_app_subnet_cidr_blocks" {
  value = aws_subnet.private_app[*].cidr_block
}

output "private_data_subnet_cidr_blocks" {
  value = aws_subnet.private_data[*].cidr_block
}