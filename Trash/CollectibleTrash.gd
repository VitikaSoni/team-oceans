extends Area2D

onready var world=get_node("../../")

func _on_CollectibleTrash_area_entered(area: Area2D) -> void:
	world.water_trash-=1
	queue_free()
	
