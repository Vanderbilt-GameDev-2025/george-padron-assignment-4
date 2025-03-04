shader_type spatial;

uniform int toon_steps : hint_range(2, 8) = 4; // number of shading steps
uniform vec3 light_dir = vec3(0.0, 1.0, 0.0);  // light direction (adjust as needed)
uniform float ambient_strength : hint_range(0.0, 1.0) = 0.2; // ambient term
uniform vec3 base_color : source_color = vec3(1.0, 1.0, 1.0);

void fragment() {
    // Normalize the normal and light direction
    vec3 N = normalize(NORMAL);
    vec3 L = normalize(light_dir);
    
    // Calculate basic diffuse lighting
    float diff = max(dot(N, L), 0.0);
    
    // Quantize the diffuse term into steps (cell shading effect)
    diff = floor(diff * float(toon_steps)) / float(toon_steps);
    
    // Combine with an ambient term and apply the base color
    ALBEDO = base_color * (ambient_strength + diff);
}
