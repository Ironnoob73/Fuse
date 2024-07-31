extends CharacterBody2D


const SPEED = 100.0
const JUMP_VELOCITY = -250.0

@onready var sprite_2d = $Sprite2D
@onready var point_light_2d = $PointLight2D
@onready var ray_cast_2d = $RayCast2D

var bullet = preload("res://Assets_main/Elements/ShootedBullet.tscn")

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	var tween = get_tree().create_tween().set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(point_light_2d,"texture_scale",1,0.25)
	set_collision_mask_value(8,false)
	set_collision_mask_value(7,true)

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if (Input.is_action_just_pressed("ui_up") || Input.is_action_just_pressed("ui_accept")) and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
	# Get down from platform
	if Input.is_action_just_pressed("ui_down"):
		set_collision_mask_value(3,false)
	if Input.is_action_just_released("ui_down"):
		set_collision_mask_value(3,true)

	# Get the input direction and handle the movement/deceleration.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	#Change Sprite & Raycast
	if !is_on_floor() || get_real_velocity().x + get_real_velocity().y != 0:
		sprite_2d.play("walk")
		if get_real_velocity().x < 0:
			sprite_2d.flip_h = true
			ray_cast_2d.target_position.x = -12
		elif get_real_velocity().x > 0:
			sprite_2d.flip_h = false
			ray_cast_2d.target_position.x = 12
	else : sprite_2d.play("idle")
	
	#Attack
	if Input.is_action_just_pressed("melee") && ray_cast_2d.get_collider():
		ray_cast_2d.get_collider().hitted()
	if Input.is_action_just_pressed("range") && get_parent().bullet_count > 0:
		get_parent().add_bullet(-1)
		var bullet_instance = bullet.instantiate()
		bullet_instance.direction = sprite_2d.flip_h
		bullet_instance.position = position
		get_parent().add_child(bullet_instance)
	
	#Restart
	if Input.is_action_just_pressed("restart"):
		get_tree().reload_current_scene()
	
	move_and_slide()

