extends CharacterBody2D
class_name Pickable


@export var impact: float = 0
var player_near: bool = false
var shrink_speed = 10
var min_radius = 5
@onready var collision_shape_2d: CollisionShape2D = $DamageArea/CollisionShape2D



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var shape = collision_shape_2d.shape as CircleShape2D
	if shape.radius > min_radius and player_near == false:
		shape.radius -= shrink_speed * delta
	
	if shape.radius < min_radius:
		shape.radius = min_radius
	
	if player_near and shape.radius < 300:
		shape.radius += .5


func _on_damage_area_body_entered(body: Node2D) -> void:
	if body is Enemy:
		body.speed -= impact
	
	if body is Player:
		player_near = true
	
func _on_damage_area_body_exited(body: Node2D) -> void:
	if body is Enemy:
		body.speed += impact
	
	if body is Player:
		player_near = false

func _on_kill_area_body_entered(body: Node2D) -> void:
	if body is Enemy:
		body.queue_free()
		
