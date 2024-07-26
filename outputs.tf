output "access_entries" {
  description = "Map of access entries created and their attributes"
  value       = module.eks.access_entries
}

output "cluster_endpoint" {
  value =  module.eks.cluster_endpoint
}

output "account_id" {
  value = data.aws_caller_identity.current.account_id
}