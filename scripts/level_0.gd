extends Node2D
@export var number := 30
@export var margin := 100
var screen_size : Vector2

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	randomize()
	for i in number:
		spawn_boid()
func spawn_boid():
	var boid : Area2D = preload("res://Scenes/boid_test.tscn").instantiate()
	$boid_folder.add_child(boid)
	boid.modulate = Color(randf(),randf(),randf(),1)
	boid.global_position = Vector2((randf_range(margin, screen_size.x - margin)), (randf_range(margin, screen_size.y - margin)))
