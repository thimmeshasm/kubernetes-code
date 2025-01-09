kubectl create namespace eks-sample-app
kubectl exec -it eks-sample-linux-deployment-65b7669776-m6qxz -n eks-sample-app -- /bin/bash
kubectl get all -n eks-sample-app
kubectl -n eks-sample-app describe service eks-sample-linux-service
kubectl get events -n kube-system --sort-by='.metadata.creationTimestamp' | tail -n 10
kubectl logs -n kube-system aws-load-balancer-controller-7869d5f794-c9t8x
kubectl delete ingress ingress-service -n eks-sample-app
{"level":"info","ts":"2025-01-05T20:00:21Z","msg":"version","GitVersion":"v2.11.0","GitCommit":"ba4152c1ba7c75be194d75cf343219d4aeaeb116","BuildDate":"2024-12-12T21:01:50+0000"}
{"level":"error","ts":"2025-01-05T20:00:26Z","logger":"setup","msg":"unable to initialize AWS cloud","error":"failed to introspect region from EC2Metadata, specify --aws-region instead if EC2Metadata is unavailable: operation error ec2imds: GetRegion, canceled, context deadline exceeded"}

Delete all pods - doesnt delete ingress reosurce
```
kubectl delete all --all -n game-2048
```

kubectl delete ingress -n game-2048 game-service-ingress
kubectl delete ingress ingress-service -n eks-sample-app

# COnnect to EKS
```
aws eks --region us-east-1 update-kubeconfig --name test

```
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
          CoreDNS provides DNS services within EKS Kubernetes clusters. DNS allows individual containers to easily discover and connect to other containers within the cluster.
          This add-on is included with every EKS cluster by default.
        - KubeProxy
            kube-proxy is a network proxy that runs on each node in a Kubernetes cluster. The role of kube-proxy is to reflect the services defined in the cluster and manage the networking rules on a node to allow communications to the pods that back a service.
            This add-on is included with every EKS cluster by default.
        - VPCCNI
          Amazon EKS supports native VPC networking with the Amazon VPC CNI plugin for Kubernetes. Using this plugin allows Kubernetes pods to have the same IP address inside the pod as they do on the VPC network.
          We recommend the Amazon VPC CNI plugin for Kubernetes for nodes on Amazon EC2 instances.
        - EKS Pod Identity Agent
          Install EKS Pod Identity Agent to use EKS Pod Identity to grant AWS IAM permissions to pods through Kubernetes service accounts.
          Be sure to install the Amazon EKS Pod Identity Agent add-on prior to creating, editing or deleting Pod Identity associations. This add-on is required for the EKS Pod Identity feature to function properly
        - Metrics Server
2. Updating this addons is a user's responsibility
3. Create a NodeGroup
4. Deploy nginx sample deployment
    https://docs.aws.amazon.com/eks/latest/userguide/sample-deployment.html
     - kubectl create namespace eks-sample-app
     - kubectl apply -f deploy.yaml
     - kubectl get pods -o wide -A
     - Get the IP
     - kubectl exec -it eks-sample-linux-deployment-65b7669776-m6qxz -n eks-sample-app -- /bin/bash
     - curl and validate nginx homepage is coming or not
     - 
5. Deploy the nginx service
    - Use ClusterIP for Internal Communication: For services that need to communicate internally, use ClusterIP services. This ensures efficient and secure internal communication.
    - kubectl apply -f service.yaml
    - kubectl get all -n eks-sample-app
