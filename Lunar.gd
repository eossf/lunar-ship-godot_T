extends RigidBody2D

const TORQUE = 200000
const ROTATION_STEP = 20
const THRUST_STEP = 5000
const THRUST_MAX = 50000

var thrust = 0
var current_rotation = 0
var latest_rotation = 0
var angle = 0

func _integrate_forces(state):
	if Input.is_action_pressed("jump"):
		thrust += THRUST_STEP
		thrust = clamp(thrust, 0, THRUST_MAX)
		state.apply_force(Vector2(0 , -thrust))
	else:
		thrust = 0
		current_rotation = 0
		angle = 0
		state.apply_force(Vector2.ZERO)
	
	if Input.is_action_pressed("move_right"):
		if sign(latest_rotation) != sign(current_rotation):
			current_rotation = 0
		current_rotation += ROTATION_STEP
		latest_rotation = current_rotation
	if Input.is_action_pressed("move_left"):
		if sign(latest_rotation) != sign(current_rotation):
			current_rotation = 0
		current_rotation -= ROTATION_STEP
		latest_rotation = current_rotation
	# rotation
	if current_rotation != 0:
		angle = deg_to_rad(current_rotation)
		state.apply_torque(angle * TORQUE)
	else:
		state.apply_torque(angle * TORQUE)
		state.apply_force(Vector2(thrust/5 * global_rotation , 0))
		
