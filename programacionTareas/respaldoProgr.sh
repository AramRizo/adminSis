#!/bin/bash
m="*"
h="*"
dd="*"
d="*"
mm="*"
carpeta=""
carpetaR=""
comando=""
user=`whoami`
exec 3>&1
dialog --separate-widget $'\n' --ok-label "Programar" \
          --title "Respaldo programado" \
          --form "Ingrese los datos correspondientes" \
15 80 0 \
        "Minuto (0-59/*):" 1 1 "$m"         1 30 40 0 \
        "Hora (0-24/*):"    2 1 "$h"        2 30 40 0 \
        "Día del mes:"    3 1 "$d"       3 30 40 0 \
        "Mes (1-12/*):"     4 1 "$mm"         4 30 40 10 \
        "Día de la semana (0-6/*):"     5 1 "$dd"         5 30 40 0 \
        "Carpeta a respaldar:"     6 1 "$carpeta"         6 30 40 0 \
        "Carpeta de respaldos:"     7 1 "$carpetaR"         7 30 40 0 \
2>&1 1>&3 | {
  read -r m
  read -r h
  read -r d
  read -r mm
  read -r dd
  read -r carpeta
  read -r carpetaR
 if [ $? != 0 ]; then
	    dialog --title "Información" --msgbox "Programación de respaldo cancelada" 0 0
        clear
  else
        if [ -d $carpeta ] && [ -d $carpetaR ] && [ ${#carpeta} != 0 ] && [ ${#carpetaR} != 0 ]
        then
            clear
            comando=`echo /proyecto/programacionTareas/respaldo.sh $carpeta $carpetaR`
            (crontab -u $user -l 2>/dev/null; echo "$m $h $d $mm $dd $comando" ) | crontab -u $user -
            dialog --title "Información" --msgbox "Se programó el respaldo con exito" 0 0
            clear
        else
            dialog --title "Información" --msgbox "Error, una de las carpetas no existe" 0 0
        fi
  fi

    

}
exec 3>&-
