extends Control
@onready var submit_text_box:= $TextEdit
var util_mode_active

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("util-mode-toggle"):
		util_mode_active = not util_mode_active
		
		visible = util_mode_active
		if util_mode_active == false:
			submit_text_box.text = ""
		
		print(util_mode_active)
		
	if util_mode_active:
		if Input.is_action_just_pressed("submit-util"):
			print(submit_text_box.text)
			var s: String = submit_text_box.text
			s = s.trim_suffix("\n")
			
			if s == "crash":
				get_tree().quit(0)
			submit_text_box.text = ""
			
	pass
