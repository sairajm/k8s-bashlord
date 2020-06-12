option1=${1?Error: No options provided. For a complete list of options type bash-lord help}

if [ -z "${1}" ];
then
    echo ${option1}
    exit
fi

if [ "${option1}" =  "help" ];
then
    cat help.txt
    exit
elif [ "${option1}" = "g" ];
then
    option2=${2?Error: No secondary option provided. Try bash-lord help}
    if [ -z "${2}" ];
    then
        echo ${option2}
        exit
    fi

    if [ "${option2}" = "projects" ];
    then
        option3=${3?Error: Can be get or set}
        if [ -z "${3}" ];
        then
            echo ${option3}
            exit
        fi

        if [ "${option3}" = "get" ];
        then
            option4=${4?Error: Can be all or partial name or complete name}
            if [ -z "${4}" ];
            then
                echo ${option4}
                exit
            fi

            if [ "${option4}" = "all" ];
            then
                gcloud projects list
            else
                gcloud projects list --filter=${option4}
            fi
        fi
    else
        echo "Error: Not a recognized operation. Try projects for gcloud; contexts for k8s"
        exit
    fi
else
    echo "Error: Not a recognized operation. Try g or k. g for gcloud; k for k8s"
fi



