extends CharacterBody2D
class_name Pipe

@export var SPEED : int = 248
var is_bottom : bool = true
var game_over : bool = false

# Deletes the Pipe when off screen/game was reset.
func remove():
	queue_free()

# Moves the Pipe when the game is playing.
func _physics_process(_delta):
	if game_over == false:
		velocity.x = -1 * SPEED
		
		move_and_slide()
