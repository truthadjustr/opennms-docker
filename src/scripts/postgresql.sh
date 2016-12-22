#!/bin/bash

/usr/pgsql-9.5/bin/pg_ctl start -D /var/lib/pgsql/9.5/data -l /var/lib/pgsql/9.5/log/postgres.log

exit 0
