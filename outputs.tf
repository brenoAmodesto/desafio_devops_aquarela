output "access_entries" {
  description = "Map of access entries created and their attributes"
  value       = module.eks.access_entries
}

output "cluster_endpoint" {
  value =  module.eks.cluster_endpoint
}