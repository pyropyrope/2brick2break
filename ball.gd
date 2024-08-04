extends RigidBody2D
@export var speed = 200
var power = 1
var is_in_play = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
 
func _physics_process(delta):
	if Engine.get_physics_frames()%10 == 0 && is_in_play == true:
		if linear_velocity.length() < speed/2:
			var curr_speed = linear_velocity.length()
			var push = (speed/2)/curr_speed
			apply_central_impulse(linear_velocity*push)

func _on_body_entered(body):
	if body.has_method("damage"):
		body.damage(power)

func launch (l):
	apply_central_impulse(l*speed)
	is_in_play = true
	


func _on_ball_visible_on_screen_notifier_2d_screen_exited():
	SignalBus.ball_exit.emit()
	is_in_play = false
	queue_free()

func get_offset():
	var offset = ($BrickBreakBall.get_rect().size)/2
	return offset

func get_center():
	return $BallCollisionShape2D.global_position
