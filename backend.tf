terraform {
  backend "s3" {
    bucket         = "terraform-state-731872584493"
    key            = "dev/terraform.tfstate"
    region         = "ap-northeast-1"
    # dynamo_db_table = "terraform-lock"
    encrypt        = true                        # Stateファイルを暗号化する
  }
}