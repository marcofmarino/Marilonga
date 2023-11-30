extends Node3D

func _ready():
	GLOBAL.puntaje = -2
	GLOBAL.vidas = 3
	$Siameses.rotation = GLOBAL.posicion_siameses
	$CanvasLayer/Control/AnimatedSprite2D.play("default")

func _on_siameses_sustractil_efectuado(_color):
	GLOBAL.posicion_siameses = $Siameses.rotation
	GLOBAL.cambiar_estado("cinematica")

func _process(_delta):
	pass
