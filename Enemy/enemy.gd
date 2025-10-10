extends CharacterBody2D

@export var speed: float = 100


func _process(_delta: float) -> void:
	var direction = (Globals.player_pos - position).normalized()
	velocity = direction * speed
	move_and_slide()
