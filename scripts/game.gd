extends Node2D

var zombie_scene = preload("res://scenes/zombie.tscn")

var spawn_area = Rect2(Vector2(-100, -177), Vector2(350, -12))
var player : CharacterBody2D

# Called when the node enters the scene tree for the first time.
func _ready():
	$EnemySpawnTimer.timeout.connect(spawn_zombies)
	$EnemySpawnTimer.start()
	player = get_node("Player")

func spawn_zombies():
	# Generate a random position within the spawn area
	var random_position = Vector2(
		randf_range(spawn_area.position.x, spawn_area.position.x + spawn_area.size.x),
		randf_range(spawn_area.position.y, spawn_area.position.y + spawn_area.size.y)
	)
	
	# Instantiate the enemy
	var zombie = zombie_scene.instantiate()
	zombie.position = random_position
	
	zombie.set_player_reference(player)
	
	# Add the enemy to the scene
	add_child(zombie)
