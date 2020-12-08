extends Node


onready var timberman = get_node("Timberman")
onready var camera = get_node("Camera")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


func _input(event):
	event = camera.make_input_local(event)
	if event is InputEventScreenTouch and event.pressed:
		print(event.position)
		if event.position.x < 360:
			timberman.left()
		else:
			timberman.right()
		timberman.beginHit()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
