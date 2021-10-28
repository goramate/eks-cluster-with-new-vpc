provider "kubectl" {
  host                   = data.aws_eks_cluster.cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
  token                  = data.aws_eks_cluster_auth.cluster.token
  load_config_file       = false
}
provider "kubernetes" {
  host                   = data.aws_eks_cluster.cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
  token                  = data.aws_eks_cluster_auth.cluster.token
}
provider "helm" {
  kubernetes {
    host                   = data.aws_eks_cluster.cluster.endpoint
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
    token                  = data.aws_eks_cluster_auth.cluster.token
  }
}
data "aws_eks_cluster" "cluster" {
  name = local.cluster-name
}
data "aws_eks_cluster_auth" "cluster" {
  name = local.cluster-name
}


locals  {
  cluster-name = "aws001-preprod-dev-eks"
  eks = {
    "cluster_oidc_issuer_url" = "oidc.eks.eu-west-1.amazonaws.com/id/CD90BDCFE6749787FDF7E0FD677AC2BE"
    "configure_kubectl" = "aws eks --region eu-west-1 update-kubeconfig --name aws001-preprod-dev-eks"
    "oidc_provider_arn" = "arn:aws:iam::733637174688:oidc-provider/oidc.eks.eu-west-1.amazonaws.com/id/CD90BDCFE6749787FDF7E0FD677AC2BE"
  }
}
