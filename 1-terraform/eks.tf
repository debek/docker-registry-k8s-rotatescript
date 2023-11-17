data "aws_eks_cluster" "cluster" {
  name = module.eks.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_id
}

locals {
  cluster_name = var.cluster_name
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "12.2.0"

  cluster_name                    = "${local.cluster_name}"
  cluster_version                 = "1.20"
  subnets                         = module.vpc.private_subnets
  cluster_endpoint_private_access = true
  cluster_endpoint_public_access  = true

  vpc_id = module.vpc.vpc_id

  node_groups = {
    first = {
      desired_capacity = 1
      max_capacity     = 4
      min_capacity     = 1

      instance_type = "t2.medium"
      asg_max_size  = 4
    }
    second = {
      desired_capacity = 1
      max_capacity     = 4
      min_capacity     = 1

      instance_type = "t2.medium"
      asg_max_size  = 4
    }
  }

  write_kubeconfig   = true
  config_output_path = "./"
}

resource "kubernetes_namespace" "create_ingress-nginx_namespace" {
  metadata {
    name = "ingress-nginx"
  }
}

resource "helm_release" "nginx_ingress" {
  name      = "ingress-nginx"
  namespace = "ingress-nginx"

  repository = "https://kubernetes.github.io/ingress-nginx"
  chart      = "ingress-nginx"

  set {
    name  = "service.type"
    value = "ClusterIP"
  }
}

resource "kubernetes_namespace" "create_cert_manager_namespace" {
  metadata {
    name = "cert-manager"
  }
}

resource "helm_release" "cert_manager" {
  name         = "cert-manager"
  repository   = "https://charts.jetstack.io"
  chart        = "cert-manager"
  version      = "v1.6.0"
  namespace    = "cert-manager"
  force_update = "true"
  verify       = "false"
  set {
    name  = "installCRDs"
    value = "true"
  }
}

resource "helm_release" "metrics-server" {
  name       = "metrics-server"
  repository = "https://kubernetes-sigs.github.io/metrics-server"
  chart      = "metrics-server"
}

resource "aws_ebs_volume" "docker-registry-volume" {
  availability_zone = "eu-central-1a"
  size              = 10

  tags = {
    Name = "DockerRegistry"
  }
}