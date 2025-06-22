variable "region" {
  default = "us-east-1"
}

variable "cluster_name" {
  default = "eks-demo"
}

variable "vpc_id" {}
variable "subnet_ids" {
  type = list(string)
}

