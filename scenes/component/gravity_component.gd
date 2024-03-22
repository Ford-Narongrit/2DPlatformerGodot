extends Node

@export var default_gravity_force: float = 980
@export var max_default_gravity_velocity: float = 1000;
@export var wall_gravity_force: float = 250
@export var max_wall_gravity_velocity: float = 300;

var project_gravity

func _ready():
	project_gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func apply_default_gravity(character_body: CharacterBody2D): 
	if character_body.velocity.y < max_default_gravity_velocity:
		character_body.velocity.y += default_gravity_force * get_process_delta_time()

func apply_wall_gravity(character_body: CharacterBody2D):
	if character_body.velocity.y < max_wall_gravity_velocity:
		character_body.velocity.y += wall_gravity_force * get_process_delta_time()
