#!/bin/bash
#调用卸载脚本删除所有运行标识文件
echo "调用卸载脚本删除所有运行标识文件"
/usr/CGcode-server/sh/uninstall.sh
#通过指令获取进程号
echo "获取所有Screen进程号:"
ps -U root -u root -N | awk '{print $4,$1}' | grep 'screen'| awk -F ' ' '{print $2}' | tee temp.tmp
echo "三秒后将杀死所有screen进程(按下Ctrl+C取消)..."
sleep 1
echo "---------------3---------------"
sleep 1
echo "---------------2---------------"
sleep 1
echo "---------------1---------------"
sleep 1
while read line
do
kill $line
done < temp.tmp
echo "screen线程杀死完毕,即将重启所有用户..."
sleep 1
while read line
do
su - ${line} -c "echo 用户：${line} su命令调用成功!"
done < /usr/CGcode-server/list/cguserlist
rm -f temp.tmp
echo "重启成功!"
