# Hello .NetCore MVC

A simple .NetCore MVC application that displays 'Hello .Net Core MVC!' on a colored background.

## Prerequisites

* install .NetCore SDK - [download](https://dotnet.microsoft.com/download)

Or if you dont won't to install the .NetCore SDK on your system use the included Vagrant project in folder vagrant/ to build an VirtualBox VM with ubuntu 16.04 OS and .NetCore SDK installed.

* Install VirtualBox - [instructions](https://www.virtualbox.org/wiki/Downloads)
* Install Vagrant - [instructions](https://www.vagrantup.com/downloads.html)
* In folder vagrant/ run `vagrant up`
* Login to the machine `vagrant ssh`
* The project will be in `~/hello-netcore-mvc/` directory

## Run the project

* to compile the project to a library - `dotnet publish`
* to start the web server with the application - `dotnet bin/Debug/netcoreapp2.1/publish/hello-netcore-mvc.dll &`

The web server will be listening for http requests on port 5000