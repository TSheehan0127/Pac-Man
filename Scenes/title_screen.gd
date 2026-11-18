extends Control

func _ready() -> void:
	if not Globals.game_started:
		$MessageLabel.text = "PACMAN"
	elif Globals.lives <= 0:
		$MessageLabel.text = "GAME OVER!"
	else:
		$MessageLabel.text = "YOU WIN!"

	$ScoreLabel.text = "SCORE: " + str(Globals.score)


func _on_button_pressed() -> void:
	Globals.game_started = true
	Globals.reset_game()
	get_tree().change_scene_to_file("res://Scenes/Level.tscn")
