extends Resource
class_name AppAliadaData

@export var nombre: String = "App Desconocida"
@export_multiline var descripcion: String = "Descripción de la herramienta."
@export var icono: Texture2D

@export_enum("Ataque", "Defensa", "Optimizacion", "Ralentizar") var tipo_efecto: String = "Ataque"

@export var potencia_efecto: int = 15
@export var tiempo_recarga: float = 5.0
@export var peso_mb: int = 50
