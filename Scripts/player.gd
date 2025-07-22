extends CharacterBody2D

const speed = 100
var current_dir = "none"
var attack_cooldown = true
var in_attack_range = false
@export var health = 100
var player_alive = true
var attack_ip = false


func _ready():
	$AnimatedSprite2D.play("front_idle")
	
	
func _physics_process(delta):
	player_movement(delta)
	get_attacked()
	attack_animation()
	current_cam()
	if health <= 0:
		player_alive = false
		health = 0
		print("Game over")
		self.queue_free()
	
func player_movement(delta):
	
	if Input.is_action_pressed("move_right"):
		current_dir = "right"
		play_anim(1)
		velocity.x = speed
		velocity.y = 0
	elif Input.is_action_pressed("move_left"):
		current_dir = "left"
		play_anim(1)
		velocity.x = -speed
		velocity.y = 0
	elif Input.is_action_pressed("move_up"):
		current_dir = "up"
		play_anim(1)
		velocity.x = 0
		velocity.y = -speed
	elif Input.is_action_pressed("move_down"):
		current_dir = "down"
		play_anim(1)
		velocity.x = 0
		velocity.y = speed
	else:
		play_anim(0)
		velocity.x = 0
		velocity.y = 0
	move_and_slide()

func play_anim(movement):
	var dir = current_dir
	var anim = $AnimatedSprite2D
	
	if dir == "right":
		anim.flip_h = false
		if movement == 1:
			anim.play("side_walk")
		elif movement == 0 :
			if  attack_ip == false:
				anim.play("side_idle")
			
	elif dir == "left":
		anim.flip_h = true
		if movement == 1:
			anim.play("side_walk")
		elif movement == 0 :
			if  attack_ip == false:
				anim.play("side_idle")
			
	elif dir == "down":
		anim.flip_h = false
		if movement == 1:
			anim.play("front_walk")
		elif movement == 0 :
			if attack_ip == false:
				anim.play("front_idle")
			
	elif dir == "up":
		anim.flip_h = false
		if movement == 1:
			anim.play("back_walk")
		elif movement == 0 :
			if attack_ip == false:
				anim.play("back_idle")

func _on_player_hitbox_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemies"):
		in_attack_range = true
		
		
		

func _on_player_hitbox_body_exited(body: Node2D) -> void:
	if body.is_in_group("enemies"):
		in_attack_range = false

func get_attacked():
	if in_attack_range == true and attack_cooldown == true:
		health = health - 20
		attack_cooldown = false
		$attack_cooldown.start()
		print(health)
	
func _on_attack_cooldown_timeout() -> void:
	attack_cooldown = true

func attack_animation():
	var dir = current_dir
	var anim = $AnimatedSprite2D
	
	if Input.is_action_just_pressed("Attack"):
		global.player_current_attack = true
		attack_ip = true
		if dir == "right":
			anim.flip_h = false
			anim.play("side_attack")
			$deal_attack.start()
			
		elif dir == "left":
			anim.flip_h = true
			anim.play("side_attack")
			$deal_attack.start()
			
		elif dir == "up":
			anim.play("back_attack")
			$deal_attack.start()
			
		elif dir == "down":
			anim.play("front_attack")
			$deal_attack.start()
			

func _on_deal_attack_timeout() -> void:
	$deal_attack.start()
	global.player_current_attack = false
	attack_ip = false

func current_cam():
	if global.current_scene == "world":
		$world_cam.enabled = true
		$cliff_side_cam.enabled = false
	elif global.current_scene == "cliff_side":
		$world_cam.enabled = false
		$cliff_side_cam.enabled = true
