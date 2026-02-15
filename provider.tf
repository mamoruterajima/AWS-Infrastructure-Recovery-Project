terraform {
  required_version = "~> 1.0" # バージョンを固定するのが実務の鉄則です
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "ap-northeast-1" # 東京リージョン

  # 実務ポイント：全てのリソースに自動でタグを付与する設定
  default_tags {
    tags = {
      Project     = "InfraRecovery"
      Environment = "dev"
      ManagedBy   = "Terraform"
    }
  }
}