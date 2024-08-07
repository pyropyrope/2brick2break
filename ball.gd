extends RigidBody2D
@export var speed = 400
@export var min_speed_mod = .9
@export var max_speed_mod = 3
@export var paddle_bounce_mod = .05
@export var boost_deg_max = 15
@export var safe_zone = 5
var max_speed
var min_speed
var power = 1
var is_in_play = false


# Called when the node enters the scene tree for the first time.
func _ready():
	max_speed = speed*max_speed_mod
	min_speed = speed*max_speed_mod


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _physics_process(delta):
	if Engine.get_physics_frames()%10 == 0 && is_in_play == true:
		# too slow
		if linear_velocity.length() < speed*min_speed_mod:
			var target_velocity = linear_velocity.normalized()* (speed*min_speed_mod)
			linear_velocity = target_velocity
			print (str(self)+ " speed up")
		#too fast
		if linear_velocity.length() > speed*max_speed_mod:
			var target_velocity = linear_velocity.normalized()*(speed*max_speed_mod)
			linear_velocity = target_velocity
			print(str(self) + ' slowed')


	#test ray


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


func _on_body_exited(body):
	if body.has_method('get_is_paddle') && linear_velocity.y <0:
		paddle_boost(body)
		print('boost')


#TODO
func paddle_boost(paddle):
	var boost_speed_vector = Vector2.ONE + Vector2(paddle_bounce_mod,paddle_bounce_mod)

	var paddle_center_x = paddle.get_center().x
	var ball_center_x = global_position.x
	var paddle_length = paddle.shape_width
	var boost_rad_max = deg_to_rad(boost_deg_max)
	var dist_from_center = paddle_center_x-ball_center_x

	var angle_delt = (dist_from_center/(paddle_length/2)*boost_rad_max)
	print(angle_delt)

	var boost_transform = Transform2D(angle_delt,Vector2.ZERO)

	linear_velocity = (linear_velocity*boost_speed_vector) * boost_transform


