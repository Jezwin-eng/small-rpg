extends Node2D




# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_scene_changer_body_entered(body: Node2D) -> void:
	if body.name == "Player" :
		global.transition_scene = true
		change_scene()


func _on_scene_changer_body_exited(body: Node2D) -> void:
	if body.name == "Player" :
		global.transition_scene = false
		
func change_scene():
	if global.current_scene == "cliff_side":
		get_tree().change_scene_to_file("res://Scenes/world.tscn")
		global.set_scene("world")
