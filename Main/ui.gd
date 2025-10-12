extends CanvasLayer


@onready var night_time: Label = $"Night Time"
@onready var count_down: Label = $Container/CountDown
@onready var round_timer: Timer = $"../RoundTimer"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	show_time()
	count_down_start()

func count_down_start():
	count_down.text = str(int(round_timer.time_left))

func show_time():
	night_time.text = "Night: " + str(int($"../NightTimer".time_left))
