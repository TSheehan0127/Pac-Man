extends Area2D

signal big_pellet_eaten

func _on_body_entered(body: Node2D) -> void:
	if body.name == "PacMan":
		big_pellet_eaten.emit()
		queue_free()
