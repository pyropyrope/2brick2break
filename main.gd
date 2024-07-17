extends Node
#scene for ball
@export var ball_scene: PackedScene
#score multiplier, adjustable
@export var multiplier =  100
#basic game info
var score = 0
var lives = 3
var level = 0
var new_ball

# Called when the node enters the scene tree for the first time.
func _ready():
	
	#connects to the signal bus
	SignalBus.brick_destroyed.connect(_on_brick_destroyed)
	SignalBus.level_over.connect(_on_level_over)
	SignalBus.ball_exit.connect(_on_ball_exit)
	#displays first (only) level
	#TODO some kind of level manager func? or do i want a scene with all the levels??? bleh
	$Game.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#launches ball when space is pressed
	#TODO better game flow, add launch variables
	if Input.is_action_just_pressed('launch'):
		
		var paddle_center = get_paddle_center()
		new_ball = create_ball(Vector2(paddle_center.x,paddle_center.y-30))
	
	if Input.is_action_just_released('launch'):
		var paddle_center = get_paddle_center()
		var launch_vector = (new_ball.position - paddle_center) *.02
		new_ball.launch(launch_vector)
	

#creates and launches a ball at specified coordinates 
#TODO add variable direction
func create_ball(v):
	var ball = ball_scene.instantiate()
	#put ball at positon
	ball.position = v
	$BallSack.add_child(ball)
	return(ball)

#adds to score based on toughness
func _on_brick_destroyed(arg):
	score += arg * multiplier
	$Game/HUD.update_score(score)
	
func _on_start_button_pressed():
	$StartScreen.hide()
	$Game.show()
	$BallSack.show()

func _on_level_over():
	print('level over')

func _on_ball_exit():
	print("ball exit")
	await get_tree().create_timer(1.0).timeout
	print($BallSack.get_child_count())

func get_paddle_center():
	return $Game/Paddle.get_center()
