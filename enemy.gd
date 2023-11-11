extends Node2D
var speed = 150.0
var dying_duration = 1.0
var dying_time = -1.0
var dying_scale = 5
var enemy_time_sep = 2.0

func _exit_tree():
	get_parent().enemy_freed()

# Called when the node enters the scene tree for the first time.
func _ready():
	get_parent().enemy_created()

	
func finalise(order, xloc, time_offset):
	var rand_factor = randf_range(0.5, 1)
	speed = speed * rand_factor
	$VisionRange.finalise_range(25 / rand_factor)
	
	position.x = xloc
	
	var time_before_reaching = order * enemy_time_sep - time_offset
	
	position.y = -speed * time_before_reaching
	
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.y += speed * delta 
	
	if dying_time > -1:
		$AnimatedSprite2D.play('dead')
		$AnimatedSprite2D.scale = Vector2(10, 10)
		$AnimatedSprite2D.offset = Vector2(0, 0)
		dying_time += delta
		
	if dying_time > dying_duration:
		
		queue_free()


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()


func _on_body_attacked():
	# this starts the dying animation 
	dying_time = 0 
	$VisionRange/CollisionPolygon2D.disabled = true
	$VisionRange.hide()
	
