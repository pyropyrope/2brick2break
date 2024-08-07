extends CharacterBody2D

@export var speed = 300
@export var border_width = 7
@export var start_pos_y = 324
static var is_paddle = true
var sprite_width
var sprite_height
var shape_width
var sprite_size
var screen_size

# Called when the node enters the scene tree for the first time.
func _ready():
	#gets size of the viewport for clamp func
	screen_size = get_viewport_rect().size

	#gets width of the paddle
	sprite_size = $BrickBreakPaddle.get_rect()
	sprite_width = sprite_size.size.x
	sprite_height = sprite_size.size.y

	shape_width = $PaddleCollisionShape.shape.get_rect().size.x
	#sets starting positon to center of screen
	var start_pos = Vector2((screen_size.x-sprite_width)/2,start_pos_y)
	position = start_pos


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):

	velocity = Vector2.ZERO

	#check inputs
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1

	#move
	velocity = velocity * speed
	position += velocity * delta

	#restrict paddle to play area
	position = position.clamp(Vector2(border_width,0),Vector2(screen_size.x-(sprite_width+border_width),INF))

func get_center():
	return $PaddleCollisionShape.global_position

func get_is_paddle():
	return is_paddle
