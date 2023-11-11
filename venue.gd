extends Node2D

# settings
@export var enemy_scene: PackedScene
var ENEMY_X_RANGE_MARGIN_RATIO = 0.05
var ENEMY_BUFFER_SIZE = 50

# to be used
var enemy_x_range: Vector2
var enemy_order = 0
var enemy_count = 0
var start_time_msec: int

# Called when the node enters the scene tree for the first time.
func _ready():
	var viewport_rect = get_viewport_rect()
	var margin = ENEMY_X_RANGE_MARGIN_RATIO*viewport_rect.size.x
	enemy_x_range = Vector2(viewport_rect.position.x+margin, viewport_rect.end.x-margin)
	
	start_time_msec = Time.get_ticks_msec()



func _process(delta):
	if enemy_count < ENEMY_BUFFER_SIZE:
		create_enemy()
		
	


func enemy_freed():
	enemy_count -= 1
	
func enemy_created():
	enemy_count += 1


func create_enemy():
	var enemy = enemy_scene.instantiate()
	var time_offset = float(Time.get_ticks_msec() - start_time_msec)/1000
	enemy.finalise(enemy_order, get_range_x_loc(), time_offset)
	enemy_order += 1
	add_child(enemy)
	
	
func get_range_x_loc():
	return randf_range(enemy_x_range[0], enemy_x_range[1])
