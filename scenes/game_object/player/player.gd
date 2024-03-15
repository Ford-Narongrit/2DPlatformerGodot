extends CharacterBody2D

@onready var visual = %Visual

var face_direction = 1

func get_input_direction():
	var direction = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	
	var move_sign = sign(direction)
	if move_sign != 0:
		face_direction = move_sign
		visual.scale = Vector2(move_sign, 1)
	
	return direction
