### Video 1: Setting Up the EKS Cluster and Installing Essential Add-ons
- **Amazon EKS (Elastic Kubernetes Service):**
  - A managed Kubernetes service that makes it easy to run Kubernetes on AWS without needing to install and operate your own Kubernetes control plane or nodes.
- **CoreDNS:**
  - A DNS server that provides DNS services within EKS Kubernetes clusters, allowing containers to discover and connect to other containers.
- **KubeProxy:**
  - A network proxy that runs on each node in a Kubernetes cluster, managing networking rules to allow communication between pods and services.
- **Amazon VPC CNI Plugin:**
  - A plugin that allows Kubernetes pods to have the same IP address inside the pod as they do on the VPC network, enabling native VPC networking.
- **EKS Pod Identity Agent:**
  - An add-on that allows Kubernetes service accounts to grant AWS IAM permissions to pods, enabling secure access to AWS resources.


### Video 2: Deploying a Sample Application on EKS Managed Node Group
- **Node Group:**
  - A group of EC2 instances within an EKS cluster that provides the compute resources for running Kubernetes workloads.
- **Namespace:**
  - A Kubernetes object that provides a way to divide cluster resources between multiple users, allowing for resource isolation and management.
- **Nginx:**
  - A popular open-source web server and reverse proxy server used for serving web content and load balancing.



### Video 3: How to access service in EKS using Kubernetes ClusterIP/Ingress
- **ClusterIP:**
  - A type of Kubernetes service that exposes the service on a cluster-internal IP, making it accessible only within the cluster.
- **Application Load Balancer (ALB):**
  - A load balancer that automatically distributes incoming application traffic across multiple targets, such as EC2 instances, containers, and IP addresses.
- **IAM Roles and Policies:**
  - AWS Identity and Access Management (IAM) roles and policies that define permissions for AWS resources and services.
- **OIDC Provider:**
  - An OpenID Connect (OIDC) provider that allows Kubernetes service accounts to assume IAM roles, enabling secure access to AWS resources.

Kubernetes Ingress
Ingress is an API object that manages external access to services in a Kubernetes cluster, typically HTTP and HTTPS.
It provides a way to define rules for routing traffic to different services based on the request's host and path.
Ingress can also handle SSL/TLS termination, load balancing, and name-based virtual hosting.
Ingress Controller
An Ingress Controller is a specialized load balancer for Kubernetes that implements the Ingress API.
It watches the Kubernetes API server for changes to Ingress resources and updates its configuration to reflect those changes.
There are various Ingress Controllers available, such as NGINX, Traefik, and HAProxy, each with different features and capabilities.
How They Work Together
Define Ingress Resource: You create an Ingress resource in your Kubernetes cluster, specifying the rules for routing traffic.
Ingress Controller: The Ingress Controller reads the Ingress resource and configures the underlying load balancer to route traffic according to the defined rules.
Traffic Routing: External traffic is routed to the appropriate services based on the Ingress rules.

- **Ingress Resource:**
  - A Kubernetes object that manages external access to services within a cluster, typically HTTP and HTTPS traffic.



### Video 8: Using One ALB for Multiple Services
- **Multiple Services with One ALB:**
  ### Video 7: Deploying a Game Sample Application
- **2048 Game Application:**
  - A simple, popular puzzle game where players combine numbered tiles to reach the number 2048.- 
  Configuring a single Application Load Balancer to handle traffic for multiple services, optimizing resource usage and cost.

These definitions should help provide a clear understanding of each topic covered in the video series.