# 最新の Amazon Linux 2023 の ID を自動取得する
data "aws_ami" "amazon_linux_2023" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023*-x86_64"]
  }
}

# EC2インスタンスの定義
resource "aws_instance" "web" {
  ami                         = data.aws_ami.amazon_linux_2023.id
  instance_type               = "t3.micro"
  subnet_id                   = aws_subnet.public_1a.id
  vpc_security_group_ids      = [aws_security_group.web_sg.id]
  associate_public_ip_address = true # 外からアクセスするためにIPを付与

  # 起動時に実行するコマンド（Webサーバー化）
  user_data = <<-EOF
              #!/bin/bash
              dnf update -y
              dnf install -y httpd
              systemctl start httpd
              systemctl enable httpd
              echo "<h1>Re-birth: Hello World from Terraform</h1>" > /var/www/html/index.html
              EOF

  tags = {
    Name = "${var.project_prefix}-web-server"
  }
}

# サーバーのIPアドレスを後で確認するために出力設定
output "public_ip" {
  value = aws_instance.web.public_ip
}