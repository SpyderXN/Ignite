extends CanvasLayer



func _on_start_pressed() -> void:
	TransitionLayer.load_scene("res://Main/main.tscn")


func _on_exit_pressed() -> void:
	get_tree().quit()
