provider "aws" {
  region = "us-east-1"
}
terraform {
  backend "s3" {
    region = "us-east-1"
    bucket = "devops4solutions-terraform"
    key    = "eks_cluster_1.tfstate"
  }
}