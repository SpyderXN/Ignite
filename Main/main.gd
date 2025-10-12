extends Node2D

var count_down_finished = false
var is_night = true
@onready var count_down: Label = $UI/Container/CountDown

func _ready() -> void:
	$RoundTimer.stop()
	$NightTimer.stop()
	start_round()
	$Spawner.process_mode = Node.PROCESS_MODE_DISABLED
	

func _process(_delta: float) -> void:
	
	if count_down_finished == true:
		count_down_finished = false
		$Spawner.process_mode = Node.PROCESS_MODE_INHERIT
	
	if is_night == false:
		is_night = true
		print("Night Finished")
		$Spawner.process_mode = Node.PROCESS_MODE_WHEN_PAUSED

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
