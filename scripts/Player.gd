extends CharacterBody2D

var weapon_scene = preload("res://scenes/weapon.tscn")

var throw_distance = 200.0
var throw_power = 400.0

var sprite_gun : Sprite2D
var sprite : Sprite2D 
@onready var cooldown = $cooldown_gun

@export var gun_bullet :PackedScene
@onready var marker = $player_with_gun/bullet
@onready var attack_colldown = $AttackColldown

func _ready():
	sprite_gun = $player_with_gun
	sprite = $player_without_gun

func _process(delta):

	look_at(get_global_mouse_position())
	
	if Input.is_action_just_pressed("spawn") && cooldown.is_stopped():
		throw_weapon()
		cooldown.start()

func throw_weapon():
	var weapon = weapon_scene.instantiate()
	weapon.position = $player_with_gun/gun.position
	
	# Calculate direction from marker to the mouse position
	var direction = $player_with_gun/gun.global_transform.x
	
	# Set the weapon's initial velocity
	if weapon is RigidBody2D:
		weapon.gravity_scale = 0
		weapon.initial_velocity = direction * throw_power

	# Connect the weapon's signal to handle removal
	weapon.connect("weapon_removed", Callable(self, "_on_weapon_removed"))

	# Hide the player's sprite and other elements
	if sprite_gun:
		sprite_gun.visible = false
	if sprite:
		sprite.visible = true

	# Add the weapon to the scene
	add_child(weapon)

func _on_weapon_removed(gun_position: Vector2):
	# Respawn the player at the last position of the weapon
	global_position = gun_position
	
	if sprite_gun:
		sprite_gun.visible = true
	if sprite:
		sprite.visible = false

func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.is_released():
		shoot()

func shoot():
	if (attack_colldown.is_stopped()) && sprite_gun.visible:
		var bullet = gun_bullet.instantiate()
		$/root/Game.add_child(bullet)
		bullet.global_position = marker.global_position
		var direction = marker.global_transform.x
		bullet.set_direction(direction)
		attack_colldown.start()


func _on_area_2d_area_entered(area):
	self.hide()
	get_node("../GameOver").game_over()
