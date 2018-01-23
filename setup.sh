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
echo "  Aditya Pratama (De4ce)"
echo "  deace.inc@gmail.com"
echo "  https://github.com/De4ce/Root-PhoenixOS"

DOWNLOAD_URL="http://phoenix.de4ce.gq/su.zip"
SU="/storage/emulated/0/de4ce"
SU_PATH="/system/xbin/su"
INT="   [#]"

check_rw () {
[ -w "/system" ] && rw_value="1" || rw_value="0"
if [ "$rw_value" != "1" ]; then echo "$INT Error: Read only file system"; exit; fi
}

sleep 1.2
echo
echo "$INT Preparing..."
if [ -d $SU ]; then rm -rf $SU; mkdir -p $SU 2> /dev/null; else mkdir -p $SU 2> /dev/null; fi

sleep 0.2
check_rw

sleep 0.1
if [ ! -d $SU ]; then echo "$INT Error: Permission denied"; exit; fi
echo "$INT Downloading SuperSU, please wait..."

sleep 0.5
wget -qP $SU $DOWNLOAD_URL 2> /dev/null
if [ ! -f "$SU/su.zip" ]; then echo "$INT Error: File not found"; exit; fi
echo "$INT Extracting zip..."
sleep 0.2
unzip -q "$SU/su.zip" -d $SU 2> /dev/null

if [ ! -d "$SU/common" ]; then echo "$INT Error: Extract failed"; exit; fi
if [ ! -d "$SU/x64" ]; then echo "$INT Error: Extract failed"; exit; fi
if [ ! -d "$SU/x86" ]; then echo "$INT Error: Extract failed"; exit; fi

ARCH=$(uname -m)
sleep 0.2
echo "$INT Installing SuperSU ($ARCH)..."
if [ -f $SU_PATH ]; then rm -f $SU_PATH; fi
if [ $ARCH = x86_64 ]; then cp $SU/x64/su $SU_PATH; else cp $SU/x86/su.pie $SU_PATH; fi
chmod 4751 $SU_PATH
su --install
su --daemon

pm install "$SU/common/Superuser.apk" &> /dev/null
sleep 1
echo "$INT SuperSU successfully installed."
rm -rf $SU
exit
