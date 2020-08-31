#!/bin/bash

prepend_zero () {
        seq -f "%02g" $1 $1
}

stat=$(cmus-remote -C status | grep status | sed  's/.*status\s//')
if [[ $stat == "playing" ]]; then
    stat=">>"
else
    stat="||"
fi
song=$(cmus-remote -C status | grep file | sed  's/.*\///')
position=$(cmus-remote -C status | grep position | cut -c 10-)
minutes1=$(prepend_zero $(($position / 60)))
seconds1=$(prepend_zero $(($position % 60)))
duration=$(cmus-remote -C status | grep duration | cut -c 10-)
minutes2=$(prepend_zero $(($duration / 60)))
seconds2=$(prepend_zero $(($duration % 60)))
echo -n "$stat $song [$minutes1:$seconds1/$minutes2:$seconds2]"
