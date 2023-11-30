extends Node3D

signal sustractil_efectuado
signal perder_vida

func _input(event):
	if event is InputEventMouseMotion:
		# Restringir movimiento
		if  (self.rotation_degrees.x > -13 and event.relative.y < 0) or (self.rotation_degrees.x < 13 and event.relative.y > 0):
			self.rotation.x += event.relative.y / GLOBAL.sensibilidad_mouse_y
		if event.relative.x != 0:
			self.rotation.y += -event.relative.x / GLOBAL.sensibilidad_mouse_x
	if Input.is_action_just_pressed("siames_1_disparo_1"):
		emit_signal("sustractil_efectuado", "color_0")
	elif Input.is_action_just_pressed("siames_1_disparo_2"):
		emit_signal("sustractil_efectuado", "color_1")
	elif Input.is_action_just_pressed("siames_2_disparo_1"):
		emit_signal("sustractil_efectuado", "color_2")
	elif Input.is_action_just_pressed("siames_2_disparo_2"):
		emit_signal("sustractil_efectuado", "color_3")
	elif Input.is_action_just_pressed("reset_crosshair"):
		self.rotation = Vector3(0, 0, 0)

	
#func _process(_delta):
	#if Input.is_action_pressed("siames_1_disparo_1"):
		#emit_signal("sustractil_efectuado", "color_0")
	#elif Input.is_action_pressed("siames_1_disparo_2"):
		#emit_signal("sustractil_efectuado", "color_1")
	#elif Input.is_action_pressed("siames_2_disparo_1"):
		#emit_signal("sustractil_efectuado", "color_2")
	#elif Input.is_action_pressed("siames_2_disparo_2"):
		#emit_signal("sustractil_efectuado", "color_3")

