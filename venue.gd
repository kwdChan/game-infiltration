extends Node2D
@export var enemy_scene: PackedScene


# Called when the node enters the scene tree for the first time.
func _ready():
	$EnemySpwanTimer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var screen_pos_y = get_viewport_rect().position.y
	print(screen_pos_y)
	$EnemySpwanPath2D.position.y = screen_pos_y + 200
	pass


func _on_enemy_spwan_timer_timeout():
	
	var enemy = enemy_scene.instantiate()
	var node = get_node("EnemySpwanPath2D/EnemyLoc")
	node.progress_ratio = randf()
	
	enemy.position = node.position 

	add_child(enemy)
	
	
