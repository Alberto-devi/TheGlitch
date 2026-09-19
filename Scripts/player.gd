extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5
var sensivility := .5

@onready var cam = $pivote

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


func _physics_process(delta: float) -> void:
	movement(delta)
	move_and_slide()

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		rotate_y(deg_to_rad(-event.relative.x * sensivility))
		cam.rotate_x(deg_to_rad(-event.relative.y * sensivility))
		cam.rotation.x = clamp(cam.rotation.x, deg_to_rad(-40), deg_to_rad(25))


func movement(delta:float) -> void:
		
	if not is_on_floor():
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var input_dir := Input.get_vector("izquierda", "derecha", "delante", "detras")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
