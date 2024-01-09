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

#blue start 
	BS="-e \033[1;34m"
#color end
	CE="\033[0;97m"
#red start
	RS="\033[0;31m"
	C="\033[0m"
#green start
	GN="\033[0;32m"
#white start
        WHS="\033[0;97m"

if [[ -d /data/data/com.termux ]]
then
if [[ -f /data/data/com.termux/files/usr/bin/ghost ]]
then
UPD="true"
else
UPD="false"
fi
else
if [[ -f /usr/local/bin/ghost ]]
then
UPD="true"
else
UPD="false"
fi
fi
{
ASESR="$( curl -s checkip.dyndns.org | sed -e 's/.*Current IP Address: //' -e 's/<.*$//' )"
} &> /dev/null
if [[ "$ASESR" = "" ]]
then 
sleep 1
echo -e ""$GN"["$RS"+"$GN"]"$CE" Download failed!"$C""
sleep 1
exit
fi
if [[ $EUID -ne 0 ]]
then
sleep 1
echo -e ""$GN"["$RS"+"$GN"]"$CE" Permission denied!"$C""
sleep 1
exit
fi
sleep 1
echo -e ""$GN"["$RS"+"$GN"]"$CE" Installing update..."$C""
{
rm -rf ~/ghost
rm /bin/ghost
rm /usr/local/bin/ghost
rm /data/data/com.termux/files/usr/bin/ghost
cd ~
git clone https://github.com/entynetproject/ghost.git
if [[ "$UPD" != "true" ]]
then
sleep 0
else
cd ghost
chmod +x install.sh
./install.sh
fi
} &> /dev/null
echo -e ""$GN"["$RS"+"$GN"]"$CE" Successfully updated!"$C""
sleep 1
exit
