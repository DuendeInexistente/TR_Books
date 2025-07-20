#!/usr/bin/zsh
mkdir -p Edited

jq -r ".[1].text" $1 | sed 's/\\r/\n/g' | sed 's/\\n/\n/g' | sed 's/\\//g' | sed 's/<BR>//gi' |  >$(echo $1 | sed 's/Unedited/Edited/g').html
