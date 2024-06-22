extends Node
var player_node : Node = null
var can_dash = true
var inventory = []
signal invetory_updated
func _ready():
	inventory.resize(30)
func add_item():
	invetory_updated.emit()

func remove_item():
	invetory_updated.emit()
func set_player_reference(player):
	player_node = player
