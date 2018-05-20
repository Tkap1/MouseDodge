extends Node

func _ready():
	randomize()
	OS.window_fullscreen = true

func _on_ButtonStart_pressed():
	Global.setSceneDifficulty(self)
	
func _input(event):
	if event.is_action_released("fullscreen"):
		OS.window_fullscreen = !OS.window_fullscreen
