#!/bin/bash
# getopt: The command line utility

USAGE="Usage: $0\n\
\t   [-c|--config config_file\n\
\t   [-f|--fragment yml_file\n\
\t   [-o|--output output_folder\n\
\t   [-h|--help\n\
\nTest options\n
"

TEMP=`getopt -o c:f:o:ht --long output:,fragment:,config:,help,trace \
	-- "$@"`

eval set -- $TEMP

while true; do
	case "$1" in
		-c|--config) CONFIGFILE=$2; shift 2;;
		-f|--fragment) SYSTEMYML=$2; shift 2;;
		-o|--output) OUTPUT=$2; shift 2;;
		-h|--help) echo -e $USAGE; exit 1;;
		-t|--trace) TRACE_ENABLE="on"; shift 1;;
		--) shift; break;;
		*) echo "internal error!"; exit 1;;
	esac
done

echo "config file: $CONFIGFILE"
echo "fragment file: $SYSTEMYML"
echo "output: $OUTPUT"
