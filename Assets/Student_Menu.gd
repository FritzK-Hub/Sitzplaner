extends Control

export var dragable_student: Resource

var instance: Control

func _on_StudentButton_button_down():
	if Global._drag_mode == false:
		Global._drag_mode = true
		instance = load(dragable_student.resource_path).instance()
		get_node("/root").add_child(instance)
		instance.get_node("./StudentButton/HBoxContainer/Name").text = $StudentButton/HBoxContainer/Firstname.text
		instance.rect_position = get_global_mouse_position() + Vector2(0,-32)
		Global._current_student = instance

func _input(event):
	var left_click_pressed = Input.is_action_pressed("left_click")
	var left_click_released = Input.is_action_just_released("left_click")
	var drag_mode = Global._drag_mode
	var current_student = Global._current_student
	
	if left_click_pressed && drag_mode && current_student != null:
		current_student.rect_position = get_global_mouse_position() + Vector2(0,-32)
		Global._switched = false
	if left_click_released && drag_mode && current_student != null:
		get_node("/root").remove_child(current_student)
		Global._drag_mode = false
