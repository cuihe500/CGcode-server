#!/bin/bash
# 需要创建的用户名，示例：USER_NAME=myuser
USER_NAME=$1;
# 创建用户所属的用户组，示例：USER_GROUP=mygroup
USER_GROUP=root;
# 用户密码，示例：USER_PASSWD=Cloud12#$
USER_PASSWD=$2;
#端口号
USER_PORT=$3;
#code-server登录密码
CS_PASSWORD=$4;
#本地路径
path=`pwd`;
# 校验参数
function check_param()
{
    if [[ ! -n ${USER_NAME} ]] || [[ ! -n ${USER_GROUP} ]] || [[ ! -n ${USER_PASSWD} ]] || [[ ! -n ${USER_PORT} ]]; then
        echo "错误！请检查用户名 密码或端口号不能为空！"
        exit 1;
    fi
}
 
echo 一键创建用户V0.4 Created By Cuichanghe
echo -------------------------------------------------
echo 参数为:${*}
creat_user $*
#复制基础文件和插件
cp -r /usr/CGcode-server/model/. /root
#新建并写入配置文件
cd /root/.config/code-server
echo bind-addr: 0.0.0.0:${USER_PORT}>config.yaml;
if [ -z "$CS_PASSWORD" ]; then
echo 检测到无code-server登录密码
echo auth: none >> config.yaml;
echo password: >> config.yaml;
else
echo 检测到有code-server登录密码
echo auth: password >> config.yaml;
echo "password: "${CS_PASSWORD} >> config.yaml;
fi
echo cert: false >> config.yaml;
#复制登录自启动脚本配置
cp -r /usr/CGcode-server/model/.bash_profile /root
#更改权限
chmod -R +775 /root/.local
#创建用户自己的工作目录
cd /root
mkdir WorkPlaceForroot
#更改所属用户
chown -R root /root/WorkPlaceForroot
#复制说明和测试文件
cp  /usr/CGcode-server/model/ReadMe.md /root/WorkPlaceForroot
cp  /usr/CGcode-server/model/Welcome.cpp /root/WorkPlaceForroot
#新建并写入初始页面配置文件
cd /home/${USER_NAME}/.local/share/code-server
echo '{' >coder.json;
echo   '"query": {},' >>coder.json;
echo    '"update": {' >>coder.json;
echo     '"checked": 1617527558674,' >>coder.json;
echo     '"version": "3.9.2"' >>coder.json;
echo '  },' >>coder.json;
echo  ' "lastVisited": {' >>coder.json;
echo     '"url": "/home/'${USER_NAME}'/WorkPlaceFor'${USER_NAME}'",' >>coder.json;
echo     '"workspace": false' >>coder.json;
echo  ' }' >>coder.json;
echo '}' >>coder.json;
#开启权限
chown -R root /root/.local
echo "用户创建成功！"