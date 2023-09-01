extends RigidBody2D

const THRUST_Y = 100000
const THRUST_X = 50000
var torque = 10000
var rotation_direction = 0
var current_rotation = 0
var angle = deg_to_rad(0)
const ROTATION_STEP = 5

func _integrate_forces(state):
	if Input.is_action_pressed("jump"):
		angle = deg_to_rad(current_rotation)
		state.apply_force(Vector2(0 , -THRUST_Y))
		print("transform.basis " + str(transform))
	else:
		state.apply_force(Vector2.ZERO)
		rotation_direction = 0
	
	if Input.is_action_pressed("move_right"):
#		rotation_direction += ROTATION_STEP
#		current_rotation = current_rotation + rotation_direction
		state.apply_force(Vector2(THRUST_X , 0))
	if Input.is_action_pressed("move_left"):
#		rotation_direction -= ROTATION_STEP
#		current_rotation = current_rotation - rotation_direction
		state.apply_force(Vector2(-THRUST_X , 0))
	
	# rotation
	if rotation_direction != 0:
		state.apply_torque(rotation_direction * torque)
