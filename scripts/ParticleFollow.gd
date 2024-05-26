extends PathFollow2D

var speed = 0.5


func _process(delta):
	progress_ratio +=delta * speed
