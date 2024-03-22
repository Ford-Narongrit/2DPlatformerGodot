extends Node

@export var max_jump_count: int = 2
@export var max_jump_impulse: float = 400
@export var min_jump_impulse: float = 100
@export var wall_jump_impulse: float = 1000

var current_jump_count: int

func _ready():
	pass

func jump(character_body: CharacterBody2D):
	if current_jump_count > 0:
		current_jump_count -= 1
		character_body.velocity.y = -max_jump_impulse

func jump_cut(character_body: CharacterBody2D):
	if character_body.velocity.y < -min_jump_impulse:
		character_body.velocity.y = -min_jump_impulse

func wall_jump(character_body: CharacterBody2D, direction_x: float):
	if current_jump_count > 0:
		current_jump_count -= 1
		character_body.velocity.y = -max_jump_impulse
		character_body.velocity.x = wall_jump_impulse * direction_x

func refill_jump():
	current_jump_count = max_jump_count
