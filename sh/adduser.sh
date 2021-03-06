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
 
# 创建用户
function creat_user()
{
    check_param
	
    #create group
    grep "^${USER_GROUP}" /etc/group &> /dev/null
    if [ $? -ne 0 ]; then
        groupadd ${USER_GROUP}
    fi
    #create user
    id ${USER_NAME} &> /dev/null
    if [ $? -ne 0 ]; then
        useradd -g ${USER_GROUP} ${USER_NAME} -d /home/${USER_NAME}
        echo ${USER_PASSWD}| passwd ${USER_NAME} --stdin
        chage -M 99999 ${USER_NAME}
    fi
}
echo 一键创建用户V0.4 Created By Cuichanghe
echo -------------------------------------------------
echo 参数为:${*}
creat_user $*
#复制基础文件和插件
cp -r /usr/CGcode-server/model/. /home/${USER_NAME}/
#新建并写入配置文件
cd /home/${USER_NAME}/.config/code-server
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
cp -r /usr/CGcode-server/model/.bash_profile /home/${USER_NAME}/
#更改权限
chmod -R +775 /home/${USER_NAME}/.local
#创建用户自己的工作目录
cd /home/${USER_NAME}/
mkdir WorkPlaceFor${USER_NAME}
#更改所属用户
chown -R ${USER_NAME} /home/${USER_NAME}/WorkPlaceFor${USER_NAME}
#复制说明和测试文件
cp  /usr/CGcode-server/model/ReadMe.md /home/${USER_NAME}/WorkPlaceFor${USER_NAME}
cp  /usr/CGcode-server/model/Welcome.cpp /home/${USER_NAME}/WorkPlaceFor${USER_NAME}
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
#创建用户标识文件.isfcg
if [ -e "/home/${USER_NAME}/.isfcg" ]; then
	echo "CGcode-server用户标识已经存在!"
else
    touch /home/${USER_NAME}/.isfcg
    echo "CGcode-server用户标识创建成功!"
fi
#新建for-code-server标识
#开启权限
chown -R ${USER_NAME} /home/${USER_NAME}/.local
#通过调用登录自启配置 开启code-server
su - ${USER_NAME} -c "echo su is succeed!"
echo ${USER_NAME} >> /usr/CGcode-server/list/cguserlist
echo "${USER_NAME}	${USER_PORT}" >> /usr/CGcode-server/list/cguserlistp
echo "用户创建成功！"