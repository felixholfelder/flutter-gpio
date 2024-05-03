#!/bin/bash

pass=$(echo cmV0cm9p | base64 --decode)

usr=pi
host=secondpie

conn=$usr@$host

#./pscp -pw "$pass" ./ $conn:/home/$usr/flutter-gpio

ssh $conn << EOF
  ls some_folder;
  ./someaction.sh 'some params'
  pwd
  ./some_other_action 'other params'
EOF

read test
