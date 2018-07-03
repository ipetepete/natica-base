#!/usr/bin/env bash

# This will allow root user to
# read the nfs mount
groupadd -g 794 nfs
usermod -a -G nfs root
