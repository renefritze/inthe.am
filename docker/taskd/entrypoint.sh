#!/bin/sh

if [ ! -d ${TASKDDATA}/pki ]; then
      cd $TASKDDATA
    taskd init
    taskd add org inthe_am
    taskd add org testing

    mkdir ${TASKDDATA}/pki
    cp /usr/share/taskd/pki/generate* ${TASKDDATA}/pki
    cp /usr/share/taskd/pki/vars ${TASKDDATA}/pki
    cd ${TASKDDATA}/pki
    ./generate
    taskd config --force client.cert ${TASKDDATA}/pki/client.cert.pem
    taskd config --force client.key ${TASKDDATA}/pki/client.key.pem
    taskd config --force server.cert ${TASKDDATA}/pki/server.cert.pem
    taskd config --force server.key ${TASKDDATA}/pki/server.key.pem
    taskd config --force server.crl ${TASKDDATA}/pki/server.crl.pem
    taskd config --force ca.cert ${TASKDDATA}/pki/ca.cert.pem

    # And finaly set taskd to listen in default port
    taskd config --force server 0.0.0.0:53589

    #chmod -R 777 /var/taskd/
fi
