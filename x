#!/bin/sh

# Author: ernierasta <ernierasta@zori.cz>
# Title: simple XBPS wrapper
# Description: I personaly like to manage packages by one tool, so thats why i wrote this.
# Everyone likes different insterfaces, this is based on alpine linux apk package manager.


usage() {
	echo \
"Packages:
	x [ACTION] [OPTION] [PKGNAME...]

Services:
	x [ACTION] [SERVICE]

ACTIONS

add|install [-s] <packages>	Install <packages>. Use -s to sync index.
del|remove [-o] <packages>	Remove <packages>. Use -o to remove only given packages.
search [-l] <text>		Search for package. Use -l to search only installed.
update|upgrade			Update all packages.
list				List all installed packeges.
info				Show information about package.
files				Show files in package.

SERVICES

slist 		Show all services, enabled and disabled.
son <service>	Enable and start service.
soff <service>	Disable and stop service.

"
}

add() {
        local OPTS="$@"
        local sync=""
	local pk=""
        
        for a in $OPTS; do
                case "$a" in
		add|install) ;;
                -s | --sync) sync="-S " ;;
                -h | --help) usage;;
                *) pk="$a $pk";;
                esac
        done
	
	pk=$(echo "$pk" | xargs)

	xbps-install $sync$pk
	#echo "xbps-install $sync$pk"
}

del() {
        local OPTS="$@"
        local norec="-R "
	local pk=""
        
        for a in $OPTS; do
                case "$a" in
		del|remove) ;;
                -o | --only) norec="" ;;
                -h | --help) usage;;
                *) pk="$a $pk";;
                esac
        done
	
	pk=$(echo "$pk" | xargs)

	echo "xbps-remove $norec$pk"
	xbps-remove $norec$pk
}


search() {
        local OPTS="$@"
        local remote="-R -s " 
	local pk=""
        
        for a in $OPTS; do
                case "$a" in
		search|find) ;;
                -l | --local) remote="-s " ;;
                -h | --help) usage;;
                *) pk="$a";;
                esac
        done
	
	pk=$(echo "$pk" | xargs)

	xbps-query ${remote}$pk
}

upgrade() {
	xbps-install -Su
}

list() {
	xbps-query -l
}

info() {
	xbps-query -R "$1"
}

files() {
	xbps-query -f "$1"
}

# services

son() {
	local svcname="$1"

	[ -z "$svcname" ] && echo "Please enter service name. For example:\n  x son dbus" && exit 1

	ln -s /etc/sv/$svcname /var/service/ && echo "Service $svcname enabled."
}

soff() {
	local svcname="$1"

	[ -z "$svcname" ] && echo "Please give service name. For example:\n  x soff dbus" && exit 1

	rm /var/service/$svcname && echo "Service $svcname disabled."
}

slist() {
	enabled=$(ls /var/service/)
	availabile=$(ls /etc/sv/)
	local ten=""
	local tdis=""

	for sv in $availabile; do
		if [ -z "${enabled##*$sv*}" ] ;then
			ten="$ten$sv\n" 
			#echo "$sv \ton"
		else
			tdis="$tdis$sv\n"
			#echo "$sv \toff"
		fi
	done

	echo "ENABLED:"
	echo "$ten"
	echo
	echo "DISABLED:"
	echo "$tdis"

}

# main
# this sucks, busybox getopt is lacking -n param, so will not work there
#OPTS=`getopt -l sync -o s -n 'parse-options' "$@"`

main_command="$1"
all_commands="$@"

case "$main_command" in
	add|install) add "$all_commands";;
	search|find) search "$all_commands";;
	upgrade|update) upgrade;;
	show|info) info "$2";;
	files) files "$2";;
	del|remove) del "$all_commands";;
	list) list;;
	son|senable) son "$2";;
	soff|sdisable) soff "$2";;
	slist) slist;;
	*) usage; exit 1;;
esac
