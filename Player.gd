extends Node2D
var speed = 400
var sprite_direction = 'up'
var sprite_state = 'idle'
var attack_ready = true
var attack_animate_total_duration = 0.1
var attack_animate_current_time = -1.0
var frame: int
var frame_progress: float
var horizontal_margin: Vector2
var margin_ratio = 0.05


signal attacking

# Called when the node enters the scene tree for the first time.
func _ready():
	var screen_rect = get_viewport_rect()
	var margin_size = int(screen_rect.size.x * margin_ratio)
	horizontal_margin = Vector2(screen_rect.position.x + margin_size, screen_rect.end.x - margin_size)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):

	var direction = Vector2(0, 0)
	
	if Input.is_action_pressed('ui_up'):
		direction.y -= 1
		sprite_direction = 'up'

	if Input.is_action_pressed('ui_down'):
		direction.y += 1
		sprite_direction = 'down'
		
	# L/R overwrite U/D if pressed together
	if Input.is_action_pressed('ui_left'):
		direction.x -= 1
		sprite_direction = 'left'
		
	if Input.is_action_pressed('ui_right'):
		direction.x += 1
		sprite_direction = 'right'
		
	# if walking
	if direction.abs():
		sprite_state = 'walk'
		position += speed * delta * direction.normalized()
	else: 
		sprite_state = 'idle'
		
	position.x = clamp(position.x,horizontal_margin[0], horizontal_margin[1])
		
	if Input.is_action_just_pressed("spacebar"):

		# attack_animate_current_frame is set if attacked 
		spacebar_handler()
		
	if attack_animate_current_time > -1 :
		
		sprite_state = 'attack'
		attack_animate_current_time += delta
		
		if attack_animate_current_time > attack_animate_total_duration:

			# this will end the attack animate
			attack_animate_current_time = -1
	
	frame = $BodyArea2D/PlayerSprite.get_frame()
	frame_progress = $BodyArea2D/PlayerSprite.get_frame_progress()
	
	$BodyArea2D/PlayerSprite.play(sprite_state + "_" + sprite_direction)
	$BodyArea2D/PlayerSprite.set_frame_and_progress(frame, frame_progress)
	

func spacebar_handler():
	if attack_ready:
		attack_ready = false
		attacking.emit()
		$BodyArea2D/AttackCD.start()
		
		# this will trigger the attack animate
		attack_animate_current_time = 0


# bad naming: this is enemy body
func _on_area_2d_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	if area.is_in_group("enemy_vision"): 
		#queue_free()
		pass

func _on_attack_cd_timeout():
	attack_ready = true
