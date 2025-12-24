# Axy DevOps Engineer Assignment – AWS Infrastructure

## Overview of Infrastructure Design
This project uses Terraform to design a production-style AWS infrastructure for a
microservices application.

The setup is built inside a single VPC with public and private subnets across two
Availability Zones to ensure high availability. An Application Load Balancer handles
incoming traffic, which is routed to EC2 instances running in an Auto Scaling Group.
The backend connects to an RDS PostgreSQL database deployed in private subnets.


![AWS Infrastructure](image.png)
High level Flow:
User → Application Load Balancer → EC2 Auto Scaling Group → RDS PostgreSQL

## Why I Chose These AWS Services

- **VPC with Public and Private Subnets**  
  Provides network isolation and allows strict control over which resources are
  exposed to the internet.

- **Application Load Balancer (ALB)**  
  Used to distribute traffic evenly across EC2 instances and perform health checks.

- **EC2 with Auto Scaling Group**  
  Chosen for flexibility and control over the runtime environment. Auto Scaling
  improves availability and adjusts capacity based on load.

- **RDS PostgreSQL (Multi-AZ)**  
  Provides a managed database with automated backups and high availability through
  Multi-AZ deployment.

- **NAT Gateway**  
  Allows instances in private subnets to access the internet securely without exposing
  them publicly.
  
Note: For this assignment, the infrastructure was reviewed using terraform plan.
terraform apply does not need to be run to avoid AWS costs.

## How to Deploy

### Prerequisites
- AWS account
- AWS CLI installed and configured
- Terraform installed

### Commands
```bash
terraform init
terraform plan
terraform apply
Security Considerations

Only the Application Load Balancer is publicly accessible
EC2 instances do not have public IP addresses
The database is deployed in private subnets only

Security groups follow the principle of least privilege:
   ALB can access backend EC2 instances
   Backend EC2 instances can access the RDS database
   No direct internet access to the database

Private subnets use a NAT Gateway for controlled outbound access

Assumptions

AWS credentials are already configured using aws configure
A valid AMI ID exists for the selected AWS region
Backend application image is available (Docker Hub or Amazon ECR)
HTTPS and custom domains would require an existing ACM certificate and
Route53 hosted zone
The infrastructure is reviewed using Terraform code and terraform plan

Trade-offs

Cost vs Performance:
Small instance types (t3.micro) were used to reduce cost, which may limit
performance under heavy load.

Security vs Cost:
A NAT Gateway adds cost but was chosen to follow proper security practices.

Simplicity vs Completeness:
HTTP is used instead of HTTPS to avoid hardcoding invalid ACM certificates.
CI/CD and monitoring are not implemented to keep the focus on core infrastructure.

Conclusion

This project demonstrates a clean and secure AWS infrastructure using Terraform.
The design follows real-world DevOps best practices while balancing cost,
simplicity, and scalability.

