extends Control

var dynamic_font

var mouse_entered_event = false
var current_font_size = 0
var current_size = 120

func _ready():
	dynamic_font = DynamicFont.new()
	dynamic_font.font_data = load("res://Assets/Fonts/JosefinSansBold-OVA7o.ttf")
	set_font(20)

func _physics_process(delta):
	var filter_mode = $StudentButton.mouse_filter
	
	if Global._edit_mode and filter_mode == Control.MOUSE_FILTER_STOP:
		$StudentButton.mouse_filter = Control.MOUSE_FILTER_IGNORE
		
	if !Global._edit_mode and filter_mode == Control.MOUSE_FILTER_IGNORE:
		$StudentButton.mouse_filter = Control.MOUSE_FILTER_STOP
	
	var g_scale = Global._editor_scale
	var g_size	= g_scale * 0.78
	current_size = g_size
		
	if current_font_size != Global.font_s:
		current_font_size = Global.font_s
		set_font(current_size/current_font_size)

func _input(event):
	var button_left_released	= Input.is_action_just_released("left_click")
	var entered					= mouse_entered_event 
	var edit 					= Global._edit_mode
	var drag_mode				= Global._drag_mode
	
	if entered && !edit && !Global._switched:
		print("released")
		$StudentButton/Label.text = Global._current_student.get_node("./StudentButton/HBoxContainer/Name").text
		Global._switched = true
	
func _on_table_resize(size) -> void:
	current_size = size[0]
	set_font(size[0]/Global.font_s)

func set_font(size):
	dynamic_font.size = size
	$StudentButton/Label.set("custom_fonts/font", dynamic_font)
	
func set_name(name):
	$StudentButton/Label.text = name


func _on_StudentButton_mouse_entered():
	mouse_entered_event = true


func _on_StudentButton_mouse_exited():
	mouse_entered_event = false
