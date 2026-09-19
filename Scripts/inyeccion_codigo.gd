extends Control

signal minijuego_terminado(exito: bool)

var secuencia_actual: Array[String] = []
var indice_tecla: int = 0
var teclas_posibles: Array[String] = ["W", "A", "S", "D", "Q", "E"]

@onready var contenedor_teclas = $VBoxContainer/ContenedorTeclas
@onready var timer = $TiempoLimite
@onready var label_tiempo = $VBoxContainer/LabelTiempo # Conectamos el nuevo Label

func _process(_delta):
	# Si el temporizador está corriendo, actualizamos el texto
	if not timer.is_stopped():
		# Formateamos el tiempo para que solo muestre un decimal (ej: "2.5s")
		label_tiempo.text = "Tiempo restante: " + str("%.1f" % timer.time_left) + "s"

func iniciar_minijuego(datos_glitch: GlitchData):
	indice_tecla = 0
	secuencia_actual.clear()
	
	#Dificultad mas alta, secuencia mas alta
	var longitud_secuencia = 3 + datos_glitch.dificultad_minijuego
	
	for i in range(longitud_secuencia):
		secuencia_actual.append(teclas_posibles.pick_random())
	
	_actualizar_ui()
	
	#Tiempo para completar la secuencia
	timer.start(4.0) 
	show()

func _input(event):
	if not visible:
		return
		
	#Deteccion de teclado fisico
	if event is InputEventKey and event.pressed and not event.echo:
		var tecla_pulsada = OS.get_keycode_string(event.keycode).to_upper()
		
		#Virificacion de tecla pulsada
		if tecla_pulsada == secuencia_actual[indice_tecla]:
			indice_tecla += 1
			_actualizar_ui()
			
			#Completas la secuencia
			if indice_tecla >= secuencia_actual.size():
				_victoria()
		else:
			#Si fallas -> Fase 2
			_derrota("¡Error de sintaxis! El Glitch te ha detectado.")

func _actualizar_ui():
	#Limpiamos las teclas
	for hijo in contenedor_teclas.get_children():
		hijo.queue_free()
		
	#Generamos las teclas
	for i in range(secuencia_actual.size()):
		var label_tecla = Label.new()
		label_tecla.text = "[" + secuencia_actual[i] + "]"
		
		label_tecla.add_theme_font_size_override("font_size", 46)
		
		#Si la tecla se pulsa, la cambiamos a verde
		if i < indice_tecla:
			label_tecla.modulate = Color(0, 1, 0)
		
		contenedor_teclas.add_child(label_tecla)

func _on_tiempo_limite_timeout():
	_derrota("Tiempo agotado. El Glitch te ha detectado.")

func _victoria():
	timer.stop()
	label_tiempo.text = "¡Desconexión!"
	print("Lipso: Código inyectado con éxito. Ventaja táctica obtenida.")
	hide()
	minijuego_terminado.emit(true)

func _derrota(motivo: String):
	timer.stop()
	label_tiempo.text = "¡Desconexión!"
	print("Lipso: " + motivo)
	hide()
	minijuego_terminado.emit(false)
