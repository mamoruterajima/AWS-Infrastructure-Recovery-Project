# AWS Infrastructure Recovery Project

## 概要
本プロジェクトは、Terraformを用いてAWS上に高可用性とセキュリティを考慮した3層アーキテクチャの基礎を構築するIaCプロジェクトです。

## 構築したアーキテクチャの特徴
- **バックエンドの要塞化**: `terraform.tfstate`をS3で管理。複数人開発を想定したStateの共有・保護を実装。
- **堅牢なネットワーク設計**: 
  - Public/Privateサブネットの分離による多層防御。
  - Internet GatewayおよびRoute Tableによる緻密なルーティング制御。
- **セキュリティの最小権限原則**: Security Groupにより、HTTP(80)およびSSH(22)のみを許可する厳格なインバウンドルールを適用。
- **自動プロビジョニング**: 
  - `data`ブロックを用いた最新AMIの動的取得。
  - `user_data`（シェルスクリプト）によるEC2起動時のWebサーバー自動構築。

## 使用技術
- Terraform (v1.x)
- AWS (VPC, EC2, S3, IAM)
- Amazon Linux 2023

## ディレクトリ構成
```text
.
├── backend.tf          # S3バックエンド設定（State管理）
├── provider.tf         # AWSプロバイダ・共通タグ設定
├── variables.tf        # プロジェクト共通変数の定義
├── vpc.tf              # ネットワーク基盤（VPC/Subnet/IGW）
├── route_table.tf      # ルーティング設定
├── security_group.tf   # ファイアウォール設定
├── ec2.tf              # サーバー本体・ユーザーデータ設定
└── README.md           # 本ドキュメント
