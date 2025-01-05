extends Machine

@onready var sanityTimer := $sanityTimer

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if sanityTimer.is_stopped():
		
		for body in effectArea.get_overlapping_bodies():
			#print(body)
			if body is Controllable:
				print("started")
				sanityTimer.start(1)
	super(delta)


func _on_sanity_timer_timeout():
	print("timed")
	for body in effectArea.get_overlapping_bodies():
		if body is Controllable:
			print("changed")
			body.change_sanity(body.sanity - 0.003)
	pass # Replace with function body.
