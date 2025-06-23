
provider "kubernetes" {
  host                   = aws_eks_cluster.eks_cluster.endpoint
  cluster_ca_certificate = base64decode(aws_eks_cluster.eks_cluster.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.cluster.token
}

resource "kubernetes_deployment" "microservice" {
  metadata {
    name = "microservice"
    labels = {
      app = "microservice"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "microservice"
      }
    }

    template {
      metadata {
        labels = {
          app = "microservice"
        }
      }

      spec {
        container {
          image = "yourdockerhubusername/microservice-app:latest"
          name  = "microservice"
          port {
            container_port = 5000
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "microservice_service" {
  metadata {
    name = "microservice-service"
  }

  spec {
    selector = {
      app = "microservice"
    }

    type = "LoadBalancer"

    port {
      port        = 80
      target_port = 5000
    }
  }
}
