#!/bin/bash
# getopts: The bash builtin

USAGE="Usage: $0\n\
\t   [-c|--config config_file\n\
\t   [-f|--fragment yml_file\n\
\t   [-o|--output output_folder\n\
\t   [-h|--help\n\
\nTest options\n
"
usage() { echo -e $USAGE; exit 0; }

[ $# -eq 0 ] && usage

while getopts ":c:f:o:th" OPTION; do
    case "${OPTION}" in
    c)
        CONFIGFILE=$OPTARG
        ;;
    f)
        SYSTEMYML=$OPTARG
        ;;
    o)
        OUTPUT=$OPTARG
        ;;
    h)
        usage
        ;;
    t)
        TRACE_ENABLE="on"
        ;;
    *)
        echo "Incorrect option"
        usage
        ;;
    esac
done

echo "config file: $CONFIGFILE"
echo "fragment file: $SYSTEMYML"
echo "output: $OUTPUT"
