# !/bin/bash

echo "Param1 = " "$1"
SO_HOME=$HOME/work/social_office

#if [ "$1" -eq "true" ]; then
  echo Remove temporary files ...
  rm -r $SO_HOME/tomcat-7.0.27/temp/*
  rm -r $SO_HOME/tomcat-7.0.27/work/*
  rm -r $SO_HOME/tomcat-7.0.27/logs/*
#fi

echo Start tomcat ...
$SO_HOME/tomcat-7.0.27/bin/startup.sh

echo done!

