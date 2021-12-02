extends KinematicBody2D
class_name Trash

onready var collectibleTrashes=get_node("../../../CollectibleTrashes")
onready var world=get_node("../../../")
onready var parent=get_node("../")
onready var stopperHitSoundEffect=$StopperHitSoundEffect
onready var personHitSoundEffect=$PersonHitSoundEffect
var dist=0
var type=""
var dir=Vector2(1,0)
const SPEED=100
const MAX_DIST=400
const MIN_DIST=350

func _ready() -> void:
	randomize()
	set_physics_process(false)
	var num=int(rand_range(1,6))
	match(num):
		1:
			type="Can"
		2:
			type="Bottle"
		3:
			type="Cup"
		4:
			type="Glass"
		5:
			type="TrashBag"
	$Sprite.texture=load("res://Trash/"+type+".png")
	dist=rand_range(MIN_DIST,MAX_DIST)

func _physics_process(delta: float) -> void:
	if(global_position.x>dist):
		stop()
	elif(global_position.x<20):
		reflected_back()
	move_and_slide(SPEED*dir)
	rotation_degrees+=1

func stop():
	parent.emit_signal("go_back")
	set_physics_process(false)
	var Trash=load("res://Trash/CollectibleTrash.tscn")
	var trash=Trash.instance()
	trash.get_node("Sprite").texture=load("res://Trash/"+type+".png")
	trash.global_position=global_position
	trash.rotation_degrees=rotation_degrees
	collectibleTrashes.add_child(trash)
	queue_free()

func _on_Area2D_body_entered(body: Node) -> void:
	if parent.currState==1:
		if  body is Stopper:
			stopperHitSoundEffect.playing=true
			world.score+=1
			dir=dir.move_toward(global_position-parent.global_position,-5)
		elif body == parent:
			personHitSoundEffect.playing=true
			parent.change_scale()
			reflected_back()
			
func reflected_back():
	set_physics_process(false)
	parent.emit_signal("go_back")
	
	
