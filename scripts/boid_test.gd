extends Node2D
@onready var ray_folder = $rayfolder.get_children()
var boids_i_see := []
var velocity := Vector2.ZERO
var speed := 10.0
var screensize : Vector2
var movv := 48

func _ready():
	var screen_size = get_viewport_rect().size
	randomize()
	
	
func _physics_process(delta):
	boids()
	check_collision()
	velocity = velocity.normalized() * speed
	move()
	rotation = lerp_angle(rotation, velocity.angle_to_point(Vector2.ZERO) , 0.4)


func boids():
	if boids_i_see:
		var number_of_boids := boids_i_see.size()
		var average_velocity := Vector2.ZERO
		var average_posittion := Vector2.ZERO
		var steer_away := Vector2.ZERO
		
		for boid in boids_i_see:
			average_velocity += boid.velocity
			average_posittion += boid.position
			steer_away -= (boid.global_position - global_position) * (movv/( global_position- boid.global_position).length())
		average_velocity /= number_of_boids
		velocity += (average_velocity - velocity) / 2
		
		average_posittion /= number_of_boids
		position += (average_posittion - position) / 2
		
		steer_away /= number_of_boids
		velocity += steer_away
		
	
func check_collision():
	for ray in ray_folder:
		var r : RayCast2D = ray
		if r.is_colliding():
			if r.get_collider().is_in_group("blocks"):
				var magnitude := (100 / (r.get_collision_point() - global_position).length_squared())
				velocity -= (r.cast_to.rotated(rotation) * magnitude)
	
func move():
	global_position += velocity
	if global_position.x < 0:
		global_position.x = screensize.x
	if global_position.x > screensize.x:
		global_position.x = 0
	if global_position.y < 0:
		global_position.y = screensize.y
	if global_position.y > screensize.y:
		global_position.y = 0


func _on_area_2d_area_entered(area):
	if area != self and area.is_in_group("boid"):
		boids_i_see.append(area)


func _on_area_2d_area_exited(area):
	if area:
		boids_i_see.erase(area)
