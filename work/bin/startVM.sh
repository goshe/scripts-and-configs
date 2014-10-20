#! /bin/sh
# /etc/init.d/StartVM
#

#Edit these variables!
VMUSER=rhengstermann
VMNAME="$1"

case "$2" in
  start)
    echo "Starting VirtualBox VM..."
    sudo -H -b -u $VMUSER VBoxManage startvm "$VMNAME" &
    ;;
  stop)
    echo "Saving state of Virtualbox VM..."
    sudo -H -u  $VMUSER VBoxManage controlvm "$VMNAME" savestate &
    ;;
  shutdown)
    echo "Shutting down Virtualbox VM $1"
    sudo -H -u  $VMUSER VBoxManage controlvm "$VMNAME" poweroff &
    ;;
  *)
    echo "Usage: startVM {vm-name} {start|stop}"
    echo "Available VMs:"
    VBoxManage list vms
    exit 1
    ;;
esac

exit 0
