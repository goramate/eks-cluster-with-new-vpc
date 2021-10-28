module "velero" {
  source  = "terraform-module/velero/kubernetes"
  version = "0.12.2"

  namespace_deploy            = true
  app_deploy                  = true
  cluster_name                = local.cluster-name
  openid_connect_provider_uri = local.eks.cluster_oidc_issuer_url
  bucket                      = aws_s3_bucket.b.id
  values = [<<EOF
# https://github.com/vmware-tanzu/helm-charts/tree/master/charts/velero

image:
  repository: velero/velero
  tag: v1.4.2

initContainers:
  - name: velero-plugin-for-aws
    image: velero/velero-plugin-for-aws:v1.1.0
    imagePullPolicy: IfNotPresent
    volumeMounts:
    - mountPath: /target
      name: plugins

# SecurityContext to use for the Velero deployment. Optional.
# Set fsGroup for `AWS IAM Roles for Service Accounts`
# see more informations at: https://docs.aws.amazon.com/eks/latest/userguide/iam-roles-for-service-accounts.html
securityContext:
  fsGroup: 1337

configuration:
  provider: aws

  backupStorageLocation:
    name: default
    provider: aws
    bucket: "mg-workshop-bucket"
    prefix: "velero/dev/my-cluster"
    config:
      region: eu-west-1

  volumeSnapshotLocation:
    name: default
    provider: aws
    # Additional provider-specific configuration. See link above
    # for details of required/optional fields for your provider.
    config:
      region: eu-west-1
metrics:
  serviceMonitor:
    enabled: true
EOF
  ]

  vars = {
    "version" = "2.12.0"
  }
  #tags = local.tags
}
