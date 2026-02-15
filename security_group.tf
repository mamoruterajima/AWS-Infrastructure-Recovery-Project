# Webサーバー用のセキュリティグループ
resource "aws_security_group" "web_sg" {
  name        = "${var.project_prefix}-web-sg"
  description = "Allow HTTP and SSH traffic"
  vpc_id      = aws_vpc.main.id

  # インバウンドルール：外から中への通信
  # HTTP (80) をどこからでも許可
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # SSH (22) をどこからでも許可（実務では自分のIPに絞りますが、まずは接続優先）
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # アウトバウンドルール：中から外への通信
  # 全ての通信を許可（サーバーのアップデート等に必要）
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_prefix}-web-sg"
  }
}