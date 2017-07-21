#!/bin/bash
# Based on: https://github.com/LearningJournal/HadoopTutorials/blob/master/HDPInstall/prepare.sh

./setup_local_hdp_repo.sh

HOST_NAME=hdp.single.host.cluster.local
SHORT_NAME=hdp
read dummy IP_ADDRESS <<< $(hostname -I)
echo $IP_ADDRESS $HOST_NAME $SHORT_NAME | sudo tee -a /etc/hosts
sudo sed -i "s/HOSTNAME=localhost.localdomain/HOSTNAME=$HOST_NAME/g" /etc/sysconfig/network
sudo hostname $HOST_NAME
sudo service network restart

ssh-keygen
sudo cp -f ~/.ssh/id_rsa /root/.ssh
sudo cp -f ~/.ssh/id_rsa.pub /root/.ssh
rm ~/.ssh/id_rsa*
sudo touch /root/.ssh/authorized_keys
sudo cat /root/.ssh/id_rsa.pub | sudo tee -a /root/.ssh/authorized_keys
sudo chmod 700 /root/.ssh
sudo chmod 600 /root/.ssh/authorized_keys

#sudo ulimit -n 10000
sudo service ntpd start
sudo chkconfig ntpd on
sudo servive iptables stop
sudo chkconfig iptables off
sudo service ip6tables stop
sudo chkconfig ip6tables off
sudo setenforce 0
sudo sed -i 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/selinux/config
sudo sed -i 's/enabled=1/enabled=0/g' /etc/yum/pluginconf.d/refresh-packagekit.conf
sudo service httpd start
sudo chkconfig httpd on
sudo service sshd start
sudo chkconfig sshd on
cat transparent_hugepage.txt | sudo tee -a /etc/rc.local

tar -zxvf ~/ambari/repo/ambari-2.5.1.0-centos6.tar.gz -C /var/www/html/
tar -zxvf ~/ambari/repo/HDP-UTILS-1.1.0.21-centos6.tar.gz -C /var/www/html/
tar -zxvf ~/ambari/repo/HDP-2.6.1.0-centos6-rpm.tar.gz -C /var/www/html/
reboot