extends Node2D

signal coin_flipped
signal key_put
signal guess_made

@export var board_width = 8
@export var board_height = 8

var phase = 0
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
			if (randi() % 2 == 0):
				cell.is_head = false
			if ((i % 2 == 0 and j % 2 == 0) or (i % 2 == 1 and j % 2 == 1)):
				cell.cell_color = cell_color_orange
			else:
				cell.cell_color = cell_color_brown
			cell.key_put.connect(_on_cell_key_put)
			cell.coin_flipped.connect(_on_cell_coin_flipped)
			cell.guess_made.connect(_on_cell_guess_made)
			add_child(cell)
			cell_pos_x += cell_size
		cell_pos_y += cell_size
	print(get_board_info())
	print(get_board_info().size())

func get_board_info() -> Array:
	var result = []
	for cell in get_children():
		result.push_back(cell.is_head)
	return result

func set_phase(set_to: int) -> void:
	for cell in get_children():
		cell.set_phase(set_to)

func _on_cell_key_put(cell):
	for tmp_cell in get_children():
		if (tmp_cell != cell):
			tmp_cell.set_has_key(false)
	key_put.emit(cell)

func _on_cell_coin_flipped(cell):
	coin_flipped.emit(cell)

func _on_cell_guess_made(cell):
	guess_made.emit(cell)
