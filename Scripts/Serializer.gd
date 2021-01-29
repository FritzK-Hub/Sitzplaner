extends Node


var s = 1
var _dimension_ratio: Vector2	=	Vector2(16.0*s, 9.0*s)
var _editor_scale: float		=	120
var _editor_size: Vector2		= 	Vector2(OS.get_window_safe_area().size.x, OS.get_window_safe_area().size.x / (_dimension_ratio.x / _dimension_ratio.y))


var _className: String = "Class Name"
var _student_list: Array
var _table_list: Array
