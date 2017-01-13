#!/bin/bash
################################################################################
# Script for Installation: ODOO 10.0 Community server on Ubuntu 16.10x64
# Author: André Schenkels, ICTSTUDIO 2015
#-------------------------------------------------------------------------------
# This script will install ODOO Community Server on
# clean UUbuntu 16.10x64 Server
#-------------------------------------------------------------------------------
# USAGE:
#
# copy odoo-install to /tmp/
#
# RUN:
# sh ./tmp/odoo-install 
################################################################################
#--------------------------------------------------
# Update & Upgrade Server
#--------------------------------------------------
echo  "\n----------------------------------- Update Server -----------------------------------"
sudo apt-get update -y
echo  "\n----------------------------------- Audo Upgrade Server -----------------------------------"
sudo DEBIAN_FRONTEND=noninteractive apt-get -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" dist-upgrade
#--------------------------------------------------
# auto remove un use responsitory
#--------------------------------------------------
echo  "\n-----------------------------------  autoremove un use -----------------------------------"
sudo apt autoremove -y
#--------------------------------------------------
# ubuntu clean unused kernels
#--------------------------------------------------
echo  "\n-----------------------------------  ubuntu clean unused kernels -----------------------------------"
apt-get clean -y
#--------------------------------------------------
# Ubuntu audo clean unused kernels
#--------------------------------------------------
echo  "\n-----------------------------------  Ubuntu audo clean unused kernels -----------------------------------"
 apt-get autoclean -y
 #--------------------------------------------------
