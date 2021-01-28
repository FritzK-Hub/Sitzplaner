extends Button

signal add_pressed

func _on_Add_pressed():
	var firstname = $"../firstname".text
	var lastname = $"../lastname".text
	if firstname != "" && lastname != "":
		Serializer._student_list.append([firstname, lastname])
		emit_signal("add_pressed")
