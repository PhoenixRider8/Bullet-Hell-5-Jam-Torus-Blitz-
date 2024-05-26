extends Area2D

@export var player_scene : PackedScene
@onready var health_bar = $HealthBar
@onready var heal_sound = $heal

var health : int
var happyOrAngry : bool = false
var isheal = false

var speed : int = 10

func _ready():
	health = 3
	health_bar.init_health(health)
	
	randomize()
	position=Vector2(randf_range(0,1152) , 0)
	
	
func _process(delta):
	if health > 0:
		if !happyOrAngry:
			$HealerSprite.play("happy")
	
	else:
		$HealerSprite.play("heal")
		await $HealerSprite.animation_finished
		queue_free()
			
		
	position.y+=speed*delta


#for torus
func _on_area_entered(area:Area2D):
	if area.name == "Torus":
		health -=1
		$HealerSprite.play("angry")
		
		happyOrAngry = true
		area.healer_isangry = true
		set_healer_health()

func set_healer_health():
	health_bar.health = health
	
	if health <=0:
		GameManager.val += 500
		_die()
		
func _die():
	%HealerSprite.kill()
	queue_free()


func _on_body_entered(body):
	if body.name == "Player":
		body.health +=5
		body.set_player_health()
		
		health = 0
		isheal = true
		heal_sound.play()
		


