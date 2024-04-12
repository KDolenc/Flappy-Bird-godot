extends Node

var pipe_scene = preload("res://scenes/pipe.tscn")

signal pipe_removed

# Spawns both child Pipes (upside down rightside up).
func spawn_pipes():
	var height = randf() * 448
	var pipe_instance1 = pipe_scene.instantiate()
	var pipe_instance2 = pipe_scene.instantiate()
	
	pipe_instance1.position.x = 512 + 32
	pipe_instance2.position.x = 512 + 32
	
	pipe_instance1.position.y = 512 + height
	pipe_instance2.position.y = pipe_instance1.position.y - 512 - 192            
	
	pipe_instance2.get_node("Sprite2D").set_flip_v(true)
	pipe_instance2.is_bottom = false
	
	add_child(pipe_instance1)
	add_child(pipe_instance2)

# Alerts the child Pipes when the game has ended/restarted.
func _on_bird_game_over_status_changed(status):
	get_node("SpawnTimer").stop()
	for i in self.get_children():
		if i is Pipe:
			i.game_over = status

# Removes all the child Pipes and restarts the SpawnTimer.
func _on_game_restarted():
	for i in self.get_children():
		if i is Pipe:
			i.remove()
	
	get_node("SpawnTimer").start()

# Spawns a new child Pipe at certain intervals.
func _on_timer_timeout():
	spawn_pipes()

# Removes the child Pipes when they move off screen.
func _process(_delta):
	for i in self.get_children():
		if i is Pipe and i.position.x < -32:
			if i.is_bottom == true:
				emit_signal("pipe_removed")
			i.remove()
