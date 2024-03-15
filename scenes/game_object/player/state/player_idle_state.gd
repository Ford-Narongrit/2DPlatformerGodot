extends State

@onready var player = $"../.."
@onready var animation_player = %AnimationPlayer

@onready var jump_component = %JumpComponent
@onready var dash_component = %DashComponent
@onready var velocity_component = %VelocityComponent

func enter():
	print("Idle")
	if player == null:
		return
	animation_player.play("idle")
	velocity_component.stop(player)
	jump_component.refill_jump()
	dash_component.start_refill_dash()

func update(_delta: float):
	if not player.is_on_floor():
		state_transition.emit(self, "Air")
		return
		
	velocity_component.stop(player)
	
	if Input.is_action_just_pressed("jump"):
		jump_component.jump(player)  
		state_transition.emit(self, "Air")
	elif not is_zero_approx(player.get_input_direction()):
		state_transition.emit(self, "Run")
	elif Input.is_action_just_pressed("dash"):
		state_transition.emit(self, "Dash")
	
	player.move_and_slide()
