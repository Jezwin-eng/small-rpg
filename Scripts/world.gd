extends Node2D
func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass

func _on_cliff_side_trans_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		global.transition_scene = true
		change_scene()


func _on_cliff_side_trans_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		global.transition_scene = false
		
func change_scene():
	if global.current_scene == "world":
		get_tree().change_scene_to_file("res://Scenes/cliff_side.tscn")
		global.set_scene("cliff_side")
