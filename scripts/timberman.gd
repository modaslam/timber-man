extends Node2D


onready var idle = get_node("Idle")
onready var hit = get_node("Hit")
onready var grave = get_node("Grave")
onready var anim = get_node("Anim")

var side

const LEFT = -1
const RIGHT = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func left():
	position = Vector2(220, 1070)
	idle.flip_h = false
	hit.flip_h = false
	
	grave.position = Vector2(-44, 41)
	grave.flip_h = true
	
	side = LEFT


func right():
	position = Vector2(500, 1070)
	idle.flip_h = true
	hit.flip_h = true
	
	grave.position = Vector2(28, 41)
	grave.flip_h = false
	
	side = RIGHT


func beginHit():
	anim.play("hit")


func die():
	anim.stop()
	idle.hide()
	hit.hide()
	grave.show()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
