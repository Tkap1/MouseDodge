extends Node

onready var vBoxName = $HBoxContainer/VBoxName
onready var vBoxScore = $HBoxContainer/VBoxScore
onready var vBoxDifficulty = $HBoxContainer/VBoxDifficulty

var font = preload("res://Assets/font128.tres")

func _ready():
	var saveFile = Global.getSave()
	var arr = getOrderedSaves(saveFile)
	for i in range(min(10,arr.size())):
		var pName = arr[i][0]
		var score = arr[i][1]
		var difficulty = saveFile.get_value(arr[i][0], "difficulty")
		newScore(pName,score,difficulty)
	
	
func newScore(name,score,difficulty):
	var labelName = Label.new()
	labelName.align = Label.ALIGN_CENTER
	labelName.valign = Label.VALIGN_CENTER
	labelName.add_font_override("font", font)
	labelName.text = name
	vBoxName.add_child(labelName)
	
	var labelScore = Label.new()
	labelScore.align = Label.ALIGN_CENTER
	labelScore.valign = Label.VALIGN_CENTER
	labelScore.add_font_override("font", font)
	labelScore.text = str(score)
	vBoxScore.add_child(labelScore)
	
	var labelDifficulty = Label.new()
	labelDifficulty.align = Label.ALIGN_CENTER
	labelDifficulty.valign = Label.VALIGN_CENTER
	labelDifficulty.add_font_override("font", font)
	labelDifficulty.text = difficulty
	vBoxDifficulty.add_child(labelDifficulty)
	
func sort(a, b):
	if a[1] > b[1]:
		return true
	return false

func getOrderedSaves(saveFile):
	var sections = saveFile.get_sections()
	var secArr = []
	for i in range(sections.size()):
		secArr.append([sections[i],saveFile.get_value(sections[i],"score")])
	
	secArr.sort_custom(self, "sort")
	return secArr

func _on_ButtonBack_pressed():
	Global.setScene(Global.difficulty)
