extends Node3D

var marilyn: Area3D
var escena_marilyn = preload("res://scenes/marilyn.tscn")
var escena_bonus = preload("res://scenes/bonus.tscn")
var escena_sustractil = preload("res://scenes/sustractil.tscn")

var piso_color: StandardMaterial3D = preload("res://assets/materials/piso_color.tres")

var pared_der_0: StandardMaterial3D = preload("res://assets/materials/pared_der_0.tres")
var pared_der_1: StandardMaterial3D = preload("res://assets/materials/pared_der_1.tres")
var pared_der_2: StandardMaterial3D = preload("res://assets/materials/pared_der_2.tres")

var pared_izq_0: StandardMaterial3D = preload("res://assets/materials/pared_izq_0.tres")
var pared_izq_1: StandardMaterial3D = preload("res://assets/materials/pared_izq_1.tres")
var pared_izq_2: StandardMaterial3D = preload("res://assets/materials/pared_izq_2.tres")

var techo_0: StandardMaterial3D = preload("res://assets/materials/techo_0.tres")
var techo_1: StandardMaterial3D = preload("res://assets/materials/techo_1.tres")
var techo_2: StandardMaterial3D = preload("res://assets/materials/techo_2.tres")

var piso_0: StandardMaterial3D = preload("res://assets/materials/piso_0.tres")
var piso_1: StandardMaterial3D = preload("res://assets/materials/piso_1.tres")
var piso_2: StandardMaterial3D = preload("res://assets/materials/piso_2.tres")

var fondo_0: StandardMaterial3D = preload("res://assets/materials/fondo_0.tres")

var nivel: int = -1
var inicio_nivel_2: bool = false

var cant_marilyns: int = 1

signal perder_vida

func _ready():
	$CamaraPrincipal/SubViewportContainer/SubViewport.size = $CamaraPrincipal/SubViewportContainer.size
	$CamaraPrincipal/SubViewportContainer/SubViewport2.size = $CamaraPrincipal/SubViewportContainer.size
	$Siameses.rotation = GLOBAL.posicion_siameses
	$Decoracion/Gabinete/AnimationPlayer.current_animation = "idle"
	$Decoracion/Planta/Planta/AnimationPlayer.current_animation = "idle"

func _input(_event):
	if Input.is_action_pressed("sumar_puntos"):
		GLOBAL.puntaje+=1
	if Input.is_action_just_pressed("siames_1_disparo_1") or Input.is_action_just_pressed("siames_1_disparo_2") or Input.is_action_just_pressed("siames_2_disparo_1") or Input.is_action_just_pressed("siames_2_disparo_2"):
		if marilyn == null:
			fallo()

func ganado():
	$TimerSpawn.stop()
	nivel = 33
	$Oficina/ParedDer.material_override = pared_der_2
	$Oficina/ParedIzq.material_override = pared_izq_2
	$Oficina/Techo.material_override = techo_2
	$Oficina/PisoFinal.material_override = piso_2
	$Oficina/Fondo.material_override = fondo_0
	$Decoracion/Gabinete/AnimationPlayer.play("fall")
	for marilyn_ in $Marilyns.get_children():
		marilyn_.speed = 0
		marilyn_.estado = "absorcion"
		marilyn_.get_child(0).set_collision_layer_value(16, true)
		marilyn_.get_child(0).set_collision_layer_value(1, false)
		marilyn_.get_child(1).animation = marilyn_.color + "_absorcion"
		marilyn_.get_child(1).play(marilyn_.color + "_absorcion")
		
	$TimerGanar.start()

func _physics_process(_delta):
	$RaySiames1.look_at($Siameses/Siames1/Crosshair.get_global_position())
	$RaySiames2.look_at($Siameses/Siames2/Crosshair.get_global_position())
	
	if $RaySiames1.is_colliding():
		marilyn = $RaySiames1.get_collider()
		GLOBAL.ultimo_raycast = "siames_1"
	elif $RaySiames2.is_colliding():
		marilyn = $RaySiames2.get_collider()
		GLOBAL.ultimo_raycast = "siames_2"
	else:
		marilyn = null

	if GLOBAL.puntaje >= GLOBAL.puntaje_para_ganar and nivel != 33:
		ganado()
		#GLOBAL.posicion_siameses = $Siameses.rotation
		#
		#GLOBAL.cambiar_estado("ganar")

	if nivel == -1 and $Marilyns.get_child_count() == 0:
		nivel += 1
		$TimerSpawn.start()
	
	if GLOBAL.puntaje > 4 and nivel == 0:
		nivel += 1
		inicio_nivel_2 = true
		cant_marilyns = 2
		$TimerSpawn.wait_time = 4
		$Oficina/ParedDer.material_override = pared_der_0
		$Oficina/ParedIzq.material_override = pared_izq_0
		$Oficina/Techo.material_override = techo_0
		$Oficina/PisoFinal.material_override = piso_0

	if GLOBAL.puntaje > 20 and nivel == 1:
		nivel+=1
		cant_marilyns = 4
		#$Decoracion/Planta/Planta.layers = 4
		$Decoracion/Planta/Planta/AnimationPlayer.current_animation = "fall"
		$TimerSpawn.wait_time = 2.5
		$Oficina/ParedDer.material_override = pared_der_1
		$Oficina/ParedIzq.material_override = pared_izq_1
		$Oficina/Techo.material_override = techo_1
		$Oficina/PisoFinal.material_override = piso_1

