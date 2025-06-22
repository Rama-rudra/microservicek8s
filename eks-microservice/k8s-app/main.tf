provider "kubernetes" {
  config_path = "~/.kube/config"
}

resource "kubernetes_namespace" "demo" {
  metadata {
    name = "demo"
  }
}

resource "kubernetes_deployment" "app" {
  metadata {
    name      = "demo-app"
    namespace = kubernetes_namespace.demo.metadata[0].name
  }

  spec {
    replicas = 2
    selector {
      match_labels = {
        app = "demo"
      }
    }
    template {
      metadata {
        labels = {
          app = "demo"
        }
      }
      spec {
        container {
          name  = "nginx"
          image = "nginx:latest"
          port {
            container_port = 80
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "app_service" {
  metadata {
    name      = "demo-service"
    namespace = kubernetes_namespace.demo.metadata[0].name
  }

  spec {
    selector = {
      app = "demo"
    }
    port {
      port        = 80
      target_port = 80
    }
    type = "LoadBalancer"
  }
}

