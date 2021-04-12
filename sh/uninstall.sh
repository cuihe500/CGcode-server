#!/bin/bash
while read username
do
	rm -f /home/${username}/.runned
done < /usr/CGcode-server/list/cguserlist
echo uninstall code-server succeed!