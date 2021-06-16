#!/bin/bash
case $# in
	0) 	dialog --title "Información" --msgbox "Se necesita como parametro la carpeta a respaldar y la carpeta de respaldos" 0 0
		exit 1;;
esac
    aux=`tr '[;%"#$&//)*:]'  '_' <<< $1`
	archivo="resp$aux$( date +'%d_%m_%y_%H_%M' )"
	carpeta=$1
	tar -czvf "${archivo}.tar.gz" $carpeta 
	mv "${archivo}.tar.gz" $2
	echo "Respaldo terminado"
