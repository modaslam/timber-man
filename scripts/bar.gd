extends Node2D


onready var scorekeeper = get_node("Scorekeeper")

var percentage = 1     # ranges from 0 to 1

signal lost

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if percentage > 0:
		percentage -= 0.1*delta
		scorekeeper.set_region_rect(Rect2(0, 0 , percentage*188, 23))
		scorekeeper.position = Vector2(-(1-percentage)*188/2, 0)
	else:
		emit_signal("lost")


func add(delta):
	percentage += delta
	if percentage > 1: percentage = 1
