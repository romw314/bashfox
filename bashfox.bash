#!/bin/bash -e

[ -z "$_FOX_NOBANNER" ] && echo >&2 "BashFOX by romw314"
export _FOX_NOBANNER=1

declare rootdir
declare RED BGRED GREEN YELLOW BLUE CYAN
declare FDB

[ "$(tput colors)" -ge 8 ] && \
	   RED=$'\x1B[31m' && \
	 BGRED=$'\x1B[41m' && \
	 GREEN=$'\x1B[32m' && \
	YELLOW=$'\x1B[33m' && \
	  BLUE=$'\x1B[34m' && \
	  CYAN=$'\x1B[36m' && \
	 RESET=$'\x1B[0m'

FDB='[ "${DEBUG:-0}" -ne 0 ]'

_cal() {
	local n="$1"
	shift
	__fox__"$n" "$@"
}

__fox__fatal() {
	echo -n "${BGRED}FATAL${RESET}: "
}

__fox__buildfile() {
	(
		echo "### $1"
		echo "### Created with BashFOX"
		echo "${FDB} && echo '${BLUE}[ DEBUG] $1: BashFOX debugger started${RESET}'"
		declare line
		while read cmd extra; do
			case "$cmd" in
				debug  ) echo   "${FDB} && echo   '${BLUE}[ DEBUG] $1: ' $extra '${RESET}'";;
				notice ) echo   "          echo   '${CYAN}[NOTICE]' $extra '${RESET}'";;
				info   ) echo   "          echo   '${CYAN}[ FATAL]' $extra '${RESET}'";;
				warn   ) echo   "          echo '${YELLOW}[ WARN ]' $extra '${RESET}'";;
				error  ) echo   "          echo    '${RED}[  ERR ]' $extra '${RESET}' && exit 1";;
				fatal  ) echo   "          echo    '${RED}[ FATAL]' $extra '${RESET}' && exit 2";;
				include) "$0" _buildfile "$extra";;
				import ) cat "$extra";;
				*) echo "$cmd $extra";;
			esac
		done
		echo "### End $1"
	) < "$1"
}

__fox_build() {
	[ "$#" -ne 1 ] && \
		_cal fatal && echo "expected 1 arguments, got $#" && \
		_cal fatal && echo "usage: bashfox build ." && \
		_cal fatal && echo "ERR_1" && \
		exit 1
	cd "$1"
	_cal buildfile main.bash > "${FOX_OUTPUT}"
	chmod 755 "${FOX_OUTPUT}"
}

[ -f bashfox.conf -a -r bashfox.conf ] && source bashfox.conf

FOX_SOURCE="${SOURCE:-src}"
FOX_OUTPUT="${OUTPUT:-${PWD}/${PWD##*/}}"

if [ "$#" -eq 0 ]; then
	[ -d "${FOX_SOURCE}" ] && ls &>/dev/null "${FOX_SOURCE}" && exec "$0" build "${FOX_SOURCE}" || exec "$0" build .
fi

cmd="$1"
shift
__fox_"$cmd" "$@"
echo >&2 "${GREEN}SUCCESS${RESET}"
