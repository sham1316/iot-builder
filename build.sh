#!/bin/bash

export BRANCH=$(echo $JB_SPACE_GIT_BRANCH | cut -d'/' -f 3)
export TAG="$BRANCH-s$JB_SPACE_EXECUTION_NUMBER"

if [ "$BRANCH" = "master" ]; then 
    echo "master" 
	export REMOTE_HOST=$SSH_HOST
else
    echo "not master"  
	export REMOTE_HOST=$SSH_HOST_DEV
fi;

echo "adding host to known host"
mkdir -p ~/.ssh
touch ~/.ssh/known_hosts 
ssh-keyscan $REMOTE_HOST >> ~/.ssh/known_hosts 
echo "run command on remote server"
echo ${TAG_NAME}

sshpass -p $SSH_PASS ssh ${SSH_USER}@${REMOTE_HOST}  << EOF
	cd $DEPLOY_FOLDER && \
    sed -i "s/${TAG_NAME}=.*/${TAG_NAME}=${TAG}/" .env && \
    docker-compose up -d && \
    docker image  prune -af
EOF
