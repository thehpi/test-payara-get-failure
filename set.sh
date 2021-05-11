#!/bin/bash

asadmin set-monitoring-configuration --dynamic=true --monitoringserviceenabled=true --amxenabled=true --jmxlogenabled=false --jmxlogfrequency=15 --jmxlogfrequencyunit=SECONDS --target=server-config 
asadmin set-monitoring-level --target=server-config --module jdbcConnectionPool --level HIGH
asadmin enable-secure-admin

