extends Area2D

onready var tween = $Tween
onready var collision = $CollisionShape2D
onready var spr = $Sprite

func _ready():
	pass

func _process(delta):
	var mouse = get_viewport().get_mouse_position()
	
	tween.remove(self,"position")
	tween.interpolate_property(self,"position", position, mouse,0.1,Tween.TRANS_LINEAR,Tween.EASE_IN)
	if not tween.is_active():
		tween.start()
		
	var direction = (mouse - position)
	
	position.x = clamp(position.x, 0,Global.width)
	position.y = clamp(position.y, 0,Global.height)

	spr.rotation = atan2(direction.x*-1,direction.y) + PI
