# !/bin/bash

echo "Param1 = " "$1"
SO_HOME=$HOME/work/social_office

export JAVA_OPTS="$JAVA_OPTS -Dcom.sun.management.jmxremote"

#if [ "$1" -eq "true" ]; then
  echo Remove temporary files ...
  rm -r $SO_HOME/tomcat-7.0.27/temp/*
  rm -r $SO_HOME/tomcat-7.0.27/work/*
  rm -r $SO_HOME/tomcat-7.0.27/logs/*
#fi

echo Start tomcat ...
$SO_HOME/tomcat-7.0.27/bin/catalina.sh jpda start

echo done!

