#!/usr/bin/env bash
# Deploy 2 versions of the hello-netcore-mvc app

#Set app versions urls for blue/green in vars
BLUE_URL='https://github.com/slavrd/hello-netcore-mvc/releases/download/v0.2/hello-netcore-mvc.zip'
GREEN_URL='https://github.com/slavrd/hello-netcore-mvc/releases/download/v0.3/hello-netcore-mvc.zip'
APP_ARTIFACT_NAME='hello-netcore-mvc.zip'


# create directories to download and deploy apps
[ -d /tmp/blue ] || mkdir /tmp/blue
[ -d /tmp/green ] || mkdir /tmp/green
[ -d /opt/blue ] || sudo mkdir /opt/blue
[ -d /opt/green ] || sudo mkdir /opt/green

# download verions
[ -e /tmp/blue/$APP_ARTIFACT_NAME ] && rm -rf /tmp/blue/$APP_ARTIFACT_NAME
wget -q -P /tmp/blue $BLUE_URL
[ -e /tmp/green/$APP_ARTIFACT_NAME ] && rm -rf /tmp/green/$APP_ARTIFACT_NAME
wget -q -P /tmp/green $GREEN_URL

# install unzip if not installed
which unzip || {
  sudo apt-get update
  sudo apt-get install -y unzip
}

# unzip and start apps
sudo kill $(pgrep dotnet) >/dev/null

[ -z "`ls -A /opt/blue/`" ] || sudo rm -rf /opt/blue/*
  sudo unzip /tmp/blue/hello-netcore-mvc.zip -d /opt/blue && {
  pushd /opt/blue/hello-netcore-mvc
  dotnet hello-netcore-mvc.dll --urls http://0.0.0.0:5002&
  popd
}

[ -z "`ls -A /opt/green/`" ] || sudo rm -rf /opt/green/*
  sudo unzip /tmp/green/hello-netcore-mvc.zip -d /opt/green && {
  pushd /opt/green/hello-netcore-mvc
  dotnet hello-netcore-mvc.dll --urls http://0.0.0.0:5003&
  popd
}

#clean up
sudo apt-get clean
rm -rf /tmp/blue /tmp/green
