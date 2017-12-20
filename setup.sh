#!/system/bin/sh
sleep 1
clear
echo "   ____             _     ____  _                      _       ___  ____  "
echo "  |  _ \ ___   ___ | |_  |  _ \| |__   ___   ___ _ __ (_)_  __/ _ \/ ___| "
echo "  | |_) / _ \ / _ \| __| | |_) | '_ \ / _ \ / _ \ '_ \| \ \/ / | | \___ \ "
echo "  |  _ < (_) | (_) | |_  |  __/| | | | (_) |  __/ | | | |>  <| |_| |___) |"
echo "  |_| \_\___/ \___/ \__| |_|   |_| |_|\___/ \___|_| |_|_/_/\_\\___/|____/ "
echo
sleep 0.2
echo "  Root PhoenixOS v1.02 by Aditya Pratama"
echo "  deace.inc@gmail.com"
echo "  https://github.com/De4ce/Root-PhoenixOS"

SU=/storage/emulated/0/de4ce
SUBIN=/system/xbin
INT="   [#]"

_x86 () {
sleep 0.2
echo "$INT Installing SuperSU (x86)..."
cd $SUBIN
if [ -f su ]; then rm -f su 2> /dev/null; fi
cp $SU/x86/su.pie su
chmod 4751 su
su --install
su --daemon
}
_x64 () {
sleep 0.2
echo "$INT Installing SuperSU (x64)..."
cd $SUBIN
if [ -f su ]; then rm -f su 2> /dev/null; fi
cp $SU/x64/su .
chmod 4751 su
su --install
su --daemon
}
sleep 1.2
echo
echo "$INT Preparing..."
if [ -d $SU ]; then rm -rf $SU; else mkdir -p $SU; fi
	
echo "$INT Downloading SuperSU, please wait..."
sleep 0.5
wget -qP $SU http://phoenix.de4ce.gq/su.zip 2> /dev/null
if [ ! -f $SU/su.zip ]; then echo "$INT File error..."; exit; fi
MD5SUM="8755c94775431f20bd8de368a2c7a179  $SU/su.zip"
FILE_MD5SUM="$(md5sum $SU/su.zip)"

if [ "$MD5SUM" != "$FILE_MD5SUM" ]; then echo "$INT File Error..."; exit; fi
echo "$INT Extracting zip..."
sleep 0.2
unzip -qd $SU su.zip 2> /dev/null
ARCH=$(uname -m)
if [ $ARCH = x86_64 ]; then _x64; else _x86; fi
pm install $SU/common/Superuser.apk 2> /dev/null
rm -rf $SU
sleep 1
echo "$INT SuperSU successfully installed."
exit
