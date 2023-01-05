#!/bin/bash

if [ $# -lt 1 ]; then
	echo "Syntax: url-tail.sh <URL> [<starting tail offset in bytes>]"
	exit 1
fi

url=$1

tail_off=0
if [ $# -eq 2 ]; then
	case $2 in
    	''|*[!0-9]*)
			echo "Tail offset must be a positive number"
			exit 1
			;;
	    *)
			tail_off=$2
			;;
	esac
fi

function check_ranges_support() {
	url=$1
	ret=`curl -s -I -X HEAD $url | grep "Accept-Ranges: bytes"`

	if [ -z "$ret" ]; then
		echo
	else
		return 1
	fi
}

function get_length() {

	url=$1
	ret=`curl -s -I -X HEAD $url | awk '/Content-Length:/ {print $2}'`
	echo $ret | sed 's/[^0-9]*//g'
}

function print_tail() {

	url=$1
	off=$2
	len=$3

	curl --header "Range: bytes=$off-$len" -s $url
}


check_ranges_support $url
ranges_support=$?

if [ $ranges_support -eq 0 ]; then
	echo "Ranges are not supported by the server"
	exit 1
fi

len=`get_length $url`
off=$((len - tail_off))


until [ "$off" -gt "$len" ]; do
	len=`get_length $url`

	if [ "$off" -eq "$len" ]; then
		sleep 3
	else
		print_tail $url $off $len
	fi

	off=$len
done
