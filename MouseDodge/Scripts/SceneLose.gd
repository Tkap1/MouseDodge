extends Node

onready var scoreLabel = $VBoxContainer/LabelScore

func init(score):
	scoreLabel.text = "Score: "+str(score)
	

func _on_ButtonRestart_pressed():
	Global.setSceneGame(self)

func _input(event):
	if event.is_action_released("fullscreen"):
		OS.window_fullscreen = !OS.window_fullscreen
	if event.is_action_released("restart"):
		_on_ButtonRestart_pressed()
	if event.is_action_released("difficulty"):
		_on_ButtonDifficulty_pressed()

func _on_ButtonDifficulty_pressed():
	Global.setSceneDifficulty(self)
