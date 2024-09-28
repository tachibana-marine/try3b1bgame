extends Node2D

signal coin_flipped
signal guess_made
signal key_put

@export var is_head: bool = true
@export var cell_color: Color = "db9661"
@export var has_key: bool = false

var phase: int = 0
var sprite_tail = load("res://asset/tail.png")
var sprite_head = load("res://asset/head.png")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$ColorRect.color = cell_color
	_set_sprite()

func _set_sprite() -> void:
	if (is_head):
		$Sprite2D.texture = sprite_head
	else:
		$Sprite2D.texture = sprite_tail

func get_is_head() -> bool:
	return is_head

func set_is_head(set_to: bool) -> void:
	is_head = set_to
	_set_sprite()
	
func set_has_key(set_to: bool):
	has_key = set_to

func set_phase(set_to: int):
	phase = set_to

func flip() -> void:
	set_is_head(!is_head)
	coin_flipped.emit(self)

func _on_area_2d_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			if (phase == 0 or phase == 1):
				flip()
			elif (phase == 2):
				guess_made.emit(self)

		if event.button_index == MOUSE_BUTTON_RIGHT and event.pressed:
			if (phase == 0):
				set_has_key(true)
				key_put.emit(self)
