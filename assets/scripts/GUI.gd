extends CanvasLayer

func _ready():
	$viditas/Margen/Control2/Container/AnimatedSprite2D.animation = "3_vidas"
	$viditas/Margen/Control2/Container/AnimatedSprite2D.play("3_vidas")
	$viditas/Margen/Control/TextureProgressBar.max_value = GLOBAL.puntaje_para_ganar

func _on_perder_vida():
	var frame = $viditas/Margen/Control2/Container/AnimatedSprite2D.frame
	match GLOBAL.vidas:
		2:
			$viditas/Margen/Control2/Container/AnimatedSprite2D.animation = "2_vidas"
			$viditas/Margen/Control2/Container/AnimatedSprite2D.frame =  frame
			$viditas/Margen/Control2/Container/AnimatedSprite2D.play("2_vidas")
		1:
			$viditas/Margen/Control2/Container/AnimatedSprite2D.animation = "1_vida"
			$viditas/Margen/Control2/Container/AnimatedSprite2D.frame =  frame
			$viditas/Margen/Control2/Container/AnimatedSprite2D.play("1_vida")

func _process(_delta):
	$viditas/Margen/Control/TextureProgressBar.value = GLOBAL.puntaje
