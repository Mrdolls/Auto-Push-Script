#!/bin/bash
if [ "$#" -gt 1 ]; then
    echo -e "\e[1;31m✘ Error: Too many arguments. Usage: $0 \"message\"\e[0m"
    exit 1
fi
commit_msg="$1"
if [ -z "$commit_msg" ]; then
    commit_msg="Automatic update"
fi
echo -e "\e[1;34m[Git] Adding files...\e[0m"
git add --all
echo -e "\e[1;34m[Git] Creating commit...\e[0m"
git commit -am "$commit_msg"
read -p "Push to remote repository? [y/n] " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    git reset --mixed HEAD~1
    echo -e "\e[1;33m[Aborted] Push aborted by user.\e[0m"
    exit 0
fi
echo -e "\e[1;34m[Git] Pushing...\e[0m"
git push
if [ $? -ne 0 ]; then
    echo -e "\e[1;31m[Error] Push failed.\e[0m"
    exit 1
fi
echo -e "\e[1;32m[Success] Push successful!\e[0m"
