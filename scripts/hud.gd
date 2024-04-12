extends Control

@onready var label = get_node("ScorePanel/ScoreLabel")

var game_over : bool = false

# Updates the score when a point is scored.
func _on_bird_updated_score(new_score):
	if game_over == false:
		label.text = str("Score: ", new_score)

# Roasts the player when they lose.
func _on_bird_game_over_status_changed(dead):
	game_over = dead
	label.text = str("YOU LOSE!")

# Resets the score to 0 on game restart.
func _on_game_restarted():
	game_over = false
	label.text = str("Score: 0")
