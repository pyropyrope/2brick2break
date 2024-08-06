extends RigidBody2D
@export var speed = 400
@export var min_speed_mod = .9
@export var max_speed_mod = 3
@export var paddle_bounce_mod = .05

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
		# too slow
		if linear_velocity.length() < speed*min_speed_mod:
			var target_velocity = linear_velocity.normalized()* (speed*min_speed_mod)
			var push = linear_velocity - target_velocity
			apply_central_impulse(push)
		#too fast
		if abs(linear_velocity.length()) > speed*max_speed_mod:
			var target_velocity = linear_velocity.normalized()*(speed*max_speed_mod)
			var push = -(linear_velocity - target_velocity)
			apply_central_impulse(push)
			print(str(self) + ' slowed')

func _on_body_entered(body):
	if body.has_method("damage"):
		body.damage(power)
	if body.has_method('get_is_paddle'):
		paddle_boost(body)

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

#TODO 
func paddle_boost(paddle):
	var paddle_center_x = paddle.get_center().x
	var ball_center_x = global_position.x
	
	# math goes here
	
	
