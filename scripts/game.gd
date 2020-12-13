extends Node

var barrel = preload("res://scenes/barrel.tscn")
var rightBarrel = preload("res://scenes/rightbarrel.tscn")
var leftBarrel = preload("res://scenes/leftbarrel.tscn")

onready var timberman = get_node("Timberman")
onready var camera = get_node("Camera")
onready var barrels = get_node("Barrels")
onready var destBarrels = get_node("DestBarrels")
onready var bar = get_node("Bar")
onready var scoreLabel = get_node("Control/Score")

const NORMAL_BARREL = 0
const LEFT_BARREL = 1
const RIGHT_BARREL = 2

const PLAYING = 1
const LOST = 2

var enemy

var score = 0

var state = PLAYING

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	generateAllBarrels()
	bar.connect("lost", self, "lose")


func _input(event):
	event = camera.make_input_local(event)
	if event is InputEventScreenTouch and event.pressed and state == PLAYING:
		if event.position.x < 360:
			timberman.left()
		else:
			timberman.right()
			
		if !verifyCollision():
			timberman.beginHit()
			var bottomBarrel = barrels.get_children()[0]
			barrels.remove_child(bottomBarrel)
			destBarrels.add_child(bottomBarrel)
			bottomBarrel.destroy(timberman.side)
			
			randomizeBarrel(Vector2(360, 1090 - 10*172))
			descend()
			
			bar.add(0.014)
			score += 1
			scoreLabel.set_text(str(score))
			
			if verifyCollision():
				lose()
		else:
			lose()


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


func verifyCollision():
	var side = timberman.side
	var bottomBarrel = barrels.get_children()[0]
	
	if side == timberman.LEFT and bottomBarrel.is_in_group("leftBarrel") or side == timberman.RIGHT and bottomBarrel.is_in_group("rightBarrel"):
		return true
	else:
		return false


func descend():
	for b in barrels.get_children():
		b.position += Vector2(0, 172)


func lose():
	timberman.die()
	bar.set_process(false)
	state = LOST
	get_node("Timer").start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Timer_timeout():
	get_tree().reload_current_scene()
