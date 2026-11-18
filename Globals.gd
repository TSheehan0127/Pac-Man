extends Node

signal stat_changed()

var game_started: bool = false

var score: int = 0:
	set(value):
		score = value
		stat_changed.emit()

var pacman_pos: Vector2 = Vector2(367,274)

var lives: int = 3

var ghost_points: int = 200

func increase_ghost_points():
	ghost_points += 200

func reset_ghost_points():
	ghost_points = 200

var empty_cell_coords = []

func get_empty_cell_coords():
	return empty_cell_coords.pick_random()

func reset_game() -> void:
	score = 0
	lives = 3
	ghost_points = 200
