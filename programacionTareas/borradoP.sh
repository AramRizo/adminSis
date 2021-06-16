#!/bin/bash
if [ $# == 0 ]
then
    dialog --title "borrado de temporales abortado" --msgbox "Operación cancelada, se necesita como parametro el numero de días" 0 0
    exit 1
fi
dias=$1
cd /tmp && { find . -type f -mtime +$dias -exec rm -rf -- {} \; ; } >errores.txt
cd /var/tmp && { find . -type f -mtime +$dias -exec rm -rf -- {} \; ; } >errores.txt
#sudo find /tmp -mtime +$dias -exec rm -rf {} +
#sudo find /var/tmp -mtime +$dias -exec rm -rf {} +
#clear
echo "borrado compleatado"

