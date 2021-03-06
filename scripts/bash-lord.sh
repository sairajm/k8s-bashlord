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
            echo "Setting the project to " ${option4} "..."
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

function k8_ops() {
    current_project=`gcloud config get-value project`
    echo "Your current GCP is" ${current_project}
    echo "Fetching all containers in this project... "
    gcloud container clusters list

    option2=${2}
    check_empty $2 ${option2}

    if [ "${option2}" = "get" ];
    then
        option3=${3?Error: Can be pods or secrets or contexts}
        check_empty $3 ${option3}

        if [ "${option3}" = "pods" ];
        then
            kubectl get pods
        elif [ "${option3}" = "secrets" ];
        then
            kubectl get secrets
        elif [ "${option3}" = "contexts" ];
        then
            kubectl config get-contexts
        else
            echo "Error: Unsupported input" ${option3}
            exit
        fi
    elif [ "${option2}" = "current" ];
    then
        kubectl config current-context
    elif [ "${option2}" = "set" ];
    then
        option3=${3?Error: Needs to be keyword contexts or name of the context you would like to switch to}
        check_empty $3 ${option3}

        if [ "${option3}" != "contexts" ];
        then
         kubectl config use-context ${option3}
        else
            option4=${4?Error: Needs to be namespace to switch to within this context}
            check_empty $4 ${option4}

            current_context=`kubectl config current-context`

            echo "Your current context is" ${current_context}

            kubectl config set-context --current --namespace=${option4}
        fi
    else
        option2=${2?Error: Needs to be a cluster name to initialize credentials}
        check_empty $2 ${option2}

        option3=${3?Error: Needs to be a valid zone. See https://cloud.google.com/compute/docs/regions-zones#available}
        check_empty $3 ${option3}

        gcloud container clusters get-credentials ${option2} --zone=${option3}
    fi
}

function help() {
    echo "For GCloud basic get and set:
1. "bash-lord g project get all" will get all projects mapped to your user. Warning: This doesn't have a limit set.
2. "bash-lord g project get sairajmadhavan" will get all projects that contain sairajmadhavan ie. partial matches are supported.
3. "bash-lord g project set sairajmadhavan" will set the project to sairajmadhavan if it exists. Do a get before set and provide accurate value.


For K8s execute in the following order:
1. "bash-lord k" to list all clusters in your current Gcloud project
2. "bash-lord k cluster-name zone" to fetch cluster endpoint and auth data for that cluster and zone.
3. "bash-lord k current" displays current context
4. "bash-lord k set contexts namespace" sets context to --current and --namespace to the namespace provided.
5. "bash-lord k get pods" displays all pods.
6. "bash-lord k get secrets" displays all secrets.
7. "bash-lord k get contexts" displays all available contexts.
8. "bash-lord k set context-name" switches to a context.
"
}

option1=${1?Error: No options provided. For a complete list of options type bash-lord help}

if [ "${option1}" =  "help" ];
then
    help
    exit
elif [ "${option1}" = "g" ];
then
    gcloud_ops $1 $2 $3 $4
elif [ "${option1}" = "k" ];
then
    k8_ops $1 $2 $3 $4
else
    echo "Error: Not a recognized operation. Try g or k. g for gcloud; k for k8s"
fi



