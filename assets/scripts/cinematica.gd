extends Node3D

var contador = 0

func _ready():
	contador = 0
	$Siameses.rotation = GLOBAL.posicion_siameses
	$Camera3D/AnimationPlayer.play("cinematica")

func _on_animation_player_animation_finished(_anim_name):
	$Timer.start()

func _on_timer_timeout():
	GLOBAL.posicion_siameses = $Siameses.rotation
	GLOBAL.cambiar_estado("nivel")
