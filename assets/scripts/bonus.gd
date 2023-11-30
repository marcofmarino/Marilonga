extends Node3D

@export var color_propio: String = ""
@export var siameses: Node3D = null

@export var speed: float = 1

signal absorbido

func _ready():
	$AnimatedSprite3D.animation = color_propio
	$AnimatedSprite3D.play(color_propio)
	#match color_propio:
		#"color_0":
			#$Sprite3D.modulate = GLOBAL.color_0
		#"color_1":
			#$Sprite3D.modulate = GLOBAL.color_1
		#"color_2":
			#$Sprite3D.modulate = GLOBAL.color_2
		#"color_3":
			#$Sprite3D.modulate = GLOBAL.color_3

func es_absorbida(color_sustractil):
	if color_propio == color_sustractil:
		if ((color_propio == "color_1" or color_propio == "color_0") and GLOBAL.ultimo_raycast == "siames_1") or ((color_propio == "color_2" or color_propio == "color_3") and GLOBAL.ultimo_raycast == "siames_2"):
			get_parent().sustractil_efectuado(color_propio)
			emit_signal("absorbido")
			queue_free()

func escapa():
	queue_free()

func _process(delta):
	self.position.z += speed * delta
