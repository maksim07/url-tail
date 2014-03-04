#!/bin/bash

if [ $# -lt 1 ]; then
	echo "Url has to be specified"
	exit 1
fi

url=$1


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
	echo "Ranges are nor supported by the server"
	exit 1
fi

len=`get_length $url`
off=$len


until [ "$off" -gt "$len" ]; do
	len=`get_length $url`

	print_tail $url $off $len
	off=$len
done