extends State

@onready var player = $"../.."
@onready var animation_player = %AnimationPlayer

@onready var gravity_component = %GravityComponent
@onready var jump_component = %JumpComponent
@onready var velocity_component = %VelocityComponent

func enter():
	print("Wall")
	if player == null:
		return
	player.velocity.y = 0
	jump_component.refill_jump()

func update(_delta: float):
	# check state
	if player.is_on_floor():
		state_transition.emit(self, "Idle")
		return
	elif not player.is_on_wall():
		state_transition.emit(self, "Air")
		return
	
	# update
	gravity_component.apply_wall_gravity(player)
	
	# get input
	if Input.is_action_just_pressed("jump"):
		jump_component.wall_jump(player, -player.face_direction)  
		state_transition.emit(self, "Air")
	elif not is_zero_approx(player.get_input_direction()):
		velocity_component.move(player, player.get_input_direction())
	elif Input.is_action_just_pressed("dash"):
		state_transition.emit(self, "Dash")
	player.move_and_slide()
