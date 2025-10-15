extends Node2D

@export var enemy_scene: PackedScene
@export_range(-2000, 2000, 10) var low: float
@export_range(-2000, 2000, 10) var high: float
var can_spawn = true

func _process(_delta: float) -> void:
	if can_spawn:
		can_spawn = false
		var spawn = enemy_scene.instantiate() as CharacterBody2D
		spawn.position.y = randf_range(low, high)
		$Timer.start()
		$Spawns.add_child(spawn)

func _on_timer_timeout() -> void:
	can_spawn = true
