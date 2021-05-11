#!/bin/bash

dir=${0%/*}

asadmin start-domain
sleep 10
${dir}/set.sh
asadmin stop-domain
asadmin start-domain
sleep 5
${dir}/get.sh
asadmin stop-domain
