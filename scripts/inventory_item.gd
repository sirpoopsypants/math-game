@tool
extends Node2D

@export var item_name = ""
@export var item_texture = ""
@export var item_description = ""
@export var item_type = ""
var scene_path : String ="res://Scenes/inventory_item.tscn"
@onready var icon_sprite = $Sprite2D



# Called when the node enters the scene tree for the first time.
func _ready():
	if not Engine.is_editor_hint():
		icon_sprite.texture = item_texture

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Engine.is_editor_hint():
		icon_sprite.texture = item_texture
