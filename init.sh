#!/bin/bash
host=$1
localdir=$2
user=$3
type=$4
if [[ -z $1 ]];then
    echo "for example ./init.sh new-server local ec2-user java"
    exit
fi
#同步ssh
ansible-playbook -i hosts --extra-vars "hosts=${host} localdir=${localdir} user=${user}" ssh.yaml

#初始化
ansible-playbook -i hosts --extra-vars "hosts=${host}" init.yaml
#java
if [[ $type == "java" ]];then
    ansible-playbook -i hosts --extra-vars "hosts=${host} type=${type}" java.yaml
    ansible-playbook -i hosts  nginx.yaml
fi


ansible-playbook -i hosts --extra-vars "hosts=${host}" deploy-shell.yaml
ansible-playbook -i hosts --extra-vars "hosts=${host}" s3fs.yaml

