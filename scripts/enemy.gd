extends Area2D

const sphere_scene = preload("res://scenes/sphere.tscn")
@export var time_between_shots = 1
var spawn_point_count = 5 
@export var radius = 10

@export var rotate_speed = 100
@export var direction_change_interval = 3 #time interval for changing rotation
var rotation_direction = 1 # 1 -> clockwise & -1 -> anticlockwise
var direction_change_timer = 0 #timer to track elapsed time

@onready var shoot_timer = $"Shoot Timer"
@onready var rotator = $Rotator

#healthbar
var health
@onready var health_bar = $HealthBar

#enemy
#@onready var animated_sprite = $EnemySprite
var speed : int = 10
@onready var death_sound = $death

func _ready():
	#enemy
	randomize()
	position=Vector2(randf_range(100,1052) , 0) #spawn enemy in random position
	
	#health
	health = 6
	health_bar.init_health(health)
	
	#bullet pattern
	_create_new_spawn_points(spawn_point_count)
		
	shoot_timer.wait_time = time_between_shots
	shoot_timer.start()

func _physics_process(delta):
	#bullet patterns
	direction_change_timer +=delta
	if direction_change_timer >= direction_change_interval:
		direction_change_timer = 0
		rotation_direction *= -1
		
	var new_rotation = rotator.rotation_degrees + rotate_speed * rotation_direction * delta
	rotator.rotation_degrees = fmod(new_rotation, 360)
	
	#enemy
	if health>0:
		%EnemySprite.play("idle")
	position.y+=speed*delta #update y position of enemy
	
func _create_new_spawn_points(amt):
	#bullet pattern
	for i in range(amt): #loop 5 times
		var spawn_point = Node2D.new()
		var angle = i * (2 * PI / amt)
		var pos = Vector2(radius * cos(angle), radius * sin(angle))
		
		spawn_point.position = pos
		spawn_point.rotation = pos.angle()
		rotator.add_child(spawn_point)

func _on_shoot_timer_timeout():
	for r in rotator.get_children(): #loop through rotator node childrens in enemy scene
		var sphere = sphere_scene.instantiate()
		get_parent().add_child(sphere)
		sphere.position = r.global_position
		sphere.rotation = r.global_rotation

func set_enemy_health():
	health_bar.health = health
	
	if health <=0:
		GameManager.val += 1
		_die()
	#print(health)


func _on_area_entered(area : Area2D):
	if area.name == "Torus":
		health-= 1
		set_enemy_health()
		
func _die():
	%EnemySprite.kill()
	death_sound.play()
	await death_sound.finished
	queue_free()

func _enemy():
	pass
