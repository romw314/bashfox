#!/bin/bash
echo "UNINSTALLING BASHFOX"
randstr="$(base64 /dev/urandom | head -c6)"
echo
echo "--- CHECK ---"
read -p "Enter $randstr to proceed: " check
[ "$check" = "$randstr" ] || ( echo "Abort" && exit )
echo
echo "--- UNINSTALL ---"
rm -vrf ~/.bashfox
grep -v 'This loads bashfox' ~/.bashrc | perl -pe 'chomp if eof' > ~/.bashrc.temp
rm -fv ~/.bashrc
mv -v ~/.bashrc.temp ~/.bashrc
