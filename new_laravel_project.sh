#!/bin/bash

PARAMS=""
while (( "$#" )); do
  case "$1" in
    -n|--name)
      NAME=$2
      shift 2
      ;;
    -r|--repo-url)
      PUSHURL=$2
      shift 2
      ;;      
    -u|--vagrant-up)
      VAGRANTUP=1
      shift
      ;;      
    -e|--edit-homestead)
      EDIT_HOMESTEAD=1
      shift
      ;;      
    -i|--interactive)
      INTERACTIVE=1
      shift
      ;;         
    -y|--no-prompts)
      NOPROMPTS=1
      shift
      ;;          
    --) # end argument parsing
      shift
      break
      ;;
    -*|--*=) # unsupported flags
      echo "Error: Unsupported flag $1" >&2
      exit 1
      ;;
    *) # preserve positional arguments
      PARAMS="$PARAMS $1"
      shift
      ;;
  esac
done
# set positional arguments in their proper place
eval set -- "$PARAMS"

if [ -z "$NAME" ]; then
    INTERACTIVE=1
    read -p "Enter the Project Name: " NAME
    if [ -z $NAME ]; then
        echo "ERROR: You must enter a project name! Will not exit."
        exit 1
    fi    
fi 

if [ -n "$INTERACTIVE" ]; then
    if [ -z "$PUSHURL" ]; then    
        read -p "Enter the url of the remote git repo to push to (leave blank if you do not wish to use one): " PUSHURL
        if [ -z "$PUSHURL" ]; then
            echo "No PUSHURL was set, if you continue changes will not be pushed to your git repo."
            while true; do
                read -p "Are you sure you wish to continue? [y/N] " yn
                case $yn in
                    [Yy]* ) break;;
                    [Nn]* ) echo "Quitting. Please start over"; exit 1;;
                    * ) echo "Please answer yes or no.";;
                esac
            done  
        fi
    fi
fi

if [ -n "$INTERACTIVE" ]; then
    if [ -z "$EDIT_HOMESTEAD" ]; then
        while true; do
            read -p "Do you wish to edit the homestead config? [y/N] " yn
            case $yn in
                [Yy]* ) EDIT_HOMESTEAD=1; break;;
                [Nn]* ) break;;
                * ) echo "Please answer yes or no.";;
            esac
        done  
    fi
fi

if [ -n "$INTERACTIVE" ]; then
    if [ -z "$VAGRANTUP" ]; then
        while true; do
            read -p "Do you wish to bring up vagrant after creating this project? [y/N] " yn
            case $yn in
                [Yy]* ) VAGRANTUP=1; break;;
                [Nn]* ) break;;
                * ) echo "Please answer yes or no.";;
            esac
        done  
    fi
fi

if [ -z "$NOPROMPTS" ]; then
    echo "Ok, we will create new project (in the current folder) with these details, but please confirm them first:"
    echo "Project Name: " $NAME
    if [ -z "$PUSHURL" ]; then
        echo "No remote git url chosen."
    else    
        echo "Remote Git Url: " $PUSHURL
    fi
    if [ -n "$EDIT_HOMESTEAD" ]; then
        echo "You will be prompted to edit the Homestead.yaml configuration."
    fi
    if [ -z "$VAGRANTUP" ]; then
        echo "Vagrant will NOT be brought up."
    else    
        echo "Vagrant will be brought up."
    fi    
    while true; do
        read -p "Do you wish to continue using these details? [y/N] " yn
        case $yn in
            [Yy]* ) break;;
            [Nn]* ) echo "Quitting. Please start over"; exit 1;;
            * ) echo "Please answer yes or no.";;
        esac
    done  
fi

CNAME="$(tr '[:lower:]' '[:upper:]' <<< ${NAME:0:1})${NAME:1}"

if [ -d "$CNAME" ]; then
    echo "ERROR: Directory '$CNAME' already exists! Exiting."
    exit 1
fi

mkdir $CNAME
cd $CNAME

echo "Setting up new Laravel project..."
export VAGRANT_PREFER_SYSTEM_BINS=true
composer create-project --prefer-dist laravel/laravel $NAME

echo "Setting up Homestead..."
cd $NAME
composer require laravel/homestead --dev
php vendor/bin/homestead make

echo "/.vagrant" >> .gitignore
echo "/.idea" >> .gitignore
echo "/Vagrantfile" >> .gitignore

echo "Creating Git repo and making first commit..."
git init
git add .
git commit -m "first commit"

if [ -z "$PUSHURL" ]; then
    echo "No PURHURL was set, skipping push..."
    echo "Don't forget to add your remote origin later!"
else 
    echo "Pushing to remote git repository..."
    git remote add origin $PUSHURL
    git push -u origin master
fi

if [ -n "$EDIT_HOMESTEAD" ]; then
    "${EDITOR:-vi}" Homestead.yaml
fi

if [ -n "$VAGRANTUP" ]; then
    echo "Bringing up vagrant.."
    vagrant up
fi    

echo "Finished."
exit 0

