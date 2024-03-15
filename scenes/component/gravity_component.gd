extends Node

var gravity: float

func _ready():
	gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func apply_gravity(character_body: CharacterBody2D):
	character_body.velocity.y += gravity * get_process_delta_time()
