class_name Controllable
extends CharacterBody2D



@onready var selected_sprite := $SelectedSprite
var goal: Vector2
var goal_original: Vector2
var previous_goal: Vector2
var selected = false
var moused_over = false

@export var control_name = ""

func change_goal(new_goal: Vector2):
	previous_goal = goal
	goal = new_goal
	goal_original = new_goal
	
	
func go_back_goal():
	goal = previous_goal
	goal_original = previous_goal

func _ready():
	World.controllable.append(self)

func _physics_process(delta):
	if Input.is_action_just_pressed("move") and selected:
		change_goal(get_global_mouse_position())
	if Input.is_action_just_pressed("select") && selected == false && moused_over:
		selected = true
	if Input.is_action_just_pressed("select") && selected == true && not moused_over && not Input.is_action_pressed("multiSelect"):
		selected = false
		
	if abs(position.x - goal.x) < 5:
		velocity = Vector2(0,0)
		#agent.target_position = position + Vector2(randf_range(-10,10),randf_range(-10,10))
	else:
		var dest = goal
		var dir = dest - position
		velocity.x += dir.normalized().x * delta * 50
		#move_toward(position,agent.get_next_path_position(),delta)
		#position.x = move_toward(position.x,dest.x,delta*100)
		#position.y = move_toward(position.y,dest.y,delta*100)
	if not is_on_floor():
		velocity.y += 10000*delta
	else:
		velocity.y = 0.0
	#velocity -= velocity * 10 * delta
	move_and_slide()

func _process(delta):
	selected_sprite.visible = selected
	pass

func _on_mouse_exited():
	moused_over = false
	pass # Replace with function body.


func _on_mouse_entered():
	moused_over = true
	pass # Replace with function body.

func die():
	World.controllable.erase(self)
	queue_free()

func _on_meander_timer_timeout():
	if abs(position.x - goal.x) < 5:
		var prop_goal = position + Vector2(randf_range(-50,50),randf_range(-10,10))
		#var difference_x = prop_goal.x - goal_original.x
		
		if abs(prop_goal.x - goal_original.x) < 50:
			goal = prop_goal
