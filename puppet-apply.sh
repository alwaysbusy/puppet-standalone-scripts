#!/bin/bash

PUPPET=/opt/puppetlabs/bin/puppet

puppetdir=$1
environment=$2

$PUPPET apply --environment $environment --codedir $puppetdir
