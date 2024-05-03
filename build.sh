#!/bin/bash

pass=$(echo cmV0cm9p | base64 --decode)

usr=pi
host=secondpie

conn=$usr@$host

#TODO - evtl stop service

flutter build linux --release

./pscp -pw "$pass" ./build/linux/x64/release/bundle/* $conn:/home/$usr/app/
read test
#putty -ssh $conn -pw "$pass" -m "./startService.txt"