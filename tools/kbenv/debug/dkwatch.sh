#!/bin/bash

function watch()
{
    fn=$1
    if [ ! -e $fn ]
    then
        echo "file $fn not exist"
        exit 1
    fi
    flist=$(<$fn)
    reg='('
    for i in $flist;do
         reg=${reg}${i}'|'
    done
    reg=${reg:0:(-1)}')'
    echo -n ${reg} | xargs inotifywait -m -r  --timefmt '%Y-%m-%d %H:%M'  --format '%T:[%e] %w%f' /etc  /var --exclude
}

while getopts "e:" arg                       
do
        case $arg in
             e)
                watch $OPTARG 
                ;;
        esac
done
