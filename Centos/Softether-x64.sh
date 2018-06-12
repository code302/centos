#-------------------------------------------------------
#Softether Auto Install Script
#For Debian 8 x64
#
#Script Coded by code302
#https://raw.githubusercontent.com/code302/Debian-with-LBC
#
#Script Based from tutorial by lincolin.hk
#
#Good Luck!
#-------------------------------------------------------
#Updating Repositories and Installing Development Packages
yum -y update
yum -y upgrade
yum -y groupinstall "Development Tools"
yum -y install gcc*
yum -y install libpcap*
yum -y install nano
#Get the Softether Packages via wget and Save it into /root
cd /root
wget http://www.softether-download.com/files/softether/v4.27-9666-beta-2018.04.21-tree/Linux/SoftEther_VPN_Server/64bit_-_Intel_x64_or_AMD64/softether-vpnserver-v4.27-9666-beta-2018.04.21-linux-x64-64bit.tar.gz
tar xzvf softether-vpnserver-v4.27-9666-beta-2018.04.21-linux-x64-64bit.tar.gz
#Making files, manual input needed
cd vpnserver
clear
make
cd ..
#Moving files to /usr/local
mv vpnserver /usr/local
#Set the permissions
cd /usr/local/vpnserver
chmod 600 *
chmod 700 vpncmd
chmod 700 vpnserver
#Downloading the Scripts for init.d and set Permission
cd /root
wget https://raw.githubusercontent.com/code302/Debian-with-LBC/master/misc/vpnserver-debian.sh --no-check-certificate
mv vpnserver-debian.sh /etc/init.d/vpnserver
cd /etc/init.d
#Creating lock and last touching...
chmod 755 /etc/init.d/vpnserver
/sbin/chkconfig --add vpnserver
/etc/init.d/vpnserver start
cd /usr/local/vpnserver
echo -----------------------------------------------------
echo Install finish!
echo check this step to check are installer is working properly
echo 1. vpnserver and vpncmd is on /usr/local/vpnserver
echo 2. /etc/init.d/vpnserver start can executed
echo if vpnserver can start, congratulations!
echo ------------------------------------------------------
exit
