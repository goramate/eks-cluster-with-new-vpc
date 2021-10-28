resource "kubectl_manifest" "test" {
    yaml_body = <<YAML
apiVersion: monitoring.coreos.com/v1
kind: PrometheusRule
metadata:
  annotations:
  labels:
    app: kube-prometheus-stacl

  name: kube-prometheus-stack-test.rules
  namespace: monitoring
spec:
  groups:
  - name: test.rules
    rules:
    - alert: Watchdog2
      annotations:
        description: |
          Exemplary alert
        runbook_url: https://github.com/kubernetes-monitoring/kubernetes-mixin/tree/master/runbook.md#alert-name-watchdog
        summary: An alert that should always be firing to certify that Alertmanager
          is working properly.
      expr: vector(1)
      labels:
        severity: none
YAML
}
