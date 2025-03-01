class_name BreachingAnomaly
extends CharacterBody2D
#who it attacks
var faction = 1
var room: Room


func _physics_process(delta):
	
	if not is_on_floor():
		velocity.y = 50
		
	var cont_in_room := []
	
	if room != null:
		var stuff_in_room = room.get_room_content()
		for body in stuff_in_room:
			if body is Controllable:
				print ("I sEe YoU ", body)
				cont_in_room.append(body)
	
	var lowest_one_seen: Controllable = null
	var lowest_dist: float = 987987987
	for cont in cont_in_room:
		var pos_of_cont = cont.position
		var dist = position.distance_to(pos_of_cont)
		if dist < lowest_dist:
			lowest_one_seen = cont
			lowest_dist = dist
	
	if lowest_one_seen != null:
		var dir = lowest_one_seen.position - position
		dir = dir.normalized()
		velocity.x = dir.x * 30
	
	move_and_slide()
	
	pass
