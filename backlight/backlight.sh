#!/bin/bash

USAGE="$0 Adjust the keyboard backlight level\n\n\
  backlight -e [-l <level>] | -d | -i | -r | -g\n\
\t   [-e|--enable Turn on the backlight, default level is 2\n\
\t   [-d|--disable Turn off the backlight\n\
\t   [-i|--increase Increase backlight level\n\
\t   [-r|--reduce Reduce backlight level\n\
\t   [-g|--get Get current backlight level\n\
\t   [-l|--level Brightness between 0-3, with 3 being the brightest\n\
"

usage() { echo -e $USAGE; exit 0; }

brightness_file="/sys/class/leds/asus::kbd_backlight/brightness"
brightness_max_file="/sys/class/leds/asus::kbd_backlight/max_brightness"
KBD_BACKLIGHT_MAX=`cat $brightness_max_file`
KDB_BACKLIGHT_CUR=`cat $brightness_file`

function enable_backlight() {
    level=2
    if [ "x$LEVEL" != "x" ]; then
        level=$LEVEL
    fi
    echo $level | tee $brightness_file
}

function disable_backlight() {
    echo 0 | tee $brightness_file
}

function increase_backlight() {
    if [ ${KDB_BACKLIGHT_CUR} -lt ${KBD_BACKLIGHT_MAX} ];then
        KDB_BACKLIGHT_CUR=$((KDB_BACKLIGHT_CUR+1))
        echo $KDB_BACKLIGHT_CUR | tee $brightness_file
    else
        echo "Reach max level"
    fi
}

function reduce_backlight() {
    if [ $KDB_BACKLIGHT_CUR -eq 0 ]; then
        echo "Blacklight was disabled"
    else
        KDB_BACKLIGHT_CUR=$((KDB_BACKLIGHT_CUR-1))
        echo $KDB_BACKLIGHT_CUR | tee $brightness_file
    fi
}

function get_cur_backlight_level() {
    echo `cat $brightness_file`
}

[ $# -eq 0 ] && usage

TEMP=`getopt -o l:iredgh --long enable,disable,increase,reduce,level:,help \
        -- "$@"`

eval set -- $TEMP

while true; do
        case "$1" in
                -d|--disable) action="DISABLE"; shift; break;;
                -e|--enable) action="ENABLE"; shift 1;;
                -l|--level) LEVEL=$2; shift 2;;
                -i|--increase) increase_backlight; exit 0;;
                -r|--reduce) reduce_backlight; exit 0;;
                -g|--get) get_cur_backlight_level; exit 0;;
                -h|--help) echo -e $USAGE; exit 0;;
                --) shift; break;;
                *) echo "Wrong option!"; exit 1;;
        esac
done

if [ "$action" == "ENABLE" ]; then
    enable_backlight
    exit 0
elif [ "$action" == "DISABLE" ]; then
    disable_backlight
    exit 0
fi
