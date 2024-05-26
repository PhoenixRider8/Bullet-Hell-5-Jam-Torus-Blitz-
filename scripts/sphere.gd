extends Area2D

var speed : int = 200
var bullet_arr = ["sphere","poison","haste"]
var bullet_rand

var enemy_curr

func _ready():
	bullet_rand = bullet_arr.pick_random()
	randBullet(bullet_rand)

func _process(delta):
	position+= transform.x * speed * delta #update torus position
	
	if position.y > 800 : #above the (0,0) y-plane
		queue_free() #delete torus

func randBullet(bullet_rand1):
	if bullet_rand1 == "sphere":
		$sphere.visible = true
		$Effects/poison.visible = false
		$Effects/haste.visible = false
		
	if bullet_rand1 == "poison":
		$sphere.visible = false
		$Effects/poison.visible = true
		$Effects/haste.visible = false
		
	if bullet_rand1 == "haste":
		$sphere.visible = false
		$Effects/poison.visible = false
		$Effects/haste.visible = true

func _on_lifetime_timer_timeout():
	queue_free()


func _on_body_entered(body):
	#player
	if body.has_method("_player"):
		if $sphere.visible == true:
			body.health -=1
			body.set_player_health()
			body.speed = 200
			enemy_curr._create_new_spawn_points(5)
			
		if $Effects/poison.visible == true:
			body.health -=3
			body.set_player_health()
			body.shoot_time = 4
			body.speed = 150
			enemy_curr._create_new_spawn_points(10)
			
		if $Effects/haste.visible == true:
			body.health -=1
			body.set_player_health()
			body.shoot_time = 1
			body.speed = 500
			enemy_curr._create_new_spawn_points(20)
	

func _on_area_exited(body:Area2D):
	if body.has_method("_enemy"):
		enemy_curr = body
		
