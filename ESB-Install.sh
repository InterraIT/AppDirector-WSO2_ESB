#!/bin/bash

export PATH=$PATH:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
set -e

################## INTERNAL PARAMETERS #########################
DOWNLOAD_URL="$download_url"
INSTALL_DIR="$install_dir"

# FUNTION TO CHECK ERROR
function check_response_code()
{
   if [ "$?" = "0" ]; then
      echo "Database Installed Successfully";
   else
      error_exit "Unsuccessful Installation. Error Code $?";
   fi
}

function check_error()
{
   if [ ! "$?" = "0" ]; then
      error_exit "$1";
   fi
}

################INSTALLING WSO2##############################
echo "Installing Pre-requistes"
if [ -f /etc/redhat-release ] ; then
   echo "RHEL / CENTOS OS"
   yum --nogpgcheck -y install unzip
elif [ -f /etc/debian_version ] ; then
   echo "Ubuntu OS"   
   apt-get -f -y install linux-firmware --fix-missing
   apt-get -f -y install unzip
elif [ -f /etc/SuSE-release ] ; then
   echo "SUSE OS"
   zypper --non-interactive --no-gpg-checks install unzip
fi

mkdir $INSTALL_DIR
cd $INSTALL_DIR
### Downloading tar ball
echo "Downloading the tar ball"
wget --output-document=installer.zip $DOWNLOAD_URL
echo "Downloading the tar ball - DONE"

### Extracting tar ball
echo "Extracting the tar ball"
unzip installer.zip
echo "Extracting the tar ball - DONE"