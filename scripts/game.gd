extends Node

var barrel = preload("res://scenes/barrel.tscn")
var rightBarrel = preload("res://scenes/rightbarrel.tscn")
var leftBarrel = preload("res://scenes/leftbarrel.tscn")

onready var timberman = get_node("Timberman")
onready var camera = get_node("Camera")
onready var barrels = get_node("Barrels")
onready var destBarrels = get_node("DestBarrels")

const NORMAL_BARREL = 0
const LEFT_BARREL = 1
const RIGHT_BARREL = 2

var enemy

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	generateAllBarrels()


func _input(event):
	event = camera.make_input_local(event)
	if event is InputEventScreenTouch and event.pressed:
		if event.position.x < 360:
			timberman.left()
		else:
			timberman.right()
		timberman.beginHit()


func randomizeBarrel(pos):
	var num = rand_range(0,3)
	if enemy: num = 0
	generateBarrel(int(num), pos)


func generateBarrel(type, pos):
	var newBarrel;
	if type == NORMAL_BARREL:
		newBarrel = barrel.instance()
		enemy = false
	elif type == LEFT_BARREL:
		newBarrel = leftBarrel.instance()
		newBarrel.add_to_group("leftBarrel")
		enemy = true
	elif type == RIGHT_BARREL:
		newBarrel = rightBarrel.instance()
		newBarrel.add_to_group("rightBarrel")
		enemy = true
	
	newBarrel.position = pos
	barrels.add_child(newBarrel)


func generateAllBarrels():
	for i in range(0, 3):
		generateBarrel(0, Vector2(360, 1090 - i*172))
		
	for i in range(3, 10):
		randomizeBarrel(Vector2(360, 1090 - i*172))

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
