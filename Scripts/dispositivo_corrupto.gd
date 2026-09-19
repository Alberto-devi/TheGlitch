extends Node3D

@export var glitch_alojado: GlitchData 

var jugador_cerca: bool = false

func _ready():
	$ZonaInteraccion.body_entered.connect(_on_zona_interaccion_body_entered)
	$ZonaInteraccion.body_exited.connect(_on_zona_interaccion_body_exited)

func _process(delta):
	if jugador_cerca and Input.is_action_just_pressed("interactuar"):
		iniciar_depuracion()

func _on_zona_interaccion_body_entered(body):
	if body.is_in_group("Player"):
		jugador_cerca = true
		print("Dispositivo glitcheado detectado. Pulsa INTERACTUAR.")

func _on_zona_interaccion_body_exited(body):
	if body.is_in_group("Player"):
		jugador_cerca = false

func iniciar_depuracion():
	# Evitamos que el jugador interactúe dos veces pulsando rápido
	jugador_cerca = false 
	
	if glitch_alojado != null:
		print("Dispositivo: Llamando a Lipso para iniciar infiltración contra " + glitch_alojado.nombre)
		# Le pasamos la pelota al GameManager
		GameManager.iniciar_encuentro(glitch_alojado)
	else:
		print("Error: Este dispositivo no tiene un GlitchData asignado en el Inspector.")
