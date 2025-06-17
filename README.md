<img width="1248" alt="Screenshot 2025-06-15 at 23 09 06" src="https://github.com/user-attachments/assets/f9f21946-5e41-4998-bed0-11073418140e" /># microservice-on-ECS-TF-automation
## **Technology Usage**

- Architecture overviews
    
    ![Screenshot 2025-06-15 at 3.24.00.png](attachment:dae55d69-dafe-44ad-9625-e1f6ea392a5a:Screenshot_2025-06-15_at_3.24.00.png)
    
- Infrustructure overviews
    1. **ECR** for **private** registry
    2. **IAM roles** are used instead of IAM users **to grant temporary and scoped access to AWS services securely**
    3. **NAT gateway** - ECS tasks run in **private subnets** and need to **Pull container images** from Amazon ECR
    4. **AWS Cloud Map** - **dynamic DNS names**  (like `dettails.bookinfo.local`) as DNS.
    5. **ECS Fargate** - **Serverless container orchestration** and can configure auto-scaling and can assing cpu, memory and IAM roles per task 
    6. **Service Connect -** Connects services by name with optional aliases & security. **automates service discovery**
    7. **Load Balancer - public route traffic to productpage(frontend)**
    8. **Terraform** - **Automates** provisioning of infra, ECS, roles, networking, etc.
    9. **Terraform workspce share** -  **isolates** each microservice's configuration, avoiding interference
    10. **Shared State Access via Remote Backend - don't need to redefine** networking and IAM in every service , Teams can work independently , No state locking conflicts 
- Architecture Details Diagram
 (attachment:e0a08636-96d1-4dbb-9ab5-bdc095de9a1f:Screenshot_2025-06-15_at_15.21.34.png)
    
- PreRequirement in Terraform Cloud for workspace management
    1. Create respective workspace( infrastructure, product-page-service, details-servicce, reviews-service, ratings-service, reviews-service)
    2. Optional - set environment for remote execution 
    3. Configure workspace sharing ( infrastructure to other workspaces)
        
        ![Screenshot 2025-06-15 at 15.29.48.png](attachment:8173c995-0c90-40d9-a5e7-d6befa64df0e:Screenshot_2025-06-15_at_15.29.48.png)
        
    
- Terraform source link
    
    https://github.com/EiMiMiAung/microservice-on-ECS-TF-automation
    
- Deploy (**Recommended deployment step when child microservices are fully deployed**)
    1. git clone [git@github.com](mailto:git@github.com):EiMiMiAung/microservice-on-ECS-TF-automation.git
    2. cd microservice-on-ECS-TF-automation.git
    3. cd infrastructure
    4. terrafom init, terrafom fmt, terrafom validate, terrafom plan, terrafom apply —auto-approve
    5. cd../details
    6. terrafom init, terrafom fmt, terrafom validate, terrafom plan, terrafom apply —auto-approve
    7. cd../ratings
    8. terrafom init, terrafom fmt, terrafom validate, terrafom plan, terrafom apply —auto-approve
    9. cd../reviews
    10. terrafom init, terrafom fmt, terrafom validate, terrafom plan, terrafom apply —auto-approve
    11. cd../productpage
    12. terrafom init, terrafom fmt, terrafom validate, terrafom plan, terrafom apply —auto-approve
