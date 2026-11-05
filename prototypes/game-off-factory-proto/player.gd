extends CharacterBody2D

@export var speed : int

var input_history : Array[String]
var latest_input : String
var dir : Vector2

const movements = {
	"right" : Vector2.RIGHT,
	"left" : Vector2.LEFT,
	"up" : Vector2.UP,
	"down" : Vector2.DOWN
}

var possible_grab : Grabbable
var grabbed_object : Grabbable

const rotations = {
	"right" : 90,
	"left" : -90,
	"up" : 0,
	"down" : 180
}

func _process(delta: float) -> void:
	dir = Vector2.ZERO
	get_inputs()
	
	if Input.is_action_just_pressed("grab"):
		if possible_grab:	
			grab(possible_grab)
		else:
			let_go()

func _physics_process(delta: float) -> void:
	velocity = dir * delta * speed * 100
	move_and_slide()

func get_inputs():
	for input in movements.keys():
		if Input.is_action_just_pressed(input):
			input_history.erase(input)
			input_history.append(input)
		if Input.is_action_just_released(input):
			input_history.erase(input)
	if input_history.size():
		dir = movements[input_history[input_history.size()-1]]
		rotation_degrees = rotations[input_history[input_history.size()-1]]
		latest_input = input_history[input_history.size()-1]

func grab(object : StaticBody2D):
	object.reparent($GrabArea)
	object.position = Vector2.ZERO
	object.set_collision_layer_value(1, false)
	grabbed_object = object

func let_go():
	if grabbed_object:
		grabbed_object.set_collision_layer_value(1, true)
		grabbed_object.reparent(self.get_parent())
		grabbed_object = null

func _on_grab_area_body_entered(body: Node2D) -> void:
	if body is Grabbable and not grabbed_object:
		possible_grab = body


func _on_grab_area_body_exited(body: Node2D) -> void:
	possible_grab = null
