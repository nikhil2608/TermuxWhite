#!/usr/bin/env sh

# Create separate directory for my repositor
decoration() {
	apt-get update -yq --silent
	apt-get install gnupg -yq --silent
	mkdir -p ~/.termux
	for i in colors.properties termux.properties font.ttf; do
		wget -q https://github.com/evildevill/TermuxWhite/raw/master/style/$i -O ~/.termux/$i
	done
	#rm -r $PREFIX/etc/motd
	#echo "toilet -F metal -F border -f future termux white" >> $PREFIX/etc/bash.bashrc
	cp $PREFIX/etc/bash.bashrc $PREFIX/etc/bash.bashrc.bk
	sed -i s:PS1.*:"PS1=\'\\\\[\\\\e\[1\;34m\\\\]WaSim Akram > \\\[\\\e[0;37m\\\\]\'": $PREFIX/etc/bash.bashrc
}

addrepo() {
	# Add repo in separate file
	mkdir -p $PREFIX/etc/apt/sources.list.d && printf "deb https://github.com/evildevill/TermuxWhite/ termuxwhite main" > $PREFIX/etc/apt/sources.list.d/termuxwhite.list

	# Add gpg public key
	wget -q https://github.com/evildevill/TermuxWhite/termuxwhite.key -O termuxwhite.key && apt-key add termuxwhite.key
	
	# just update
	apt-get update -yq --silent
}

echo "[*] Installing TermuXWhite ..."
decoration
addrepo
echo "[*] Finished :)"
# Now trigger broadcast to make changes visible
am broadcast --user 0 -a com.termux.app.reload_style com.termux > /dev/null
echo "[*] Now open new session & enjoy"
