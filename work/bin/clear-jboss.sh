#bin/sh!
echo "# -------------------------------------------------------- #"
echo "# Cleaning $JBOSS_HOME/server/default/work                 #"
echo "# -------------------------------------------------------- #"
rm -rf $JBOSS_HOME/server/default/work/*
#
echo "# -------------------------------------------------------- #"
echo "# Cleaning $JBOSS_HOME/server/default/tmp                  #"
echo "# -------------------------------------------------------- #"
rm -rf $JBOSS_HOME/server/default/tmp/*
#
echo "# -------------------------------------------------------- #"
echo "# Cleaning $JBOSS_HOME/server/default/log                  #"
echo "# -------------------------------------------------------- #"
rm -rf $JBOSS_HOME/server/default/log/*