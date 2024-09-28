extends Node2D

@export var is_head: bool = true
@export var cell_color: Color = "db9661"

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
	

func flip() -> void:
	set_is_head(!is_head)


func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	print("event")
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			print("Left button was clicked at ", event.position)
		if event.button_index == MOUSE_BUTTON_WHEEL_UP and event.pressed:
			print("Wheel up")