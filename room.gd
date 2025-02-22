class_name Room
extends Node2D
@onready var room_area := $room_area
@onready var debug_label := $Label
@export var room_name = "UNNAMED ROOM"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	debug_label.text = room_name + "\n" + str(get_room_content()) 
	#print(debug_label.text)
	pass

func get_room_content():
	var list = room_area.get_overlapping_bodies()
	
	list.append(room_area.get_overlapping_areas())
	
	return list
