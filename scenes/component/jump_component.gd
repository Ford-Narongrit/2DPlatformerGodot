extends Node

@export var max_jump_count: int = 2
@export var jump_impulse: float = 400

var current_jump_count: int

func _ready():
	pass

func jump(character_body: CharacterBody2D):
	if current_jump_count > 0:
		current_jump_count -= 1
		character_body.velocity.y = -jump_impulse

func refill_jump():
	current_jump_count = max_jump_count
