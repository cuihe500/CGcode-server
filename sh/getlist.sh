#!/bin/bash
dir=$(ls -l /home/ |awk '/^d/ {print $NF}')
for i in $dir
do
if [ -f $/home/${i}/.isfcg ]; then
	i > cguserlist;
else
	echo "用户： ${i} 不是CGcode-server用户！"
fi
done 
echo "用户列表重建完毕！"