extends Node3D

func _ready() -> void:
	var outline_material = self.material.next_pass
	
	var tween = create_tween()
	tween.set_loops()
	tween.set_trans(Tween.TRANS_SINE)
	tween.set_ease(Tween.EASE_IN_OUT)
	
	# Lighting animation
	tween.parallel().tween_method(
		func(value): self.material.set_shader_parameter("fresnel_strength", value), 
		2.0, 10.0, 0.5
	)
	tween.parallel().tween_method(
		func(value): self.material.set_shader_parameter("fresnel_strength", value), 
		10.0, 2.0, 0.5
	)
	# Border Animation
	tween.parallel().tween_method(
		func(value): 
			outline_material.set_shader_parameter('outline_thickness', value / 10.0),
		0.0, 0.55, 1.0
	)
	tween.parallel().tween_method(
		func(value): 
			outline_material.set_shader_parameter('outline_thickness', value / 10.0),
		0.055, 0.0, 1.0
	)
