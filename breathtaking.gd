extends Machine

@onready var deathTimer := $deathTimer


# Called when the node enters the scene tree for the first time.
func _ready():
	super()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#super._process(delta)
	super(delta)
	pass

func _physics_process(delta):
	#super(delta)
	#super._physics_process(delta)
	
	if deathTimer.is_stopped():
		for body in effectArea.get_overlapping_bodies():
			if body is Controllable:
				deathTimer.start(5)
				


func _on_death_timer_timeout() -> void:
	var deathRoll = randi_range(1, 25)
	
	print(deathRoll)
	
	for body in effectArea.get_overlapping_bodies():
		if body is Controllable:
			
			
			if deathRoll > body.temperence * 5:
				
				body.die()
				
	pass # Replace with function body.
