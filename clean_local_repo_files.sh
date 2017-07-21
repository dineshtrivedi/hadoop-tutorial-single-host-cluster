#!/bin/bash

. utils.sh

dorun "rm -rf ~/ambari/"
dorun "sudo rm /etc/yum.repos.d/ambari.repo"
dorun "sudo rm /etc/yum.repos.d/hdp.repo"