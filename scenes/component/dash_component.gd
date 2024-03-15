extends Node

@export var max_dash_count: int = 1
@export var dash_speed: float = 800
@export var dash_duration: float = 0.1
@export var dash_refill_duration: float = 0.5

@onready var dashing_duration_time = $DashingDurationTime
@onready var dashing_refill_time = $DashingRefillTime

var current_dash_count: int
var dash_character_body: CharacterBody2D
var face_direction: float

func _ready():
	dashing_refill_time.timeout.connect(on_dashing_refill_timeout)
	
	dashing_duration_time.wait_time = dash_duration
	dashing_refill_time.wait_time = dash_refill_duration
	current_dash_count = max_dash_count

func start_dash(character_body: CharacterBody2D, direction_x: float):
	if current_dash_count > 0:
		stop_refill_dash()
		current_dash_count = max(current_dash_count - 1, 0)
		dashing_duration_time.start()
		dash_character_body = character_body
		face_direction = direction_x

func dashing():
	var movement_x = face_direction * dash_speed
	dash_character_body.velocity = Vector2(movement_x, 0)

func is_dashing():
	return not dashing_duration_time.is_stopped()

func start_refill_dash():
	if dashing_refill_time.is_stopped():
		dashing_refill_time.start()

func refill_dash():
	if current_dash_count >= max_dash_count:
		stop_refill_dash()
		return
	current_dash_count = min(current_dash_count + 1, max_dash_count)
	start_refill_dash()

func stop_refill_dash():
	dashing_refill_time.stop()

func on_dashing_refill_timeout():
	refill_dash()
	print("current_dash:" + str(current_dash_count))
