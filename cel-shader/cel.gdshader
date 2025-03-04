shader_type spatial;

uniform vec4 base_color= vec4(1.0); 
uniform sampler2D texture_albedo; 
uniform float color_bands = 3.0; 
uniform float specular_cutoff = 0.9; 
uniform float specular_size = 0.2; 
uniform vec4 specular_color = vec4(1.0); 

// Rim light parameters 
uniform vec4 rim_color = vec4(0.5, 0.7, 1.0, 1.0); 
uniform float rim_threshold = 0.5; 
uniform float rim_power = 2.0; 

varying vec3 world_normal; 
varying vec3 view_dir; 

void vertex() {
	world_normal = normalize((MODEL_MATRIX * vec4(NORMAL, 0.0)).xyz);
	view_dir = normalize(INV_VIEW_MATRIX[3].xyz - (MODEL_MATRIX * vec4(VERTEX, 1.0)).xyz); 
}

void fragment() {
	// Base texture color
	vec4 tex_color = texture(texture_albedo, UV); 
	ALBEDO = tex_color.rgb * base_color.rgb; 
	
	// Rim lighting calculation 
	float rim = 1.0 - dot(world_normal, view_dir); 
	rim = smoothstep(rim_threshold, rim_threshold + 0.2, rim); 
	EMISSION = rim_color.rgb * pow(rim, rim_power); 
}

void light() {
	vec3 light_dir = normalize(-LIGHT);
	
	float NdotL = max(dot(world_normal, light_dir), 0.0);
	float stepped_diffuse = floor(NdotL * color_bands) / color_bands; 
	
	// Sharp specular highlights
	vec3 reflect_dir = reflect(-light_dir, world_normal); 
	float specular = dot(view_dir, reflect_dir); 
	specular = smoothstep(specular_cutoff, specular_cutoff + specular_size, specular);
	
	vec3 light_contrib = (stepped_diffuse * ATTENUATION + specular) * LIGHT_COLOR.rgb;
	DIFFUSE_LIGHT += light_contrib * ALBEDO;  
}
