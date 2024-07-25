extends Area2D

var opened : bool = false
@onready var image = $Image
@onready var particle = $GPUParticles2D

func _on_body_entered(body):
	if get_parent().fuse == get_parent().fuse_total && opened == false:
		opened = true
		get_parent().add_score(50)
		get_parent().power_on()
		particle.set_emitting(true)
		image.play("on")