# Install git to clone reponsitory using later
#--------------------------------------------------
echo  "\n----------------------------------- install git -----------------------------------"
sudo apt-get install git -y
#--------------------------------------------------
# Install vim for editing
#--------------------------------------------------
echo  "\n----------------------------------- install vim -----------------------------------"
sudo apt-get install vim -y
#--------------------------------------------------
# Adding requirement sources list.
#--------------------------------------------------
echo  "\n----------------------------------- adding requirement sources list -----------------------------------"
sudo echo "deb http://us.archive.ubuntu.com/ubuntu vivid main universe" >> /etc/apt/sources.list
#--------------------------------------------------
# Update & Upgrade Server
#--------------------------------------------------
echo  "\n----------------------------------- Update & Upgrade Server -----------------------------------"
sudo apt-get update -y
sudo apt-get dist-upgrade -y
#--------------------------------------------------
# Install Python
#--------------------------------------------------
echo  "\n----------------------------------- install python -----------------------------------"
sudo apt-get install python -y
#--------------------------------------------------
# install install python-gevent
#--------------------------------------------------
echo  "\n----------------------------------- install python-gevent -----------------------------------"
sudo apt-get install python-gevent -y
#--------------------------------------------------
# install python-pybabel
#--------------------------------------------------
echo  "\n----------------------------------- install python-pybabel -----------------------------------"
sudo apt-get install python-pybabel -y
#--------------------------------------------------
# Install PostgreSQL Server
#--------------------------------------------------
echo  "\n----------------------------------- install postgresql -----------------------------------"
sudo apt-get install postgresql -y
#--------------------------------------------------
# Adding nodejs sources
#--------------------------------------------------
echo  "\n----------------------------------- Adding nodejs 6.x sources  -----------------------------------"
curl -sL https://deb.nodesource.com/setup_6.x | sudo  bash -
#--------------------------------------------------
# Update & Upgrade Server
#--------------------------------------------------
echo  "\n----------------------------------- Update & Upgrade Server -----------------------------------"
sudo apt-get update -y
sudo apt-get dist-upgrade -y
#--------------------------------------------------
# install node js
#--------------------------------------------------
echo  "\n----------------------------------- install nodejs 6.x -----------------------------------"
sudo apt-get install -y nodejs
#--------------------------------------------------
# install less
#--------------------------------------------------
echo  "\n----------------------------------- install less -----------------------------------"
sudo npm install -g less
#--------------------------------------------------
# Adding odoo public key to avoid ignore auto 
#--------------------------------------------------
echo  "\n----------------------------------- Adding odoo public key  -----------------------------------"
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys DEF2A2198183CBB5
#--------------------------------------------------
# Adding odoo sources list
#--------------------------------------------------
echo  "\n----------------------------------- Adding odoo sources list -----------------------------------"
wget -O - https://nightly.odoo.com/odoo.key | apt-key add -
sudo echo "deb http://nightly.odoo.com/10.0/nightly/deb/ ./" >> /etc/apt/sources.list
#--------------------------------------------------
# Update & Upgrade Server
#--------------------------------------------------
echo  "\n----------------------------------- Update & Upgrade Server -----------------------------------"
sudo apt-get update -y
sudo apt-get dist-upgrade -y
#--------------------------------------------------
# install odoo
#--------------------------------------------------
echo  "\n----------------------------------- install odoo -----------------------------------"
sudo apt-get install -y odoo
echo  "\n----------------------------------- config port 80 -----------------------------------"
#--------------------------------------------------
# Back to root
#--------------------------------------------------
echo  "\n----------------------------------- Back to root -----------------------------------"
cd
#--------------------------------------------------
# config runing port 80 & 443
#--------------------------------------------------
echo  "\n----------------------------------- write config port 80 file -----------------------------------"
cat >> /etc/rc.local << EOF 
#!/bin/sh -e
#
# rc.local
#
# This script is executed at the end of each multiuser runlevel.
# Make sure that the script will "exit 0" on success or any other
# value on error.
#
# In order to enable or disable this script just change the execution
# bits.
#
# By default this script does nothing.
iptables -t nat -A PREROUTING -i eth0 -p tcp --dport 80 -j REDIRECT --to-port 8069
iptables -t nat -A PREROUTING -i eth0 -p tcp --dport 443 -j REDIRECT --to-port 8070
exit 0
EOF
chmod +x /etc/rc.local
sh /etc/rc.local
#--------------------------------------------------
# install wkhtmltopdf
#--------------------------------------------------
echo  "\n----------------------------------- install wkhtmltopdf -----------------------------------"
#--------------------------------------------------
# Downloads  libpng dependency
#--------------------------------------------------
echo  "\n----------------------------------- Downloads  libpng dependency -----------------------------------"
sudo wget -P Downloads http://ftp.us.debian.org/debian/pool/main/libp/libpng/libpng12-0_1.2.50-2+deb8u2_amd64.deb
#--------------------------------------------------
# Downloads  wkhtmltopdf
#--------------------------------------------------
echo  "\n----------------------------------- Downloads  wkhtmltopdf -----------------------------------"
sudo wget -P Downloads http://download.gna.org/wkhtmltopdf/0.12/0.12.1/wkhtmltox-0.12.1_linux-trusty-amd64.deb
#--------------------------------------------------
# Go to Download directory
#--------------------------------------------------
echo  "\n----------------------------------- Go to Download directory -----------------------------------"
cd ~/Downloads
#--------------------------------------------------
# install libpng12
#--------------------------------------------------
echo  "\n----------------------------------- install libpng -----------------------------------"
sudo dpkg -i libpng12-0_1.2.50-2+deb8u2_amd64.deb
#--------------------------------------------------
# install wkhtmltox
#--------------------------------------------------
echo  "\n----------------------------------- install wkhtmltox -----------------------------------"
sudo dpkg -i wkhtmltox-0.12.1_linux-trusty-amd64.deb
#--------------------------------------------------
# Check wkhtmltopdf version
#--------------------------------------------------
echo  "\n----------------------------------- Check wkhtmltopdf version -----------------------------------"
wkhtmltopdf -V
#--------------------------------------------------
# If successful install so test printing pdf file
#--------------------------------------------------
echo  "\n----------------------------------- If successful install so test printing pdf file -----------------------------------"
wkhtmltopdf http://google.com google.pdf
#--------------------------------------------------
# Update & Upgrade Server
#--------------------------------------------------
echo  "\n----------------------------------- Update & Upgrade Server -----------------------------------"
sudo apt-get update -y
sudo apt-get dist-upgrade -y
echo  "\n--------if all your work success then will auto run the next part for install saas dependencies requirements  -----------------------------------"
#--------------------------------------------------
# If success then install saas dependencies requirements
#--------------------------------------------------
echo  "\n----------------------------------- saas dependencies installation -----------------------------------"
sudo sh odoo-saas-install.sh


















