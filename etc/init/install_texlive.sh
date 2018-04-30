#!/bin/sh

set -u

path_tmproot="$HOME/tmp$$"

url_texlive="mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz"
url_texrepo="http://ftp.jaist.ac.jp/pub/CTAN/systems/texlive/tlnet"

trap '
    if [ -d "$path_tmproot" ]; then
        rm -rf "$path_tmproot"
    fi
' 1 2 3 15

if ! command -v wget > /dev/null 2>&1; then
    printf "ERROR: command \"wget\" not found.\\n" 1>&2
    exit 1
fi

mkdir "$path_tmproot"
cd "$path_tmproot" || exit

if [ ! -d "$HOME/usr/texlive" ]; then
    mkdir -p "$HOME/usr/texlive"
fi

wget -O - "$url_texlive" | tar xzv &&
cd "$(find "$path_tmproot" -maxdepth 1 |
      grep -e "install-tl")" || exit
printf "I\\n" |
TEXLIVE_INSTALL_PREFIX="$HOME/usr/texlive" ./install-tl --repository "$url_texrepo"

cd "$HOME" || exit
if [ -d "$path_tmproot" ]; then
    rm -rf "$path_tmproot"
fi

