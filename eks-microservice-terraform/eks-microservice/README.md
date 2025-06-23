# EKS Microservice with Terraform

This setup provisions an Amazon EKS cluster and deploys a Python Flask microservice via Terraform.

## Steps

1. **Update the Docker image** in `k8s.tf` with your actual Docker Hub image.
2. **Initialize Terraform**
   ```bash
   terraform init
   ```

3. **Apply Terraform**
   ```bash
   terraform apply
   ```

4. **Get the Load Balancer URL**
   ```bash
   terraform output load_balancer_hostname
   ```

## Cleanup
```bash
terraform destroy
```
