# Hadoop tutorial single host cluster

[![Codacy Badge](https://api.codacy.com/project/badge/Grade/493f78ccea8f40c5a558622c5a8f0e4d)](https://www.codacy.com/app/dinesh-dart/hadoop-tutorial-single-host-cluster?utm_source=github.com&amp;utm_medium=referral&amp;utm_content=dineshtrivedi/hadoop-tutorial-single-host-cluster&amp;utm_campaign=Badge_Grade)

## Virtualbox 

You can download [here](https://www.virtualbox.org/wiki/Downloads) or follow the command for the following OS:

### Ubuntu 16.04
```
sudo apt-get install -y virtualbox
sudo apt-get update && sudo apt-get install virtualbox-dkms virtualbox-qt linux-headers-$(uname -r) -y
modprobe vboxdrv
```

If you get an error running the modprobe command similar to the message below check the [Boot Problems section](#boot-problems).
```
modprobe: ERROR: could not insert 'vboxdrv': Required key not available
```

## Downloading operational system
The operational system used is CentOS 6. According to this [link](https://wiki.centos.org/Manuals/ReleaseNotes/CentOS7#head-76148df6f2cc6a03ab2ceaa23204ace3e2acbfb9) it is recommended to download the DVD version. However in this tutorial I am using the LiveCD iso version.
You can download it [here](http://mirror.za.web4africa.net/centos/6.9/isos/x86_64/).

## Machine specification
OS: CentOS 6.9 X64
Memory: 4GB
Disk: 40GB
Processors: 2 Cores
Network: 2 Adapters
- Adapter 1: NAT
- Adapter 2: Bridged Adapter
VM General Settings Section (Advanced Tab):
- Shared Clipboard: Bidirectional
- Drag'n'Drop: Bidirectional

## Add your user as sudoer
Log in as root and open the terminal:
```
yum install vim
vim /etc/sudoers
```

Find the root line (first line below) and add the second line to the file:
```
root 	ALL=(ALL)	ALL
<your_username> 	ALL=(ALL)	ALL
```

## Change to fixed IP
Probably the eth1 is using DHCP. Go to Edit connection and change it to Manual. You can use values similar to:
Adderss: 192.168.0.101
Netmask: 255.255.255.0
Gateway: 0.0.0.0


## Installing Guest Machine Additions
Go to Devices menu and then "Insert Guest Addition CD Image...". Follow the steps download the ISO from the internet.
Throught the console go to some path similar to below and install the additions:
```
sudo yum groupinstall "Development Tools"
sudo yum install kernel-devel-`uname -r`
sudo yum update
sudo yum install epel-release
yum repolist
sudo yum install dkms make perl
export KERN_DIR=/usr/src/kernel/`uname -r`
cd /media/VBOXADDITONS_<VERSION>
sudo ./VBOXLinuxAdditions.run
```

Now just shutdown and start your machine again. The copy/paste and seamless mode (View option of virtual box menu) feature will be enable.

## Boot Problems
Be sure that the Secure Boot is disabled and you are using the Legacy Boot. Check the steps to change this:
```
	
You can disable Secure Boot (UEFI) in the BIOS with the following steps:
1. Reboot your machine and enter the BIOS Menu (In my case pressing F2)
2. Search for Secure Boot and change to Legacy
```

Here is a [link](https://askubuntu.com/questions/762254/why-do-i-get-required-key-not-available-when-install-3rd-party-kernel-modules) with more information.

## Hadoop Distribution
This tutorial uses [Hortnworks](https://hortonworks.com/) distribution. This tutorial uses [Ambari documentation](https://docs.hortonworks.com/HDPDocuments/Ambari-2.5.1.0/bk_ambari-installation/content/ch_Getting_Ready.html).

### Preparing environment
Run the prepare.sh script
```
./prepare.sh
```

The system will reboot after finishes it. The download can take a while.

After the reboot, from the Ambari Server, make sure you can connect to each host in the cluster using SSH, without having to enter a password. In our case is the same machine so get your hostname running:
```
hostname -f
```

Get the host name and run the command:
```
ssh root@<hostname>
```

If the following warning message displays during your first connection: Are you sure you want to continue connecting (yes/no)? Enter Yes

### Ambari Server Instalation
According to the documentation the instalation run the following commands:
```
sudo yum -y install ambari-server-2.5.1.0
sudo yum install -y ntp
sudo ambari-server setup
```
The following steps are to install hadoop:
* Go to http://localhost:8080
* The default user is admin and the password is also admin
* Click Launch Install Wizard
* Add your cluster name
* Select the latest version for HDP
* Use public repository (Requires internet access)
* get you hostname running on the terminal:
```
hostname -f
```
* get your private ssh key running:
```
cat /root/.ssh/id_rsa
```

## References
* [SELinux](https://www.digitalocean.com/community/tutorials/an-introduction-to-selinux-on-centos-7-part-1-basic-concepts)
* [Guest machine Virtualbox](https://askubuntu.com/questions/22743/how-do-i-install-guest-additions-in-a-virtualbox-vm/22745#22745)
* [Learning Journal Tutorial Youtube](https://www.youtube.com/watch?v=DJPwV2ge9m0&list=PLkz1SCf5iB4dw3jbRo0SYCk2urRESUA3v&index=6)
* [Huge Pages and Transparent Huge Pages](https://access.redhat.com/documentation/en-US/Red_Hat_Enterprise_Linux/6/html/Performance_Tuning_Guide/s-memory-transhuge.html)
* [Learning Journal HadoopTutorials Repository](https://github.com/LearningJournal/HadoopTutorials)