nano install
chmod 755 * && ./install

#!/bin/bash
read -r -p "This will install SoftEther to your server. Are you sure you want to continue? [y/N] " response
case $response in
[yY][eE][sS]|[yY])
echo "Updating the system first..."
apt-get update
apt-get upgrade
apt-get install checkinstall build-essential
echo "Downloading last stable release: 4.20"
sleep 2
wget http://www.softether-download.com/files/softether/v4.25-9656-rtm-2018.01.15-tree/Linux/SoftEther_VPN_Server/64bit_-_Intel_x64_or_AMD64/softether-vpnserver-v4.25-9656-rtm-2018.01.15-linux-x64-64bit.tar.gz
tar -xzf soft*
cd vpn*
echo "Please press 1 for all the following questions."
sleep 1
make
cd ..
mv vpnserver /usr/local/
chmod 600 * /usr/local/vpnserver
chmod 700 /usr/local/vpnserver/vpncmd
chmod 700 /usr/local/vpnserver/vpnserver
echo '#!/bin/sh
### BEGIN INIT INFO
# Provides:          vpnserver
# Required-Start:    $remote_fs $syslog
# Required-Stop:     $remote_fs $syslog
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: Start daemon at boot time
# Description:       Enable Softether by daemon.
### END INIT INFO
DAEMON=/usr/local/vpnserver/vpnserver
LOCK=/var/lock/subsys/vpnserver
TAP_ADDR=192.168.7.1

test -x $DAEMON || exit 0
case "$1" in
start)
$DAEMON start
touch $LOCK
sleep 1
/sbin/ifconfig tap_soft $TAP_ADDR
;;
stop)
$DAEMON stop
rm $LOCK
;;
restart)
$DAEMON stop
sleep 3
$DAEMON start
sleep 1
/sbin/ifconfig tap_soft $TAP_ADDR
;;
*)
echo "Usage: $0 {start|stop|restart}"
exit 1
esac
exit 0' > /etc/init.d/vpnserver
echo "System daemon created. Registering changes..."
sleep 2
chmod 755 /etc/init.d/vpnserver
update-rc.d vpnserver defaults
echo "SoftEther VPN Server should now start as a system service from now on. Starting SoftEther VPN service..."
../etc/init.d/vpnserver start
esac
