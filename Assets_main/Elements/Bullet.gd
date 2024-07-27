extends Area2D

@onready var particle = $GPUParticles2D
@onready var image = $Image
var getted : bool = false

func _on_body_entered(_body):
	if getted == false:
		get_parent().add_score(5)
		get_parent().add_bullet(1)
		getted = true
		image.hide()
		particle.set_emitting(true)
		await get_tree().create_timer(1).timeout
		queue_free()
