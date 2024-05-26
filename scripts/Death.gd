extends Control

func _on_play_again_pressed():
	get_tree().paused = false
	get_tree().reload_current_scene()
	GameManager.player_death = false

func _on_quit_pressed():
	get_tree().paused = false
	get_tree().quit()
