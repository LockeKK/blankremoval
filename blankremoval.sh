#!/bin/bash

#Config
filetype=("*.c" "*.h")

#$1: filetype, $2: path
function proceed {
local fileset="$(find $2 -name $1)"
local arr=($fileset)
local bak="bak"

for filename in ${arr[@]}
do
    sed 's/[[:space:]]*$//' $filename > $filename$bak$bak
    sed -r 's/^\s+$//' $filename$bak$bak | cat -s > $filename$bak
    rm -rf $filename$bak$bak
done
}

function rename {
local fileset="$(find $1 -name *bak)"
local arr=($fileset)

for filename in ${arr[@]}
do
    mv $filename ${filename%*bak}
done
}

if [ $# -ne 1 ]
then
    echo "Usage: `basename $0` <path>" 
else
if [ ! -d $1 ]; then  
    echo "$1 is an invalid path."
    exit
fi
for file in ${filetype[@]}
do
    proceed $file $1
    rename $1
done
fi
