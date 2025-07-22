class_name enemy
extends CharacterBody2D
@export var speed = 35
var player_chase = false
var player = null
var touching = false
@onready var nav_agent := $NavigationAgent2D as NavigationAgent2D
var in_area = false
var health = 100
var in_attack = false
var can_take_dmg = true

func _ready():
	
	add_to_group("enemies")  
	$AnimatedSprite2D.play("jump")
func _physics_process(_delta: float) -> void:
	update_health()
	if player_chase and not touching:
		$AnimatedSprite2D.play("run")
		var dir = to_local(nav_agent.get_next_path_position()).normalized()
		velocity = dir * speed
		move_and_slide()
		if (player.position.x - position.x) < 0 :
			$AnimatedSprite2D.flip_h = true
		else:
			$AnimatedSprite2D.flip_h = false
	else:
		$AnimatedSprite2D.play("jump")
	if in_area:
		makepath()
		#global_position = global_position.move_toward(player.global_position, speed * delta)
	damage_received()
func makepath() -> void:
	nav_agent.target_position = player.global_position
func _on_detection_area_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		player = body
		player_chase = true
		in_area = true
	
func _on_detection_area_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		player = null
		player_chase = false
		touching = false
		in_area = false

func _on_slime_hitbox_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		touching = true
		in_attack = true
		

func _on_slime_hitbox_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		touching = false
		in_attack = false
		
func damage_received():
	if in_attack and global.player_current_attack == true :
		if can_take_dmg == true:
			health = health - 20
			print("slime health =", health)
			$damage_taken.start()
			can_take_dmg = false
			if health <= 0 :
				queue_free()


func _on_damage_taken_timeout() -> void:
	can_take_dmg = true
	
func update_health():
	var healthbar = $health_bar
	healthbar.value = health
	if health >= 100:
		healthbar.visible = false
	else:
		healthbar.visible = true
		
	if health < 50:
		healthbar.modulate = Color("ff3225")
	else:
		healthbar.modulate = Color("75f625")
		
		
