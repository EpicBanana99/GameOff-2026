extends Node2D

@export var shift_label : Label

var shift : String
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	shift = "night"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	shift_label.text = shift + " shift"
	if shift == "day":
		pass

func toggleShift():
	if shift == "day":
		shift ="night"
		return
	shift="day"
