class_name World
extends Node2D

static var controllable: Array[Controllable]

func _process(delta):
	if Input.is_action_just_pressed("debug spawn guy"):
		var goober: Controllable = preload("res://p1.tscn").instantiate()
		#goober.global_position = Vector2(0,0)
		goober.control_name = "fyfyfgyfgyfgyfgyfgyfgyfgyfgy"
		add_child(goober)
