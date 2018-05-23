extends Node

onready var scoreLabel = $VBoxContainer/LabelScore
onready var subName = $VBoxContainer/LineEdit
var score = 0

func init(score):
	self.score = score
	scoreLabel.text = "Score: "+str(score)

func _on_ButtonSubmit_pressed():
	if subName.text.length() > 2:
		Global.saveScore(subName.text, score)
		Global.setScene(Global.leaderboard)