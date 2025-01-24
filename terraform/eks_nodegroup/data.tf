data "aws_subnets" "private_subnets" {
  filter {
    name   = "vpc-id"
    values = [module.vpc.vpc_id]
  }
  filter {
    name   = "availability-zone"
    values = ["us-east-1b", "us-east-1c"] # Replace with your cluster AZs
  }
  filter {
    name   = "tag:Name"
    values = ["*private*"] # This matches all subnets with a Name tag
  }
}

data "aws_subnets" "public_subnets" {
  filter {
    name   = "vpc-id"
    values = [module.vpc.vpc_id]
  }
  filter {
    name   = "tag:Name"
    values = ["*public*"] # This matches all subnets with a Name tag
  }
}