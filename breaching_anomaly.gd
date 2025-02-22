extends CharacterBody2D



func _physics_process(delta):
	
	if not is_on_floor():
		velocity.y = 50
		
		
	
	
	move_and_slide()
	
	pass
