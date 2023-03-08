#!/bin/bash

error(){
    notify-send "$1"; # comment out this if you dont want to get error notify
    exit 1;
}

if [[ "$#" < 2 || -z "$1" && -z "$2" ]] ;then
    error "not enough arguments.";
fi

MAX_ROWS=10;
MAX_COLS=10;
MAX_WS=$((($MAX_ROWS*$MAX_COLS)+($MAX_ROWS-1)));
DIRECTION=$1
MODE=$2

# number of the current workspace
CURRENT_WS=$(i3-msg -t get_workspaces | jq -r '.[] | select(.focused==true).num');

#check correct num of ws
if [[ "$CURRENT_WS" -gt "$MAX_WS" || "$CURRENT_WS" -lt 10 ]]; then
    error "wrong_ws"
fi

ROW_NUM=$(($CURRENT_WS%10)); #second digit
COL_NUM=$((($CURRENT_WS-$ROW_NUM)/10)); #first digit
ROW_MOD=$(($ROW_NUM%$MAX_ROWS));
COL_MOD=$(($COL_NUM%$MAX_COLS));

if [[ "$DIRECTION" == "up" ]]; then
    ROW_NUM=$(($ROW_NUM-1));
    if [ "$ROW_MOD" == "0" ]; then
        ROW_NUM=$(($ROW_NUM+$MAX_ROWS));
    fi
elif [[ "$DIRECTION" == "down" ]]; then
    ROW_NUM=$(($ROW_NUM+1));
    if [ "$ROW_MOD" == $(($MAX_ROWS-1)) ]; then
        ROW_NUM=$(($ROW_NUM-$MAX_ROWS));
    fi
elif [[ "$DIRECTION" == "left" ]]; then
    COL_NUM=$(($COL_NUM-1));
    if [ "$COL_MOD" == "1" ]; then 
        COL_NUM=$(($COL_NUM+$MAX_COLS));
    fi
elif [[ "$DIRECTION" == "right" ]]; then
    COL_NUM=$(($COL_NUM+1));
    if [ "$COL_MOD" == "0" ]; then
        COL_NUM=$(($COL_NUM-$MAX_COLS));
    fi
else
    error "invalid first argument: $1";
fi

if [[ "$MODE" == "move" ]]; then
    i3-msg move container to workspace "$COL_NUM$ROW_NUM"
elif [[ "$MODE" == "switch" ]]; then
    i3-msg workspace number "$COL_NUM$ROW_NUM"
elif [[ "$MODE" == "move-and-switch" ]]; then
    i3-msg move container to workspace "$COL_NUM$ROW_NUM"
    i3-msg workspace number "$COL_NUM$ROW_NUM"
else
    error "invalid second argument";
fi



