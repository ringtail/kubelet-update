#!/usr/bin/env bash 

set -e -x 

kubelet_version=$(/usr/bin/kubelet --version)
base_oss_repo="http://custom-kubernetes.oss-cn-hangzhou.aliyuncs.com/kubelet"

if [ -n "$OSS_REPO" ];then 
	base_oss_repo="$OSS_REPO" 
fi 

if [ -z "$VERSION" ];then
	echo "you must specific kubelet version."
	exit 0
fi 

if [ "$kubelet_version" == "Kubernetes $VERSION" ];then 
	echo "no need to update kubelet"
	echo "current kubelet version is $VERSION"
else 
	curl "$base_oss_repo/$VERSION/kubelet" -o /tmp/kubelet
	chmod +x /tmp/kubelet 
	mv /usr/bin/kubelet /tmp/kubelet_bak 
	mv /tmp/kubelet /usr/bin/kubelet 
	/bin/systemctl restart kubelet.service
fi 

cat 
