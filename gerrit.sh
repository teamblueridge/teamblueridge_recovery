#!/bin/bash
if [ -f ~/.ssh/tbr_username ]
url="http://gerrit.teamblueridge.com"
name="Team BlueRidge Gerrit"
then
	echo "Welcome back to $name!"
	echo "You've already been through setup. Lets continue!"
else
	echo "Welcome to $name"
	echo "You need to setup your account."
	echo "If you don't have a $name account, please go to $url and create one."
	echo -n "What is your $name username: "
	read un #'$un' = Username
	echo $un > ~/.ssh/tbr_username
	echo "BE SURE YOUR SSH KEYS ARE MATCHED WITH GERRIT IN YOUR SETTINGS"
fi
un=`cat ~/.ssh/tbr_username` # Redefines $un as tbr_username file contents (from setup)
echo "Your username is $un to reconfigure, run this command (w/o quotes) 'rm -rf ~/.ssh/tbr_username'"
echo -n "Project name: "
read projectname
echo -n "Branch: "
read branch
git push "ssh://$un@gerrit.teamblueridge.com:29418/$projectname" "HEAD:refs/for/$branch"
echo "If your push succeeded, please go to $url to view the status."
echo "As an alternative to using this script, you could clone straight from Gerrit (IF you know what you're doing)"
