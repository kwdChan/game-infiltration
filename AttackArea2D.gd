extends Area2D


var attack_ready = true


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("spacebar"):
		if attack_ready:
			attack_ready = false
			attack()
			$AttackCD.start()
		
func attack():
	for area_ in get_overlapping_areas():
		if area_.is_in_group('enemy'):
			area_.attacked_emit()


func _on_attack_cd_timeout():
	
	attack_ready = true


