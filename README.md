# 欢迎使用CGcode-server
基于[code-server™](https://github.com/cdr/code-server)再次开发
目前更新到:v0.2  
安装依赖：Screen  
Centos:  
`yum install screen`  
安装步骤：  
`git clone https://github.com/cuihe500/CGcode-server`  
`./install.sh`  
注意：运行脚本必须在root用户下，否则将会出现权限问题
按照提示根据输入第一个用户的用户名和ssh(本地用户)密码,并且指定端口号  
确认回车后将会进行自动部署，并且创建第一个用户  
后续创建用户可以使用:  
`/root/adduser.sh 用户名 ssh(本地用户)密码 端口号`
将会自动进行创建用户并且部署  
可以直接使用端口号进行访问  

1. sh(脚本文件目录)
	- adduser.sh 自动添加用户并部署
	- code-server.sh 自动运行code-server（一般被.bash_profile）调用
	- uninstall.sh 关机卸载状态
2. model(默认配置文件目录)
	- .bash_profile 复制到用户目录下(/home/${USER_NAME})通过su命令调用
	- stopSrv.service 配置关机或重启系统系统服务(关机或重启自动清理状态或缓存文件)
	- Welcome.cpp 调试用默认cpp文件
	- ReadMe.md 默认说明文件
	- .local 插件所在文件夹
	- .config 配置所在文件夹
3. code-server(code-server主目录，会复制到/usr 目录下)
	- \bin\code-server 启动文件 可以手动运行该文件达到启动code-server目的  
--------------------------------------------------------
Created By Cuichanghe  2021年4月7日(V0.2)
玩的开心！Have Fun!
