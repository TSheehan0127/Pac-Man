extends CharacterBody2D

signal death_animation_done

const SPEED = 100;
var direction = Vector2.RIGHT;


func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("left"):
		direction = Vector2.LEFT
		$Sprite2D.rotation_degrees = 180
	elif Input.is_action_pressed("right"):
		direction = Vector2.RIGHT
		$Sprite2D.rotation_degrees = 0
	elif Input.is_action_pressed("up"):
		direction = Vector2.UP
		$Sprite2D.rotation_degrees = 270
	elif Input.is_action_pressed("down"):
		direction = Vector2.DOWN
		$Sprite2D.rotation_degrees = 90

	velocity = direction * SPEED
	move_and_slide()
	Globals.pacman_pos = global_position


func die():
	direction = Vector2.ZERO
	$AnimationPlayer.play("die")


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "die":
		death_animation_done.emit()

func reset_pacman():
	$AnimationPlayer.play("move")
