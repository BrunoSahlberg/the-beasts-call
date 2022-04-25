extends Actor

func _physics_process(_delta):
	var is_jump_released:= Input.is_action_just_released("jump") and velocity.y < 0
	
	var direction := get_input_direction()
	
	velocity = calculate_move_velocity(velocity, direction, speed, is_jump_released)
	velocity = move_and_slide(velocity, FLOOR_NORMAL)


func get_input_direction() -> Vector2:
	var horizontal:= Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	
	return Vector2(horizontal,
	-1.0 if Input.is_action_just_pressed("jump") and is_on_floor() else 0.0)


func calculate_move_velocity(linear_velocity: Vector2, direction: Vector2, speed: Vector2, 
															is_jump_released: bool) -> Vector2:
	var move_velocity:= linear_velocity
	
	move_velocity.x = direction.x * speed.x
	move_velocity.y += gravity * get_physics_process_delta_time()
	
	if direction.y == -1.0:
		move_velocity.y = speed.y * direction.y
		
	if is_jump_released:
		move_velocity.y = 0.0
	
	return move_velocity
