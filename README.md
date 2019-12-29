# AIO: All In One

## Description
The main task here is to code a script which automates serveral tasks like Setting up Samba Server, Updating system packages, Checking System health (CPU, Disk and Network Usages), Detecting and mounting usb and disk drives etc.

## Language to be used
Scripts should be coded in either bash or Python.

## Detailed Plan of the project
Task here is to code a bash/python script which can support the following tasks:
### 1) Setting up the Samba Server.
Script should take serveral input from the user like directory to be shared, username and password for server login etc.
### 2) Updating the system packages.
Scipt should be able to detect the distro on which it is running and should be able to run the appropriate commands to update packages. 
### 3) Running in system monitoring mode.
Script should support running in a monitoring mode where it can keep a check on system health by monitoring system wide resource usage, hardware health, Network usage etc.
### 4) Mounting and Unmounting plugged in devices.
Script should be able to check for plugged in disk devices (USB devices and drive partitions) and mounting/unmounting.

## Instructions
1) Each of the 4 tasks must be submitted in different commits.
2) Script should accept command like options -1,-2,-3,-4 and -help for each task and "help" for descriptions of the script.
3) Corner cases should be handled accordingly for each task.
4) Do not copy code directly from other PRs or stackoverflow.
5) For any query, Open an issue and place your query there. 
6) Script should support both Debian and Fedora based distributions.


