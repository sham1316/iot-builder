#!/bin/bash

SSH_USER = $1
SSH_HOST = $2
SSH_HOST_DEV = $3
SSH_PASS = $4
BRANCH = $5
DEPLOY_FOLDER = $6


echo "adding host to known host"
mkdir -p ~/.ssh
touch ~/.ssh/known_hosts 
ssh-keyscan $SSH_HOST >> ~/.ssh/known_hosts 
echo "run command on remote server"

sshpass -p pass ssh ${2}@sftp  << EOF
    ls
    pwd
EOF
