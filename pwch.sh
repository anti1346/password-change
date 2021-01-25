#!/bin/bash

MyIP=`dig @resolver1.opendns.com myip.opendns.com +short`
NetworkID=`echo $MyIP | cut -d . -f1-3`
HostID=`echo $MyIP | cut -d . -f4`

userlist=$@

function PASSWORD
{
  for user in $userlist; do

    if [ $user = user1 ]; then
      pwdstr=aaa
    elif [ $user = user2 ]; then
      pwdstr=bbb
    elif [ $user = root ]; then
      pwdstr=ccc
    else
      echo -e "Unknown user name '$user'."
      exit 127
    fi

    echo $pwdstr$nid$hid | passwd --stdin $user > /dev/null 2>&1
    echo -e "$user password has been updated."
    echo -e "sshpass -p'$pwdstr$nid$hid' ssh $user@$MyIP -oStrictHostKeyChecking=no"
  done
}

case $NetworkID in  
  111.111.111)
    nid='!!!'
    hid=$HostID
    PASSWORD
    ;;
  222.222.222)
    nid='@@@'
    hid=$HostID
    PASSWORD
    ;;
  10.10.10)
    nid=')!)'
    hid=$HostID
    PASSWORD
    ;;
  10.10.20)
    nid=')@)'
    hid=$HostID
    PASSWORD
    ;;
  192.168.0)
    nid=')))'
    hid=$HostID
    PASSWORD
    ;;
  *)
    echo -e "Unknown Network ID(Nenmask) '$NetworkID'."
    ;;
esac
