#!/bin/bash

. utils.sh

function download_if_not_exists(){
    if [ -f $2 ]; then
        echo_green "File $2 already existis."
    else
        dorun "wget $1 -O $2"
    fi
}

function download_if_not_exists_as_sudo_output(){
    if [ -f $2 ]; then
        echo_green "File $2 already existis."
    else
        dorun "sudo wget $1 -O $2"
    fi
}

mkdir -p /var/www/html/
mkdir -p ~/ambari/repo

download_if_not_exists_as_sudo_output http://public-repo-1.hortonworks.com/ambari/centos6/2.x/updates/2.5.1.0/ambari.repo /etc/yum.repos.d/ambari.repo

download_if_not_exists_as_sudo_output http://public-repo-1.hortonworks.com/HDP/centos6/2.x/updates/2.6.1.0/hdp.repo /etc/yum.repos.d/hdp.repo

download_if_not_exists http://public-repo-1.hortonworks.com/HDP/centos6/2.x/updates/2.6.1.0/HDP-2.6.1.0-centos6-rpm.tar.gz ~/ambari/repo/HDP-2.6.1.0-centos6-rpm.tar.gz

download_if_not_exists http://public-repo-1.hortonworks.com/HDP-UTILS-1.1.0.21/repos/centos6/HDP-UTILS-1.1.0.21-centos6.tar.gz ~/ambari/repo/HDP-UTILS-1.1.0.21-centos6.tar.gz

download_if_not_exists http://public-repo-1.hortonworks.com/ambari/centos6/2.x/updates/2.5.1.0/ambari-2.5.1.0-centos6.tar.gz ~/ambari/repo/ambari-2.5.1.0-centos6.tar.gz