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
	student_left = load(student_resource.resource_path).instance()
	student_right = load(student_resource.resource_path).instance()
	
	$Control.add_child(student_left)	
	$Control.add_child(student_right)
	
	connect("table_resize", student_left, "_on_table_resize")
	connect("table_resize", student_right, "_on_table_resize")
		
	
func set_student_left_name(name):
	student_left.call("set_name", name)
func set_student_right_name(name):
	student_right.call("set_name", name)
	
func _on_window_resize():
	var g_scale = Global._editor_scale
	var g_size	= g_scale * 0.78
	
	student_left.get_child(0).rect_size      = Vector2(g_size, g_size)
	student_left.get_child(0).rect_position  = Vector2(-g_size/2, -g_size/2)
	student_right.get_child(0).rect_size     = Vector2(g_size, g_size)
	student_right.get_child(0).rect_position = Vector2(-g_size/2, -g_size/2)
	
	student_left.rect_position = Vector2(g_scale/2, g_scale/2)
	student_right.rect_position = Vector2(g_scale*1.5, g_scale/2)
	
	student_left.get_child(0).get_child(0).rect_size      = Vector2(g_size, g_size)
	student_right.get_child(0).get_child(0).rect_size     = Vector2(g_size, g_size)
	
	
	$Control.rect_size = Vector2(g_scale * 2, g_scale)
	$Control.rect_position = Vector2(-(g_scale * 2)/2, -(g_scale)/2)
	
	var temp_x = Global.map(relative_position.x, 0, 16, 0, Global._editor_size.x)
	var temp_y = Global.map(relative_position.y, 0, 9, 0, Global._editor_size.y)
	
	self.position = Vector2(temp_x, temp_y)
	
	
	var new_students = [current_students[0], current_students[1], relative_position.x, relative_position.y]
	
	for i in range(Serializer._student_list.size()):
		var firstname_one = Serializer._student_list[i][0][0]
		var firstname_two = Serializer._student_list[i][1][0]
		var lastname_one = Serializer._student_list[i][0][1]
		var lastname_two = Serializer._student_list[i][1][1]
		
		var current_firstname_one = current_students[0][0]
		var current_firstname_two = current_students[1][0]
		var current_lastname_one = current_students[0][1]
		var current_lastname_two = current_students[1][1]
		
		if firstname_one == current_firstname_one && firstname_two == current_firstname_two && lastname_one == current_lastname_one && lastname_two == current_lastname_two:
			Serializer._student_list[i] = new_students
		
	print(Serializer._student_list)
	
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
		
	if entered && modifier && button_right_released && edit:
		emit_signal("remove_table", [self, id])
		
func mover(pos: Vector2) -> void:
	relative_position = pos
	
	pos.x = Global.map(pos.x, 0, 16, 0, Global._editor_size.x)
	pos.y = Global.map(pos.y, 0, 9, 0, Global._editor_size.y)
	
	pos.x = clamp(pos.x, Global._editor_scale, Global._editor_size.x - Global._editor_scale)
	pos.y = clamp(pos.y, Global._editor_scale/2, Global._editor_size.y - Global._editor_scale/2)
	
	self.position = pos
	
	_on_window_resize()
		
func rotater(degrees) -> void:
	self.rotate(deg2rad(degrees))
	student_left.rect_rotation -= degrees
	student_right.rect_rotation -= degrees
		
func _on_mouse_entered():
	mouse_entered_event = true

func _on_mouse_exited():
	mouse_entered_event = false

func _set_current_students(students):
	current_students = students
