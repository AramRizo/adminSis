#!/bin/bash

opc=0

#MENU PRINCIAL
while [ "$opc" -ne "5" ]; do
	
	clear
	opc=$(dialog  --title "PROGRAMACIÓN DE TAREAS" --menu --stdout  "Seleccione una opción del menu" 0 0 0 \
		1 "Programación de tareas manual"\
	       	2 "Respaldo programado" \
		3 "Borrado de temporales programado"\
		4 "Inhabilitación de usuarios"\
		5 "Regresar")
	if [ $? != 0 ]; then
		opc=5
	fi
	
	case "$opc" in 
		1) 

			/proyecto/programacionTareas/progTar.sh
			;;
		2) 
			clear
			/proyecto/programacionTareas/respaldoProgr.sh
			;;
		3)
			clear
            /proyecto/programacionTareas/borradoTemp.sh
			;;
        4)
            /proyecto/programacionTareas/inhabilitar.sh
			;;

		5)  ;;			
		esac
 
done

