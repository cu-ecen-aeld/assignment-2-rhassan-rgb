#!/bin/bash

set -e
set -u

#check if the input parameters are 2
if [ ! $# -eq 2 ]
then
    echo "Too few arguemnts, usage finder filesdir searchstr"
    exit 1
fi

# needed vriables
filesdir=$1
searchstr=$2
filecount=0
linescount=0

# making sure first argument is a directory 
if [ ! -d $filesdir ]
then 
    echo "$filesdir is not a directory"
    exit 1
fi

#searching for the matches 
grepexec=$(grep -Roc $searchstr $filesdir)

# TODO Remove (Testing)
# echo "$grepexec"

# TODO Remove (Tracing)
# echo "reading"

#grep output regex pattern
pattern=".*:([0-9]+)"
# read line by line from the grep result
while read -r line; do
    
    # TODO Remove (Tracing)
    # echo "$line"
    if [[ $line =~ $pattern ]]; then
        capturedgroup="${BASH_REMATCH[1]}"
        # TODO Remove (Tracing)
        # echo "$capturedgroup"
        if [ "$capturedgroup" != "0" ]; then
            filecount=$((filecount + 1))
            linescount=$((linescount + capturedgroup))
        fi
    fi      
done <<< "$grepexec"

echo "The number of files are $filecount and the number of matching lines are $linescount"

exit 0
