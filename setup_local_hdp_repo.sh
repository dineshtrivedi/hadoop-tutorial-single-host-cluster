#!/bin/bash
sudo wget -nv -N http://public-repo-1.hortonworks.com/ambari/centos6/2.x/updates/2.5.1.0/ambari.repo -O /etc/yum.repos.d/ambari.repo
sudo wget -nv -N http://public-repo-1.hortonworks.com/HDP/centos6/2.x/updates/2.6.1.0/hdp.repo -O /etc/yum.repos.d/hdp.repo

mkdir -p /var/www/html/
mkdir -p ~/ambari/repo
wget -nv -N http://public-repo-1.hortonworks.com/HDP/centos6/2.x/updates/2.6.1.0/HDP-2.6.1.0-centos6-rpm.tar.gz -O ~/ambari/repo/HDP-2.6.1.0-centos6-rpm.tar.gz
wget -nv -N http://public-repo-1.hortonworks.com/HDP-UTILS-1.1.0.21/repos/centos6/HDP-UTILS-1.1.0.21-centos6.tar.gz -O ~/ambari/repo/HDP-UTILS-1.1.0.21-centos6.tar.gz
wget -nv -N http://public-repo-1.hortonworks.com/ambari/centos6/2.x/updates/2.5.1.0/ambari-2.5.1.0-centos6.tar.gz -O ~/ambari/repo/ambari-2.5.1.0-centos6.tar.gz
