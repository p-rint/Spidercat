extends CharacterBody3D


const SPEED = 16.0
const JUMP_VELOCITY = 14

@onready var camPiv: Node3D = $CameraPivot

@onready var ray : RayCast3D = $RayCast3D

@onready var web_target: MeshInstance3D = $"../WebTarget"


var isSwing = false

var swingTarget : Vector3

func _physics_process(delta: float) -> void:
	if not isSwing:
		aim()
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var input_dir := Input.get_vector("Left", "Right", "Up", "Down")
	var direction := flatten(camPiv.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	
	
	if Input.is_action_just_pressed("Swing"):
		isSwing = true
		swingTarget = web_target.position
	if Input.is_action_just_released("Swing"):
		isSwing = false


	if isSwing:
		swing()

	move_and_slide()

func flatten(vec) -> Vector3:
	return vec * Vector3(1,0,1)



func aim() -> void:
	ray.target_position = -camPiv.basis.z.normalized() * 100
	if ray.is_colliding():
		#print(ray.get_collider())
		web_target.global_position = ray.get_collision_point()
			




func swing() -> void:
	if (swingTarget.distance_to(position) > 10):
		#var newPos = position + velocity
		#newPos = swingTarget + (newPos - swingTarget).normalized() * 10
		position = swingTarget + (position - swingTarget).normalized() * 10
		#velocity = (position - newPos).normalized() * velocity.length()
		print("A")
