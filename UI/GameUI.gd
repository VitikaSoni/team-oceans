extends CanvasLayer

onready var waterTrashLabel=$WaterTrashLabel
onready var scoreLabel=$ScoreLabel
onready var valueChangeSoundEffect=waterTrashLabel.get_node("ValueChangeSoundEffect")

func water_trash_change(var increase):
	valueChangeSoundEffect.playing=false
	valueChangeSoundEffect.playing=true
	waterTrashLabel.get_font("font").size=28
	if(increase):
		waterTrashLabel.set("custom_colors/font_color",Color(1,.04,.04,1))
	else:
		waterTrashLabel.set("custom_colors/font_color",Color(.27,.8,.05,1))
	yield(get_tree().create_timer(.5),"timeout")
	waterTrashLabel.set("custom_colors/font_color",Color(1,1,1,1))
	waterTrashLabel.get_font("font").size=24
		
func score_changed():
	scoreLabel.get_font("font").size=28
	scoreLabel.set("custom_colors/font_color",Color(.27,.8,.05,1))
	yield(get_tree().create_timer(.5),"timeout")
	scoreLabel.set("custom_colors/font_color",Color(1,1,1,1))
	scoreLabel.get_font("font").size=24
