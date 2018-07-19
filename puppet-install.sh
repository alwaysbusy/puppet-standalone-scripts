#!/bin/bash

puppetdir=$1
setconf=0
if [ "$#" -eq 2 ]; then
    setconf=1
fi

RELEASE_VERSION=`lsb_release -c -s`

PUPPET_RELEASE_PACKAGE=puppet5-release-$RELEASE_VERSION.deb

wget https://apt.puppetlabs.com/$PUPPET_RELEASE_PACKAGE
dpkg -i $PUPPET_RELEASE_PACKAGE
rm -rf $PUPPET_RELEASE_PACKAGE

apt update
apt-get install -y puppet-agent

if [ $setconf -eq 1 ]; then
    PUPPET_CONF=$puppetdir/puppet.conf
    if [ -e $PUPPET_CONF ]; then
        PUPPET_DATA_PATH=/etc/puppetlabs/puppet
        rm -rf $PUPPET_DATA_PATH/puppet.conf
        ln -sf $PUPPET_CONF $PUPPET_DATA_PATH/puppet.conf
    fi
fi
