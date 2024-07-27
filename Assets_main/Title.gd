extends Control

@onready var env_light = $DirectionalLight2D
@onready var point_light = $PointLight2D

func _ready():
	env_light.show()
	var tween = get_tree().create_tween().set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(point_light,"texture_scale",2,0.25)

func _process(delta):
	point_light.position = get_global_mouse_position()

func _on_tutorial_pressed():
	var tween = get_tree().create_tween().set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(point_light,"texture_scale",0,0.25)
	tween.tween_callback(func():get_tree().change_scene_to_file("res://Assets_main/Tutorial.tscn"))
	
