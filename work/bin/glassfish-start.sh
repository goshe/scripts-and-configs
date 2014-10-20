#!/bin/bash
if [ -z "$1" ]; then
    echo ERROR!!! please provide your personal profile name as property!!!
else
    echo ==================================================
    echo Start the domain on $1\'s local glassfish
    echo ==================================================
    mvn -P$1,glassfish-local-start -N exec:exec
    STATUS=$?
    if [ $STATUS -eq 0 ]; then
        echo ==================================================
        echo done.
        echo ==================================================
    else
        echo ==================================================
        echo Domain-Start failed!!!
        echo ==================================================
    fi
fi
