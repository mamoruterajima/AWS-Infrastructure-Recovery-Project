# 1. ルートテーブルの作成 (パブリック用)
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  # 0.0.0.0/0（すべての通信）をインターネットゲートウェイに向ける
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "${var.project_prefix}-public-rt"
  }
}

# 2. サブネットとルートテーブルの紐付け
resource "aws_route_table_association" "public_1a" {
  subnet_id      = aws_subnet.public_1a.id
  route_table_id = aws_route_table.public.id
}