extends Area2D

@onready var kill_timer = $KillTimer
const speed = 700

var direction := Vector2.ZERO


# Called when the node enters the scene tree for the first time.
func _ready():
	kill_timer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if direction != Vector2.ZERO:
		var velocity = direction * speed * delta
		global_position += velocity

func set_direction(direction: Vector2):
	self.direction = direction 

func _on_kill_timer_timeout():
	queue_free()


func _on_body_entered(body):
	if body.has_method("handle_hit"):
		body.handle_hit()
		queue_free()


func _on_area_entered(area):
	queue_free()
