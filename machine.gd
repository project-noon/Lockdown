class_name Machine
extends Node2D



var mouseover = false
var display_something = false
@onready var display_menu := $VBoxContainer
@onready var selection_list_menu := $VBoxContainer2
var attached_controllable: Controllable
@onready var teleportArea := $TeleportArea
@onready var waitTime := $Timer
@onready var teleportDest := $TeliportDest
@onready var effectArea := $Area2D
@onready var stopButton := $stop
var worktype = 1 # 1 is instict, 2 is insight, 3 is attachment, 4 is repression, 5 is psychology, 6 is special\
var special = false
@onready var scrollWorktypeL := $VBoxContainer/HBoxContainer/scrollWorktypeL
@onready var scrollWorktypeR := $VBoxContainer/HBoxContainer/scrollWorktypeR
@onready var worktypeName := $VBoxContainer/HBoxContainer/worktypeName


func _ready():
	selection_list_menu.visible = false

func _on_area_2d_mouse_entered():
	mouseover = true
	pass # Replace with function body.


func _on_area_2d_mouse_exited():
	mouseover = false
	pass # Replace with function body.

func _process(delta):
	if mouseover and Input.is_action_just_pressed("select") and attached_controllable == null:
		display_something = true
	else:
		if Input.is_action_just_pressed("select"):
			display_something = false
			selection_list_menu.visible = false
			
	if waitTime.is_stopped():
		for body in teleportArea.get_overlapping_bodies():
			if body is Controllable:
				waitTime.start(2)
			
	display_menu.visible = display_something
	stopButton.visible = attached_controllable != null


func _on_button_pressed():
	selection_list_menu.visible = true
	display_something = false
	
	for child in selection_list_menu.get_children():
		child.queue_free()
	
	for controllable in World.controllable:
		var button_to_add = Button.new()
		
		button_to_add.text = controllable.control_name
		
		var press_button_f = func(): for cont in World.controllable: if cont.control_name == button_to_add.text:
			cont.change_goal(position)
			if attached_controllable != null:
				attached_controllable.go_back_goal()
			attached_controllable = cont
			#cont.goal_original = position
			#cont.goal = position
		
		button_to_add.pressed.connect(press_button_f)
		
		selection_list_menu.add_child(button_to_add)
	
	
	
	pass # Replace with function body.


func _on_timer_timeout() -> void:
	for body in teleportArea.get_overlapping_bodies():
		if body is Controllable and attached_controllable == body:
			body.position = teleportDest.global_position
			body.change_goal(teleportDest.global_position)
			#body.meander = false
			break
	pass # Replace with function body.


func _on_teleport_area_body_entered(body: Node2D) -> void:
	if body is Controllable:
		waitTime.start(2)
	pass # Replace with function body.


func _on_stop_pressed():
	
	if attached_controllable != null:
		if effectArea.get_overlapping_bodies().find(attached_controllable) != -1:
			attached_controllable.position = teleportArea.global_position
		attached_controllable.change_goal(attached_controllable.startingPos)
		attached_controllable = null
	
	pass # Replace with function body.


func _on_scroll_worktype_l_pressed():
	worktype -=1
	update_worktype_name()
	pass # Replace with function body.

func update_worktype_name(): 
	if worktype <= 0:
		if special == true:
			worktype = 6
		else:
			worktype = 5
	
	if worktype >= 6:
		if special == true && worktype >= 7:
			worktype = 1
		else:
			worktype = 1
	
	if worktype == 1:
		worktypeName.text = "instinct"
	if worktype == 2: 
		worktypeName.text = "insight"
	if worktype == 3: 
		worktypeName.text = "attachment"
	if worktype == 4: 
		worktypeName.text = "repression"
	if worktype == 5: 
		worktypeName.text = "psychology"
	if worktype == 6: 
		worktypeName.text = "special"

func _on_scroll_worktype_r_pressed():
	worktype +=1
	update_worktype_name()
	pass # Replace with function body.
