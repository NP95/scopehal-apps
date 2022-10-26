#version 150 //hack: brought up from version 130 for apple compat, make dynamic if this hurts other platforms

in vec2 			texcoord;
uniform sampler2D	fbtex;
uniform sampler2D	ramp;

out vec4 			finalColor;

void main()
{
	if( (texcoord.x < 0) || (texcoord.x > 1) )
		discard;

	//Look up the intensity value and clamp it
	vec4 yvec = texture(fbtex, vec2(texcoord));
	float y = yvec.r;
	if(y >= 0.99)
		y = 0.99;
	if(y < 0.001)
		discard;

	//Look up the actual color
	vec2 pos;
	pos.x = y;
	pos.y = 0.5;
	vec4 color = texture(ramp, pos);

	finalColor.r = color.r;
	finalColor.g = color.g;
	finalColor.b = color.b;
	finalColor.a = 1;
}