6. Deploy ALB (https://docs.aws.amazon.com/eks/latest/userguide/lbc-helm.html)
    - Create IAM role & policy provided by AWS doc
            ```
            {
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Federated": "arn:aws:iam::xxxxxxxx:oidc-provider/oidc.eks.us-east-1.amazonaws.com/id/FA064912B8007F5AC4EA4D8D90C1AA36"
            },
            "Action": "sts:AssumeRoleWithWebIdentity",
            "Condition": {
                "StringEquals": {
                    "oidc.eks.us-east-1.amazonaws.com/id/FA064912B8007F5AC4EA4D8D90C1AA36:aud": "sts.amazonaws.com",
                    "oidc.eks.us-east-1.amazonaws.com/id/FA064912B8007F5AC4EA4D8D90C1AA36:sub": "system:serviceaccount:kube-system:aws-load-balancer-controller"
                }
            }
        }
    ]
}

    - Create OIDC Provider (https://docs.aws.amazon.com/eks/latest/userguide/enable-iam-roles-for-service-accounts.html)

### Create a Service Account

Purpose: This command creates a new service account named aws-load-balancer-controller in the kube-system namespace.

Service Account: A service account in Kubernetes is used to provide an identity for processes that run in a Pod. This identity can be used to access the Kubernetes API and other resources.

```
    kubectl create serviceaccount aws-load-balancer-controller -n kube-system
```

### Annotation

Purpose: This command adds an annotation to the aws-load-balancer-controller service account.
Annotation: Annotations are key-value pairs that can be attached to Kubernetes objects. They are used to store arbitrary metadata.

Role ARN: The annotation eks.amazonaws.com/role-arn specifies the Amazon Resource Name (ARN) of an IAM role. This IAM role grants the necessary permissions for the AWS Load Balancer Controller to interact with AWS resources.

```
    kubectl annotate serviceaccount aws-load-balancer-controller -n kube-system eks.amazonaws.com/ role-arn=arn:aws:iam::936379345511:role/acct-managed/eks-alb-role

    
    kubectl describe serviceaccount aws-load-balancer-controller -n kube-system

 ```

Purpose: This command provides detailed information about the aws-load-balancer-controller service account in the kube-system namespace.

Output: The output includes information such as the annotations, secrets, and tokens associated with the service account.



### Run Helm Commands
```
helm repo add eks https://aws.github.io/eks-charts
helm repo update eks
helm install aws-load-balancer-controller eks/aws-load-balancer-controller \
  -n kube-system \
  --set clusterName=test \
  --set serviceAccount.create=false \
  --set region=us-east-1 \
  --set vpcId=vpc-0a39e03c2cec4d6f4 \
  --set serviceAccount.name=aws-load-balancer-controller
```

Check the status
```
   kubectl get deployment -n kube-system aws-load-balancer-controller
```



8. Deploy ingress resource
    - kubectl apply -f ingress.yaml
    - Troubleshoot - 
       - response error StatusCode: 403, RequestID: d87d4c0c-31b8-483f-859d-6f62dad5d032, api error AccessDenied: Not authorized to perform sts:AssumeRoleWithWebIdentity
         - Update IAM trust policy
         - Restart ALB
    kubectl rollout restart deployment/aws-load-balancer-controller -n kube-system
       -  Failed build model due to couldn't auto-discover subnets: unable to resolve at least one subnet (0 match VPC and tags: [kubernetes.io/role/elb])
           - Update one public subnet 
                 kubernetes.io/role/elb = 1
           - Delete ingress resource and recreated agaub
           - Failed build model due to couldn't auto-discover subnets: subnets count less than minimal required count: 1 < 2
           - Updatethe public subnet - 2
           - Now it has created ALB on AWS console and all the requires secuirty group in an automated way
9. DEploy Game sample application also
   https://docs.aws.amazon.com/eks/latest/userguide/alb-ingress.html    
   kubectl apply -f https://raw.githubusercontent.com/kubernetes-sigs/aws-load-balancer-controller/v2.11.0/docs/examples/2048/2048_full.yaml    
   
3. Deploy ALB & create ingress resource
4. Access the application
5. Use one ALB for multiple services


# Create Fargate Profile
1. IAM role
2. Create Fargate profile using different namespace name
3. EC2 managed node group and Fargate profile cant have the same namespace ?

Tasks
1. Create EKS cluster using autoenabled
    - Essential addons are included automatically
2. Deploy the nginx service & deployment 
3. Deploy the ingress resource
4. Access the Application
5. Deploy the game application
    test the game application for storage - How does that work
6. Deploy stateful workload




EKS vs EKS AutoEnabled
1. Loadbalancer is not required in EKSA
2. Helm The deployed chart doesn’t receive security updates automatically. You need to manually upgrade to a newer chart when it becomes available.



OutStanding Question/DEMO
1. Use 1 ALB for multiple services
2. Ingress resource doesnt tied to specific namespace


eksctl create iamserviceaccount \
  --cluster=my-cluster \
  --namespace=kube-system \
  --name=aws-load-balancer-controller \
  --role-name AmazonEKSLoadBalancerControllerRole \
  --attach-policy-arn=arn:aws:iam::111122223333:policy/AWSLoadBalancerControllerIAMPolicy \
  --approve \
  --dry-run > aws-load-balancer-controller.yaml


# EKS using Terraform
https://catalog.us-east-1.prod.workshops.aws/workshops/afee4679-89af-408b-8108-44f5b1065cc7/en-US/500-eks-terraform-workshop/570-observability
