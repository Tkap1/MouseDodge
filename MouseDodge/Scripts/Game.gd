extends Node2D

onready var projectile = load("res://Scenes/Projectile.tscn")
onready var player = $Player
onready var sprites = $Sprites
onready var labelScore = $LabelScore
onready var deathSound = $AudioDeath
onready var music = $AudioMusic
onready var audioWin = $AudioWin

var width = 800
var height = 450
var spawns = [0,1,2,3]
var score = 0

func _ready():
	# left
	spawns[0] = [0,str(height)]
	# right
	spawns[1] = [width,str(height)]
	# top
	spawns[2] = [str(width),0]
	# bottom
	spawns[3] = [str(width),height]
	
	updateScore(0)
	
	checkMusic()
	$TimerSpawn.wait_time = Global.getSpawnTime()
	$TimerSpawn.start()


func _process(delta):
	var direction = get_viewport().get_mouse_position() - player.position
	if direction.length() < 10:
		return
	$ParallaxBackground.scroll_offset -= direction * delta * 2

func _on_TimerSpawn_timeout():
	spawnProjectile()
	
func spawnProjectile():
	var index = randi() % spawns.size()
	var x = spawns[index][0]
	var y = spawns[index][1]
	if typeof(x) == TYPE_STRING:
		x = randi() % (int(x)+1)
	if typeof(y) == TYPE_STRING:
		y = randi() % (int(y)+1)
	
	var position = Vector2(x,y)
	var target = Vector2(randi() % (width+1),randi() % (height+1))
	var direction = (target - position)
	var sprite = sprites.getRandomSprite()
	
	var proj = projectile.instance()
	add_child(proj)
	proj.init(position,Global.getSpeed(),Global.getSize(),direction,sprite)



func _on_Player_area_entered(area):
	deathSound.play(0)
	player.hide()
	player.collision.disabled = true
	
func _input(event):
	if event.is_action_released("fullscreen"):
		OS.window_fullscreen = !OS.window_fullscreen
		
	if event.is_action_released("muteMusic"):
		Global.muteMusic = !Global.muteMusic
		checkMusic()


func _on_TimerScore_timeout():
	updateScore(score + 1)
	
func updateScore(score):
	self.score = score
	labelScore.text = "Score: "+ str(score)
	if score == 60:
		audioWin.play(0)
		
func _on_deathSound_finished():
	Global.musicPlayback = music.get_playback_position()
	if score < 60:
		Global.setSceneLose(self,score)
	else:
		Global.setSceneWin(self,score)

func checkMusic():
	if Global.muteMusic:
		if music.playing:
			music.stop()
			Global.musicPlayback = music.get_playback_position()
		return
	music.play(Global.musicPlayback)