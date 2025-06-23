
output "load_balancer_hostname" {
  value = kubernetes_service.microservice_service.status[0].load_balancer.ingress[0].hostname
}
