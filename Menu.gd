extends Control

signal file_loaded

var file_dialog
var json_parse_result: Dictionary




func _process(delta):
	if Global._menu_toggle:
		self.margin_left = lerp(self.margin_left, -330, 0.2)
	else:
		self.margin_left = lerp(self.margin_left, 0, 0.2)



func _on_MenuToggle_pressed():
	Global._menu_toggle = !Global._menu_toggle



func _on_Load_pressed():
	file_dialog 				= FileDialog.new()
	file_dialog.mode 			= FileDialog.MODE_OPEN_FILE
	file_dialog.access 			= FileDialog.ACCESS_FILESYSTEM
	file_dialog.rect_size 		= Vector2(Global._editor_size.x * 0.5, Global._editor_size.y * 0.4)
	file_dialog.rect_position 	= Vector2(Global._editor_size.x * 0.25, Global._editor_size.y * 0.25)
	file_dialog.set_filters		( PoolStringArray(["*.spd ; SitzPlaner Datafile"]))
	file_dialog.connect("file_selected", self, "_on_file_selected")
	
	add_child(file_dialog)
	file_dialog.popup()
	
	

func _on_file_selected(path_to_selected_file: String) -> void:
	var selected_file = File.new()
	selected_file.open(path_to_selected_file, File.READ)
	
	json_parse_result = JSON.parse(selected_file.get_as_text()).result[0]
	
	selected_file.close()
	
	file_content_to_serializer()
	emit_signal("file_loaded")
	
func file_content_to_serializer() -> void:
	Serializer._className = json_parse_result.get("className")
	Serializer._student_list = json_parse_result.get("students")
