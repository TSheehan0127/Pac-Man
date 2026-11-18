extends Node2D
const SMALL_PELLET = preload("res://Scenes/small_pellet.tscn")
const TITLE_SCREEN: PackedScene = preload("res://Scenes/title_screen.tscn")

func _ready() -> void:
	var empty_coords = []

	for cell in $MazeTML.get_used_cells():
		var tile_data = $MazeTML.get_cell_tile_data(cell)
		if tile_data.get_custom_data("Empty"):
			var cell_coords = $MazeTML.to_global($MazeTML.map_to_local(cell))
			empty_coords.append(cell_coords)
			if tile_data.get_custom_data("SmallPellet"):
				var small_pellet = SMALL_PELLET.instantiate()
				small_pellet.global_position = cell_coords
				small_pellet.pellet_eaten.connect(ate_pellet)
				$Pellets.add_child(small_pellet)

	Globals.empty_cell_coords = empty_coords

	for pellet in $BigPellets.get_children():
		pellet.big_pellet_eaten.connect(ate_big_pellet)

	update_score_label()
	Globals.stat_changed.connect(update_score_label)

	for ghost in $Ghosts.get_children():
		ghost.pacman_dies.connect(lose_life)
		ghost.eaten_anim.connect(freeze_physics)
		ghost.eaten_anim_done.connect(resume_physics)


func ate_pellet():
	await get_tree().process_frame
	$Sounds/PelletSound.play(0.6)
	if $Pellets.get_child_count() == 0 and $BigPellets.get_child_count() == 0:
		print("Pacman wins!")
		get_tree().change_scene_to_packed(TITLE_SCREEN)


func ate_big_pellet() -> void:
	ate_pellet()
	$Sounds/BigPelletSound.playing = true
	for ghost in $Ghosts.get_children():
		ghost.run_away()


func _on_right_portal_body_entered(body: Node2D) -> void:
	body.position.x = $Portals/LeftPortal/CollisionShape2D.global_position.x + 30

func _on_left_portal_body_entered(body: Node2D) -> void:
	print("work!")
	body.position.x = $Portals/RightPortal/CollisionShape2D.global_position.x - 30

func update_score_label():
	$HUD/ScoreLabel.text = "SCORE: " + str(Globals.score)


func lose_life():
	freeze_physics()
	$PacMan.die()
	$Sounds/PacmanDeathSound.play()
	await $PacMan.death_animation_done
	Globals.lives -= 1
	if Globals.lives <= 0:
		print("Game Over")
		get_tree().change_scene_to_packed(TITLE_SCREEN)
	else:
		if Globals.lives == 2:
			$HUD/TextureRect3.visible = false
		elif Globals.lives == 1:
			$HUD/TextureRect2.visible = false

		for ghost in $Ghosts.get_children():
			ghost.reset_ghost()

		$PacMan.global_position = $PacManStartPosition.global_position
		$PacMan.reset_pacman()
		resume_physics()

func freeze_physics():
	for ghost in $Ghosts.get_children():
		ghost.set_physics_process(false)
	$PacMan.set_physics_process(false)

func resume_physics():
	for ghost in $Ghosts.get_children():
		ghost.set_physics_process(true)
	$PacMan.set_physics_process(true)
