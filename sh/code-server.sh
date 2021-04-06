#!/bin/bash
path=`pwd`
if [ -f ${path}/.runned ]; then
{
    echo "This script can only execute once! You have runned it!"
    exit
}
else
    touch ${path}/.runned
    screen_name=$"code_server"
    screen -dmS $screen_name
    cmd=$"cd /usr/CGcode-server/code-server/bin"
    screen -x -S $screen_name -p 0 -X stuff "$cmd"
    screen -x -S $screen_name -p 0 -X stuff $'\n'
    cmd=$"./code-server"
    screen -x -S $screen_name -p 0 -X stuff "$cmd"
    screen -x -S $screen_name -p 0 -X stuff $'\n'
    echo code-server is running!
fi
