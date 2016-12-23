#==============================================================================
# Author: Markus Schneider
# Arch:             x86_64
# Entities:         CentOS-7.2
#                   PostgreSQL-9.5
#                   OpenNMS-18.2.1 
#==============================================================================

FROM schneidermatic/postgresql:postgresql-9.5_centos-7.2
MAINTAINER markus.schneider73@gmail.com

## Set work dir 
WORKDIR /tmp

## JAVA ENV
ENV JAVA_VERSION 8u111
ENV BUILD_VERSION b14
ENV JAVA_HOME=/usr/java/orajava8

## OPENNMS ENV
ENV OPENNMS_HOME /opt/opennms

## Upgrading system
# RUN yum -y upgrade
# RUN yum clean all

##------------------------------------------------------------------------------
## BASE INSTALL
##------------------------------------------------------------------------------

## Install JDK
## origin - https://github.com/Mashape/docker-java8
RUN wget --no-cookies --no-check-certificate --header "Cookie: oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/$JAVA_VERSION-$BUILD_VERSION/jdk-$JAVA_VERSION-linux-x64.rpm" -O /tmp/jdk-8-linux-x64.rpm
RUN yum -y install ./jdk-8-linux-x64.rpm
RUN yum clean all

## Add OpenNMS PGP Key
RUN rpm --import http://yum.opennms.org/OPENNMS-GPG-KEY 

## Add PKGs Begin 
RUN rpm -Uvh http://yum.opennms.org/stable/rhel7/jicmp/jicmp-1.4.6-1.x86_64.rpm
RUN rpm -Uvh http://yum.opennms.org/stable/rhel7/jicmp6/jicmp6-1.2.4-1.x86_64.rpm
RUN rpm -Uvh http://yum.opennms.org/stable/common/opennms/opennms-core-18.0.2-1.noarch.rpm
RUN rpm -Uvh http://yum.opennms.org/stable/common/opennms/opennms-webapp-jetty-18.0.2-1.noarch.rpm
RUN rpm -Uvh http://yum.opennms.org/stable/common/opennms/opennms-plugin-provisioning-snmp-asset-18.0.2-1.noarch.rpm
RUN rpm -Uvh http://yum.opennms.org/stable/common/opennms/opennms-jmx-config-generator-18.0.2-1.noarch.rpm
RUN rpm -Uvh http://yum.opennms.org/stable/common/opennms/opennms-plugin-northbounder-jms-18.0.2-1.noarch.rpm
RUN rpm -Uvh http://yum.opennms.org/stable/common/opennms/opennms-plugin-protocol-cifs-18.0.2-1.noarch.rpm
RUN rpm -Uvh http://yum.opennms.org/stable/common/opennms/opennms-plugin-protocol-dhcp-18.0.2-1.noarch.rpm
RUN rpm -Uvh http://yum.opennms.org/stable/common/opennms/opennms-plugin-protocol-xml-18.0.2-1.noarch.rpm
RUN rpm -Uvh http://yum.opennms.org/stable/common/opennms/opennms-plugin-protocol-nsclient-18.0.2-1.noarch.rpm
RUN rpm -Uvh http://yum.opennms.org/stable/common/opennms/opennms-plugin-provisioning-snmp-hardware-inventory-18.0.2-1.noarch.rpm
RUN rpm -Uvh http://yum.opennms.org/stable/common/opennms/opennms-plugin-ticketer-jira-18.0.2-1.noarch.rpm
RUN rpm -Uvh http://yum.opennms.org/stable/common/opennms/opennms-plugin-ticketer-otrs-18.0.2-1.noarch.rpm

## File for initial OpenNMS DB installation
RUN touch /opt/opennms/etc/install_onmsdb

## Add Config
RUN mkdir -p /opt/docker/config
COPY src/config /opt/docker/config

## Update supervisord.conf 
COPY src/config/supervisord.conf /etc/supervisord.conf

## Update 'bootstrap' file
COPY src/scripts/bootstrap /opt/docker/scripts/bootstrap
RUN chmod 775 /opt/docker/scripts/bootstrap

## Add opennms wrapper script    
ADD src/scripts/opennmsw.sh /opt/docker/scripts/opennmsw.sh
RUN chmod 775 /opt/docker/scripts/opennmsw.sh

## Volumes for storing data outside of the container
VOLUME ["/var/log/opennms","/var/opennnms"]

##------------------------------------------------------------------------------
## EXPOSED PORTS
##------------------------------------------------------------------------------
## -- OpenNMS HTTP       Port(8980)
## -- OpenNMS HTTPS      Port(8443)
## -- OpenNMS JMX        Port(18980)
## -- OpenNMS KARAF RMI  Port(1099)
## -- OpenNMS KARAF SSH  Port(8101)
## -- OpenNMS MQ         Port(61616)
## -- OpenNMS Eventd     Port(5817)
## -- PostgreSQL         Port(5432)
## -- SNMP (AGENT)       Port(161)
## -- SNMP (SERVER)      Port(162)
## -- SSH                Port(22)
EXPOSE 8980 8443 18980 1099 8101 61616 5817 5432 162/udp 161/udp 
