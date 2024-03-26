resource "aws_vpc" "main_vpc" {
  cidr_block = var.vpc_cidr

  tags = merge(
    {
      "Name" : "main-vpc-${terraform.workspace}"
  }, var.default_tags)
}

data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_subnet" "lbsubnets" {
  count                = var.az_count
  vpc_id               = aws_vpc.main_vpc.id
  cidr_block           = cidrsubnet(aws_vpc.main_vpc.cidr_block, 8, count.index + 30)
  availability_zone_id = data.aws_availability_zones.available.zone_ids[count.index % 2]

  tags = merge(
    {
      "Name" : "lb-subnet-${count.index}-${terraform.workspace}"
  }, var.default_tags)

}

resource "aws_subnet" "ecssubnets" {
  count                = var.az_count
  vpc_id               = aws_vpc.main_vpc.id
  cidr_block           = cidrsubnet(aws_vpc.main_vpc.cidr_block, 8, count.index + 20)
  availability_zone_id = data.aws_availability_zones.available.zone_ids[count.index % 2]

  tags = merge(
    {
      "Name" : "web-subnet-${count.index}-${terraform.workspace}"
  }, var.default_tags)

}