resource "helm_release" "nginx_ingress" {
  name       = "nginx-ingress"
  repository = "https://kubernetes.github.io/ingress-nginx"
  chart      = "ingress-nginx"
  namespace  = "ingress-nginx"

  create_namespace = true

  wait    = true
  atomic = true
  timeout = 600

  values = [<<EOF
controller:
  service:
    type: NodePort
  admissionWebhooks:
    enabled: false
EOF
  ]
}
