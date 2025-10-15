extends CharacterBody2D
class_name Player

@export var speed: float = 100
@export var accelaration: float = 100
@export var friction: float = 100

var is_in_range: bool = false
var target_object: CharacterBody2D
var held_object: CharacterBody2D
@onready var hand_position: Marker2D = $HandPosition
@onready var idle_sprite: Sprite2D = $IdleSprite
@onready var animation_player: AnimationPlayer = $AnimationPlayer

signal enemy_attacked

func _process(delta: float) -> void:
	var input_vector = Vector2.ZERO
	
	input_vector.x = Input.get_action_strength("RIGHT") - Input.get_action_strength("LEFT")
	input_vector.y = Input.get_action_strength("DOWN") - Input.get_action_strength("UP")
	
	if input_vector.length() > 0:
		input_vector = input_vector.normalized()
		velocity = velocity.move_toward(input_vector * speed, accelaration * delta)
		animation_player.play("Idle")
	else:
		velocity = velocity.move_toward(Vector2.ZERO, friction * delta)
		animation_player.stop()
		
	Globals.player_pos = global_position
	move_and_slide()
	
	pickup_object()
	drop_object()
	
	
	
	if input_vector.x != 0:
		idle_sprite.flip_h = input_vector.x < 0
		#hand_position.position.x = -1 if input_vector.x < 0 else 1



func pickup_object() -> void:
	if is_in_range:
		if Input.is_action_just_pressed("PICKUP") and !held_object:
			held_object = target_object
			held_object.reparent(hand_position)
			held_object.position = hand_position.position

func drop_object() -> void:
	if Input.is_action_just_pressed("DROP") and held_object:
		held_object.reparent(get_parent())
		held_object.position = position + Vector2.RIGHT * 35
		held_object = null

func _on_range_body_entered(body: Node2D) -> void:
	if body.is_in_group("Pickable"):
		is_in_range = true
		target_object = body


func _on_range_body_exited(body: Node2D) -> void:
	if body.is_in_group("Pickable"):
		is_in_range = false
		target_object = null


func _on_enemy_near_body_entered(body: Node2D) -> void:
	if body is Enemy:
		emit_signal("enemy_attacked")
