extends Camera2D
#zooming variables
var zoom_speed = 100
var zoom_margin = 0.3
var zoom_min = 0.5
var zoom_max = 1
var player = null

var zoom_position = Vector2()
var zoom_factor = 1.0

#camera shake variable
@export var random_strength : float = 5.0
@export var shake_fade : float = 2.5
var random = RandomNumberGenerator.new()
var shake_strength : float = 0.0

func _ready():
	# Find the player node in the scene tree
	player = get_parent()

func apply_shake():
	shake_strength = random_strength
	
func random_offset() -> Vector2:
	return Vector2(random.randf_range(-shake_strength, shake_strength) , random.randf_range(-shake_strength, shake_strength)  )
	
func _process(delta):
	
	if player:
		var player_direction = player.axis
		
	if Input.is_action_just_pressed("dash") and GlobalVariables.can_dash == true:
		if Input.is_action_pressed("up") or Input.is_action_pressed("down") or Input.is_action_pressed("left") or Input.is_action_pressed("right"): 
			apply_shake()
	if shake_strength > 0:
		shake_strength = lerpf(shake_strength, 0, shake_fade * delta)
		
		offset = random_offset()

	zoom.x = lerp(zoom.x, zoom.x * zoom_factor, zoom_speed * delta)
	zoom.y = lerp(zoom.y, zoom.y * zoom_factor, zoom_speed * delta)
	
	zoom.x = clamp(zoom.x, zoom_min, zoom_max)
	zoom.y = clamp(zoom.y, zoom_min, zoom_max)
func _input(event):
	if abs(zoom_position.x - get_global_mouse_position().x) > zoom_margin:
		zoom_factor = 1.0
	if abs(zoom_position.y - get_global_mouse_position().y) > zoom_margin:
		zoom_factor = 1.0
	if event  is InputEventMouseButton:
		if event.is_pressed():
			if event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
				zoom_factor -= 0.02
				zoom_position = get_global_mouse_position()
				
			if event.button_index == MOUSE_BUTTON_WHEEL_UP:
				zoom_factor += 0.02
				zoom_position = get_global_mouse_position()
				
