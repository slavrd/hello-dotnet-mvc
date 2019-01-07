#!/usr/bin/env bash
# Deploy 2 versions of the hello-netcore-mvc app

#Set app versions urls for blue/green in vars
BLUE_URL='https://github.com/slavrd/hello-netcore-mvc/releases/download/v0.2/hello-netcore-mvc.zip'
GREEN_URL='https://github.com/slavrd/hello-netcore-mvc/releases/download/v0.3/hello-netcore-mvc.zip'


# create directories to download and deploy apps
mkdir /tmp/blue
mkdir /tmp/green
sudo mkdir /opt/blue
sudo mkdir /opt/green

# download verions
wget -q -P /tmp/blue $BLUE_URL
wget -q -P /tmp/green $GREEN_URL

# install unzip if not installed
which unzip || {
  sudo apt-get update
  sudo apt-get install -y unzip
}

# unzip and start apps
sudo unzip /tmp/blue/hello-netcore-mvc.zip -d /opt/blue && {
  pushd /opt/blue/hello-netcore-mvc
  dotnet hello-netcore-mvc.dll --urls http://0.0.0.0:5002&
  popd
}

sudo unzip /tmp/green/hello-netcore-mvc.zip -d /opt/green && {
  pushd /opt/green/hello-netcore-mvc
  dotnet hello-netcore-mvc.dll --urls http://0.0.0.0:5003&
  popd
}

#clean up
sudo apt-get clean
rm -rf /tmp/blue /tmp/green
