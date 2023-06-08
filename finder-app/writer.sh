#!/bin/sh

set -e
set -u

#check if the input parameters are 2
if [ ! $# -eq 2 ]
then
    echo "Too few arguemnts, usage writer writefile writestr"
    exit 1
fi

# needed vriables
writefile=$1
searchstr=$2

mkdir -p "$(dirname "$writefile")"

touch "$writefile"

echo "$searchstr" >> "$writefile"