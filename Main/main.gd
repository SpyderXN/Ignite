extends Node2D

var count_down_finished = false
var is_night = true
@onready var count_down: Label = $UI/Container/CountDown
@onready var game_audio: AudioStreamPlayer2D = $GameAudio
@onready var night_time: Label = $"UI/Night Time"


func _ready() -> void:
	$RoundTimer.stop()
	$NightTimer.stop()
	start_round()
	$Spawner.process_mode = Node.PROCESS_MODE_DISABLED
	$VSpawner.process_mode = Node.PROCESS_MODE_DISABLED
	$VSpawner2.process_mode = Node.PROCESS_MODE_DISABLED
	night_time.visible = false

func _process(_delta: float) -> void:
	
	if count_down_finished == true:
		count_down_finished = false
		$Spawner.process_mode = Node.PROCESS_MODE_INHERIT
		$VSpawner.process_mode = Node.PROCESS_MODE_INHERIT
		$VSpawner2.process_mode = Node.PROCESS_MODE_INHERIT
		game_audio.playing = true
		night_time.visible = true
	
	if is_night == false:
		is_night = true
		print("Night Finished")
		$Spawner.process_mode = Node.PROCESS_MODE_WHEN_PAUSED
		$VSpawner.process_mode = Node.PROCESS_MODE_WHEN_PAUSED
		$VSpawner2.process_mode = Node.PROCESS_MODE_WHEN_PAUSED
		$Player.process_mode = Node.PROCESS_MODE_WHEN_PAUSED
		game_audio.playing = false
		
		TransitionLayer.load_scene("res://Winner/winner.tscn")

func start_round():
	print("Round countdown started")
	count_down_finished = false
	$RoundTimer.start()

func _on_round_timer_timeout() -> void:
	count_down_finished = true
	$RoundTimer.stop()
	print("Round Finished → Starting Night Timer")
	start_night_timer()
	count_down.visible = false
	

func start_night_timer():
	$NightTimer.start()
	is_night = true
	print("Night Timer Started")

func _on_night_timer_timeout() -> void:
	is_night = false
	$NightTimer.stop()

func _on_player_enemy_attacked() -> void:
	TransitionLayer.load_scene("res://GameOver/game_over.tscn")
