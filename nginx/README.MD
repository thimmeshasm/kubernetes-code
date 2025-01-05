kubectl create namespace eks-sample-app
kubectl exec -it eks-sample-linux-deployment-65b7669776-m6qxz -n eks-sample-app -- /bin/bash
kubectl get all -n eks-sample-app
kubectl -n eks-sample-app describe service eks-sample-linux-service
# Metadata
name: The name of the Deployment. In this case, it's eks-sample-linux-deployment.
 


 EKS AutoMode
 https://docs.aws.amazon.com/eks/latest/userguide/auto-elb-example.html


 Ingress Resource
 1. EKS cluster
 2. Have the AWS Load Balancer Controller deployed on your cluster
    https://docs.aws.amazon.com/eks/latest/userguide/aws-load-balancer-controller.html
3. Created IAM role
4. https://docs.aws.amazon.com/eks/latest/userguide/alb-ingress.html



Tasks
1. Create EKS cluster simple
    - Install Required Addons
        - CoreDNS
        - KubeProxy
        - VPCCNI
3. Deploy the nginx service & deployment 
4. Deploy ALB & create ingress resource
5. Access the application

Tasks
1. Create EKS cluster using autoenabled
    - Essential addons are included automatically
2. Deploy the nginx service & deployment 
3. Deploy the ingress resource
4. Access the Application
5. Deploy the game application
6. Deploy stateful workload
7. 



EKS vs EKS AutoEnabled
1. Loadbalancer is not required in EKSA
2. 



