extends CharacterBody2D

const SPEED = 300.0
@export var gun_bullet :PackedScene
@onready var marker = $Sprite2D/Marker2D
@onready var attack_colldown = $AttackColldown

# Get the gravity from the project settings to be synced with RigidBody nodes.
#var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	look_at(get_global_mouse_position())
	# Add the gravity.
	#if not is_on_floor():
		#velocity.y += gravity * delta

	# Handle jump.
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		#velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	#var direction = Input.get_axis("ui_left", "ui_right")
	#if direction:
		#shoot()
		#velocity.x = direction * SPEED
	#else:
		#velocity.x = move_toward(velocity.x, 0, SPEED)
#
	#move_and_slide()
	
func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.is_released():
		shoot()

func shoot():
	if (attack_colldown.is_stopped()):
		var bullet = gun_bullet.instantiate()
		$/root/Game.add_child(bullet)
		bullet.global_position = marker.global_position
		var direction = marker.global_transform.x
		bullet.set_direction(direction)
		attack_colldown.start()
