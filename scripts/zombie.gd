extends CharacterBody2D

# Speed of the enemy
var speed = 100
var health = 60

# Reference to the player node, which is a CharacterBody2D
var player: CharacterBody2D

func set_player_reference(p: CharacterBody2D):
	player = p

func _process(delta):
	if player:
		
		look_at(player.global_position)
		# Calculate the direction vector to the player
		var direction = (player.global_position - global_position).normalized()
		
		# Set the enemy's velocity to move towards the player
		velocity = direction * speed
		
		# Move the enemy using move_and_slide
		move_and_slide()

func handle_hit():
	health -= 30
	if health <= 0:
		queue_free()
