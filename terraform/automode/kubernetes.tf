resource "kubectl_manifest" "ingress_class_params" {
  yaml_body = jsonencode({
    apiVersion = "eks.amazonaws.com/v1"
    kind       = "IngressClassParams"
    metadata = {
      name = "eks-auto-alb"
    }
    spec = {
      scheme = "internet-facing"
    }
  })
}

resource "kubectl_manifest" "ingress_class" {
  yaml_body = jsonencode({
    apiVersion = "networking.k8s.io/v1"
    kind       = "IngressClass"
    metadata = {
      name = "eks-auto-alb"
    }
    spec = {
      controller = "eks.amazonaws.com/alb"
      parameters = {
        apiGroup = "eks.amazonaws.com"
        kind     = "IngressClassParams"
        name     = "eks-auto-alb"
      }
    }
  })
}
