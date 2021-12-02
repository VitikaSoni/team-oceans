extends Panel

func _ready() -> void:
	$HighScoreLabel.text+=str(Main.high_score)
	$CurrentScoreLabel.text=str(Main.current_score)
	
func _on_RetryButton_pressed() -> void:
	get_tree().change_scene_to(load("res://World/World.tscn"))

func _on_MenuButton_pressed() -> void:
	get_tree().change_scene_to(load("res://UI/MenuScreen.tscn"))
