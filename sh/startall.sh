#!/bin/bash
#
while read line
do
if [ -f $/home/${line}/.runned ]; then
	echo "${line}已经运行！"
elif [ -f $/home/${line}/.iscfg ]; then
	su - ${line} -c "echo 用户：${line} su命令调用成功!"
else
	echo "用户: ${line}非CGcode-server用户！"
fi
done < /usr/CGcode-server/list/cguserlist
echo "所有用户启动成功!"