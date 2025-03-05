shader_type spatial;
render_mode blend_mix, depth_draw_opaque, cull_disabled, diffuse_toon, specular_toon;

uniform vec4 base_color : source_color = vec4(0.6);
uniform sampler2D color_gradient;
uniform sampler2D fresnel_gradient;
uniform float fresnel_strength = 4.0;
uniform float shadow_softness = 2.1;
uniform float light_clamp = 0.9;

float fresnel(float amount, vec3 normal, vec3 view) {
	return pow((1.0 - clamp(dot(normalize(normal), normalize(view)), 0.0, 1.0)), amount);
}

void fragment() {
	float basic_fresnel = fresnel(fresnel_strength, NORMAL, VIEW);
	ALBEDO = base_color.rgb + (basic_fresnel * texture(fresnel_gradient, vec2(basic_fresnel, 0.0)).rgb * 1.0);
}

void light() {
	float dotproduct = clamp(dot(NORMAL, LIGHT), -light_clamp, light_clamp);
	float sample = clamp((dotproduct + 1.0) * ATTENUATION / shadow_softness, 0.05, 0.95);
	vec4 shaded = texture(color_gradient, vec2(sample, 0.0));
	DIFFUSE_LIGHT = clamp(shaded.rgb * LIGHT_COLOR, 0.0, 1.0);
}
