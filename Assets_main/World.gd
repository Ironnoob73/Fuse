extends Node2D

@onready var tile_map = $TileMap
@onready var env_light = $DirectionalLight2D
@onready var player_light = $CharacterBody2D/PointLight2D
@onready var character = $CharacterBody2D
@onready var canvas_layer = $CanvasLayer

@onready var bc_text = $CanvasLayer/Control/HBoxContainer/Label

var power : bool = false
var exited : bool = false

var fuse_total : int = 1
var fuse : int = 0
var bullet_count : int = 0

func _ready():
	env_light.show()
	add_bullet(0)
	canvas_layer.flow = true
	canvas_layer.fuse_text.text = str(fuse) + "/" + str(fuse_total)
	canvas_layer.last_time = 10

func power_on():
	power = true
	var tween = get_tree().create_tween().set_parallel()
	tween.tween_property(env_light,"energy",0,0.25)
	tween.tween_property(player_light,"energy",0,0.25)
	tween.tween_property(player_light,"texture_scale",10,1)
	character.set_collision_mask_value(8,true)
	character.set_collision_mask_value(7,false)

func add_fuse():
	fuse += 1
	canvas_layer.fuse_text.text = str(fuse) + "/" + str(fuse_total)

func add_bullet(count:int):
	bullet_count += count
	bc_text.text = str(bullet_count)
	
func add_score(added_score:int):
	canvas_layer.score += added_score
	canvas_layer.score_text.text = "   " + "%08d" % canvas_layer.score

func exit():
	canvas_layer.flow = false
	add_score(floor(canvas_layer.last_time * 10))
	var tween = get_tree().create_tween().set_parallel()
	tween.tween_property(env_light,"energy",1,0.25)
	tween.tween_property(player_light,"energy",1,0.25)
	tween.tween_property(player_light,"texture_scale",0,0.5).set_trans(Tween.TRANS_CUBIC)
	tween.tween_callback(func():get_tree().change_scene_to_file("res://Assets_main/Title.tscn")).set_delay(0.5)

func _on_canvas_layer_time_out():
	canvas_layer.add_health(true)
