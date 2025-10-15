extends CharacterBody2D
class_name Pickable


@export var impact: float = 0
var player_near: bool = false
@export var shrink_speed = 10
@export var min_radius = 20
@export var min_light = 1
@export var light_reduce_speed = .5
@onready var collision_shape_2d: CollisionShape2D = $DamageArea/CollisionShape2D
@onready var point_light_2d: PointLight2D = $PointLight2D



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var shape = collision_shape_2d.shape as CircleShape2D
	if shape.radius > min_radius and player_near == false:
		shape.radius -= shrink_speed * delta
		point_light_2d.energy -= light_reduce_speed * delta
	
	if shape.radius < min_radius:
		shape.radius = min_radius
		point_light_2d.energy = min_light
	
	if player_near and shape.radius < 60:
		shape.radius += 1
	
	if player_near and point_light_2d.energy < 1:
		point_light_2d.energy = 1.4


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
		
