extends Node

func _ready():
	randomize()
#	OS.window_fullscreen = true


func _on_ButtonStart_pressed():
	Global.setScene(Global.difficulty)
