output "EKS_CLUSTER_NAME" {
    value = aws_eks_cluster.eks_cluster.id
}

output "EKS_CLUSTER_ENDPOINT" {
    value = aws_eks_cluster.eks_cluster.endpoint
}