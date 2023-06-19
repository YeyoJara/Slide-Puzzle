extends Area2D
 
# detecta si existen cuerpos al en el area

var ficha = null


func detecta_ficha():
	
	return ficha != null
	
	
func _on_body_entered(body):
	ficha = body
	
	
func _on_body_exited(_body):
	ficha = null
