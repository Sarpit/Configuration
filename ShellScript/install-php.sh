#!/bin/bash

echo "Checking if php is already installed"
php -v 2> /dev/null 1> /dev/null


if [[ $? == 0 ]]; then
    echo "php is already installed, exiting the script"
    exit 1
fi

echo -e "Choose php version to Install: \n7.4 \n8.1"
read -p "Enter version: " version


if [[ $version == 8.* ]]; then 
    echo "Installing Php 8.1"
    echo ""

    sudo apt install software-properties-common -y
    sudo add-apt-repository ppa:ondrej/php 
    sudo apt update
    sudo apt install php8.1 -y
fi

if [[ $version == 7.* ]]; then 
    echo "Installing Php 7.4"

    sudo apt install software-properties-common ca-certificates lsb-release apt-transport-https -y 
    sudo LC_ALL=C.UTF-8 add-apt-repository ppa:ondrej/php 

    echo ""
    sudo apt install php7.4 -y
fi

echo ""
echo "php version: $(php -v)"