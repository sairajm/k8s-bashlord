#!/bin/bash
function check_empty() {
    if [ -z "${1}" ];
    then
        echo ${2}
        exit
    fi
}

function gcloud_ops() {
    option2=${2?Error: No secondary option provided. Try bash-lord help}
    check_empty $2 ${option2}

    if [ "${option2}" = "projects" ];
    then
        option3=${3?Error: Can be get or set}
        check_empty $3 ${option3}

        if [ "${option3}" = "get" ];
        then
            option4=${4?Error: Can be all or partial name or complete name}
            check_empty $4 ${option4}

            if [ "${option4}" = "all" ];
            then
                gcloud projects list
            else
                gcloud projects list --filter=${option4}
            fi
        elif [ "${option3}" = "set" ];
        then
            option4=${4?Error: Should be complete name of the gcloud project. Use get all to get project names first.}
            check_empty $4 ${option4}
            gcloud config set project ${option4}
        else
            echo "Error: Can be get or set"
            exit
        fi
    else
        echo "Error: Not a recognized operation. Try projects for gcloud; contexts for k8s"
        exit
    fi
}

option1=${1?Error: No options provided. For a complete list of options type bash-lord help}

check_empty $1 ${option1}

if [ "${option1}" =  "help" ];
then
    cat help.txt
    exit
elif [ "${option1}" = "g" ];
then
    gcloud_ops $1 $2 $3 $4
else
    echo "Error: Not a recognized operation. Try g or k. g for gcloud; k for k8s"
fi



