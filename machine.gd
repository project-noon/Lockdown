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
		if effectArea.get_overlapping_bodies().find(attached_controllable):
			attached_controllable.position = teleportArea.global_position
			attached_controllable.change_goal(attached_controllable.startingPos)
			attached_controllable = null
	
	pass # Replace with function body.
