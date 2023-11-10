extends Node2D
var speed = 150

var dying_duration = 1
var dying_time = -1 
var dying_scale = 5

# Called when the node enters the scene tree for the first time.
func _ready():
	var reduction = float(randi_range(5, 10)) / 10
	speed = speed * reduction
	$VisionRange.finalise_range(25 / reduction)
	pass # Replace with function body.


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
	
