extends Control

const GridScn = preload("res://msgrid.tscn")

var current_grid

var width = 10
var height = 10
var mines = 10

var starting_time = 0
var frozen_time = 0

func _ready():
	new_game()

func new_game():
	$GameStat.hide()
	if current_grid:
		remove_child(current_grid)
		current_grid.queue_free()
	current_grid = GridScn.instantiate()
	current_grid.width = width
	current_grid.height = height
	current_grid.mines = mines
	current_grid.scale = Vector2(min(1, 36.0/width), min(1, 17.0/height))
	current_grid.pivot_offset = Vector2(width*16, height*16)
	add_child(current_grid)
	starting_time = 0
	frozen_time = 0

func _process(_delta):
	if starting_time:
		var minutes
		var seconds
		var now = Time.get_ticks_msec()
		if frozen_time:
			minutes = frozen_time / 60000.0
			seconds = fmod(frozen_time, 60000.0) / 1000.0
		else:
			minutes = (now - starting_time) / 60000.0
			seconds = fmod(now - starting_time, 60000.0) / 1000.0
		$Stopwatch.text = ("%02d" % minutes)+":"+("%02d" % seconds)+"."+("%03d" % round(fmod(seconds, 1)*1000))
	else:
		$Stopwatch.text = "00:00.000"

func _on_new_game_pressed():
	new_game()

func update_text_mine_ratio():
	$WidthLbl.text = "Width: "+str(width)
	$HeightLbl.text = "Height: "+str(height)
	var temp_mines = clamp(mines, width * height / 10, width * height - 10)
	$MinesLbl/Mines.min_value = width * height / 10
	$MinesLbl/Mines.max_value = width * height - 10
	mines = temp_mines
	$MinesLbl/Mines.value = mines
	$MinesLbl.text = "Mines: "+str(mines)

func _on_width_value_changed(value):
	width = int(value)
	update_text_mine_ratio()

func _on_height_value_changed(value):
	height = int(value)
	update_text_mine_ratio()

func _on_mines_value_changed(value):
	mines = int(value)
	update_text_mine_ratio()

func _on_beginner_pressed():
	$WidthLbl/Width.value = 10
	$HeightLbl/Height.value = 10
	$MinesLbl/Mines.value = 10
	update_text_mine_ratio()

func _on_intermediate_pressed():
	$WidthLbl/Width.value = 17
	$HeightLbl/Height.value = 17
	$MinesLbl/Mines.value = 40
	update_text_mine_ratio()

func _on_expert_pressed():
	$WidthLbl/Width.value = 30
	$HeightLbl/Height.value = 16
	$MinesLbl/Mines.value = 99
	update_text_mine_ratio()
