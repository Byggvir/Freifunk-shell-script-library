#!/bin/sh

die() {
	echo $1
	exit 1
}

help_msg() {
	echo "Usage: ./fritzflash.sh <IP-ADDRESS> <IMAGE>"
	exit 1
}

if [ $# -lt 2 ]
then
	help_msg
fi

FRITZBOX=$1
FILE=$2
USER='adam2'
PASSWD='adam2'

echo "Flashing image $FILE to FritzBox at $FRITZBOX"

ping -q -4 -w 1 -c 1 "$FRITZBOX" &> /dev/null  || die "FritzBox at $FRITZBOX is not reachable. aborting"

cat << EOS

This script will flash a given image to mtd1 of a FritzBox device.

This process will take some time!

About 2 Minutes for a 1750E.
About 2 Minutes for a 4020.
About 5 minutes for a 4040.

If you want a status bar: Attach a serial to the device and look there.

In case this process has not terminated after 10 minutes:
 - Terminate this process first!
 - Powercycle FritzBox
 - Retry

(Note: Make sure that you connected the router on the yellow LAN ports and not the blue WAN).

EOS

ftp -n -4 "$FRITZBOX" << END_SCRIPT
quote USER $USER
quote PASS $PASSWD
quote MEDIA FLSH
binary
passive
put $FILE mtd1
bye
END_SCRIPT

exit 0

Navigationsmenü

    Benutzerkonto erstellen
    Anmelden

    Seite
    Diskussion

    Lesen
    Quelltext anzeigen
    Versionsgeschichte

Suche
