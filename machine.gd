extends Node2D

# cool comment!


var mouseover = false
var display_something = false
@onready var display_menu := $VBoxContainer
@onready var selection_list_menu := $VBoxContainer2
var attached_controllable: Controllable

func _ready():
	selection_list_menu.visible = false

func _on_area_2d_mouse_entered():
	mouseover = true
	pass # Replace with function body.


func _on_area_2d_mouse_exited():
	mouseover = false
	pass # Replace with function body.

func _process(delta):
	if mouseover and Input.is_action_just_pressed("select"):
		display_something = true
	else:
		if Input.is_action_just_pressed("select"):
			display_something = false
			selection_list_menu.visible = false
	display_menu.visible = display_something


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
