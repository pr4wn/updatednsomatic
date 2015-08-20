#!/bin/bash
# Installation script for update-dnsomatic 
ETC=/etc/update-dnsomatic
CFG=$ETC/config
PROG=/usr/local/bin/update-dnsomatic

if [ ! `whoami` == "root" ]; then

	echo "Install must be run as root or using sudo."
	exit 1

fi

if [ ! -d $ETC ]; then

	echo "Creating directory $ETC"
	mkdir $ETC

else

	echo "Directory $ETC already exists."

fi
############################# Install config file ############################# 
if [ -e $CFG ]; then

	echo "File $CFG already exists."
	read  -p "Overwrite $CFG (y/n)?" REPLY
	
	if [ "$REPLY" == "y" ]; then
	
		if [ -e ./config ]; then
			
			cp ./config $CFG
			chmod 600 $CFG
			echo "Installed $CFG"
			
		else
		
			echo "Error. ./config does not exist."
			exit 1
		
		fi
		
	fi
	
else

	echo "Installing $CFG"

	if [ -e ./config ]; then
			
		cp ./config $CFG
		chmod 600 $CFG
		echo "Installed $CFG"
		
	else
		
		echo "Error. ./config does not exist."
		exit 1
		
	fi
	

fi
######################### Install update-dnsomatic ############################ 
if [ -e $PROG ]; then

	echo "File $PROG already exists."
	read -p "Overwrite $PROG (y/n)?" REPLY
	
	if [ "$REPLY" == "y" ]; then
	
		if [ -e ./update-dnsomatic ]; then
			
			cp ./update-dnsomatic $PROG
			chmod 700 $PROG
			echo "Installed $PROG"
			
		else
		
			echo "Error. ./update-dnsomatic does not exist."
			exit 1
		
		fi
		
	fi
       
else

	echo "Installing $PROG"

	if [ -e ./update-dnsomatic ]; then
			
		cp ./update-dnsomatic $PROG
		chmod 700 $PROG
		echo "Installed $PROG"
		
	else
		
		echo "Error. ./update-dnsomatic does not exist."
		exit 1
		
	fi

fi

echo "Installed update-dnsomatic"
echo

################################ Setup crontab ################################
echo "Sample crontab: */10 * * * * /usr/local/bin/update-dnsomatic"
echo
echo "Will run the update every 10 minutes."
 
read -p "Do you wish to setup up crontab now? (y/n)?" REPLY

if [  "$REPLY" == "y" ]; then

	crontab -e
	
fi 

