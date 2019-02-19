#!/bin/sh

set -u
umask 0022

# path to the temporary directory
path_tmproot="$HOME/tmp$$"

# url of the installer script
url_installer='raw.githubusercontent.com/ShellShoccar-jpn/installer/master/shellshoccar.sh'

# remove the temporary directory
remove_tmproot() {
	if [ -d "$path_tmproot" ]; then
		rm -rf "$path_tmproot"
	fi
}
trap 'remove_tmproot' 1 2 3 15

# make a directory to install local applications
if [ ! -d "$HOME/usr" ]; then
	mkdir -p "$HOME/usr"
fi

# main routine
mkdir -p "$path_tmproot"
cd "$path_tmproot" || exit 1
if command -v curl >/dev/null 2>&1; then
	wget -O - "$url_installer" >"$path_tmproot/installer.sh" &&
	sh "$path_tmproot/installer.sh" --prefix="$HOME/usr/shellshoccar" install
elif command -v wget >/dev/null 2>&1; then
	curl -L "$url_installer" >"$path_tmproot/installer.sh" &&
	sh "$path_tmproot/installer.sh" --prefix="$HOME/usr/shellshoccar" install
else
	printf 'ERROR: command curl or wget not found.\n' >&2
	exit 1
fi

# remove the temporary directory
remove_tmproot
