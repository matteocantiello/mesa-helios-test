#!/bin/bash

find /mnt/home/mcantiello/ceph/testhub -maxdepth 1 -type d -mtime +6 -exec rm -rf {} \;
find /mnt/home/mcantiello/ceph/mesa-git-tests -maxdepth 1 -type d -mtime +6 -exec rm -rf {} \;
