extends CharacterBody2D


#variables
@export var MAX_SPEED = 300
@export var ACCELERATION = 1500
@export var FRICTION = 1200
@export var cooldown = 1
@onready var player = %Player
@onready var cam = %Camera2D

@onready var dash_cooldown = $dash_cooldown
@onready var axis = Vector2.ZERO
@onready var dash_timer = $dash_timer
@onready var gpu_particles_2d = $GPUParticles2D
@onready var gpu_particles_2d_2 = $Sprite2D/GPUParticles2D2

@onready var animation_player = $CanvasLayer/AnimationPlayer
var cursor_visible = false

func _ready():
	
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	gpu_particles_2d.emitting = false
	gpu_particles_2d_2.emitting = false
func _physics_process(delta):
	move(delta)
	if velocity != Vector2.ZERO:
		var direction = atan2(velocity.x, velocity.y)
		rotation = lerp_angle(rotation, atan2(velocity.x, -velocity.y), 50 * delta)



	
func get_input_axis():
	return Input.get_vector("left", "right", "up", "down")
	
	
func move(delta):
	
	axis = get_input_axis()
	
	if axis == Vector2.ZERO:
		apply_friction(FRICTION * delta)
	else:
		apply_movement(axis * ACCELERATION * delta)
		
	move_and_slide()


	
func apply_friction(amount):
	velocity = velocity.move_toward(Vector2.ZERO, amount)
		
		
func apply_movement(acceleration):
	velocity += acceleration
	velocity = velocity.limit_length(MAX_SPEED)
	
func _input(event):
	
	if Input.is_action_just_pressed("show_cursor") and cursor_visible==false:
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		cursor_visible = true
		
	elif Input.is_action_just_pressed("show_cursor") and cursor_visible==true:
		cursor_visible = false
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

	
	if Input.is_action_just_pressed("dash") and GlobalVariables.can_dash == true:
		dash_cooldown.start(cooldown)
		dash_timer.start(0.3)
		MAX_SPEED = 1400
		FRICTION = 0
		ACCELERATION = 100000000
		gpu_particles_2d.emitting = true
		gpu_particles_2d_2.emitting = true
		animation_player.play("shockwave")
		
		
func _on_dash_timer_timeout():
	MAX_SPEED = 300
	FRICTION = 1200
	ACCELERATION = 1500
	GlobalVariables.can_dash = false
	gpu_particles_2d.emitting = false
	gpu_particles_2d_2.emitting = false
	
func _on_dash_cooldown_timeout():
	GlobalVariables.can_dash = true
	
