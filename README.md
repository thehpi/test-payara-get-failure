# test-payara-get-failure

There is an intermittent problem that causes 'asadmin get' to produce different results from what is stored in domain.xml.

## Expected Outcome ##

If I execute this command:

    asadmin set-monitoring-level --target=server-config --module jdbcConnectionPool --level HIGH

and I stop and start the domain (because this is required for some settings) then I expect the following command to produce the same value

    asadmin get configs.config.server-config.monitoring-service.module-monitoring-levels.jdbc_connection_pool

So:

    configs.config.server-config.monitoring-service.module-monitoring-levels.jdbc-connection-pool=HIGH

## Current Outcome ##

The outcome is sometimes

    configs.config.server-config.monitoring-service.module-monitoring-levels.jdbc-connection-pool=OFF

If the delays in the entrypoint.sh script are lowered it happens more often.

## Steps to reproduce ## 

Run the script

    ./restart.sh

### Details

This will stop and delete the container if it exists and restart it so it starts clean.

The entrypoint.sh script is overridden and will be started.

The script will

    asadmin start-domain
    sleep 10
    ${dir}/set.sh
    asadmin stop-domain
    asadmin start-domain
    sleep 5
    ${dir}/get.sh
    asadmin stop-domain

The set.sh script:

    asadmin set-monitoring-configuration --dynamic=true --monitoringserviceenabled=true --amxenabled=true --jmxlogenabled=false --jmxlogfrequency=15 --jmxlogfrequencyunit=SECONDS --target=server-config 
    asadmin set-monitoring-level --target=server-config --module jdbcConnectionPool --level HIGH
    asadmin enable-secure-admin

The get.sh script:

    asadmin get configs.config.server-config.monitoring-service.module-monitoring-levels.jdbc_connection_pool


