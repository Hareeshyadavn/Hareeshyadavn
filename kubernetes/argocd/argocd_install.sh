1. Install Argo CD
    kubectl create namespace argocd
    kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

2. Access The Argo CD API Server
    kubectl patch svc argocd-server -n argocd -p '{"spec": {"type": "NodePort"}}'

3. Install argocd cli
    curl -sSL -o argocd-linux-amd64 https://github.com/argoproj/argo-cd/releases/latest/download/argocd-linux-amd64
sudo install -m 555 argocd-linux-amd64 /usr/local/bin/argocd
rm argocd-linux-amd64

4. Login to argocd with user - "admin"
    To get password:
        argocd admin initial-password -n argocd

5. Register A Cluster To Deploy Apps
   a. Login to argocd from cli
        argocd login <server_ip>:<service_port>
		
		
Step 4 — Handling Multiple Clusters (Optional)
kubectl config get-contexts -o name

step-5 add ekscluster to argocd
argocd cluster add arn:aws:eks:ap-south-1:625764689828:cluster/test-eks-cluster --name t
est
		
