module addons {
  source = "github.com/particuleio/terraform-kubernetes-addons.git//modules/aws?ref=v2.17.0"
  eks = local.eks
  cluster-name = local.cluster-name
  cluster-autoscaler = {
    enabled = true
    extra_values = <<VALUES
serviceMonitor:
  # serviceMonitor.enabled -- If true, creates a Prometheus Operator ServiceMonitor.
  enabled: true
prometheusRule:
  # prometheusRule.enabled -- If true, creates a Prometheus Operator PrometheusRule.
  enabled: true
VALUES
  }
  kube-prometheus-stack = {
      enabled = true
      thanos_sidecar_enabled =false
      thanos_create_iam_resources_irsa=false
      extra_values = <<VALUES
prometheus:
  prometheusSpec:
    serviceMonitorSelectorNilUsesHelmValues: false
    ruleSelectorNilUsesHelmValues: false
    podMonitorSelectorNilUsesHelmValues: false
VALUES
  }
}
