extends Area2D

const baseSize = 32.0

var speed
var direction
onready var spr = $Sprite
onready var coll = $CollisionShape2D
onready var vis = $VisibilityNotifier2D

func init(position,speed,size,direction,sprite):
	
	self.position = position
	self.speed = speed
	self.direction = direction.normalized()
	
	coll.shape = CircleShape2D.new()
	coll.shape.radius = size / 2.0
	
	var newScale = size / baseSize
	spr.texture = sprite.texture
	spr.region_rect = sprite.region_rect
	spr.scale.x = newScale
	spr.scale.y = newScale
	
	vis.rect = Rect2(-size,-size,size,size)
	
func _process(delta):
	position += direction * speed * delta

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
