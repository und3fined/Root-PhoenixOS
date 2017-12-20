#!/system/bin/sh
sleep 01
clear
echo "   ____             _     ____  _                      _       ___  ____  "
echo "  |  _ \ ___   ___ | |_  |  _ \| |__   ___   ___ _ __ (_)_  __/ _ \/ ___| "
echo "  | |_) / _ \ / _ \| __| | |_) | '_ \ / _ \ / _ \ '_ \| \ \/ / | | \___ \ "
echo "  |  _ < (_) | (_) | |_  |  __/| | | | (_) |  __/ | | | |>  <| |_| |___) |"
echo "  |_| \_\___/ \___/ \__| |_|   |_| |_|\___/ \___|_| |_|_/_/\_\\___/|____/ "
echo
sleep 0.2
echo "  Root PhoenixOS v1.01 by Aditya Pratama"
echo "  deace.inc@gmail.com"
echo "  https://github.com/De4ce/Root-PhoenixOS"

SU=/storage/emulated/0/de4ce
SUBIN=/system/xbin

_x86 () {
sleep 0.2
echo "   [#] Installing SuperSU (x86).."
cd $SUBIN
[ -f su ] || rm -f su
cp $SU/x86/su.pie su
chmod 4751 su
su --install
su --daemon
}

_x64 () {
sleep 0.2
echo "   [#] Installing SuperSU (x64)..."
cd $SUBIN
[ -f su ] || rm -f su
cp $SU/x64/su .
chmod 4751 su
su --install
su --daemon
}

sleep 1.2
echo
echo "   [#] Preparing..."
[ -d $SU] || rm -rf $SU
[ !-d $SU ] || mkdir -p $SU

echo "   [#] Downloading SuperSU, please wait..."
sleep 0.5
wget -qP $SU http://phoenix.de4ce.gq/su.zip 2> /dev/null

echo "   [#] Extracting zip..."
sleep 0.2
unzip -qd $SU su.zip 2> /dev/null

MD5SUM="8755c94775431f20bd8de368a2c7a179  $SU/su.zip"
FILE_MD5SUM=$(md5sum $SU/su.zip)


[ $MD5SUM != $DOWNLOAD_MD5SUM ] || echo "   [#] File Error..."; exit

ARCH=$(uname -m)
if [ "$ARCH" = "x86_64" ]; then
	_x64
else
	_x86
fi

pm install $SU/common/Superuser.apk &> /dev/null
rm -rf $SU
sleep 1
echo "   [#] SuperSU successfully installed."
exit
