#!/bin/bash
ips=`cat list`
key='/home/www/ansible/files/pemkey/oms/Fruitday.pem'
for ip in $ips
do
    ssh -i ${key}  ec2-user@${ip} "cat /home/ec2-user/.ssh/authorized_keys"
    #ssh  ec2-user@${ip} "cat /home/ec2-user/.ssh/authorized_keys"
echo $ip
echo '--------------------------'
    read -p "是否同步authorized_keys?([y]/n): "
    if [ "$REPLY" == "y" ]; then
#        scp  -r files/local/.ssh ec2-user@${ip}:/home/ec2-user/
        scp -i ${key} -r files/local/.ssh ec2-user@${ip}:/home/ec2-user/
    fi
done
