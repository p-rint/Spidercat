extends CharacterBody3D

var direction : Vector3

const SPEED = 16.0
const JUMP_VELOCITY = 4.5

@onready var camPiv = $CamPivot

@onready var model = $Character
var dt : float
var targetRot = 0

@onready var web_target: MeshInstance3D = $"../WebTarget"

#States 

var webZipTarget : Vector3
var webZipSpeed = 50


@onready var StateManager : Node = $scripts/StateManager
@onready var InputManager: Node = $scripts/Input

#var States = StateManager.States

@onready var state = StateManager.state




func flatten(vector: Vector3) -> Vector3:
	return Vector3( vector.x, 0, vector.z)

func move() -> void:
	model.rotation.y = lerp_angle(model.rotation.y, targetRot, .5)
	
	if direction:
		velocity.x = lerp(velocity.x, direction.x * SPEED, .15 * 2)
		velocity.z = lerp(velocity.z, direction.z * SPEED, .15 * 2)
		
		model.rotation.y = lerp_angle(model.rotation.y, atan2(-velocity.x, -velocity.z), .2)
	else:
		velocity.x = move_toward(velocity.x, 0, .15 * 3)
		velocity.z = move_toward(velocity.z, 0, .15 * 3)



func _physics_process(delta: float) -> void:
	dt = delta
	
	#gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	move_and_slide()
	
