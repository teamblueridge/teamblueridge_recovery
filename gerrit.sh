#!/bin/bash
clear
project=$1
branch=$2
name="Team BlueRidge Gerrit"
url="http://gerrit.teamblueridge.com/"
un=`cat ~/.ssh/tbr_username`
if [ -f ~/.ssh/tbr_username ]
then
echo "Welcome back to $name, $un!"
echo "You've already been through setup already so let's continue!"
echo "Your username is ${un}. To change this, execute 'rm -rf ~/.ssh/tbr_username'."
else
echo "Welcome to $name"
echo "You need to setup your account."
echo "If you don't have a $name account, please go to $url and create one."
echo -n "What is your $name username: "
read un #'$un' = Username
echo $un > ~/.ssh/tbr_username
echo "Your username is ${un}. To change this, execute 'rm -rf ~/.ssh/tbr_username'."
echo "BE SURE YOUR SSH KEYS ARE MATCHED WITH GERRIT IN YOUR SETTINGS"
fi

if [ -z "$1" ]
then
echo "Project name not given. Next time, please use the format './gerrit <project> <branch>'";
read -p "Project name (case-sensitive): " project
fi
if [ -z "$2" ]
then
echo "Branch wname not given. Next time, please use the format './gerrit <project> <branch>'"
read -p "Branch name (case-sensitive): " branch
fi
un=`cat ~/.ssh/tbr_username`
while true; do
read -p "Have you already committed your changes [Y/N]? " yn
case $yn in
[Yy]* ) echo "Good, let's continue"; break;;
[Nn]* ) echo "Please go and commit your changes ('git commit -a')."; exit;;
    * ) echo "Please answer Y(es) or N(o).";;
esac
done
echo "Push information:"
echo "Your username: $un"
echo "Project: $project"
echo "Branch: $branch"
while true; do
read -p "Are you sure you wish to push to Gerrit [Y/N]? " yn
case $yn in
[Yy]* ) git push "ssh://$un@gerrit.teamblueridge.com:29418/$project" "HEAD:refs/for/$branch"; break;;
[Nn]* ) echo "Goodbye."; exit;;
    * ) echo "Please answer Y(es) or N(o).";;
esac
done
exit
