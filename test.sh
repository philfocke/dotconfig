#!/usr/bin/env bash


if test "$(echo $OSTYPE)" == "$(echo gnu-linux)"; then
 echo "A"

else
    echo $(echo $OSTYPE)
fi

