extends Node

onready var scoreLabel = $VBoxContainer/LabelScore
onready var submitButton = $VBoxContainer/ButtonSubmit

var score = 0
var minScore = 5

func init(score):
	self.score = score
	scoreLabel.text = "Score: "+str(score)
	if not score >= 5:
		submitButton.disabled = true
	
func _input(event):
	if event.is_action_released("restart"):
		_on_ButtonRestart_pressed()
	if event.is_action_released("difficulty"):
		_on_ButtonDifficulty_pressed()
		
func _on_ButtonRestart_pressed():
	Global.setScene(Global.game)

func _on_ButtonDifficulty_pressed():
	Global.setScene(Global.difficulty)


func _on_ButtonSubmit_pressed():
	Global.setScene(Global.submit,true,score)
