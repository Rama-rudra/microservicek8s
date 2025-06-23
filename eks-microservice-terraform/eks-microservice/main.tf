provider "aws" {
  region = "us-east-1"
}

resource "aws_eks_cluster" "eks_cluster" {
  name     = "microservice-cluster"
  role_arn = aws_iam_role.eks_cluster_role.arn

  vpc_config {
    subnet_ids = aws_subnet.public[*].id
  }

  depends_on = [aws_iam_role_policy_attachment.eks_cluster_policy]
}

resource "aws_eks_node_group" "node_group" {
  cluster_name    = aws_eks_cluster.eks_cluster.name
  node_group_name = "microservice-node-group"
  node_role_arn   = aws_iam_role.eks_node_role.arn
  subnet_ids      = aws_subnet.public[*].id
  scaling_config {
    desired_size = 2
    max_size     = 2
    min_size     = 1
  }

  depends_on = [aws_eks_cluster.eks_cluster]
}

# ... (IAM roles, VPC, subnet, and other resources are needed here)

output "cluster_name" {
  value = aws_eks_cluster.eks_cluster.name
}
