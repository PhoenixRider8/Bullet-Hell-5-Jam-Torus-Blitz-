extends Node

var enemy_scene = preload("res://scenes/enemy.tscn")
var healer_scene = preload("res://scenes/healer.tscn")

func _ready():
	#Spawning Enemies
	var timer = Timer.new() #create timer for spawning enemies
	add_child(timer) #add timer to game manager node
	timer.wait_time = 10 #5 secs interval time before spawning new enemy
	timer.timeout.connect(create_enemy) #timeout of 1.5 secs everytime create_enemy() function is called 
	timer.timeout.connect(create_healer)
	timer.start() 

func create_healer():
	var healer = healer_scene.instantiate()
	get_parent().get_node("Healer_Collection").add_child(healer)

func create_enemy():
	var enemy = enemy_scene.instantiate() #obj of enemy_scene
	get_parent().get_node("Enemy_Collection").add_child(enemy)
