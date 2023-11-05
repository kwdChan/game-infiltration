extends Area2D

var radius = 200
var color = Color(1.0, 0.0, 0.0, 0.2)

func circle_arc_poly(radius, total_angle, centre_angle = 180):
	var nb_points = 32
	var points_arc = PackedVector2Array()
	var center = Vector2(0, 0)
	points_arc.push_back(center)
	
	var angle_from = centre_angle - total_angle/2
	var angle_to = centre_angle + total_angle/2
	for i in range(nb_points + 1):
		var angle_point = deg_to_rad(angle_from + i * (angle_to - angle_from) / nb_points - 90)
		points_arc.push_back(center + Vector2(cos(angle_point), sin(angle_point)) * radius)
	return points_arc

var points_arc = circle_arc_poly(radius, 45)

func _draw():
	draw_polygon(points_arc, PackedColorArray([color]))

# Called when the node enters the scene tree for the first time.
func _ready():
	$CollisionPolygon2D.polygon = points_arc
	
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	pass
