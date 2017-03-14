#!/bin/bash
SERVER="http://dl.4players.de"
SERVER_PATH="ts/releases/3.0.13.6"
LATEST_FILE="teamspeak3-server_linux_amd64-3.0.13.6.tar.bz2"
VERSION="3.0.13.6"

INSTALLATION_FOLDER="/opt/ts3-server"
USER="ts3-user"

#Create user for teamspeak server
echo "Creating user ..."
useradd -d $INSTALLATION_FOLDER -m $USER
#Download the last server version
echo "Downloading latest version of the server"
wget "$SERVER/$SERVER_PATH/$LATEST_FILE"
# Uncompress it
tar -xjvf $LATEST_FILE
# Move the files to the proper folder
echo "Moving files to the proper folder"
mv ./teamspeak3-server_linux-amd64/* $INSTALLATION_FOLDER
# Change its owner
chown $USER:$USER $INSTALLATION_FOLDER -R
# Remove the downloaded the temporary files
rm -fr $LATEST_FILE teamspeak3-server_linux-amd64

#Adding the service script
move ts3 /etc/init.d/ts3

#Changing permisions
chmod a+x /etc/init.d/ts3
chmod a+x $INSTALLATION_FOLDER/ts3server_startscript.sh
chmod a+x $INSTALLATION_FOLDER/ts3server_minimal_runscript.sh
update-rc.d ts3 defaults

sleep 5

echo "Launching service"
service ts3 start

echo "Done! Enjoy it :)"
