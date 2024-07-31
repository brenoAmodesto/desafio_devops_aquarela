resource "aws_iam_policy" "eks_node_ebs_policy" {
  name        = "EKSNodeEBSAccess"
  description = "Policy for EKS nodes to access EBS volumes"
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : [
          "ec2:AttachVolume",
          "ec2:CreateSnapshot",
          "ec2:CreateTags",
          "ec2:CreateVolume",
          "ec2:DeleteSnapshot",
          "ec2:DeleteTags",
          "ec2:DeleteVolume",
          "ec2:DescribeInstances",
          "ec2:DescribeSnapshots",
          "ec2:DescribeTags",
          "ec2:DescribeVolumes",
          "ec2:DetachVolume"
        ],
        "Resource" : "*"
      }
    ]
  })
}

data "aws_eks_cluster" "eks_cluster" {
  name = module.eks.cluster_name
}

data "aws_eks_node_groups" "node_groups" {
  cluster_name = data.aws_eks_cluster.eks_cluster.name
}

data "aws_eks_node_group" "node_group" {
  for_each = toset(data.aws_eks_node_groups.node_groups.names)
  cluster_name    = data.aws_eks_cluster.eks_cluster.name
  node_group_name = each.value
}

resource "aws_iam_role_policy_attachment" "eks_node_policy_attachment" {
  for_each = data.aws_eks_node_group.node_group

  role       = element(split("/", each.value.node_role_arn), 1)
  policy_arn = aws_iam_policy.eks_node_policy.arn

  depends_on = [
    module.eks,
    aws_iam_policy.eks_node_ebs_policy
  ]

}
