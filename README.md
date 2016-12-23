
## Supported tags

* `latest`, currently 18.0.2-1 
* `18.0.2-1`, stable Horizon

### 18.0.2

* CentOS 7.2 Oracle jdk1.8.0_112
* CentOS 7.2 PostgreSQL 9.5.x latest
* CentOS 7.2 OpenNMS 18.0.2

## OpenNMS Horizon Docker files

This repository provides different versions of OpenNMS Horizon docker images.
OpenNMS is shipped as an express version (all in one Dockerfile). 

**NOTE: This express version is for learning/staging/testing purposes only.** 
**Don't use this OpenNMS Docker image in production environments!**

## Requirements

* docker 1.11+

## Usage

```
    1.  Set Environment Variables

      $ export IMAGE="schneidermatic/opennms:18.0.2_centos-7.2"
      $ export NAME="onms1"

    2.  Pull Docker image  

      $ docker pull $IMAGE

    3.  Run Docker container

      $ docker run -v $(pwd):$(pwd) -w $(pwd) -h $NAME -dit -p 8980:8980 -p 18980:18980 -p 1099:1099 -p 8101:8101 -p 61616:61616 -p 5817:5817 -p 161-162:161-162/udp -p 22:22 --name $NAME $IMAGE

    The web application is exposed on TCP port 8980 (URL - http://localhost:8980/opennms). You can login
    with default user **admin** with password **admin**. Please change immediately the default password to
    a secure password.

    NOTE: The first start takes nearly 60 seconds or more till you are able to access the web-console. 
    This is because of the initial database installation process.

    4.  SSH Login
        
        $ ssh sysadm@localhost -p 22 

        Default password is **changeit**. User **sysadm** is member of the **wheel** group, so change this
        password to a more secure one. After a successfull login run the following command ...

        $ sudo passwd sysadm

```

## Support and Issues

Please open issues in the [GitHub issue](https://github.com/schneidermatic/opennms-dockerfiles/issues) section.

## Author
Markus Schneider
