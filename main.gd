extends Node

var phase = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Sprite2D.hide()


func set_phase(set_to: int):
	phase = set_to
	$board.set_phase(set_to)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (Input.is_action_just_pressed("flip_by_algorithm")):
		do_the_math()

func do_the_math():
	var board_info = $board.get_board_info()
	var parity = [false, false, false, false, false, false]

	for i in board_info.size():
		for j in range(6):
			if (i & int(pow(2, j)) > 0):
				parity[j] = parity[j] != board_info[i]
	var parity_in_int = 0
	for i in range(6):
		if (parity[i]):
			parity_in_int += pow(2, i)
		
	
	print(parity, parity_in_int)

func _on_board_key_put(cell) -> void:
	_phase1_to_phase2()
	var pos = cell.position
	pos.x += 50
	pos.y += 50
	$Sprite2D.set_deferred("position", pos)
	$Sprite2D.show()
	print($Sprite2D.visible, $Sprite2D.modulate)
	var tween = create_tween()
	tween.tween_property($Sprite2D, "modulate:a", 1, 0)
	tween.tween_property($Sprite2D, "modulate:a", 0, 1)


func _on_board_coin_flipped(_cell) -> void:
	if (phase == 1):
		_phase2_to_phase3()
		
func _phase1_to_phase2() -> void:
	set_phase(1)
	$Label.hide()
	$Label2.show()
	$InputHint.hide()
	$InputHint2.show()

func _phase2_to_phase3() -> void:
	set_phase(2)
	$Label2.hide()
	$Label3.show()
	$InputHint2.hide()
	$InputHint3.show()

func _back_to_phase1() -> void:
	set_phase(0)
	$ResultColorRect.hide()
	$Label.show()
	$Label2.hide()
	$Label3.hide()
	$InputHint.show()
	$InputHint2.hide()
	$InputHint3.hide()


func _on_board_guess_made(cell) -> void:
	if (cell.has_key):
		$ResultColorRect.show()
		$ResultColorRect/ResultLabel.text = "You Did It!"
	else:
		$ResultColorRect.show()
		$ResultColorRect/ResultLabel.text = "Failed"
