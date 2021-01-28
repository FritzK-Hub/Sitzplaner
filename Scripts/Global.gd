extends Node

# EDITOR GLOBALS
var s = 1
var _dimension_ratio: Vector2	=	Vector2(16.0*s, 9.0*s)
var _editor_scale: float		=	120
var _editor_size: Vector2		= 	Vector2(OS.get_window_safe_area().size.x, OS.get_window_safe_area().size.x / (_dimension_ratio.x / _dimension_ratio.y))

# MENU GLOBALS
var _drag_mode: bool			=	false
var _switched: bool				=	true
var _current_student: Control

var _edit_mode: bool			=	true
var _menu_toggle: bool			=	false
