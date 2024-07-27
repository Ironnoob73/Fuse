extends Area2D

func _on_body_entered(body):
	if get_parent().power:
		get_parent().add_score(50)
		get_parent().exit()
