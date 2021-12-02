extends Panel

func _on_RetryButton_pressed() -> void:
	get_tree().change_scene_to(load("res://UI/MenuScreen.tscn"))
