#!/bin/bash

PUPPET=/opt/puppetlabs/bin/puppet
MODULE_FILE=forge-modules

puppetdir=$1
environment=$2

module_list_installer () {
    modulelist=$1
    if [ -e $modulelist ]; then
        while read module; do
            $PUPPET module install $module --environment $environment --codedir $puppetdir
        done <$modulelist
    fi
}

MODULE_LIST=$puppetdir/$MODULE_FILE
module_list_installer $MODULE_LIST

ENVIRONMENT_MODULE_LIST=$puppetdir/environments/$environment/$MODULE_FILE
module_list_installer $ENVIRONMENT_MODULE_LIST
