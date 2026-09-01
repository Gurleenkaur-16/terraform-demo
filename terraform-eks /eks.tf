module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 21.0"

  name = local.name

  # Set an explicit Kubernetes version so child modules don't receive
  # a computed value (which breaks `count` evaluation during plan).
  kubernetes_version = "1.33"

  endpoint_public_access = true

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  control_plane_subnet_ids = module.vpc.intra_subnets

  addons = {
    vpc-cni = {
      most_recent = true
    }

    kube-proxy = {
      most_recent = true
    }

    coredns = {
      most_recent = true
    }
  }

  eks_managed_node_groups = {
    gk_cluster_ng = {
      # Use a newer instance family and on-demand capacity to improve stability
      instance_types = ["t3.medium"]

      min_size     = 2
      max_size     = 3
      desired_size = 2

      capacity_type = "ON_DEMAND"

      # Use the EKS-managed default launch template (simpler bootstrap behavior)
      create_launch_template     = false
      use_custom_launch_template = false

      # Ensure CNI policy is attached so nodes can configure networking
      iam_role_attach_cni_policy = true

      attach_cluster_primary_security_group = true
    }
  }

  tags = {
    Environment = local.env
    Terraform   = "true"
  }
}
