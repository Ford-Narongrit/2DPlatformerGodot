extends State

@onready var player = $"../.."
@onready var animation_player = %AnimationPlayer

@onready var jump_component = %JumpComponent
@onready var velocity_component = %VelocityComponent
@onready var gravity_component = %GravityComponent

func enter():
	print("Air")
	if player == null:
		return
	animation_player.play("jump")

func update(_delta: float):
	# check state
	if player.is_on_floor():
		animation_player.play("landing")
		state_transition.emit(self, "Idle")
		return
	elif player.is_on_wall():
		state_transition.emit(self, "Wall")
		return
	
	# update
	gravity_component.apply_default_gravity(player)
	if player.velocity.y > 0:
		animation_player.play("fall")
	
	# get input
	if Input.is_action_just_pressed("dash"):
		state_transition.emit(self, "Dash")
	elif Input.is_action_just_pressed("jump"):
		jump_component.jump(player)
	elif Input.is_action_just_released("jump"):
		jump_component.jump_cut(player)
	elif not is_zero_approx(player.get_input_direction()):
		velocity_component.move(player, player.get_input_direction())
	else:
		velocity_component.stop(player)
	
	player.move_and_slide()
