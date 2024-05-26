extends CharacterBody2D

#torus
var torus_scene = preload("res://scenes/torus.tscn")
var shoot_time = 1.0 #cooldown timer
var shoot_counter = 0 #increament by delta time

#player

var direction : int = 0
var speed : int = 300
var player_halfwidth = 32 #player_width/2

#healthbar
@onready var health_bar = $HealthBar
var health

#sounds
@onready var attack_sound = $sounds/attack
@onready var death_sound = $sounds/death

func _ready():
	health = 30
	health_bar.init_health(health)

func _physics_process(delta):
	shoot_counter +=delta
	if Input.is_action_just_pressed("attack") and shoot_counter>shoot_time:
		shoot_counter = 0
		#attack animation
		attack_sound.play()
		
		var torus_obj = torus_scene.instantiate() #create object of torus scene 
		torus_obj.position.x = position.x
		torus_obj.position.y = position.y - (player_halfwidth*2)
		get_parent().get_node("Torus_Collection").add_child(torus_obj) #add torus object to torus_collection node
	
	#player
	var direction = Input.get_vector("left","right","up","down")
	velocity = direction * speed
	if Input.is_action_pressed("left"):
		set_rotation(-45)
		%PlayerSprite.play("idle")
	elif Input.is_action_pressed("right"):
		set_rotation(45)
		%PlayerSprite.play("idle")
	else:
		set_rotation(0)
		if Input.is_action_pressed("attack"):
			%PlayerSprite.play("attack")
	
	move_and_slide()
	
func set_player_health():
	health_bar.health = health
	
	if health <=0:
		_die()
	#print(health)

func _die():
	health_bar.queue_free()
	death_sound.play()
	await death_sound.finished
	%PlayerSprite.kill()
	queue_free()
	GameManager.player_death = true

func _player():
	pass
