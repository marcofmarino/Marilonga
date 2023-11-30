extends Node

var vidas: int = 3
var sensibilidad_mouse_x: int = 2000
var sensibilidad_mouse_y: int = 1000
var ultimo_raycast: String = ""
var puntaje: int = -2
var puntaje_para_ganar: int = 30

var posicion_siameses: Vector3

const color_0: Color = Color("00b6f0")
const color_1: Color = Color("94c120")
const color_2: Color = Color("e4171e")
const color_3: Color = Color("ffdd11")

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED # Ocultar y restringir cursor

func cambiar_estado(estado):
	match estado:
		"menu":
			get_tree().change_scene_to_file("res://scenes/menu.tscn")
		"cinematica":
			get_tree().change_scene_to_file("res://scenes/cinematica.tscn")
		"nivel":
			get_tree().change_scene_to_file("res://scenes/nivel.tscn")
		"perder":
			get_tree().change_scene_to_file("res://scenes/perder.tscn")
		"ganar":
			get_tree().change_scene_to_file("res://scenes/ganar.tscn")

# Función para convertir un rango de números a otro
#func map_range(value, istart, istop, ostart, ostop):
#	return ostart + (ostop - ostart) * ((value - istart) / (istop - istart))
