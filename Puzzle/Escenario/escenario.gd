extends Node2D

# crea un diccionario para cada ficha_No. disponible 
var fichas = []
# crea un diccionario para las cordenadas iniciales de cada ficha
var posicion_inicial = []
# crea un diccionario para la posiciona atual de cada ficha ####
var posicion_actual = []
# crea un diccionario para la cordenada aleatoria  asignada a cada ficcha, para que esta no se repita
var posicion_ocupada = []

var contador = 0

@onready var Cronometro_Visual = $Cronometro/Tiempo_Pantalla
@onready var Cronometro = $Cronometro/Cronometro

func _ready():
	
	# permite acceder a todos la instancias (nodos) con el nombre Ficha_No. asignando un rango de 1 a 24
	# y remplazando el No. por el numero correspondiente
	for i in range(1,25):
		var ficha = get_node("Fichas/Ficha_"+str(i))
		fichas.append(ficha)
		
	# guarda la posicion inicial de cada ficha
	for ficha in fichas:
		posicion_inicial.append(ficha.position)
		
		
func _process(_delta):
	
	# asigna al cronomitro visual formato de hh:mm:ss
	var horas = contador / 3600
	var minutos = (contador % 3600) / 60
	var segundos = contador % 60
	
	Cronometro_Visual.text = formato_tiempo(horas) + ":" + formato_tiempo(minutos) + ":" + formato_tiempo(segundos)
	
	#crea un diccionario de las acciones precionadas para reescribir el diccionario actual
	var Entradas_presionadas = [
		"ui_down",
		"ui_up",
		"ui_right",
		"ui_left"
	]
	
	if Entradas_presionadas.any(Input.is_action_just_pressed):
		posicion_actual.clear()
		for ficha in fichas:
			posicion_actual.append(ficha.position)
			
	if posicion_inicial == posicion_actual:
		Cronometro.stop()
		
		
# crea cordenadas aleatorias dentro del vector 2 Estas cordenadas estan limitadas a un espacio de  180x180 
# (el tamaño de la imagen) además cada cordenada debe ser multiplo de 36, dado que la ficha  tiene esta dimensión, 
# tambiéén inicia en las cordenadas 88, -18 que es donde se ubica la imagen dentro de la escena, esta es uan función 
# tipo vector2, tiee que retornar valores Vector(x,y)######### 
func posicion_aleatoria() -> Vector2i:
	
	var posicion_nueva = Vector2i()
	var posicion_llena = true
	while posicion_llena:
		posicion_nueva.x = ((randi() % ((250 - 70 + 1) / 36) * 36) + 88)
		posicion_nueva.y = ((randi() % ((180 - 0 + 1) / 36) +1 ) * 36)-18
		
		posicion_llena = verificar_posicion(posicion_nueva)
		
	return posicion_nueva
	
# verifica si existe las cordenadas dentro del diciconario de cordenadas ocupadas, para asignar un valor vacio 
# y que no haya superposicion de fichas, es un funcion booleana rerequiere retornar valores true o false
func verificar_posicion(posicion:Vector2i) -> bool:
	for pos in posicion_ocupada:
		if pos == posicion:
			return true
			
	return false
		
		
#### Verifica si la posicion de las fichas permite Solucionar el rompecabesas
func puede_resolverse() -> bool:
	
	var inversiones = 0
	
	#### calcula el nuero de inversion de las fichas
	for i in range(fichas.size()-1):
		for j in range (i + 1, fichas.size()):
			var ficha_i = fichas [i]
			var ficha_j = fichas [j]
			
	#### ignora la posicon vacia
			if ficha_i != null and ficha_j != null:
				if ficha_i.get_index() > ficha_j.get_index():
					inversiones += 1
				
	##### verifica si el numero de inversiones es par
	return inversiones % 2 == 0
	
	
# Limpiar diccionario y asignar nuevas posiicones a las fichas
func _on_mezclador_pressed():
	
	var resoluble = false
	# repite el proceso hasta que obtener una disposicion que pueda ser resuelta
	while not resoluble:
		
		# Limpia el diciconario de posicion_ocupada
		posicion_ocupada.clear()
	
	# asigna a cada ficha una posicion aleatoria
		for ficha in fichas:
			var posicion_nueva = posicion_aleatoria()
			ficha.global_position = posicion_nueva
			posicion_ocupada.append(posicion_nueva)
			
		resoluble = puede_resolverse()
		
	$Mezclador.release_focus()
	
	Cronometro.start()
	contador = 0
	
	
#asigna valor al str y agrega dos zeros a la impresion del cronometro
func formato_tiempo(value):
	var str_value = str(value)
	return str_value.pad_zeros(2)

func _on_cronometro_timeout():
	contador += 1
