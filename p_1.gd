class_name Controllable
extends CharacterBody2D


@onready var meander_timer := $MeanderTimer
@onready var selected_sprite := $SelectedSprite
@onready var sprite := $Sprite2D
var goal: Vector2
var goal_original: Vector2
var previous_goal: Vector2
var selected = false
var moused_over = false
var meander = true
@onready var area := $Area2D
@export var control_name = ""
var dead:= false
var fortitude = 1
var prudence = 1
var temperence = 1
var justice = 1
var health = 1.0
var sanity = 1.0
var soul = 1.0
var startingPos: Vector2
@onready var sanityText := $Label
var move_speed = 90
var max_sanity = sanity


func change_goal(new_goal: Vector2):
	previous_goal = goal
	goal = new_goal
	goal_original = new_goal
	
	
func go_back_goal():
	goal = previous_goal
	goal_original = previous_goal

func _ready():
	startingPos = position
	World.controllable.append(self)

func _physics_process(delta):
	if Input.is_action_just_pressed("move") and selected:
		change_goal(get_global_mouse_position())
	if Input.is_action_just_pressed("select") && selected == false && moused_over && sanity > 0.01:
		selected = true
	if Input.is_action_just_pressed("select") && selected == true && not moused_over && not Input.is_action_pressed("multiSelect"):
		selected = false
		
	if abs(position.x - goal.x) < 5:
		velocity = Vector2(0,0)
		#agent.target_position = position + Vector2(randf_range(-10,10),randf_range(-10,10))
	else:
		if not dead:
			var dest = goal
			var dir = dest - position
			var am = move_speed
			if sanity <= 0: 
				am = (move_speed * temperence + (max_sanity * 100))
			velocity.x = dir.normalized().x * am
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
	if health <= 0:
		die()
	pass

func _on_mouse_exited():
	moused_over = false
	pass # Replace with function body.


func _on_mouse_entered():
	moused_over = true
	pass # Replace with function body.

func die():
	#World.controllable.erase(self)
	#queue_free()
	dead = true
	if sprite.rotation == 0:
		sprite.rotate(rad_to_deg(90))
	
	
	pass

func change_sanity(new_sanity):

	if new_sanity <= 0.0001:
		meander_timer.wait_time = 0.5
	sanity = new_sanity
	sanityText.text = str(sanity)

func _on_meander_timer_timeout():
	
	var overlappingMachine = false
	
	
	for body in area.get_overlapping_areas():
		var p_machine = body.get_parent()
		if p_machine is Machine and p_machine.attached_controllable == self:
			overlappingMachine = true
	if meander and not overlappingMachine and not dead:
		if abs(position.x - goal.x) < 5:
			
			var prop_goal = position + Vector2(randf_range(-50,50),randf_range(-10,10))
			if sanity <= 0.01:
				prop_goal = position + Vector2(randf_range(-250,250),randf_range(-10,10))
				print(control_name,prop_goal)
			#var difference_x = prop_goal.x - goal_original.x
			
			if abs(prop_goal.x - goal_original.x) < 50 or true:
				goal = prop_goal
