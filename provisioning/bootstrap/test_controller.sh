#!/bin/bash

for i in `seq 1 15`; do 
  echo "-=Student $i=-"
  curl -k -X POST -c cookies -d 'username=admin&password=Avi123$%' https://controller.student${i}.lab/login > /dev/null 2>&1
  curl -k -b cookies 'https://controller.student${i}.lab/api/cloud-inventory?name=AWS&fields=status'
  echo
done
