extends Control


signal window_resize

var current_window_size = OS.get_window_safe_area().size
var local_s = Global.s

func _ready():
	current_window_size = OS.get_window_safe_area().size
	self.rect_size = current_window_size
	$Editor.rect_size = Vector2(current_window_size.x, current_window_size.x / (Global._dimension_ratio.x / Global._dimension_ratio.y))
	Global._editor_size = $Editor.rect_size
	Global._editor_scale = current_window_size.x / Global._dimension_ratio.x
	
	emit_signal("window_resize")

func _physics_process(delta):
	if current_window_size != OS.get_window_safe_area().size:
		current_window_size = OS.get_window_safe_area().size
		self.rect_size = current_window_size
		$Editor.rect_size = Vector2(current_window_size.x, current_window_size.x / (Global._dimension_ratio.x / Global._dimension_ratio.y))
		Global._editor_size = $Editor.rect_size
		Global._editor_scale = current_window_size.x / Global._dimension_ratio.x
		
		emit_signal("window_resize")
		
	
	if local_s != Global.s:
		local_s = Global.s
		Global._dimension_ratio = Vector2(16*local_s, 9*local_s)
		Global._editor_scale = current_window_size.x / Global._dimension_ratio.x
		print(Global.s)
		print(Global._editor_scale)
		print(Global._dimension_ratio)
		print("____________________")
		emit_signal("window_resize")

func _input(event):
	if event.is_action_pressed("toggle_fullscreen"):
		OS.window_fullscreen = !OS.window_fullscreen
		
	if event.is_action_pressed("close_program"):
		get_tree().quit()

func _notification(what):
	if what == MainLoop.NOTIFICATION_WM_QUIT_REQUEST:
		get_tree().quit() # default behavior
