extends Node

@onready var plr = $"../.."

var input_dir

@onready var StateManager: Node = $"../StateManager"


@onready var zipTimer = $"../StateManager/zipTime"


func flatten(vector: Vector3) -> Vector3:
	return Vector3( vector.x, 0, vector.z)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:

	if Input.is_action_just_pressed("Teleport"):
		teleport()
		
	if Input.is_action_just_pressed("Swing"):
		swing()
	
	
	input_dir = Input.get_vector("Left", "Right", "Up", "Down")
	plr.direction = flatten(plr.camPiv.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	


func teleport() -> void:
	plr.position = $"../tp".position
	




func swing() -> void:
	#print("s")
	plr.webZipTarget = -(plr.position - $"../../../WebTarget".position)
	
	var dist = plr.webZipTarget.length()
	
	zipTimer.start(dist/plr.webZipSpeed)
	plr.state = StateManager.States.WEBZIP
	
	
	
	
