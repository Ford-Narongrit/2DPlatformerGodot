extends State

@onready var player = $"../.."
@onready var animation_player = %AnimationPlayer

@onready var dash_component = %DashComponent

func enter():
	print("Dash")
	if player == null:
		return
	animation_player.play("dash")
	if player.is_on_wall():
		dash_component.start_dash(player, -player.face_direction)
	else:
		dash_component.start_dash(player, player.face_direction)

func update(_delta: float):
	# check state
	if dash_component.is_dashing():
		dash_component.dashing()
	elif not player.is_on_floor():
		state_transition.emit(self, "Air")
		return
	else:
		state_transition.emit(self, "Idle")
		return
	
	# update
	
	# get input
	
	player.move_and_slide()
