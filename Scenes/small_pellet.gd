extends Area2D

signal pellet_eaten

func _on_body_entered(body: Node2D) -> void:
	if body.name == "PacMan":
		pellet_eaten.emit()
		Globals.score += 10
		queue_free()
