extends Node3D

@export var color_propio: String = ""
@export var speed: float = 20
#@export var siameses: Node3D = null
@export var camara: Camera3D = null
var direccion

func _ready():
#	direccion = siameses.get_global_position() - self.global_position
#	direccion = camara.get_global_position() - get_global_position()
	look_at(camara.get_global_position())

	match color_propio:
		"color_0":
#			material_nuevo.albedo_color = Color("00dcff") AZUL
			$AnimatedSprite3D.modulate = GLOBAL.color_0
		"color_1":
#			material_nuevo.albedo_color = Color("33EE99") VERDE
			$AnimatedSprite3D.modulate = GLOBAL.color_1
		"color_2":
#			material_nuevo.albedo_color = Color("ee2288") ROJO
			$AnimatedSprite3D.modulate = GLOBAL.color_2
		"color_3":
#			material_nuevo.albedo_color = Color("888822") AMARILLO
			$AnimatedSprite3D.modulate = GLOBAL.color_3
	$AnimatedSprite3D.play("default")
	$AnimatedSprite3D/AnimatedSprite3D2.play("default")

func _process(delta):
#	self.position += direccion.normalized() * speed * delta
	position -= position.normalized()*speed*delta

func _on_area_3d_area_entered(_area):
	GLOBAL.puntaje += 1
	queue_free()
