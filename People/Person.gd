extends KinematicBody2D

signal go_back

onready var animatedSprite=$AnimatedSprite
onready var timer=$Timer
var velocity=Vector2.ZERO
var dir=Vector2.ZERO
var dist
enum state{
	COMING,
	THROWING,
	GOING
}
var currState=state.COMING
const MAX_DIST=200
const MIN_DIST=50
const SPEED=20

func _ready() -> void:
	randomize()
	animatedSprite.frames=animatedSprite.frames.duplicate()
	set_animated_sprite()
	global_position.y=rand_range(10,290)
	dist=rand_range(MIN_DIST,MAX_DIST)
	dir.x=1
	_on_Timer_timeout()
	animatedSprite.playing=true
	animatedSprite.play("Walk")

func _physics_process(delta: float) -> void:
	if currState==state.COMING:
		move_and_slide(dir*SPEED)
		if(global_position.x>dist):
			currState=state.THROWING
			animatedSprite.playing=false
			timer.stop()
			animatedSprite.playing=false
			if $Trash!=null:
				$Trash.set_physics_process(true)
				$Trash.set_collision_layer(4) 
				
			
	elif currState==state.THROWING:
		yield(self,"go_back")
		currState=state.GOING
		dir.x=-1
		timer.start()
		animatedSprite.flip_h=true
		animatedSprite.playing=true
		animatedSprite.play("Walk")
		
	else:
		move_and_slide(dir*SPEED)
		if(global_position.x<-5):
			queue_free()
		
func change_scale():
	animatedSprite.modulate=Color(.95,.55,.55,1)
	animatedSprite.scale.x=0.8
	animatedSprite.scale.y=1.2
	yield(get_tree().create_timer(.5),"timeout")
	animatedSprite.modulate=Color(1,1,1,1)
	animatedSprite.scale.x=1
	animatedSprite.scale.y=1
	
func set_animated_sprite():
	var type=int(rand_range(1,4))
	animatedSprite.frames.add_frame("Walk",load("res://People/Person"+str(type)+"_idle.png"),0)
	animatedSprite.frames.add_frame("Walk",load("res://People/Person"+str(type)+"_walk1.png"),1)
	animatedSprite.frames.add_frame("Walk",load("res://People/Person"+str(type)+"_idle.png"),2)
	animatedSprite.frames.add_frame("Walk",load("res://People/Person"+str(type)+"_walk2.png"),3)
	
func _on_Timer_timeout() -> void:
	timer.wait_time=rand_range(0,1)
	dir.y=int(rand_range(-2,2))







