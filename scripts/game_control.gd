extends Node2D

@onready var score : Label = $ScoreSystem/Points

func _process(delta):
	
	score.text = str(GameManager.val)
	if GameManager.player_death:
		get_tree().paused = true
		$Death.visible = true
		Engine.time_scale = 1

