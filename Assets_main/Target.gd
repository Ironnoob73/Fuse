extends AnimatableBody2D

@onready var particle = $GPUParticles2D
@onready var image = $Image
var breaked : bool = false

func hitted():
	if breaked == false:
		get_parent().add_score(20)
		breaked = true
		image.hide()
		particle.set_emitting(true)
		await get_tree().create_timer(1).timeout
		queue_free()
