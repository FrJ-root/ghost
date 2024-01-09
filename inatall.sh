#!/bin/bash

# Copyright (C) 2016 - 2019 Entynetproject
#
# Licensed under the Apache License, Version 2.0 (the "License"); you may not
# use the software except in compliance with the License.
#
# You may obtain a copy of the License at:
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
# WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
# License for the specific language governing permissions and limitations under
# the License.

RS="\033[0;31m"
YS="\033[1;33m"
CE="\033[0;97m"

printf '\033]2;install.sh\a'

#blue start 
	BS="\033[1;34m"
#color end
	CE="\033[0;97m"
	C="\033[0m"
#red start
	RS="\033[0;31m"
#green start
	GN="\033[0;32m"
#white start
   WHS="\033[0;97m"

if [[ $EUID -ne 0 ]]
then
   sleep 1
   echo -e ""$GN"["$RS"+"$GN"]"$CE" This script must be run as root!"$C"" 1>&2
   sleep 1
   exit
fi

if [[ -d ~/ghost ]]
then
sleep 0
else
cd ~
{
git clone https://github.com/entynetproject/ghost.git
} &> /dev/null
fi
sleep 0.5
clear
sleep 0.5
cd ~/ghost
echo
cat banner/banner.txt
echo

sleep 1
echo -e ""$GN"["$RS"+"$GN"]"$CE" Installing dependencies..."$C""
sleep 1

{
pkg update
pkg -y install git
pkg -y install python
pkg -y install android-tools
apt-get update
apt-get -y install git
apt-get -y install python
apt-get -y install adb
apk update
apk add git
apk add python
apk add android-tools
pacman -Sy
pacman -S --noconfirm git
pacman -S --noconfirm python
pacman -S --noconfirm android-tools
zypper refresh
zypper install -y git
zypper install -y python
zypper install -y android-tools
yum -y install git
yum -y install python
yum -y install android-tools
dnf -y install git
dnf -y install python
dnf -y install android-tools
eopkg update-repo
eopkg -y install git
eopkg -y install python
eopkg -y install android-tools
xbps-install -S
xbps-install -y git
xbps-install -y python
xbps-install -y android-tools
} &> /dev/null

{
cd ~/ghost/bin
cp ghost /usr/local/bin
chmod +x /usr/local/bin/ghost
cp ghost /bin
chmod +x /bin/ghost
cp ghost /data/data/com.termux/files/usr/bin
chmod +x /data/data/com.termux/files/usr/bin/ghost
} &> /dev/null

sleep 1
echo -e ""$GN"["$RS"+"$GN"]"$CE" Successfully installed!"$C""
sleep 1
