extends AnimatedSprite2D

@export var deathParticle : PackedScene


func kill():
	var particle : CPUParticles2D = deathParticle.instantiate()
	particle.position = global_position
	particle.rotation = global_rotation
	particle.emitting = true
	get_tree().current_scene.add_child(particle)
	
	await particle.finished
