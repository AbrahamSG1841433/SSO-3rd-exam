#! /bin/bash

#In this part the operating system is identified
#Operating system identification

echo "OS detected"

#Variables to Show the OS in Ubuntu
OSDT=$(awk -F= '/^NAME/{print $2}' /etc/os-release)
UBOS=$(hostnamectl | grep ubuntu)
if [ -z "$UBOS" ];
then
	echo "OS detected: "$OSDT" "


#Variables to install and detect epel in Ubuntu

	Flag=$(yum list installed | grep epel)
		if [ -z "$Flag" ];
		then
			echo "Checking for Epel"
			yum -y install epel-release
			echo "Epel is being installed"
		else 
			echo "Epel installation is completed"
		fi
    
 #Variables to install and detect clamav in Ubuntu
 
		echo "Checking for clamav"
		Flag=$(yum list installed | grep clamav)
		if  [ -z "$Flag" ]; 
		then
			echo "Clamav is being installed"
			yum -y install clamav clamav-devel
		else 
			echo "Clamav installation has been completed"
		fi

		echo "If you want to continue hit enter on the keyboard"
		read -p "If you want to cancel the installation press any key" ack
		if [ -z "$ack" ];
		then
			echo "checking for updates"
			yum update
		else 
			echo "Canceling the update"
		fi
fi

#Variables to Show the OS in Centos
UBOS=$(hostnamectl | grep centos)
if [ -z "$UBOS" ];
then

	echo "OS detected: "$OSDT" "
		echo "Checking for clamav"
		Flag=$(dpkg-query -l | grep clamav)
		if  (apt list clamav); 
		then
			echo "clamav is already installed"
		else 
			echo "Clamav is being installed"
			apt-get install clamav clamav-daemon -y
		fi

		#echo "If you want to continue hit enter on the keyboard"
		#read -p "If you want to cancel the installation press any key" ack
		#if  ("$ack" = ""); 
		#then
			echo "checking for updates"
			sudo apt-get update
		#else 
		#	echo "Canceling the update"
		#fi

fi 


exit
