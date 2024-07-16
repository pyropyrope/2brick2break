extends RigidBody2D
@export var speed = 2
var power = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
 

func _on_body_entered(body):
	if body.has_method("damage"):
		body.damage(power)

func launch (l):
	apply_central_impulse(l*speed)
	


func _on_ball_visible_on_screen_notifier_2d_screen_exited():
	SignalBus.ball_exit.emit()
	queue_free()
	
