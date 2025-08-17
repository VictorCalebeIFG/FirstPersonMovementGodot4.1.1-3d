extends CharacterBody3D

const SPEED = 5.0
const JUMP_VELOCITY = 4.5

var rotation_y
var rotation_x

@export var mouse_sensitivity := -0.05

@onready var head: Node3D = $Head

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var input_dir := Input.get_vector("a", "d", "w", "s")
	var direction = ((head.transform.basis.x * input_dir.x) + (head.transform.basis.z * input_dir.y))
	
	var n_direcrtion := Vector2(direction.x,direction.z).normalized()
	
	if direction:#direction:
		velocity.x = n_direcrtion.x * SPEED
		velocity.z = n_direcrtion.y * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	move_and_slide()

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		head.rotation_degrees.x += event.relative.y * mouse_sensitivity
		head.rotation_degrees.y += event.relative.x * mouse_sensitivity
		
		#print(head.rotation_degrees)
		#head.rotate_y(deg_to_rad(event.relative.x * mouse_sensitivity))
