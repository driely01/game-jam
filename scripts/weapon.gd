extends RigidBody2D

var initial_velocity = Vector2()
var max_distance = 200.0
var lifetime = 0.5
var start_position = Vector2()
var traveled_distance = 0.0

# Declare a signal for weapon removal
signal weapon_removed(position: Vector2)

func _ready():
	# Store the initial position of the weapon
	start_position = position

	# Initialize the weapon's velocity
	linear_velocity = initial_velocity
	
	# Set up a timer to remove the weapon after 'lifetime' seconds
	var timer = Timer.new()
	timer.wait_time = lifetime
	timer.one_shot = true
	timer.autostart = false
	add_child(timer)
	
	# Connect the timer's timeout signal to _on_timeout
	timer.timeout.connect(Callable(self, "_on_timeout"))
	
	# Start the timer
	timer.start()

func _process(delta):
	# Calculate the distance traveled since the start position
	traveled_distance = start_position.distance_to(position)

	# Check if the weapon has traveled the maximum distance
	if traveled_distance >= max_distance:
		# Stop the weapon by setting its velocity to zero
		linear_velocity = Vector2.ZERO
		
		# Optionally, you could also make sure it's removed from the scene
		_remove_weapon()

func _on_timeout():
	# Timer expired, handle the weapon removal
	_remove_weapon()

func _remove_weapon():
	# Emit the weapon_removed signal with the current position

	emit_signal("weapon_removed", global_position)
	
	# Remove the weapon from the scene
	queue_free()
