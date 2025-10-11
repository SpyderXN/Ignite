extends Area2D

#var shrink_speed = 10
#var min_radius = 5
#@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
#
#
## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#var shape = collision_shape_2d.shape as CircleShape2D
	#if shape.radius > min_radius:
		#shape.radius -= shrink_speed * delta
