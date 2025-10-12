extends CharacterBody2D
class_name Enemy

@export var speed: float = 150


func _physics_process(_delta: float) -> void:
	var direction = (Globals.player_pos - global_position).normalized()
	velocity = direction * speed

	move_and_slide()
