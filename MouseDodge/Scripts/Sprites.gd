extends Node2D


onready var sprites = []

func _ready():
	for i in range(16):
		sprites.append(get_node(str(i)))
	

func getRandomSprite():
	var sprite = sprites[randi()%sprites.size()]
	return sprite