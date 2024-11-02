extends Machine

@onready var deathTimer := $deathTimer

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#super._process(delta)
	pass

func _physics_process(delta):
	#super._physics_process(delta)
	
	
	for body in effectArea.get_overlapping_bodies():
		if body is Controllable:
			print("aaaaaaaaaaaaaaaaaa")
