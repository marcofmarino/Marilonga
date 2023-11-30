extends Node3D

func _ready():
	$Siameses.rotation = GLOBAL.posicion_siameses
	$Camera3D/AnimationPlayer.play("ganar")

func _on_timer_timeout():
	GLOBAL.posicion_siameses = $Siameses.rotation
	GLOBAL.cambiar_estado("menu")

func _on_animation_player_animation_finished(_anim_name):
	$Timer.start()
