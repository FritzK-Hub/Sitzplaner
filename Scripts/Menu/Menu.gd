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
	
	json_parse_result = JSON.parse(selected_file.get_as_text()).result
	
	selected_file.close()
	
	file_content_to_serializer()
	emit_signal("file_loaded")
	
func file_content_to_serializer() -> void:
	Serializer._className = json_parse_result.get("className")
	Serializer._table_list = json_parse_result.get("tables")
	Serializer._student_list = json_parse_result.get("students")
	
	print(Serializer._student_list)


func _on_Save_pressed():
	file_dialog 				= FileDialog.new()
	file_dialog.mode 			= FileDialog.MODE_SAVE_FILE
	file_dialog.access 			= FileDialog.ACCESS_FILESYSTEM
	file_dialog.rect_size 		= Vector2(Global._editor_size.x * 0.5, Global._editor_size.y * 0.4)
	file_dialog.rect_position 	= Vector2(Global._editor_size.x * 0.25, Global._editor_size.y * 0.25)
	file_dialog.set_filters		( PoolStringArray(["*.spd ; SitzPlaner Datafile"]))
	file_dialog.connect("file_selected", self, "_on_save_file_selected")
	
	add_child(file_dialog)
	file_dialog.popup()

func _on_save_file_selected(selected_file_path: String) -> void:
	var c_name = Serializer._className
	var student_list = Serializer._student_list
	var table_list = Serializer._table_list
	
	#var base_arr = []
	
	var dict = {"className":c_name}
	
	dict["tables"] = table_list
	dict["students"] = student_list
	
	#base_arr.append(dict)
	
	var file:File = File.new()
	file.open(selected_file_path, File.WRITE)
	file.store_string(JSON.print(dict, "\t"))
	file.close()




func _on_ClassnameLabel_text_changed(new_text):
	Serializer._className = new_text
