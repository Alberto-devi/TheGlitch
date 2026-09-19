extends Node

var glitch_actual: GlitchData
var ventaja_infiltracion: bool = false

var ruta_minijuego = preload("res://Scenes/inyeccion_codigo.tscn")
var ruta_combate = preload("res://Scenes/Depuracion.tscn")

func iniciar_encuentro(glitch: GlitchData):
	glitch_actual = glitch
	
	#Iniciamos minujuego
	var minijuego = ruta_minijuego.instantiate()
	get_tree().root.add_child(minijuego)
	
	#Cuando termina el minujuego
	minijuego.minijuego_terminado.connect(_on_minijuego_terminado)
	
	#Datos del Glitch
	minijuego.iniciar_minijuego(glitch_actual)

func _on_minijuego_terminado(exito: bool):
	ventaja_infiltracion = exito
	
	if exito:
		print("GameManager: ¡Infiltración exitosa! Entrando a Fase 2 con ventaja.")
	else:
		print("GameManager: ¡Detectado! Entrando a Fase 2 en desventaja.")
		
	#Cambiamos a la Fase 2
	get_tree().change_scene_to_packed(ruta_combate)
