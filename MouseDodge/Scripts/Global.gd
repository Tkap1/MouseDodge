extends Node

var width = 800
var height = 450
var musicPlayback = 0.0
var muteMusic = false

const baseTime = 0.2
const minSpeed = 100
const maxSpeed = 300
const minSize = 16
const maxSize = 32

var timerMult
var speedMultMin
var speedMultMax
var sizeMultMax

func setScene(new, old):
	var root = get_node("/root")
	old.queue_free()
	root.add_child(new)
	
func showFPS():
	print(Performance.get_monitor(Performance.TIME_FPS))
	
func setSceneGame(old):
	var new = load("res://Scenes/Game.tscn").instance()
	setScene(new,old)
	
func setSceneMain(old):
	var new = load("res://Scenes/SceneMain.tscn").instance()
	setScene(new,old)
	
func setSceneDifficulty(old):
	var new = load("res://Scenes/SceneDifficulty.tscn").instance()
	setScene(new,old)
	
func setSceneLose(old,score):
	var new = load("res://Scenes/SceneLose.tscn").instance()
	setScene(new,old)
	new.init(score)
	
func setSceneWin(old,score):
	var new = load("res://Scenes/SceneWin.tscn").instance()
	setScene(new,old)
	new.init(score)
	
	
func setEasy():
	timerMult = 1.0
	speedMultMin = 1.0
	speedMultMax = 1.0
	sizeMultMax = 1.0
	
func setNormal():
	timerMult = 1.5
	speedMultMin = 1.0
	speedMultMax = 1.33
	sizeMultMax = 1.5
	
func setHard():
	timerMult = 2
	speedMultMin = 0.5
	speedMultMax = 1.66
	sizeMultMax = 2
	
	
func getSpawnTime():
	return baseTime / timerMult
	
func getSpeed():
	return int(rand_range(minSpeed*speedMultMin,maxSpeed*speedMultMax))
	
func getSize():
	return int(rand_range(minSize,maxSize*sizeMultMax))