# AeCargo-Project
AWS ECS Cluster  Deployment using EC2 Instance with Terraform.

Amazon ECS is a fully managed container orchestration service that helps you easily deploy, manage, and scale containerized applications. It deeply integrates with the rest of the AWS platform to provide a secure and easy-to-use solution for running container workloads in the cloud and now on your infrastructure with Amazon ECS Anywhere. It is understood that the ECS would manage starting tasks on the EC2 instance based on the Docker Image (ngnix) stored in ECR container Register. Hence various security groups were created in this job/project as required by components and could be seen in the code. The following are some of the components provisioned with Terraform: 

• VPC with a public subnet as an isolated pool for my resources 

• Internet Gateway to contact the outer world

 • Security groups for RDS MySQL and for EC2s
 
 • Auto-scaling group for ECS cluster with launch configuration
 
 • RDS MySQL instance
 
 • ECR container registry 
 
• ECS cluster with task and service definition Cluster is created using container instances (EC2 launch type, not Fargate!). In addition further research are ongoing to deploy this provisioned infrastructure through git action to AWS from git hub.


