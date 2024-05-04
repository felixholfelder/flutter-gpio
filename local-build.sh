#!/bin/bash

pass=$(echo cmV0cm9p | base64 --decode)

usr=pi
host=secondpie

conn=$usr@$host

./pscp -pw "$pass" -r ./ $conn:/home/$usr/app/debug

plink -ssh $conn -pw "$pass" -m "copy.txt"
