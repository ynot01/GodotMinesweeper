extends TextureButton

signal fire_down(sendid)
signal fire_up(sendid)
signal fire_pressed(sendid)
signal fire_flag(sendid)
signal fire_chord(sendid)

var id = 0
var tilehidden = true
var flag = false
var mine = false
var tile_position : Vector2i
var near = 0

func _ready():
	button_down.connect(emit_down.bind())
	button_up.connect(emit_up.bind())
	pressed.connect(emit_pressed.bind())
	fire_down.connect(get_parent().tile_down.bind())
	fire_up.connect(get_parent().tile_up.bind())
	fire_pressed.connect(get_parent().tile_pressed.bind())
	fire_flag.connect(get_parent().tile_flag.bind())
	fire_chord.connect(get_parent().tile_chord.bind())

func emit_down():
	fire_down.emit(id)

func emit_up():
	fire_up.emit(id)

func emit_pressed():
	fire_pressed.emit(id)

func emit_flag():
	fire_flag.emit(id)

func emit_chord():
	fire_chord.emit(id)

func _on_flag_btn_pressed():
	emit_flag()

func _on_chord_btn_pressed():
	emit_chord()
