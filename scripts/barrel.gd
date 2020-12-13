extends Node2D


const LEFT = -1
const RIGHT = 1


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func destroy(direction):
	if(direction == LEFT):
		get_node("AnimationPlayer").play("throw_right")
	else:
		get_node("AnimationPlayer").play("throw_left")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
