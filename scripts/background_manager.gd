extends Node

# Alerts the child Backgrounds if the game has ended/restarted.
func _on_bird_game_over_status_changed(died):
	for i in self.get_children():
		if i is Background:
			i.game_over = died

# Moves the child Backgrounds along.
# Moves the child Backgrounds back to the start when they are offscreen.
func _process(_delta):
	var background1 = get_node("Background1")
	var background2 = get_node("Background2")
	if background1.position.x < -256:
		background1.position.x = background2.position.x + 512
	if background2.position.x < -256:
		background2.position.x = background1.position.x + 512
