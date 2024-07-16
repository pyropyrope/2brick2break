extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func hide():
	$HUD.hide()
	$Paddle.hide()
	$LevelManager.hide()

func show():
	$HUD.show()
	$Paddle.show()
	$LevelManager.show()
