extends Node3D

@export var color_propio: String = ""
@export var siameses: Node3D = null
@export var speed: float = 1
@export var estado: String = "correr"

var color: String = ""

signal absorbida

func _ready():
	match color_propio:
		"color_0":
			color = "azul"
		"color_1":
			color = "verde"
		"color_2":
			color = "rojo"
		"color_3":
			color = "amarillo"
	if estado == "aparicion":
		$Area3D.set_collision_layer_value(16, true)
		$Area3D.set_collision_layer_value(1, false)
	$AnimatedSprite3D.animation = self.color + "_" + estado
	$AnimatedSprite3D.play(self.color + "_" + estado)

func es_absorbida(color_sustractil):
	if color_propio == color_sustractil and not estado == "absorcion":
		if ((color_propio == "color_1" or color_propio == "color_0") and GLOBAL.ultimo_raycast == "siames_1") or ((color_propio == "color_2" or color_propio == "color_3") and GLOBAL.ultimo_raycast == "siames_2"):
			get_parent().get_parent().sustractil_efectuado(color_propio)
			$Area3D.set_collision_layer_value(16, true)
			$Area3D.set_collision_layer_value(1, false)
			$AnimatedSprite3D.animation = self.color + "_absorcion"
			$AnimatedSprite3D.play(self.color + "_absorcion")
			estado = "absorcion"
#			queue_free()
		else:
			get_parent().get_parent().fallo()
	else:
		get_parent().get_parent().fallo()

func escapa():
	queue_free()

func _process(delta):
	if estado  == "correr":
		self.position.z += speed * delta

func _on_animated_sprite_3d_animation_finished():
	if estado == "absorcion":
		queue_free()
	elif estado == "aparicion":
		estado = "correr"
		$AnimatedSprite3D.animation = self.color + "_correr"
		$AnimatedSprite3D.play(self.color + "_correr")
		$Area3D.set_collision_layer_value(16, false)
		$Area3D.set_collision_layer_value(1, true)
		speed = 1
