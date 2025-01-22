terraform {
  backend "s3" {
    bucket         = "gt-bucket-terraform"
    key            = "alb-sg-ec2/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-lock"
    encrypt        = true
  }
}