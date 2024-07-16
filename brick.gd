extends StaticBody2D

@export var toughness = 1
var start_toughness = 0

#brick textures
var t1 = load("res://assets/brick break brick.aseprite")
var t2 = load("res://assets/brick2 break brick.aseprite")
var t3 = load("res://assets/brick3 break brick.aseprite")
var t_dict = {1:t1,2:t2,3:t3}


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func damage(power):
	toughness -= power
	if toughness <=0:
		SignalBus.brick_destroyed.emit(start_toughness)
		queue_free()
	else :
		$Brick1.set_texture(t_dict[toughness])

func setup_brick(pos, t):
	toughness = t
	position = pos
	
	$Brick1.set_texture(t_dict[toughness])

