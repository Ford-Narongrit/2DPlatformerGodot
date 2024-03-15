extends Node

@export var max_speed: float = 40
@export var acceleration: float = 5

func move(character_body: CharacterBody2D, direction_x: float):
	var desired_velocity_x = direction_x * max_speed
	character_body.velocity.x = lerp(character_body.velocity.x, desired_velocity_x, 1 - exp(-acceleration * get_process_delta_time()))

func stop(character_body: CharacterBody2D):
	move(character_body, 0)
	
