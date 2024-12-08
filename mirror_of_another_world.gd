extends Machine

@onready var sanityTimer := $sanityTimer

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if sanityTimer.is_stopped():
		for body in effectArea.get_overlapping_bodies():
			if body is Controllable:
				sanityTimer.start(1)
	
	pass


func _on_sanity_timer_timeout():
 	for body in effectArea.get_overlapping_bodies():
			if body is Controllable:
				body.sanity -= 0.5
				print(body.sanity)
	pass # Replace with function body.
