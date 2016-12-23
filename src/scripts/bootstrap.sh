#!/bin/bash

#******************************************************************************
# Copyright 2015 the original author or authors.                              *
#                                                                             *
# Licensed under the Apache License, Version 2.0 (the "License");             *
# you may not use this file except in compliance with the License.            *
# You may obtain a copy of the License at                                     *
#                                                                             *
# http://www.apache.org/licenses/LICENSE-2.0                                  *
#                                                                             *
# Unless required by applicable law or agreed to in writing, software         *
# distributed under the License is distributed on an "AS IS" BASIS,           *
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.    *
# See the License for the specific language governing permissions and         *
# limitations under the License.                                              *
#******************************************************************************/

OPENNMS_HOME=/opt/opennms
DOCKER_HOME=/opt/docker

export DB_HOST=${DB_HOST:-127.0.0.1}
export DB_PORT=${DB_PORT:-5432}
export DB_PASSWORD=${DB_PASSWORD:-"changeit"}

__install_db() {
  cd $OPENNMS_HOME/etc
  sed -i s/PG_HOST/$(echo $DB_HOST)/g opennms-datasources.xml
  sed -i s/PG_PORT/$(echo $DB_PORT)/g opennms-datasources.xml
  sed -i s/PG_PASSWORD/$(echo $DB_PASSWORD)/g opennms-datasources.xml
  $OPENNMS_HOME/bin/install -dis
  cp $DOCKER_HOME/config/supervisord.conf /etc/supervisord.conf
  supervisorctl reread 
  supervisorctl start opennms
  rm $OPENNMS_HOME/etc/install_onmsdb     
}  

__manage_db() {
  $DOCKER_HOME/scripts/dbadmin.sh
}  

__init() {
  if [ "$INSTALL_DB" = "y" ] || [ -e $OPENNMS_HOME/etc/install_onmsdb ]
  then
     /usr/sbin/sshd -D &
     sudo -u postgres /usr/pgsql-9.5/bin/postgres -D /var/lib/pgsql/9.5/data -c config_file=/var/lib/pgsql/9.5/data/postgresql.conf &
     __install_db && /opt/opennms/bin/opennms -f start
     #__manage_db
  else
     supervisord
  fi
}

main() {
  __init "$@"
}

main "$@"