func _on_siameses_sustractil_efectuado(color_sustractil):
	#if not ($RaySiames1.is_colliding() or $RaySiames2.is_colliding()):
		#fallo()
	if is_instance_valid(marilyn):
		marilyn.get_parent().es_absorbida(color_sustractil)

func fallo():
	$Siameses/AnimationPlayer.play("fail")

func _on_timer_spawn_timeout():
	var spawns = $Spawns.get_children()
	var spawn
	for i in range(cant_marilyns):
		randomize()
		var nueva_marilyn = escena_marilyn.instantiate()
		nueva_marilyn.color_propio = ["color_0", "color_1", "color_2", "color_3"].pick_random()
		var color
		match nueva_marilyn.color_propio:
			"color_0":
				color = "azul"
			"color_1":
				color = "verde"
			"color_2":
				color = "rojo"
			"color_3":
				color = "amarillo"
		nueva_marilyn.estado = "aparicion"
		nueva_marilyn.speed = 0
		nueva_marilyn.get_child(1).animation = color + "_aparicion"
		nueva_marilyn.get_child(1).play(color + "_aparicion")

		spawn = spawns.pick_random()
		spawns.erase(spawn)
		nueva_marilyn.position = spawn.get_global_position()
		nueva_marilyn.rotation = spawn.rotation
		$Marilyns.add_child(nueva_marilyn)

	var num = randi_range(0, 100)
	if inicio_nivel_2 or (nivel > 0 and num > 98):
		inicio_nivel_2 = false
		var bonus = escena_bonus.instantiate()
		bonus.color_propio = ["color_0", "color_1", "color_2", "color_3"].pick_random()
		spawn = spawns.pick_random()
		bonus.position = spawn.get_global_position()
#		bonus.rotation = spawn.rotation
		add_child(bonus)
		bonus.absorbido.connect(_on_bonus_absorbido.bind())

func _on_objetivo_marilyn_area_entered(area):
	GLOBAL.vidas -= 1
	area.get_parent().escapa()
	var mat = $GlitchNode/GlitchTexture.material
	mat.set_shader_parameter("noiseIntensity", 0.01)
	mat.set_shader_parameter("noiseQuality", 80)
	$GlitchNode/GlitchTimer.start()

	if GLOBAL.vidas <= 0:
		GLOBAL.cambiar_estado("perder")
		return
	emit_signal("perder_vida")

func _on_bonus_absorbido():
	for marilyn_ in $Marilyns.get_children():
		marilyn_.speed = 0
		marilyn_.estado = "bonus"
		marilyn_.get_child(0).set_collision_layer_value(16, false)
		marilyn_.get_child(0).set_collision_layer_value(1, true)
		marilyn_.get_child(1).animation = marilyn_.color + "_bonus"
		marilyn_.get_child(1).play(marilyn_.color + "_bonus")
		
		$BonusTimer.start()

func _on_glitch_timer_timeout():
	var mat = $GlitchNode/GlitchTexture.material
	mat.set_shader_parameter("noiseIntensity", 0.002)
	mat.set_shader_parameter("noiseQuality", 235)

func _on_bonus_timer_timeout():
	for marilyn_ in $Marilyns.get_children():
		if marilyn_.estado == "bonus":
			marilyn_.get_child(1).animation = marilyn_.color + "_correr"
			marilyn_.get_child(1).play(marilyn_.color + "_correr")
			marilyn_.estado = "correr"
			marilyn_.speed = 1

func _on_objetivo_bonus_area_entered(area):
	area.get_parent().queue_free()

func sustractil_efectuado(color_asd):
	var sustractil_nuevo = escena_sustractil.instantiate()
	sustractil_nuevo.color_propio = color_asd
#	sustractil_nuevo.siameses = $Siameses
	sustractil_nuevo.camara = $CamaraPrincipal
	sustractil_nuevo.position = marilyn.get_global_position()
	$Sustractil.add_child(sustractil_nuevo)


func _on_timer_ganar_timeout():
	GLOBAL.posicion_siameses = $Siameses.rotation
	GLOBAL.cambiar_estado("ganar")
