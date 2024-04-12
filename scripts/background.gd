extends CharacterBody2D
class_name Background

@export var SPEED : int = 124
var game_over : bool = false

# Moves the Background when the game is playing.
func _physics_process(_delta):
	if game_over == false:
		velocity.x = -1 * SPEED
		
		move_and_slide()
