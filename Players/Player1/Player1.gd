extends KinematicBody2D
class_name Player1

onready var animatedSprite=$Position2D/AnimatedSprite
onready var world=get_node("../")
onready var position2D=$Position2D
onready var stopper=$Stopper
onready var sprite=$Position2D/Sprite
onready var waterSoundEffect=$WaterSoundEffect
onready var cpuParticles2D=position2D.get_node("CPUParticles2D")
var speed=100
var dir=Vector2.ZERO 
var velocity=Vector2.ZERO
var up="ui_up"
var down="ui_down"
var left="ui_left"
var right="ui_right"
var is_in_water=false setget set_is_in_water
var state=states.WALKING
enum states{IDLE,WALKING}

func _physics_process(delta: float) -> void:
	if is_in_water:
		flip()
	if(state==states.IDLE):
		dir=Vector2(Input.get_action_strength(right)-Input.get_action_strength(left),
		Input.get_action_strength(down)-Input.get_action_strength(up))
		if dir!=Vector2.ZERO:
			state=states.WALKING
			if !is_in_water:
				animatedSprite.play("Walk")
				
			else:
				waterSoundEffect.stream_paused=false
				cpuParticles2D.emitting=true
	else:
		velocity=speed*dir
		velocity=move_and_slide(velocity)
		dir=Vector2(Input.get_action_strength(right)-Input.get_action_strength(left),
		Input.get_action_strength(down)-Input.get_action_strength(up))
		if dir==Vector2.ZERO:
			state=states.IDLE
			if !is_in_water:
				animatedSprite.play("Idle")
			else:
				waterSoundEffect.stream_paused=true
				cpuParticles2D.emitting=false
		
func flip():
	if dir.x>0:
		position2D.scale.x=-1
	elif dir.x<0:
		position2D.scale.x=1

func set_is_in_water(value):
	is_in_water=value
	if !value:
		waterSoundEffect.stream_paused=true
	else:
		waterSoundEffect.stream_paused=false
