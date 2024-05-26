extends Area2D

var speed : int = 200
var healer_isangry = false

func _physics_process(delta):
	if !healer_isangry:
		position.y-= speed * delta #update torus position
	
	else:
		position.y+= speed * delta
		
	#rotate
	rotate(45)
	
	if position.y < 0 or position.y > 648: #above the (0,0) y-plane
		queue_free() #delete torus




func _on_body_entered(body):
	if body.name == "Player":
		body.health -=10
		body.set_player_health()
