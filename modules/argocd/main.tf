terraform {
  required_providers {
    kubernetes = {
      source = "hashicorp/kubernetes"
    }
  }
}

provider "kubernetes" {
  host                   = var.EKS_CLUSTER_ENDPOINT
  token                  = data.aws_eks_cluster_auth.main.token
  cluster_ca_certificate = base64decode(${var.EKS_CLUSTER_NAME}.certificate_authority[0].data)
}

provider "helm" {
  kubernetes {
    host                   = data.aws_eks_cluster_auth.eks_cluster.endpoint
    token                  = data.aws_eks_cluster_auth.eks_cluster.token
    cluster_ca_certificate = base64decode(data.aws_eks_cluster_auth.eks_cluste.certificate_authority[0].data)
  }
}

data "aws_eks_cluster_auth" "eks_cluster" {
  name = var.EKS_CLUSTER_NAME
}

resource "helm_release" "argocd" {
  depends_on = [aws_eks_node_group.node_group]
  name       = "argocd-server-deploy"
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  version    = "4.5.2"

  namespace = "argocd-server-space"

  create_namespace = true

  set {
    name  = "server.service.type"
    value = "LoadBalancer"
  }

  set {
    name  = "server.service.annotations.service\\.beta\\.kubernetes\\.io/aws-load-balancer-type"
    value = "nlb"
  }
}


data "kubernetes_service" "argocd_server" {
  metadata {
    name      = "argocd-server"
    namespace = helm_release.argocd.namespace
  }
}