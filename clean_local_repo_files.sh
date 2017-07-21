#!/bin/bash

. utils.sh

dorun "rm -rf $HOME/ambari"
dorun "sudo rm /etc/yum.repos.d/ambari.repo"
dorun "sudo rm /etc/yum.repos.d/hdp.repo"