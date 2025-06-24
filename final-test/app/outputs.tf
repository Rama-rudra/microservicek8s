output "nginx_public_url" {
  value = "http://${kubernetes_service.nginx.status[0].load_balancer[0].ingress[0].hostname}"
}
