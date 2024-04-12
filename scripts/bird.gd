extends CharacterBody2D

signal updated_score(new_score : int)
signal game_over_status_changed(status : bool)
signal game_restarted()

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@export var jump_velocity : int = -550
var is_alive : bool = true
var score : int = 0

# bounce() and jump() are different beacuse bounce() is called when the Bird dies.
# When the Bird dies we don't want the jump sound to play.
func bounce():
	velocity.y = jump_velocity

func jump():
	bounce()
	get_node("FlutterAudioPlayer").play()

# The Bird's rotation is dependant on how fast it is travelling up/down.
func change_tilt():
	rotation = velocity.y / 1000

# Spins the Bird when it dies.
func spin():
	rotate(-50)

func die():
	if is_alive:
		bounce()
		get_node("HitAudioPlayer").play()
		is_alive = false
		emit_signal("game_over_status_changed", true)

func add_score():
	score += 1
	emit_signal("updated_score", score)

# Checks if the Bird has touched the top or bottom of the screen.
func check_has_hit_border():
	if position.y <= 0 + 24 or position.y >= 768 - 24:
		return true
	else:
		return false

# Restarts the game on game over.
func restart():
	position.y = 384
	velocity.y = 0
	
	score = 0
	is_alive = true
	
	emit_signal("updated_score", 0)
	emit_signal("game_over_status_changed", false)
	emit_signal("game_restarted")

# Adds a point when a Pipe is passed.
func _on_pipe_manager_pipe_removed():
	add_score()
	get_node("PointAudioPlayer").play()

# Bird dies on Pipe collision.
func _on_pipe_collision(body):
	if body is Pipe:
		die()

func _physics_process(delta):
	# Calculates the new y velocity of the Bird.
	# Will be changed if the Bird jumps.
	if not is_on_floor():
		velocity.y += gravity * delta
	
	# The Bird dies if it has touched the top or bottom of the screen.
	if check_has_hit_border():
		die()
	
	# Handles what the spacebar key does; restarts the game if the Bird is dead, or the Bird jumps.
	if is_alive == false:
		spin()
		if Input.is_action_just_pressed("input_jump"):
			restart()
	else:
		if Input.is_action_just_pressed("input_jump"):
			jump()
		change_tilt()
	
	# Finally moves the Bird when movement calulations are complete
	move_and_slide()
