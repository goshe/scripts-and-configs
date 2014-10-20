# script with basic-liferay functions for
# - deplyoment of wars
# - undeployment of wars
# - tomcat restart
#
# following variables must be providet by cosuming script:
# - $LIFERAY_DIR = liferay-base dir
# - $DIST_DIR    = base dir for portlets
# - $TOMCAT_DIR  = tomcat directory

NOW=$(date +"%Y-%m-%d_%H-%M")

DEPLOY_DIR="$LIFERAY_DIR/deploy/"
TOMCAT_WEBAPPDIR="$TOMCAT_DIR/webapps/"

NEW_CATALINA_OUT="$LOGDIR""catalina_""$NOW"".out"

LOGDIR="$TOMCAT_DIR/logs/"
LOGFILE="$LOGDIR""catalina.out"

STOP=./bin/shutdown.sh
#KILL="pkill -9 -f DEVWETEC"
START=./bin/statup.sh
AVAIL_PATTERN='(is|are) available for use'
UNREG_PATTERN='was unregistered'
STARTPATTERN="Server startup in"

waitForInstallMessage(){
    ## WAIT FOR INSTALLATION MESSAGE IN LOGFILE
    echo "waiting for install message: "$1
    waitForMessage "$1" "installed"
}

waitForUndeployMessage(){
    ## WAIT FOR UNDEPLOY MESSAGE IN LOGFILE
    echo "waiting for undeploy message: "$1
    waitForMessage "$1" "undeployed"
}

waitForMessage(){
	i=1
	while [ $i -le 200 ]
	do
	sleep 1
	t=$(tail -n 150 $LOGFILE | grep -E "$1")
	if [ ! -z "$t" ]; then
			echo "$2!"
			echo "going on ... "
			i=200
	fi
	i=`expr $i + 1`
	done
}


stop(){
	cd $TOMCAT_DIR
	$STOP

	i=1
	while [ $i -le 10 ]
	do
	sleep 1
	i=`expr $i + 1`
	done

#	echo "kill remaining process"
#	$KILL

	## MOVE CATALINA.OUT
	rm $LOGFILE
	touch $NEW_CATALINA_OUT
	ln -s $NEW_CATALINA_OUT $LOGFILE
}

restart(){
	stop

	start
}

start(){
	cd $TOMCAT_DIR
	echo "start liferay"
	$START

	echo "waiting for startup message"
	waitForMessage "$STARTPATTERN" "liferay started"
}

moveWarToDeploy(){
	if [ -d $DIST_DIR ] && [ -d $DEPLOY_DIR ] && [ -d $TOMCAT_DIR ]
	then
		ARTIWARNAME=$1.war
		echo "deploy $ARTIWARNAME to $DEPLOY_DIR ... "
		cd $DIST_DIR
	    	mv $ARTIWARNAME $DEPLOY_DIR
		## WAIT FOR INSTALLATION
		LOGMSG="$1 $AVAIL_PATTERN"
		waitForInstallMessage "$LOGMSG"
		echo "deploy $ARTIWARNAME done!"
	else
		echo -e "could not deploy $1.war!"
		echo -e "ensure that following directory's exist and are set:"
		echo -e "dist-dir:\t$DIST_DIR"
		echo -e "deploy-dir:\t$DEPLOY_DIR"
		echo -e "tomcat-home:\t$TOMCAT_DIR"
	fi
}

undeployWebapp(){
	echo "remove " $1 " from webapps... "
	cd $TOMCAT_WEBAPPDIR
	if [ -d $1 ]
	then
 		rm -rf $1
		echo "waiting for undeploy message... "
		LOGMSG="$1 $UNREG_PATTERN"
		waitForUndeployMessage "$LOGMSG"
		echo "undeploy $1 done!"
	else
		echo "$1 not deployed"
	fi
}

cleanupTomcat(){
	echo "cleanup tomcat: deleting temp and work folder"
	cd $TOMCAT_DIR
	rm -fR temp
    	rm -fR work
}

cleanRestart(){
	stop
	cleanupTomcat
	start
}
