#!/bin/bash
if [ -z "$1" ]; then
    echo ERROR!!! please provide your personal profile name as property!!!
else
    echo ==================================================
    echo Build complete Extranet project
    echo ==================================================
    mvn clean install
    STATUS=$?
    if [ $STATUS -eq 0 ]; then
        echo ==================================================
        echo Deploy Extranet project to $1\'s local glassfish
        echo ==================================================
        mvn -P$1,glassfish-local-deploy -N resources:resources exec:exec
        STATUS=$?
        if [ $STATUS -eq 0 ]; then
            echo ==================================================
            echo done.
            echo ==================================================
        else
            echo ==================================================
            echo Deployment failed!!!
            echo ==================================================
        fi
    else
        echo ==================================================
        echo Build failed, so deployment not possible!!!
        echo ==================================================
    fi
fi
