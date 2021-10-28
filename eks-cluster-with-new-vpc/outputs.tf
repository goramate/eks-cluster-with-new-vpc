output "configure_kubectl" {
  description = "Configure kubectl: make sure you're logged in with the correct AWS profile and run the following command to update your kubeconfig"
  value       = "aws eks --region ${data.aws_region.current.id} update-kubeconfig --name ${module.aws-eks-accelerator-for-terraform.cluster_name}"
}
output "cluster_name" {
  description = "Kubernetes Cluster Name"
  value       = module.aws-eks-accelerator-for-terraform.cluster_name
}
output "cluster_oidc_url" {
  description = "The URL on the EKS cluster OIDC Issuer"
  value       = module.aws-eks-accelerator-for-terraform.cluster_oidc_url
}

output "oidc_provider_arn" {
  description = "The ARN of the OIDC Provider if `enable_irsa = true`."
  value       = module.aws-eks-accelerator-for-terraform.oidc_provider_arn
}
