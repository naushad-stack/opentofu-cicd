resource "kubernetes_ingress_v1" "demo_ingress" {
  metadata {
    name      = "demo-ingress"
    namespace = kubernetes_namespace.apps.metadata[0].name
  }

  spec {
    ingress_class_name = "nginx"

    rule {
      host = "demo.local"

      http {
        path {
          path      = "/"
          path_type = "Prefix"

          backend {
            service {
              name = kubernetes_service.demo_service.metadata[0].name
              port {
                number = 80
              }
            }
          }
        }
      }
    }
  }

  depends_on = [
    kubernetes_service.demo_service,
    kubernetes_deployment.demo_app,
    helm_release.nginx_ingress
  ]
}
