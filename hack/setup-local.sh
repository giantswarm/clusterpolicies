kind create cluster --image quay.io/giantswarm/kind-node:$1 --name kyverno-cluster
kubectl wait nodes/kyverno-cluster-control-plane --for=condition=ready --timeout=5m > /dev/null
kind get kubeconfig --name kyverno-cluster > $(pwd)/kube.config
# Giant Swarm CRDs
kubectl create --context kind-kyverno-cluster -f https://raw.githubusercontent.com/giantswarm/apiextensions/b9a6bed05850045530eaf8ba7fd01941de6c8525/helm/crds-common/templates/giantswarm.yaml
# CAPI CRDs
kubectl create --context kind-kyverno-cluster -f https://raw.githubusercontent.com/kubernetes-sigs/cluster-api/release-0.3/config/crd/bases/cluster.x-k8s.io_clusters.yaml
kubectl create --context kind-kyverno-cluster -f https://raw.githubusercontent.com/kubernetes-sigs/cluster-api/release-0.3/config/crd/bases/cluster.x-k8s.io_machinedeployments.yaml
# CAPA CRDs
kubectl create --context kind-kyverno-cluster -f https://raw.githubusercontent.com/kubernetes-sigs/cluster-api-provider-aws/main/config/crd/bases/infrastructure.cluster.x-k8s.io_awsclusters.yaml
kubectl create --context kind-kyverno-cluster -f https://raw.githubusercontent.com/kubernetes-sigs/cluster-api-provider-aws/main/config/crd/bases/infrastructure.cluster.x-k8s.io_awsmachinetemplates.yaml
kubectl create --context kind-kyverno-cluster -f https://raw.githubusercontent.com/kubernetes-sigs/cluster-api-provider-aws/main/config/crd/bases/infrastructure.cluster.x-k8s.io_awsclusterroleidentities.yaml
# CAPZ CRDs
kubectl create --context kind-kyverno-cluster -f https://raw.githubusercontent.com/kubernetes-sigs/cluster-api-provider-azure/master/config/crd/bases/infrastructure.cluster.x-k8s.io_azureclusters.yaml
# Kyverno
kubectl create --context kind-kyverno-cluster -f https://raw.githubusercontent.com/kyverno/kyverno/main/definitions/release/install.yaml
