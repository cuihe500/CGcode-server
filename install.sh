#!/bin/bash
#一键部署脚本v0.3 Created By Cuichanghe
path=$(pwd);
pathto="/usr/CGcode-server";
echo 一键部署脚本V0.3 Created By Cuichanghe;
echo 请确认目前正在root用户下执行！！！
echo 请输入第一个用户的用户名:
read USER_NAME
echo 请输入第一个用户的SSH登录密码（系统密码）:
read USER_PASSWORD
echo 请输入第一个用户的端口号:
read USER_PORT
echo 请输入code-server登录密码(留空则为无):
read CS_PASSWORD
if [[ -z "$USER_NAME" ]] || [[ -z "$USER_PASSWORD" ]] || [[ -z "$USER_PORT" ]]
echo 参数有误！请检查参数是否正确？
exit
fi
echo 三秒后将会自动部署CGCode-server... 按下Ctrl+C终止执行
echo ----------------------3----------------------
sleep 1
echo ----------------------2----------------------
sleep 1
echo ----------------------1----------------------
sleep 1
echo 开始执行脚本
copy(){
    echo 正在复制code-server本体
    mkdir -p ${pathto}
    cp -r ${path}/code-server ${pathto}
    echo 正在复制model文件夹
    cp -r ${path}/model ${pathto}
    echo 正在复制脚本文件
    cp -r ${path}/sh ${pathto}
    echo 正在复制环境配置文件到用户目录
    echo 复制完成
}
copy
ln -sf ${path}/sh/adduser.sh /root/adduser.sh #生成添加用户脚本软连接
chmod +x ${path}/sh/adduser.sh
/root/adduser.sh ${USER_NAME} ${USER_PASSWORD} ${USER_PORT} ${CS_PASSWORD}
copyusr(){
    echo 正在配置环境文件
    cp ${path}/model/stopSrv.service /usr/lib/systemd/system/
    systemctl enable stopSrv
    echo 环境文件配置完成
}
copyusr
echo CGcode-server安装完成 请使用/root/adduser.sh 增加用户
echo 使用方式为:/root/adduser.sh 用户名 密码 端口号
echo 玩的开心！Have Fun!
