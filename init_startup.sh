#!/bin/sh
# bigmudcake v1.00 - Startup script to install and run C2IdentityLdapSync


echo "* init_startup - setup folders and access permissions"
mkdir -p /install
chown -R root /install
chmod -R 770 /install
# chmod -R 775 /var/log
# chmod -R 775 /runfiles
cd /install

init_cleanup(){
    echo "* init_cleanup - cleanup folders and access permissions"
    # install.sh contains your LDAP root password in clear text
    # so make sure install.sh in not accessable by other users
    chown -R root /install
    chmod -R 700 /install
}


# Setup and run if install.sh exists
if [ -f "/install/install.sh" ]; then
    echo "* init_startup - Found 'install.sh' and preprocessing prior to execution of script"
    # convert Windows end of line to Unix end of line (CR/LF to LF)
    sed 's|\r||g' -i /install/install.sh
    # we are running as root so remove all sudo commands from install.sh
    sed 's|sudo ||g' -i /install/install.sh
    # start ldapsyncd directly within this script, do not use systemctl within install.sh
    sed 's|systemctl|# |g' -i /install/install.sh
    echo "*----- START 1st EXEC install.sh -----"
    ./install.sh
    echo -e "\n*----- FINISH 1st EXEC install.sh -----"
    if [ -f "/etc/init.d/ldapsyncd" ]; then
        echo "* init_startup - Found 'ldapsyncd' and waiting 10s for ldapsyncd init service to start"
        service ldapsyncd start
        sleep 10s
        if [ -e "/opt/Synology/C2IdentityLdapSync/synoc2ia-service.sock" ]; then
            echo "* init_startup - ldapsyncd service started successfully"
            echo "*----- START 2nd EXEC install.sh -----"
            if [ "$LDAP_DEBUG" = "0" ]; then
                echo "* init_startup - To see all ongoing ldapsync messaging in logs set env variable LDAP_DEBUG to 1"
                # pipe output to null to prevent log from filling up with constant status approved messages
                ./install.sh >/dev/null 2>&1 &
            else
                echo "* init_startup - debug is on and all output is logged"
                # debug mode is set so send all command outputs to log
                ./install.sh &
            fi
            echo "*----- FINISH 2nd EXEC install.sh -----"
            init_cleanup
            echo "* init_startup - Finished container startup, check container logs for any issues."
        else
            echo "* init_startup - ERROR !! The service ldapsyncd did not startup successfully."
            echo "* init_startup - Make sure you follow the INSTALL instructions prior to running this docker container again."
            exit 3
        fi
    else
        echo "* init_startup - ERROR !! There was errors running the script 'install.sh'."
        echo "* init_startup - Make sure you follow the INSTALL instructions prior to running this docker container again."
        exit 2
    fi
else
    echo "* init_startup - ERROR !! Could not find 'install.sh'."
    echo "* init_startup - Make sure you follow the INSTALL instructions prior to running this docker container again."
    exit 1
fi
