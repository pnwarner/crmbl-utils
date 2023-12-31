#!/usr/bin/bash

if [[ ! -z $1 ]]
then
    if [[ "$1" == "--location" ]]
    then
        if [[ -z $2 ]]
        then
            echo "No crmbl project location given. Exiting"
            exit 1
        fi
    else
        echo "Invalid option. Exiting"
        exit 1
    fi
    if [[ -d "$2/crmbl/data/config/site" ]]
    then
        dir_list_string=$(bash ./list-sites.sh --location $2)
        IFS=' ' read -r -a dir_list <<< "$dir_list_string"
    else
        echo "Invalid project path provided. Exiting"
        exit 1
    fi
    for dir in "${dir_list[@]}"
    do
        bash ./backup-site.sh "$dir" --location "$2"
    done
else
    dir_list_string=$(bash ./list-sites.sh)
    IFS=' ' read -r -a dir_list <<< "$dir_list_string"
    for dir in "${dir_list[@]}"
    do
        bash ./backup-site.sh "$dir"
    done
fi