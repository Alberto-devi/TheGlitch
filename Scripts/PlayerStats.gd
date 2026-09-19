extends Node

#Señales para actualiza stats
signal antivirus_cambiado(hp_actual, hp_maxima)
signal mipsocoins_cambiadas(cantidad_actual)
signal nivel_cambiado(nivel_actual)

#Estadisticas
var hp_antivirus_maxima: int = 100
var hp_antivirus_actual: int = 100

#Progresion
var mipsocoins: int = 0
var nivel_perfil: int = 1
var nivel_cpu_portatil: int = 1 # Define el "lag" del enemigo y facilidad de minijuegos

func _ready():
	hp_antivirus_actual = hp_antivirus_maxima

#Combate
func recibir_dano(cantidad: int):
	hp_antivirus_actual -= cantidad
	
	# Prevenimos que la vida baje de 0
	if hp_antivirus_actual < 0:
		hp_antivirus_actual = 0
		
	#Actualizar barra de vida
	antivirus_cambiado.emit(hp_antivirus_actual, hp_antivirus_maxima)
	print("Alerta Lipso: Integridad del Antivirus al ", hp_antivirus_actual, "%")
	
	if hp_antivirus_actual == 0:
		_pantallazo_azul()

func curar_antivirus(cantidad: int):
	hp_antivirus_actual += cantidad
	if hp_antivirus_actual > hp_antivirus_maxima:
		hp_antivirus_actual = hp_antivirus_maxima
		
	antivirus_cambiado.emit(hp_antivirus_actual, hp_antivirus_maxima)

#Recompensa despues del combate
func modificar_mipsocoins(cantidad: int):
	mipsocoins += cantidad
	mipsocoins_cambiadas.emit(mipsocoins)

func _pantallazo_azul():
	print("CRITICAL ERROR. Sistema comprometido. Probabilidad de supervivencia del sistema: 0%.")
