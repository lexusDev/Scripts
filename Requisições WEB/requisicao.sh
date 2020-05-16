#!bin/bash

touch templinks

links="$(curl -s "https://pastebin.com/archive" | grep "i_p0" | cut -d"=" -f5 | cut -d'"' -f2 | tr -d "/")"

for l in $links; do
    r="$(grep "$l" templinks)"
    if [ "$r" == "" ]; then echo $l >> templinks; fi
done

cat templinks  | while read a; do
    echo "$r" >> templinks2
    r2="$(curl -s "https://pastebin.com/raw/$a" | grep "public")"; 
    if [ "$r2" != "" ]; then 
        echo "https://pastebin.com/raw/$a"; fi; 
done