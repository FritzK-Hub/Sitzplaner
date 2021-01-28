extends LineEdit



func _on_Menu_file_loaded():
	self.text = Serializer._className
