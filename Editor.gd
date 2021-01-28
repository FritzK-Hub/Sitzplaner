extends Control


export var Table: Resource


var table_list: Array
var table_resource: PackedScene

var grid_x = 20
var grid_y

var id = -1

func _ready():
	table_resource = load(Table.resource_path)
	for i in range(10):
		instance_at(Vector2(i*200, 200), new_id())
		

func _input(event):
	if Input.is_action_pressed("modifier"):
		if Input.is_action_just_released("left_click") && Global._edit_mode:
			instance_at(get_global_mouse_position(), new_id())

func instance_at(pos: Vector2, _id: int) -> void:
	var instance: Node2D = table_resource.instance()
	add_child(instance)
	table_list.append(instance)
	get_parent().connect("window_resize", instance, "_on_window_resize")
	instance.connect("remove_table", self, "_on_remove_table")
	instance.call("mover", pos)
	instance.id = _id

func _on_remove_table(parameters):
	table_list.remove(table_list.find(parameters[0]))
	print(table_list)
	remove_child(parameters[0])

func new_id():
	id += 1
	return id
