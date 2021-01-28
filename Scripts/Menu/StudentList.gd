extends VBoxContainer

export var student_menu_resource: Resource

var student_menu_arr: Array

var popup_dialog


func _on_Menu_file_loaded():
	for i in self.get_children():
		i.queue_free()
	
	#print(Serializer._student_list)
	for i in Serializer._student_list:
		var student_instance_one: Control = load(student_menu_resource.resource_path).instance()
		var student_instance_two: Control = load(student_menu_resource.resource_path).instance()
		add_child(student_instance_one)
		add_child(student_instance_two)
		
		student_instance_one.get_node("./StudentButton/HBoxContainer/Fullname").text = str(" " + i[0][0] + " " + i[0][1])
		student_instance_one.get_node("./StudentButton/HBoxContainer/Firstname").text = i[0][0]
		student_instance_one.get_node("./StudentButton/HBoxContainer/Lastname").text = i[0][1]
		
		student_instance_two.get_node("./StudentButton/HBoxContainer/Fullname").text = str(" " + i[1][0] + " " + i[1][1])
		student_instance_two.get_node("./StudentButton/HBoxContainer/Firstname").text = i[1][0]
		student_instance_two.get_node("./StudentButton/HBoxContainer/Lastname").text = i[1][1]




func _on_Add_add_pressed():
	_on_Menu_file_loaded()
