extends Panel

func _ready() -> void: 
	$HighScoreLabel.text+=str(Main.high_score)
	
func _on_Button_pressed() -> void:
	get_tree().change_scene_to(load("res://World/World.tscn"))


func _on_HowToPlayButton_pressed() -> void:
	get_tree().change_scene_to(load("res://UI/HowToPlayScreen.tscn"))
