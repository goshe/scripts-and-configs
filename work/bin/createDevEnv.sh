#!/bin/sh

# Variables
WORK="/home/${USER}/work/"
BIN="${WORK}bin/"
ECLIPSE="eclipse-jee-kepler-SR2-linux-gtk-x86_64.tar.gz"
WORKSPACE="workspace.tar.gz"
DEV_BASE="/home/${USER}/work/dev_base/"

echo "work-folder:" $WORK
echo "eclipse package:" $ECLIPSE
echo "dev-base:" $DEV_BASE

if [ $# -eq 0 ]
  then
        echo "No arguments supplied"
        echo "Name of dev-environment must be supplied."
else
	# Variables for new environment
	WS_NAME="${WORK}${1}_ws"
	ECLIPSE_NAME="${WORK}eclipse-${1}/"
	SH_NAME="${BIN}${1}-ws.sh"
	# Creating workspace
	mkdir ${WS_NAME}
	tar -xf "${DEV_BASE}${WORKSPACE}" -C ${WS_NAME}
	# Creating eclipse-installtion
        mkdir ${ECLIPSE_NAME}
	tar -xf "${DEV_BASE}${ECLIPSE}" -C ${ECLIPSE_NAME}
	# Create start-script
	touch ${SH_NAME}
	printf "#!/bin/sh\n${ECLIPSE_NAME}eclipse -data ${WS_NAME} -user ${WS_NAME} &" >> ${SH_NAME}
	chmod +x ${SH_NAME}
fi
