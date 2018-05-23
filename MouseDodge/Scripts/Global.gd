extends Node

var game = preload("res://Scenes/Game.tscn")
var main = preload("res://Scenes/SceneMain.tscn")
var difficulty = preload("res://Scenes/SceneDifficulty.tscn")
var lose = preload("res://Scenes/SceneLose.tscn")
var win = preload("res://Scenes/SceneWin.tscn")
var submit = preload("res://Scenes/SceneSubmit.tscn")
var leaderboard = preload("res://Scenes/SceneLeaderboard.tscn")

var savePath = "user://save.txt"

var width = 800
var height = 450
var musicPlayback = 0.0
var muteMusic = false
var removeParticles

const baseTime = 0.2
const minSpeed = 100
const maxSpeed = 300
const minSize = 16
const maxSize = 32

var timerMult
var speedMultMin
var speedMultMax
var sizeMultMax
var difficultyStr

var currentScene

func _ready():
	removeParticles = "HTML" in OS.get_name()
	currentScene = get_tree().current_scene

func _input(event):
	if event.is_action_released("fullscreen"):
		OS.window_fullscreen = !OS.window_fullscreen
		
	if event.is_action_released("particles"):
		if not "Game" in currentScene.name:
			removeParticles = !removeParticles
	

func setScene(new, init=false, value=0):
	var newScene = new.instance()
	call_deferred("changeScene",newScene,init,value)

func changeScene(newScene, init=false, value=0):
	currentScene.free()
	currentScene = newScene
	get_tree().get_root().add_child(currentScene)
	get_tree().set_current_scene(currentScene)
	if init:
		currentScene.init(value)
	
func setEasy():
	timerMult = 1.0
	speedMultMin = 1.0
	speedMultMax = 1.0
	sizeMultMax = 1.0
	difficultyStr = "Easy"
	
func setNormal():
	timerMult = 1.5
	speedMultMin = 1.0
	speedMultMax = 1.33
	sizeMultMax = 1.5
	difficultyStr = "Normal"
	
func setHard():
	timerMult = 2
	speedMultMin = 0.5
	speedMultMax = 1.66
	sizeMultMax = 2
	difficultyStr = "Hard"
	
	
func getSpawnTime():
	return baseTime / timerMult
	
func getSpeed():
	return int(rand_range(minSpeed*speedMultMin,maxSpeed*speedMultMax))
	
func getSize():
	return int(rand_range(minSize,maxSize*sizeMultMax))
	
func saveScore(pName, pScore):
	
	var saveFile = getSave()
	
	saveFile.set_value(pName,"score",pScore) 
	saveFile.set_value(pName,"difficulty",difficultyStr) 
	 
	saveFile.save(savePath)
	
func getSave():
	var saveFile = ConfigFile.new()
	saveFile.load(savePath)
	return saveFile
	