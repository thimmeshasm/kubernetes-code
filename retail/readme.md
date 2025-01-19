install helm - 3.7 version
aws cli
kubectl latest versdion

aws ecr-public get-login-password --region us-east-1 | helm registry login --username AWS --password-stdin public.ecr.aws


helm install -f values.yaml retail-store-app oci://public.ecr.aws/aws-containers/retail-store-sample-chart --version 0.8.3

kubectl get statefulset retail-store-app-catalog-mysql \
  -o jsonpath='{.spec.volumeClaimTemplates}' | jq .
