extends Resource
class_name GlitchData

@export var nombre: String = "Glitch Desconocido"
@export_multiline var descripcion: String = "Un error genérico en el sistema."
@export var icono_ui: Texture2D
@export var modelo_3d: PackedScene

@export var vida_maxima: int = 100
@export var ataque: int = 10
@export var velocidad_ataque: float = 2.0
@export var dificultad_minijuego: int = 1

@export var mipsocoins_drop: int = 5
@export var probabilidad_captura: float = 0.5
