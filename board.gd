extends Node2D

@export var board_width = 6
@export var board_height = 6

var scene_cell = preload("res://cell.tscn")
var cell_color_orange: Color = "db9661"
var cell_color_brown: Color = "704421"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var cell_size = 100 # width and height of each cell
	var cell_pos_x = 0
	var cell_pos_y = 0
	for i in range(board_width):
		cell_pos_x = 0
		for j in range(board_height):
			var cell = scene_cell.instantiate()
			cell.position = Vector2(cell_pos_x, cell_pos_y)
			if ((i % 2 == 0 and j % 2 == 0) or (i % 2 == 1 and j % 2 == 1)):
				cell.cell_color = cell_color_orange
			else:
				cell.cell_color = cell_color_brown
			add_child(cell)
			cell_pos_x += cell_size
		cell_pos_y += cell_size
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
