#!/bin/bash
path=`pwd`
if [ -e "/home/${USER}/.runned" ]; then
    echo "This script can only execute once! You have runned it!"
    exit
else
    touch /home/${USER}/.runned
    screen_name=$"code_server"
    screen -dmS $screen_name
    cmd=$"code-server"
    screen -x -S $screen_name -p 0 -X stuff "$cmd"
    screen -x -S $screen_name -p 0 -X stuff $'\n'
    echo code-server is running!
fi
