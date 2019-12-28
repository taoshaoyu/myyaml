#!/bin/bash

version_info=`kubeadm config images list 2>/dev/null`

for i in $version_info 
do 
    if [[ $i =~ coredns ]]
    then
        tmp2=`echo $i | sed 's@k8s.gcr.io@coredns@'`  
    else
        target=`echo $i | sed 's@k8s.gcr.io@kubeimage@'` 
        tmp=(${target//:/ })
        tmp2=${tmp[0]}-amd64:${tmp[1]}  
    fi
    echo ***pull $tmp2 && docker pull $tmp2
    echo ***modify tag from $tmp2 to $i  && docker tag $tmp2 $i
    echo ***delete tag && docker rmi $tmp2
done