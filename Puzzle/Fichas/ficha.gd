extends CharacterBody2D

@onready var Dir_Abajo = $Ficha_Abajo
@onready var Dir_Arriba = $Ficha_Arriba
@onready var Dir_Derecha = $Ficha_Derecha
@onready var Dir_Izquierda = $Ficha_Izquierda

var mov_abajo = false
var mov_arriba = false
var mov_derecha = false
var mov_izquierda = false


# Movimiento de las fichas, limitando la acción a solo un evento

func _input(event):
	
	# variables de la escena instanciada para detectar si hay fichas o tablero alrededor y limitar o restringir
	var Mov_Abajo = Dir_Abajo.ficha
	var Mov_Arriba = Dir_Arriba.ficha
	var Mov_Derecha = Dir_Derecha.ficha
	var Mov_Izquierda = Dir_Izquierda.ficha
	
	
	if event.is_action_pressed("ui_up"):
		mov_abajo = true
	elif  event.is_action_released("ui_up"):
		mov_abajo = false
		
	if event.is_action_pressed("ui_down"):
		mov_arriba = true
	elif  event.is_action_released("ui_down"):
		mov_arriba = false
		
	if event.is_action_pressed("ui_right"):
		mov_derecha = true
	elif event.is_action_released("ui_right"):
		mov_derecha = false
		
	if event.is_action_pressed("ui_left"):
		mov_izquierda = true
	elif event.is_action_released("ui_left"):
		mov_izquierda = false
		
		
	# Asigna el movimiento deacuerdo al tamaño  de la ficha, además excluye los movimientos diferentes 
	# a la tecla presionada para segurarse  que solo se ejecute un movimiento a la vez 
	
	if Mov_Abajo == null:
		if mov_abajo and not mov_arriba and not mov_derecha and not mov_izquierda:
			move_local_y(-36)
			
	if  Mov_Arriba == null:
			if mov_arriba and not mov_abajo and not mov_derecha and not mov_izquierda:
				move_local_y(36)
				
	if  Mov_Derecha == null:
		if mov_derecha and not mov_abajo and not mov_arriba and not mov_izquierda:
				move_local_x(36)
				
	if  Mov_Izquierda == null:
		if mov_izquierda and not mov_abajo and not mov_arriba and not  mov_derecha:
				move_local_x(-36)
				
