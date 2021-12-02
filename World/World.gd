extends Node2D

onready var people=get_node("People")
onready var peopleSpawnTimer=$PeopleSpawnTimer
onready var gameUI=$GameUI
onready var gamePlayedTimer=$GamePlayedTimer
var Stopper=load("res://Players/Stopper.tscn")
var Person=load("res://People/Person.tscn")
var water_trash=0 setget set_water_trash
var score=0 setget set_score
var max_spawn_time=5
var min_spawn_time=3

func _ready() -> void:
	OS.set_window_maximized(true)
	
func set_score(value):
	score=value
	gameUI.scoreLabel.text=str(value)
	gameUI.score_changed()

func set_water_trash(value):
	var increase=false
	if value>water_trash:
		increase=true
	water_trash=value
	gameUI.waterTrashLabel.text=str(value)+"/10"
	gameUI.water_trash_change(increase)
	
func _on_WaterArea_body_entered(body: Node) -> void:
	if body is Player1:
		body.stopper.set_as_toplevel(true)
		body.stopper.global_position=body.global_position
		body.speed/=3
		body.is_in_water=true
		body.animatedSprite.stop()
		body.animatedSprite.play("WalkInWater")
		
		body.get_node("Position2D/CPUParticles2D").emitting=true
	elif body is Trash:
		set_water_trash(water_trash+1)
		
		if(water_trash>=10):
			yield(get_tree().create_timer(1),"timeout")
			if Main.high_score<score:
				Main.save_data(score)
			Main.current_score=score
			get_tree().change_scene_to(load("res://UI/GameOverScreen.tscn"))
		
func _on_WaterArea_body_exited(body: Node) -> void:
	if body is Player1:
		body.stopper.position=Vector2.ZERO
		body.stopper.set_as_toplevel(false)
		body.speed*=3
		body.is_in_water=false
		body.state=0
		body.get_node("Position2D/CPUParticles2D").emitting=false

func _on_PeopleSpawnTimer_timeout() -> void:
	var person=Person.instance()
	people.add_child(person)
	peopleSpawnTimer.wait_time=rand_range(min_spawn_time,max_spawn_time)

func _on_GamePlayedTimer_timeout() -> void:
	max_spawn_time-=.3
	min_spawn_time-=.3
	if(min_spawn_time<=0):
		gamePlayedTimer.wait_time=10
		gamePlayedTimer.queue_free()
		
	
	
