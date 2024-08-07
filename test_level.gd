extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

#gets the possible start positons of bricks in the grid via magic dont touch
func possible_possitons():
	var bricks_pos = Array()
	var row_length = 10
	var num_bricks = get_child_count()
	var num_rows = num_bricks/row_length
	var brick_count = 0

	for r in (num_rows-1):
		var row = Array()
		for b in row_length:

			var brick = get_child(brick_count)
			var pos = brick.get_position()
			row.append(pos)
			brick_count += 1
		bricks_pos.append(row)
	return bricks_pos
