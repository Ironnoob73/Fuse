extends Area2D

@onready var image = $Image

var direction : bool = false

func _physics_process(delta):
	if direction == false:
		position.x += 10
	else :
		image.set_flip_v(true)
		position.x -= 10

func _on_body_entered(body):
	if body is TileMap || body.get_collision_layer_value(2):
		queue_free()
	elif body.get_collision_layer_value(5):
		body.hitted()
		queue_free()
