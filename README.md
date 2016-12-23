
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

## Requirements

* docker 1.11+

## Usage

```
* Set Environment Variables

    $ export IMAGE="schneidermatic/opennms:18.0.2_centos-7.2"
    $ export NAME="onms1"

* Pull the Docker image  

    $ docker pull $IMAGE

* Run a docker container

    $ docker run -v $(pwd):$(pwd) -w $(pwd) -h $NAME -dit -P --name $NAME $IMAGE
    $ CONTAINER_ID=$(docker ps | grep "$IMAGE" | awk '{ print $1 }')
    $ IP_ADDRESS=$(docker inspect -f '{{ .NetworkSettings.IPAddress }}' $CONTAINER_ID)
    $ echo "http://$IP_ADDRESS:8980/opennms"

    The web application is exposed on TCP port 8980. You can login with default user *admin* with password *admin*. Please change immediately the default password to a secure password.

    NOTE: It takes nearly 60 seconds or more till you can access the web-console due to database installation process.

```

## Support and Issues

Please open issues in the [GitHub issue](https://github.com/schneidermatic/opennms-dockerfiles) section.

## Author

markus.schneider73@gmail.com
