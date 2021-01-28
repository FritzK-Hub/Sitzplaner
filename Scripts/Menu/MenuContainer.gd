extends VBoxContainer


func _on_PositionMode_toggled(button_pressed):
	Global._edit_mode = button_pressed
	print(Global._edit_mode)


func _on_HSlider_value_changed(value):
	Global.s = value


func _on_FontSlider_value_changed(value):
	Global.font_s = value
