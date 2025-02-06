#!/bin/bash

find /mnt/home/pmocz/ceph/testhub -maxdepth 1 -type d -mtime +70 -exec rm -rf {} \;
find /mnt/home/pmocz/ceph/mesa-git-tests -maxdepth 1 -type d -mtime +70 -exec rm -rf {} \;
