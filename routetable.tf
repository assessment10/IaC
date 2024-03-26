resource "aws_route_table" "lbroute" {
  vpc_id = aws_vpc.main_vpc.id

  tags = merge({
    Name = "lbroute-${terraform.workspace}"
  }, var.default_tags)
}

resource "aws_route_table" "ecsroute" {
  vpc_id = aws_vpc.main_vpc.id

  tags = merge({
    Name = "ecsroute-${terraform.workspace}"
  }, var.default_tags)
}

resource "aws_route" "internet_access_lb" {
  route_table_id         = aws_route_table.lbroute.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

resource "aws_route" "internet_access_ecs" {
  route_table_id         = aws_route_table.ecsroute.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

resource "aws_route_table_association" "private_route_ecs_table_association" {
  count          = var.az_count
  subnet_id      = element(aws_subnet.ecssubnets.*.id, count.index)
  route_table_id = aws_route_table.ecsroute.id
}

resource "aws_route_table_association" "public_web_route_table_association" {
  count          = var.az_count
  subnet_id      = element(aws_subnet.lbsubnets.*.id, count.index)
  route_table_id = aws_route_table.lbroute.id
}
