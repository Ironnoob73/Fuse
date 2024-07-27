extends CanvasLayer

var flow : bool = false
var time : float = 0
var last_time : float = 0
var score : int = 0
@onready var time_text = $Control/Time
@onready var fuse_text = $Control/VBoxContainer/Fuse/Label
@onready var score_text = $Control/VBoxContainer/HBoxContainer/Score

#https://www.youtube.com/shorts/M-0UNa8M5bE
func _physics_process(delta):
	if flow:
		time += delta
		time_text.text = "%02d:" % floor(fmod(time,3600)/60) + "%02d." % floor(fmod(time,60)) + "%02d" % floor(fmod(time,1)*100)
		if get_parent().power:
			last_time -= delta
			fuse_text.text = str(floor(fmod(last_time,60))) + "." + "%02d" % floor(fmod(last_time,1)*100)
