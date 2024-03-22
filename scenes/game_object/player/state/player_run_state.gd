extends State

@onready var player = $"../.."
@onready var animation_player = %AnimationPlayer

@onready var jump_component = %JumpComponent
@onready var velocity_component = %VelocityComponent

func enter():
	print("Run")
	if player == null:
		return
	animation_player.play("run")

func update(_delta: float):
	# check state
	if not player.is_on_floor():
		state_transition.emit(self, "Air")
		return
	
	# update
	
	# get input
	if not is_zero_approx(player.get_input_direction()):
		velocity_component.move(player, player.get_input_direction())
	else:
		state_transition.emit(self, "Idle")
	
	if Input.is_action_just_pressed("jump"):
		jump_component.jump(player)
		state_transition.emit(self, "Air")
	elif Input.is_action_just_pressed("dash"):
		state_transition.emit(self, "Dash")
	
	player.move_and_slide()
