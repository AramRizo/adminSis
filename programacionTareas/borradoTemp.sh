#!/bin/bash
m="*"
h="*"
dd="*"
d="*"
mm="*"
dias=""
comando=""
user=`whoami`
exec 3>&1
dialog --separate-widget $'\n' --ok-label "Programar" \
          --title "Borrado de temporales" \
          --form "Ingrese los datos correspondientes" \
15 80 0 \
        "Minuto (0-59/*):" 1 1 "$m"         1 30 40 0 \
        "Hora (0-24/*):"    2 1 "$h"        2 30 40 0 \
        "Día del mes:"    3 1 "$d"       3 30 40 0 \
        "Mes (1-12/*):"     4 1 "$mm"         4 30 40 10 \
        "Día de la semana (0-6/*):"     5 1 "$dd"         5 30 40 0 \
        "Días sin modificacines:"     7 1 "$dias"         7 30 40 0 \
2>&1 1>&3 | {
  read -r m
  read -r h
  read -r d
  read -r mm
  read -r dd
  read -r dias
 if [ $? != 0 ]; then
	    dialog --title "Información" --msgbox "Programación de borrado de temporales cancelada" 0 0
        clear
  else
        if [ ${#dias} != 0 ] 
        then
            comando=`echo /proyecto/programacionTareas/borradoP.sh $dias`
            clear
            (crontab -u $user -l 2>/dev/null; echo "$m $h $d $mm $dd $comando" ) | crontab -u $user -
            dialog --title "Información" --msgbox "Se programó el borrado de temporales con exito" 0 0
            clear
        else
            dialog --title "Información" --msgbox "Error, numero de días no puede estar vacio; programación cancelada" 10 30
        fi
  fi

    

}
exec 3>&-
