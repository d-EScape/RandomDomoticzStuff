#!/bin/bash
#This customstart.sh is customized to my requirements. They probably do not match yours!

if [ -f /opt/domoticz/FIRSTRUN ]; then
echo 'Domoticz container already prepped'
#sleep 2
else
echo 'Preparing Domoticz container for FIRSTRUN'
echo 'installing python modules'
pip install cryptography setuptools requests parallel-ssh paramiko motionblinds python_picnic_api paho-mqtt gTTS pychromecast hwmon fritzconnection tinytuya aioharmony
echo 'updating linux packages'
apt-get -qq update
echo 'installing linux packages'
apt-get install -y \
	iputils-ping \
	nano \
	wakeonlan \
	procps
echo 'change default file owner id in script'
sed -i -e 's/chown -R 1000:1000 "${USERDATA}"/chown -R 1001:1001 "${USERDATA}"/g' /usr/local/bin/docker-entrypoint.sh
chown -R 1001:1001 "/opt/domoticz/userdata"
echo 'creating FIRSTRUN file so script does not run again on container start'
touch /opt/domoticz/FIRSTRUN
cd /opt/domoticz || return
fi
