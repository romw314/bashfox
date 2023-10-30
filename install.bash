#!/bin/bash -e
trap 'tput cvvis' EXIT
tput civis
if [ -z "$NO_FOX" ]; then
	echo "BashFOX installer"
	echo "BashFOX is created by romw314"
	echo "https://romw314.github.io/bashfox"
	echo
	echo -ne "Installing... [...........]\x1B[12D"
	rm -rf ~/.bashfox
	echo -n '#' # 1/11
	mkdir -p ~/.bashfox
	echo -n '#' # 2/11
	cd ~/.bashfox
	echo -n '#' # 3/11
	curl -sL "https://github.com/romw314/bashfox/archive/refs/heads/master.zip" -o bashfox.zip
	echo -n '#' # 4/11
	unzip -qq bashfox.zip
	echo -n '#' # 5/11
	mkdir bin
	echo -n '#' # 6/11
	cp bashfox-master/bashfox.bash bin/bashfox
	echo -n '#' # 7/11
	chmod 755 bin/bashfox
	echo -n '#' # 8/11
	rm -rf bashfox-master
	echo -n '#' # 9/11
	rm -f bashfox.zip
	echo -n '#' # 10/11
	echo >> ~/.bashrc
	echo >> ~/.bashrc "PATH=\"\$PATH\"':${HOME/"'"/"'\\''"}/.bashfox/bin' # This loads bashfox"
	echo -n '#' # 11/11 (Complete)
	echo -e "\x1B[27DComplete     "
fi || rm -rf ~/.bashfox
