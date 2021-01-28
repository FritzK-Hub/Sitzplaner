extends Control


export var Table: Resource


var table_list: Array
var table_resource: PackedScene

var grid_x = 20
var grid_y


func _ready():
	table_resource = load(Table.resource_path)
	#for i in range(10):
	#	instance_at(Vector2(i*200, 200))
		

func _input(event):
	if Input.is_action_pressed("modifier"):
		if Input.is_action_just_released("left_click") && Global._edit_mode:
			var m = get_global_mouse_position()
			var temp_x = Global.map(m.x, 0, Global._editor_size.x, 0, 16)
			var temp_y = Global.map(m.y, 0, Global._editor_size.y, 0, 9)
			instance_at([[" ", " "], [" ", " "], temp_x, temp_y])


func instance_at(students: Array) -> void:
	var instance: Node2D = table_resource.instance()
	add_child(instance)
	table_list.append(instance)
	instance.call("set_student_left_name", students[0][0])
	instance.call("set_student_right_name", students[1][0])
	instance.call("_set_current_students", students)
	
	get_parent().connect("window_resize", instance, "_on_window_resize")
	instance.connect("remove_table", self, "_on_remove_table")
	instance.call("mover", Vector2(students[2], students[3]))
	
	
	
func _on_remove_table(parameters):
	table_list.remove(table_list.find(parameters[0]))
	print(table_list)
	remove_child(parameters[0])



func _on_Menu_file_loaded():
	if table_list.size() > 0:
		for i in table_list:
			i.queue_free()
		
	for i in Serializer._student_list:
		instance_at(i)
