# microservice-on-ECS-TF-automation
## **Technology Usage**

- Architecture overviews
    
   <img width="547" alt="Screenshot 2025-06-15 at 3 24 00" src="https://github.com/user-attachments/assets/856fac31-6d80-42e4-b569-b4bd4ddabf6c" />
    
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
    10. **Shared State Access via Remote Backend - don't need to re
define** networking and IAM in every service , Teams can work independently , No state locking conflicts 
- Architecture Details Diagram
 <img width="1248" alt="Screenshot 2025-06-15 at 23 09 06" src="https://github.com/user-attachments/assets/f9f21946-5e41-4998-bed0-11073418140e" />
    
- PreRequirement in Terraform Cloud for workspace management
    1. Create respective workspace( infrastructure, product-page-service, details-servicce, reviews-service, ratings-service, reviews-service)
    2. Optional - set environment for remote execution 
    3. Configure workspace sharing ( infrastructure to other workspaces)
        
       <img width="745" alt="Screenshot 2025-06-15 at 15 29 48" src="https://github.com/user-attachments/assets/c2922218-0cac-49d7-8901-be999bc10f34" />
        
    
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
