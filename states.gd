extends Node

@onready var plr: CharacterBody3D = $"../.."

var stateWebZip = false

enum States {DEFAULT, WEBZIP}

@export var state : States

@onready var zipTimer = $zipTime

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	$zipTime.timeout.connect(end)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if plr.state == States.DEFAULT:
		plr.move()
	if plr.state == States.WEBZIP:
		state_webZip()



func state_webZip() -> void:
	if zipTimer.time_left > 0:
		plr.velocity = plr.webZipTarget.normalized() * plr.webZipSpeed
	else:
		stateWebZip = false
		plr.velocity = Vector3.ZERO
		plr.state = States.DEFAULT
		

func end():
	print("End")
