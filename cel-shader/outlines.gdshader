shader_type spatial;
render_mode unshaded, cull_front;

uniform float outline_thickness : hint_range(0.0, 0.2) = 0.015; // adjust for thicker/thinner outlines
uniform vec4 outline_color : source_color = vec4(0.0, 0.0, 0.0, 1.0); // black outline

void vertex() {
    // Push vertices outward along their normal to create an outline
    VERTEX += NORMAL * outline_thickness;
}

void fragment() {
    // Render in a solid outline color
    ALBEDO = outline_color.rgb;
}
