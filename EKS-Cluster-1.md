### Video 1: Setting Up the EKS Cluster and Installing Essential Add-ons
Show the kubernetes architecture diagram and then tell which are AWS responsibility and which is customer's responsibility
Get the diagram from Kubernetes website and use it

- **Amazon EKS (Elastic Kubernetes Service):**
  - A managed Kubernetes service that makes it easy to run Kubernetes on AWS without needing to install and operate your own Kubernetes control plane or nodes.

Prerequistie
1. VPC with private and public subnets with proper tagging
2. IAM role - Cluster IAM role


- **CoreDNS:**
  - A DNS server that provides DNS services within EKS Kubernetes clusters, allowing containers to discover and connect to other containers.
  **CoreDNS** is a flexible, extensible DNS server that provides DNS and service discovery within Kubernetes clusters. Here’s a detailed explanation of its purpose and function:

### Purpose of CoreDNS
- **DNS Services:** CoreDNS provides DNS services within Kubernetes clusters, translating service names into IP addresses. This allows pods to communicate with each other using service names rather than IP addresses[1](https://coredns.io/manual/toc/).
- **Service Discovery:** CoreDNS integrates with Kubernetes to provide service discovery, enabling pods to discover and connect to other services within the cluster[2](https://coredns.io/).

### Function of CoreDNS
- **Plugin-Based Architecture:** CoreDNS is highly modular and uses a plugin-based architecture. Each plugin performs a specific DNS function, such as service discovery, metrics collection, or query rewriting[1](https://coredns.io/manual/toc/).
- **Kubernetes Integration:** The Kubernetes plugin in CoreDNS allows it to interact with the Kubernetes API to resolve service names to their corresponding ClusterIP addresses[3](https://www.ansiblepilot.com/articles/coredns-vs-externaldns/).
- **Flexibility and Customization:** CoreDNS can be customized by enabling or disabling plugins based on the specific needs of the cluster. This makes it highly flexible and efficient[2](https://coredns.io/).
- **Performance:** CoreDNS is designed to be fast and efficient, handling DNS queries quickly and reliably[2](https://coredns.io/).

### Key Features
- **Service Discovery:** Resolves internal Kubernetes service names to their corresponding IP addresses, facilitating communication between pods[3](https://www.ansiblepilot.com/articles/coredns-vs-externaldns/).
- **Metrics Collection:** Collects and exposes metrics for monitoring and performance analysis.
- **Query Rewriting:** Allows for the modification of DNS queries based on specific rules.

In summary, CoreDNS is an essential component for DNS and service discovery in Kubernetes clusters, providing reliable and efficient name resolution and enabling seamless communication between services.

If you have any more questions or need further clarification, feel free to ask!

[1](https://coredns.io/manual/toc/): [CoreDNS Manual](https://coredns.io/manual/toc/)
[2](https://coredns.io/): [CoreDNS Overview](https://coredns.io/)
[3](https://www.ansiblepilot.com/articles/coredns-vs-externaldns/): [CoreDNS vs ExternalDNS](https://www.ansiblepilot.com/articles/coredns-vs-externaldns/)
- **KubeProxy:**
  - A network proxy that runs on each node in a Kubernetes cluster, managing networking rules to allow communication between pods and services.
  **KubeProxy** is a critical component of Kubernetes responsible for maintaining network rules on each node in the cluster. Here’s a detailed explanation of its purpose and function:

### Purpose of KubeProxy
- **Network Proxy:** KubeProxy acts as a network proxy,ensuring that requests to Kubernetes services are properly routed to the appropriate pods[1](https://kodekloud.com/blog/kube-proxy/).
- **Load Balancer:** It performs load balancing for network traffic, distributing requests across multiple pods to ensure even load distribution and high availability[2](https://zesty.co/finops-glossary/kubernetes-kube-proxy/).
- **Service Management:** KubeProxy monitors changes to service objects and their endpoints, translating these changes into actual network rules inside the node[1](https://kodekloud.com/blog/kube-proxy/).

### Function of KubeProxy
- **Service-to-Pod Mapping:** KubeProxy maintains a network routing table that maps service IP addresses to the IP addresses of the pods that belong to the service. This allows consistent communication with pods, even as they are terminated and recreated[1](https://kodekloud.com/blog/kube-proxy/).
- **Network Rules Management:** It manages network rules using different modes such as iptables, IPVS, or user-space mode, depending on the configuration[3](https://kubernetes.io/docs/reference/command-line-tools-reference/kube-proxy/).
- **Protocol Support:** KubeProxy supports various protocols, including TCP, UDP, and SCTP, ensuring versatile network communication within the cluster[3](https://kubernetes.io/docs/reference/command-line-tools-reference/kube-proxy/).

### Modes of Operation
- **User-Space Mode:** In this mode, KubeProxy runs in user space and forwards traffic to the appropriate pod.
- **Iptables Mode:** This mode uses iptables rules to handle traffic routing, providing better performance and scalability.
- **IPVS Mode:** IPVS (IP Virtual Server) mode offers advanced load balancing capabilities and is suitable for large-scale clusters[1](https://kodekloud.com/blog/kube-proxy/).

In summary, KubeProxy is essential for managing network traffic within a Kubernetes cluster, ensuring efficient and reliable communication between services and pods.

- **Amazon VPC CNI Plugin:**
  - A plugin that allows Kubernetes pods to have the same IP address inside the pod as they do on the VPC network, enabling native VPC networking.
  Purpose of the Amazon VPC CNI Plugin
Pod Networking: The VPC CNI plugin is responsible for providing network connectivity to Kubernetes pods. It assigns VPC IP addresses to pods, allowing them to communicate with each other and with other AWS services using the same IP address space as the VPC1.
Elastic Network Interfaces (ENIs): The plugin manages ENIs on the EC2 instances that make up the EKS cluster. It attaches additional ENIs to nodes as needed and allocates IP addresses from the VPC to pods2.
IP Address Management: The plugin includes an IP Address Management (IPAM) daemon that maintains a pool of available IP addresses, ensuring that pods can be quickly assigned IPs when they are created2.
Scalability: By using VPC IP addresses, the plugin allows for a high number of pods per node, constrained only by the number of IP addresses available in the VPC and the instance type's ENI limits2.
Consequences of Skipping the Amazon VPC CNI Plugin
Lack of Network Connectivity: Without the VPC CNI plugin, pods would not have network connectivity, making it impossible for them to communicate with each other or with other AWS services1.
Manual Network Configuration: You would need to manually configure networking for your pods, which is complex and error-prone1.
Limited Pod Density: Without the efficient IP address management provided by the VPC CNI plugin, you would be limited in the number of pods you can run per node2.
Incompatibility with AWS Services: The VPC CNI plugin is specifically designed to integrate with AWS services, providing seamless networking and security features. Skipping it would result in a lack of integration and potential compatibility issues1.

- **EKS Pod Identity Agent:**
  - An add-on that allows Kubernetes service accounts to grant AWS IAM permissions to pods, enabling secure access to AWS resources.
  IAM Role: The controller needs an IAM role with the necessary permissions to create and manage AWS resources like ALBs.
Service Account: The Kubernetes service account used by the controller must be annotated with the IAM role ARN to allow the controller to assume the role and gain the required permissions.
Without the EKS Pod Identity Agent, you wouldn't be able to associate IAM roles with Kubernetes service accounts. This means the AWS Load Balancer Controller wouldn't have the necessary permissions to manage ALBs, and you wouldn't be able to deploy Ingress resources that rely on the ALB controller12.

In summary, the EKS Pod Identity Agent is essential for enabling secure and efficient access to AWS services for your Kubernetes pods, including the AWS Load Balancer Controller.
- **Metrics Server:**
  - A cluster-wide aggregator of resource usage data, providing metrics for Kubernetes components like the Horizontal Pod Autoscaler.