resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main_vpc.id
  tags = merge({
    Name = "igw-${terraform.workspace}"
  }, var.default_tags)
}
