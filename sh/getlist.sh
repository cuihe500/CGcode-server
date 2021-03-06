#!/bin/bash
dir=$(ls -l /home/ |awk '/^d/ {print $NF}')
if [ -e "/usr/CGcode-server/list/cguserlist" ]; then
	rm -f /usr/CGcode-server/list/cguserlist
	touch /usr/CGcode-server/list/cguserlist
else
	touch /usr/CGcode-server/list/cguserlist
fi
for i in $dir
do
if [ -e "/home/${i}/.isfcg" ]; then
	echo ${i} >> /usr/CGcode-server/list/cguserlist;
else
	echo "用户： ${i} 不是CGcode-server用户！"
fi
done 
echo "用户列表重建完毕！"