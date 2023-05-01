#!/bin/bash

# author: Sérgio Napolitano
# purpose: auto create users, groups and groupdirs for new test environments with shared dirs.
# Disclaimer: 
# this script was written just for test purpose and your destination should be only for test environment

# vars section
USER_GRPS="ADM VEN SEC";
USERS_ADM="carlos maria joao"
USERS_VEN="debora sebastiana roberto"
USERS_SEC="josefina amanda rogerio"
USER_PASS="Senha123"
CRYPT_PASS=$(perl -e 'print crypt($ARGV[0], "password")' $USER_PASS)

echo "Creating users and shared dirs..."
for i in $USER_GRPS ; do
    groupadd GRP_$i
    mkdir /${i,,}
    chown root:GRP_$i /${i,,}
    chmod 770 /${i,,}
done
mkdir /publico
chmod 777 /publico

echo ""
echo "#########"
echo "Creating users based on groups..."
for i in $USER_GRPS ; do
    grp=$(echo USERS_${i})	
    for j in ${!grp} ; do
       useradd $j -m -s /bin/bash -p $CRYPT_PASS -G GRP_$i
    done
done


