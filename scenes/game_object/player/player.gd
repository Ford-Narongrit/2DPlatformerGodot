extends CharacterBody2D

@onready var visual = %Visual

var face_direction = 1

func get_input_direction():
	var direction = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	
	var move_sign = sign(direction)
	if move_sign != 0:
		set_face_direction(move_sign)
	
	return direction

func set_face_direction(direction_x: float):
	face_direction = direction_x
	visual.scale = Vector2(direction_x, 1)
