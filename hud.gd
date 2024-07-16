extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

#if i have to explain these functions you have failed as a programmer
func update_score(score):
	$CenterContainer/ScoreLabel.text = str(score)
func update_level(level):
	$RightContainer/LevelNum.text(level)
