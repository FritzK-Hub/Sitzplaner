extends Node2D

signal table_resize
signal remove_table

var mouse_entered_event = false

export var student_resource: Resource

var student_left: Control
var student_right: Control

var current_offset: Vector2
var moving: bool = false

var relative_position: Vector2

var rotater_degrees = 15

var id

var current_students: Array


func _ready():
	$Control/Background.connect("mouse_entered", self, "_on_mouse_entered")
	$Control/Background.connect("mouse_exited",  self, "_on_mouse_exited")
	
		
	
func set_student_left_name(name):
	student_left.call("set_name", name)
func set_student_right_name(name):
	student_right.call("set_name", name)
	
func _on_window_resize():
	var g_scale = Global._editor_scale
	var g_size	= g_scale * 0.78
	
	
	
	$Control.rect_size = Vector2(g_scale * 2, g_scale)
	$Control.rect_position = Vector2(-(g_scale * 2)/2, -(g_scale)/2)
	
	var temp_x = Global.map(relative_position.x, 0, 16, 0, Global._editor_size.x)
	var temp_y = Global.map(relative_position.y, 0, 9, 0, Global._editor_size.y)
	
	temp_x = clamp(temp_x, Global._editor_scale, Global._editor_size.x - Global._editor_scale)
	temp_y = clamp(temp_y, Global._editor_scale/2, Global._editor_size.y - Global._editor_scale/2)
	
	self.position = Vector2(temp_x, temp_y)
	
	emit_signal("table_resize", [g_size])




func _input(event):
	var modifier				= Input.is_action_pressed("modifier")
	var button_right_released 	= Input.is_action_just_released("right_click")
	var button_left 			= Input.is_mouse_button_pressed(BUTTON_LEFT)
	var wheel_up				= Input.is_mouse_button_pressed(BUTTON_WHEEL_UP)
	var wheel_down				= Input.is_mouse_button_pressed(BUTTON_WHEEL_DOWN)
	var entered					= mouse_entered_event 
	var edit 					= Global._edit_mode
	
	if button_left && entered && edit && !moving:
		moving = true
		current_offset = get_global_mouse_position() - self.position
		
	if button_left && entered && edit && moving:
		var m = get_global_mouse_position() - current_offset
		var temp_x = Global.map(m.x, 0, Global._editor_size.x, 0, 16)
		var temp_y = Global.map(m.y, 0, Global._editor_size.y, 0, 9)
		mover(Vector2(temp_x, temp_y))
		
	if !button_left && entered && edit && moving:
		moving = false
		
	if wheel_up && entered && edit:
		rotater(-rotater_degrees)
		
	if wheel_down && entered && edit:
		rotater(rotater_degrees)
	
		
func mover(pos: Vector2) -> void:
	relative_position = pos
	
	_on_window_resize()
	

func update_students(student_par: Array) -> void:
	
	var old_student = student_par[1]
	var new_student = student_par[0]
	
	for i in range(Serializer._table_list.size()):
		var firstname_one = Serializer._table_list[i][0][0]
		var firstname_two = Serializer._table_list[i][1][0]
		var switched = false
		
		if firstname_one == old_student:
			Serializer._table_list[i][0][0] = new_student
			switched = true
		if firstname_two == old_student && !switched:
			Serializer._table_list[i][1][0] = new_student
		
func rotater(degrees) -> void:
	self.rotate(deg2rad(degrees))
		
func _on_mouse_entered():
	mouse_entered_event = true

func _on_mouse_exited():
	mouse_entered_event = false

func _set_current_students(students):
	current_students = students
