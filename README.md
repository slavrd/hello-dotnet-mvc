# Hello .NetCore MVC

A simple .NetCore MVC application that displays 'Hello .Net Core MVC!' on a colored background.

## Prerequisites

* install .NetCore SDK - [download](https://dotnet.microsoft.com/download)

Or if you dont won't to install the .NetCore SDK on your system use the included Vagrant project in folder vagrant/ to build an VirtualBox VM with ubuntu 16.04 OS and .NetCore SDK installed.

* Install VirtualBox - [instructions](https://www.virtualbox.org/wiki/Downloads)
* Install Vagrant - [instructions](https://www.vagrantup.com/downloads.html)
* In the project root folder run `vagrant up`
* Login to the machine `vagrant ssh`
* The project will be in `~/hello-netcore-mvc/` directory

Note that the Vagrant configuration will create the following port forwardings:

* `host:5000 => guest:5000`
* `host:5002 => guest:5002`
* `host:5003 => guest:5003`
* `host:80 => guest:8080`

In case you need to use a different port you can change the host port by editing `vagrant/Vagrantfile`. For example:

```Ruby
# change the host port to a desired free port on your system
config.vm.network "forwarded_port", guest: 5000, host: 5000
```

## Run the project

* to compile the project to a library - `dotnet publish`
* to start the web server with the application - `dotnet bin/Debug/netcoreapp2.1/publish/hello-netcore-mvc.dll --urls http://0.0.0.0:5000 &`

The web server will be listening for http requests on `port 5000`. You can access it from the host and guest machines by making an http request to `http://localhost:5000`

## Blue/Green Deployment Demo

Blue/Green deployment is a technique where you don't immediately remove the old version of an application when deploying a new one. Instead the new version is deployed on another set if infrastructure identical to the one running the current version so both run in parallel. Switching to the new version is done by rerouting traffic between the two infrastructure sets.

The main advantages to doing this are:

* The actual new production environment can be tested before it's presented to the clients.
* The traffic switch is usually much faster than the deployment process so less or no downtime.
* Depending on the method used, traffic can be switched proportionally or based on specific criteria instead of all at once.
* Reverting to the previous version is equally fast (as long as the old version environment is maintained) and it is done via the same process as the deployment so operators are familiar with it.

### Running the Demo

* Start the vagrant project as described in the [Prerequisites](#Prerequisites) section

  The virtual machine which is created will have:

  * Version 0.2 (Blue Background) of the app running on `port 5002`
  * Version 0.3 (Green Background) of the app running on `port 5003`
  * Nginx running as load balancer listening on `port 80` and host's `port 8080` forwarded to it. All traffic will be routed to the "blue" server

* Switch traffic between the two versions:

  * In the vagrant VM - `cd /vagrant/ops/scripts`
  * Switch the traffic between the environments by using `./switch-nginx-traffic.sh <blue|blue-green|green>`