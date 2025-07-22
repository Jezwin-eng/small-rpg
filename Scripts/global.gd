extends Node

var player_current_attack = false
var current_scene = "world"
var transition_scene = false

var player_exit_cliffside_posx = 212
var player_exit_cliffside_posy = 7
var player_start_posx = 48
var player_start_posy = 75
var first_game_start = true

func set_scene(scene):
	current_scene = scene
			
