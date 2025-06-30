resource "aws_security_group" "db" {
  name        = "${var.project}-db-sg"
  description = "Allow Postgres access from EKS nodes"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    description = "EKS nodes"
    security_groups = [aws_security_group.eks_nodes.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

data "aws_security_group" "eks_nodes" {
  filter {
    name   = "tag:eksctl.cluster.k8s.local/cluster-name"
    values = [var.project]
  }
  filter {
    name   = "group-name"
    values = ["eksctl-${var.project}-ClusterSharedNodeSecurityGroup-*"]
  }
}
