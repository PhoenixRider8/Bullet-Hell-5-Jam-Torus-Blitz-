extends Control


#start game
func _on_button_pressed():
	get_tree().change_scene_to_file("res://scenes/game_manager.tscn")
