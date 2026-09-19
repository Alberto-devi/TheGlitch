extends Node

# Tu "App Store" - Guarda los instaladores (.exe) que has conseguido
var instaladores_desbloqueados: Array[AppAliadaData] = []

# Tu Equipo Activo - El dock de 5 espacios para combatir
var equipo_instalado: Array[AppAliadaData] = [null, null, null, null, null]

# --- LÓGICA DE ALMACENAMIENTO ---
func agregar_instalador(nueva_app: AppAliadaData):
	if not nueva_app in instaladores_desbloqueados:
		instaladores_desbloqueados.append(nueva_app)
		print("Lipso: Archivo de instalación adquirido -> " + nueva_app.nombre)
	else:
		print("Lipso: El instalador ya existe en el sistema.")

# --- LÓGICA DE INSTALACIÓN (Equipar) ---
func instalar_app(app: AppAliadaData, ranura: int):
	if ranura < 0 or ranura >= 5:
		print("Error: Espacio en disco inválido.")
		return
		
	# Si ya hay una app en esa ranura, la reemplazamos
	equipo_instalado[ranura] = app
	print("Instalación completada: " + app.nombre + " asignada a la ranura " + str(ranura))

func desinstalar_app(ranura: int):
	if ranura >= 0 and ranura < 5 and equipo_instalado[ranura] != null:
		print("Desinstalando " + equipo_instalado[ranura].nombre + "...")
		equipo_instalado[ranura] = null
