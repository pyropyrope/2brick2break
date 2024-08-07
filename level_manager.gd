extends Node
var possible_possitons
@export var brick: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	possible_possitons = $TestLevel.possible_possitons()
	$TestLevel.queue_free()
	print(possible_possitons)
	make_level(4,10)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func make_level(cols,rows):

	for r in (rows):
		var row = possible_possitons[r]
		for c in (cols):
			var new_brick = brick.instatiate()
			new_brick.setup_brick(row[c],1)
			$ActiveLevel.addChild(new_brick)

