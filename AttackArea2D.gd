extends Area2D


func _ready():
	pass

func _process(delta):
	pass

func attack():
	for area_ in get_overlapping_areas():
		if area_.is_in_group('enemy'):
			area_.attacked_emit()
	
func _on_player_attacking():
	attack() # Replace with function body.
