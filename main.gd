extends Node
#scene for ball
@export var ball_scene: PackedScene
#score multiplier, adjustable
@export var multiplier =  100
@export var ball_height = 25
var game_started = false
var levels_played = 0

#basic game info
var score = 0
var lives = 3
var level = 0
var new_ball


# Called when the node enters the scene tree for the first time.
#needs aesprite to display any assets?
func _ready():

	#connects to the signal bus
	SignalBus.brick_destroyed.connect(_on_brick_destroyed)
	SignalBus.level_over.connect(_on_level_over)
	SignalBus.ball_exit.connect(_on_ball_exit)
	levels_played += 1
	$Game/HUD/RightContainer/LevelNum.text = str(levels_played)
	#displays first (only) level
	#TODO some kind of level manager func? or do i want a scene with all the levels??? bleh
	$Game.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#launches ball when space is pressed
	#TODO better game flow, add launch variables
	if game_started == true:
		if Input.is_action_just_pressed('launch'):

			var paddle_center = get_paddle_center()
			new_ball = create_ball(paddle_center)

		if Input.is_action_just_released('launch'):
			var paddle_center = get_paddle_center()
			var launch_vector = (new_ball.get_center() - paddle_center).normalized()
			print(launch_vector)
			new_ball.launch(launch_vector)


#creates and launches a ball at specified coordinates
#TODO add variable direction
func create_ball(v):
	var ball = ball_scene.instantiate()
	#put ball at positon
	v = v - Vector2(ball.get_offset().x, ball_height)
	ball.position = v
	$BallSack.add_child(ball)
	return(ball)

#adds to score based on toughness
func _on_brick_destroyed(arg):
	score = score + arg * multiplier
	$Game/HUD.update_score(score)

func _on_start_button_pressed():
	$StartScreen.hide()
	$Game.show()
	$BallSack.show()
	game_started = true

func _on_level_over():
	print('level over')
	$NextLevelMenu.visible = true
	for ball in $BallSack.get_children():
		ball.queue_free()


func _on_ball_exit():
	print("ball exit")
	await get_tree().create_timer(1.0).timeout
	print($BallSack.get_child_count())

func get_paddle_center():
	return $Game/Paddle.get_center()

func _on_next_level_button_pressed():
	$NextLevelMenu.visible = false
	levels_played += 1
	$Game/HUD/RightContainer/LevelNum.text = str(levels_played)
	$Game/LevelManager.make_rand_level(4,10,10)
