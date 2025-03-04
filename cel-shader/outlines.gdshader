shader_type spatial;
render_mode cull_front, unshaded; 

uniform float outline_thickness = 0.01;
uniform vec4 outline_color = vec4(0.0, 0.0, 0.0, 1.0);  // Black by default

void vertex() {
	
	VERTEX += NORMAL * outline_thickness;
}

void fragment() {
	ALBEDO = outline_color.rgb;
}
