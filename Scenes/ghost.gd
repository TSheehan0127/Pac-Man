extends CharacterBody2D

signal pacman_dies
signal eaten_anim
signal eaten_anim_done

const DEFAULT_SPEED: int = 50
const EATEN_SPEED: int = 100

enum ghost_state {AT_HOME, SCATTER, CHASE_PACMAN, RUN_AWAY, EATEN}

var current_state = ghost_state.AT_HOME
var speed: int = DEFAULT_SPEED

var direction = Vector2.DOWN

@export var scatter_pos = Vector2(99,243)
@export var home_pos = Vector2(332,474)
@export var ghost_color: Color = Color.RED
@export var timer_length: float = 3.00

func _ready():
	$BodySprite2D.modulate = ghost_color
	$Timers/AtHomeTimer.wait_time = timer_length
	$Timers/AtHomeTimer.start()
	$AnimationPlayer.play("move")

func _physics_process(delta: float) -> void:
	if current_state != ghost_state.AT_HOME:
		var next_pos: Vector2 = $NavigationAgent2D.get_next_path_position()
		direction = global_position.direction_to(next_pos)
		velocity = direction * speed
		move_and_slide()

func scatter():
	current_state = ghost_state.SCATTER
	speed = DEFAULT_SPEED
	$NavigationAgent2D.target_position = scatter_pos
	$BodySprite2D.modulate = ghost_color
	$AnimationPlayer.play("move")

func chase_pacman():
	current_state = ghost_state.CHASE_PACMAN
	speed = DEFAULT_SPEED
	$BodySprite2D.modulate = ghost_color
	$AnimationPlayer.play("move")

func run_away():
	current_state = ghost_state.RUN_AWAY
	speed = DEFAULT_SPEED
	$BodySprite2D.modulate = Color.WHITE
	$NavigationAgent2D.target_position = Globals.get_empty_cell_coords()
	$Timers/RunAwayTimer.start()
	$AnimationPlayer.play("vulnerable")


func eaten():
	current_state = ghost_state.EATEN
	eaten_anim.emit()
	$AnimationPlayer.play("eaten")
	$EatGhost.play()
	$PointsLabel.text = str(Globals.ghost_points)
	Globals.score += Globals.ghost_points
	Globals.increase_ghost_points()
	await $AnimationPlayer.animation_finished
	eaten_anim_done.emit()
	$AnimationPlayer.play("eaten_move")
	speed = EATEN_SPEED
	$NavigationAgent2D.target_position = home_pos
	$BodySprite2D.modulate = Color.BLACK


func _on_at_home_timer_timeout() -> void:
	scatter()

func _on_run_away_timer_timeout() -> void:
	Globals.reset_ghost_points()
	if current_state == ghost_state.RUN_AWAY:
		chase_pacman()


func _on_update_target_position_timer_timeout() -> void:
	if current_state == ghost_state.CHASE_PACMAN:
		$NavigationAgent2D.target_position = Globals.pacman_pos


func _on_navigation_agent_2d_navigation_finished() -> void:
	if current_state == ghost_state.SCATTER or current_state == ghost_state.EATEN:
		chase_pacman()
	elif current_state == ghost_state.RUN_AWAY:
		$NavigationAgent2D.target_position = Globals.get_empty_cell_coords()


func _on_ghost_area_2d_body_entered(body: Node2D) -> void:
	if current_state == ghost_state.SCATTER or current_state == ghost_state.CHASE_PACMAN:
		pacman_dies.emit()
		print("Pacman dies")
	elif current_state == ghost_state.RUN_AWAY:
		eaten()

func reset_ghost():
	current_state = ghost_state.AT_HOME
	$BodySprite2D.modulate = ghost_color
	$AnimationPlayer.play("move")
	$Timers/AtHomeTimer.start()
	global_position = home_pos
