output "public_url" {
  value = kubernetes_service.app_service.status[0].load_balancer[0].ingress[0].hostname
}
