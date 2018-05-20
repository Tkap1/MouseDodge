extends Node



func _on_ButtonEasy_pressed():
	Global.setEasy()
	startGame()


func _on_ButtonNormal_pressed():
	Global.setNormal()
	startGame()


func _on_ButtonHard_pressed():
	Global.setHard()
	startGame()

func startGame():
	Global.setSceneGame(self)
	
func _input(event):
	if event.is_action_released("fullscreen"):
		OS.window_fullscreen = !OS.window_fullscreen