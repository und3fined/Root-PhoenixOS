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

DOWNLOAD_URL="http://phoenix.de4ce.gq/su.zip"
SU=/storage/emulated/0/de4ce
SU_PATH=/system/xbin/su
INT="   [#]"

_x86 () {
sleep 0.2
echo "$INT Installing SuperSU (x86)..."
if [ -f $SU_PATH ]; then rm -f $SU_PATH; fi
cp $SU/x86/su.pie $SU_PATH
chmod 4751 $SU_PATH
su --install
su --daemon
}

_x64 () {
sleep 0.2
echo "$INT Installing SuperSU (x64)..."
if [ -f $SU_PATH ]; then rm -f $SU_PATH; fi
cp $SU/x64/su $SU_PATH
chmod 4751 $SU_PATH
su --install
su --daemon
}

sleep 1.2
echo
echo "$INT Preparing..."
if [ -d $SU ]; then rm -rf $SU; else mkdir -p $SU &> /dev/null; fi

sleep 0.1
if [ ! -d $SU ]; then echo "$INT Can't create folder, permission denied..."; exit; fi
echo "$INT Downloading SuperSU, please wait..."

sleep 0.5
wget -qP $SU $DOWNLOAD_URL &> /dev/null
if [ ! -f $SU/su.zip ]; then echo "$INT su.zip not found..."; exit; fi
echo "$INT Extracting zip..."
sleep 0.2
unzip -q $SU/su.zip -d $SU &> /dev/null

if [ ! -d $SU/common ]; then echo "$INT Extract failed..."; exit; fi
if [ ! -d $SU/x64 ]; then echo "$INT Extract failed..."; exit; fi
if [ ! -d $SU/x86 ]; then echo "$INT Extract failed..."; exit; fi


ARCH=$(uname -m)
if [ $ARCH = x86_64 ]; then _x64; else _x86; fi
pm install $SU/common/Superuser.apk &> /dev/null

sleep 1
echo "$INT SuperSU successfully installed."
rm -rf $SU
exit
