
module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"
  cluster_name    = "eks"
  cluster_version = "1.31"
  bootstrap_self_managed_addons = true
  cluster_upgrade_policy = {
   support_type = "STANDARD"
  }
  cluster_addons = {
    coredns                = {}
    eks-pod-identity-agent = {}
    kube-proxy             = {}
    vpc-cni                = {}
  }

  # Optional
  cluster_endpoint_public_access = true

  # Optional: Adds the current caller identity as an administrator via cluster access entry
  enable_cluster_creator_admin_permissions = true

  vpc_id                   =  module.vpc.vpc_id
  subnet_ids               = data.aws_subnets.private_subnets.ids
  control_plane_subnet_ids = data.aws_subnets.private_subnets.ids
  tags = {
    Environment = "dev"
    Terraform   = "true"
  }
}

module "eks_managed_node_group" {
  source = "terraform-aws-modules/eks/aws//modules/eks-managed-node-group"
cluster_service_cidr = module.eks.cluster_service_cidr
  name            = "separate-eks-mng"
  cluster_name    = module.eks.cluster_name
  cluster_version = "1.31"

  subnet_ids = data.aws_subnets.private_subnets.ids
  cluster_primary_security_group_id = module.eks.cluster_primary_security_group_id
  vpc_security_group_ids            = [module.eks.node_security_group_id]
  min_size     = 1
  max_size     = 2
  desired_size = 1

  instance_types = ["t3.large"]
  capacity_type  = "SPOT"

  labels = {
    Environment = "test"
    GithubRepo  = "terraform-aws-eks"
    GithubOrg   = "terraform-aws-modules"
  }

  tags = {
    Environment = "dev"
    Terraform   = "true"
  }
}
