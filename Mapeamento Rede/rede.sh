#!bin/bash

for ip in $(sudo nmap -sN -p21,22,80 $(echo "$(ifconfig | grep "inet" | grep "broadcast" | cut -d" " -f10 | cut -d"." -f1-3).0/24") | grep "report for" | cut -d" " -f6 | cut -d"(" -f2 | cut -d")" -f1); do
    sudo nmap -sS -F -O $ip > temp
    portas="$(cat temp | grep "/tcp" | cut -d"/" -f1 | tr "\n" " ")"
    if [ "$portas" == "" ]; then portas="Nenhuma porta detectada"; fi
    os="$(cat temp | grep "OS details" | cut -d":" -f2 | cut -d" " -f2-99 | grep -v "many fingerprints")"
    if [ "$os" == "" ]; then os="Nenhum OS detectado"; fi 

    echo "IP Ativo: $ip | Portas: $portas | Sistema Operacional: $os"
done