extends Area2D

signal attacked 

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func attacked_emit():
	attacked.emit()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
