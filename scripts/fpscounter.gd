extends Label
@onready var fpscounter = $"."

func _process(delta):
	fpscounter.text = str(Engine.get_frames_per_second())
