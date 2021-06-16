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

			./proyecto/programacionTareas/example.sh
			;;
		2) 
			clear
			login=$(dialog --stdout --title "Login" --inputbox "Ingresa el login del usuario" 0 0)
			password=$( dialog --stdout --title "Contraseña" --passwordbox "Pon tu contraseña:" 0 0)
			if [ ${#login} = 0 ] || [ ${#password} = 0 ]
			then
				 dialog --title "Información" --msgbox "No se realizó la operacion con exito, uno o más campos se dejaron vacios" 0 0
			else
				egrep "^$login" /etc/passwd >/dev/null
					if [ $? -eq 0 ]; then
						dialog --title "Información" --msgbox "El usuario ya existe!" 0 0
					else
						useradd -m $login
						echo "$login:$password" | chpasswd
						dialog --title "Información" --msgbox "Alta realizada con exito" 0 0	
					fi
			fi
			;;
		3)
			clear
            		ruta=$(dialog --stdout --title "ruta" --inputbox "ruta del archivo de donde se tomarán las contraseñas" 0 0)
			if [ ${#ruta} = 0  ]; then
				dialog --title "Información" --msgbox "No se realizó la operacion con exito, ruta vacia" 0 0
			else
				if [ -f "$ruta" ]
				then
					cambioPassword
					dialog --title "Información" --msgbox "cambio de contraseñas realizado con exito" 0 0
				else
					dialog --title "Error" --msgbox "No se realizó la operacion con exito, archivo inexistente" 0 0
				fi
			fi
			;;
        4)
            clear
			login=$(dialog --stdout --title "Login" --inputbox "Ingresa el login del usuario" 0 0)
			password=$( dialog --stdout --title "Nueva contraseña" --passwordbox "Ingrese la nueva contraseña:" 0 0)
			if [ ${#login} = 0 ] || [ ${#password} = 0 ]
			then
				 dialog --title "Información" --msgbox "No se realizó la operacion con exito, uno o más campos se dejaron vacios" 0 0
			else
				egrep "^$login" /etc/passwd >/dev/null
					if [ $? -eq 0 ]; then
					        echo "$login:$password" | chpasswd
						dialog --title "Información" --msgbox "Cambio realizado con exito" 0 0	
					else
                			        dialog --title "Información" --msgbox "El usuario ingresado no existe!" 0 0
					fi
			fi
			;;

		5)  ;;			
		esac
 
done

