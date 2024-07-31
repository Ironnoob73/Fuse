extends CanvasLayer

var flow : bool = false
var time : float = 0
var last_time : float = 0
var score : int = 0
var health : int = 10
@onready var time_text = $Control/Time
@onready var fuse_text = $Control/VBoxContainer/Fuse/Label
@onready var score_text = $Control/VBoxContainer/HBoxContainer/Score
@onready var health_bar = $Control/VBoxContainer/HBoxContainer/Health

signal time_out

#https://www.youtube.com/shorts/M-0UNa8M5bE
func _physics_process(delta):
	if flow:
		time += delta
		time_text.text = "%02d:" % floor(fmod(time,3600)/60) + "%02d." % floor(fmod(time,60)) + "%02d" % floor(fmod(time,1)*100)
		if get_parent().power:
			if last_time > 0:
				last_time -= delta
				fuse_text.text = str(floor(fmod(last_time,60))) + "." + "%02d" % floor(fmod(last_time,1)*100)
			else :
				fuse_text.text = "0.00"
				fuse_text.set_modulate(Color(1,0,0))
				emit_signal("time_out")
				flow = false
				
func add_health(hurt:bool):
	var count : int = 2
	if hurt == true:	health -= count
	else :	health += count
	for i in health_bar.get_children():
		if (i.get_index() + 1) * 2 <= health:
			i.get_child(0).set_frame(0)
		elif (i.get_index() + 1) * 2 -1 > health:
			i.get_child(0).set_frame(2)
		elif (i.get_index() + 1) * 2 -1 == health:
			i.get_child(0).set_frame(1)
