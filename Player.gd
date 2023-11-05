extends Node2D
var speed = 400

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):

	var direction = Vector2(0, 0)
	if Input.is_action_pressed('ui_left'):
		direction.x -= 1
		
	if Input.is_action_pressed('ui_right'):
		direction.x += 1
		
	if Input.is_action_pressed('ui_up'):
		direction.y -= 1

	if Input.is_action_pressed('ui_down'):
		direction.y += 1
		
	if direction.abs():
		position += speed * delta * direction.normalized()

# bad naming: this is enemy body
func _on_area_2d_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	print('oh my')
	if area.is_in_group("enemy_vision"): 
		queue_free()
	
