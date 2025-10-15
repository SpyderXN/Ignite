extends CanvasLayer



func _on_retry_pressed() -> void:
	TransitionLayer.load_scene("res://Main/main.tscn")


func _on_exit_pressed() -> void:
	TransitionLayer.load_scene("res://Menu/menu.tscn")
