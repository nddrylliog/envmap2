// Position of the view eye in world space
uniform vec3 eyePos;

// Ratio of indices of refraction
uniform float etaRatio;

// Reflected and refracted vectors
varying vec3 reflectedVector, refractedVector;

// Reflection factor based on fresnel equation
varying float refFactor;

void main()
{
	// Create incident and normal vectors
	vec3 I = normalize(gl_Vertex.xyz - eyePos.xyz);
	vec3 N = normalize(gl_Normal);
	
	// Calculate reflected and refracted vectors
	reflectedVector = reflect(I, N);
	refractedVector = refract(I, N, etaRatio);
	

	// Compute cos(incident angle) for the fresnel equations
	float cosThetaI = dot(I,N);
	
	// Real fresnel equation
	refFactor = (etaRatio * sqrt(1 - (1 - cosThetaI * cosThetaI)*etaRatio*etaRatio) - cosThetaI);
	refFactor = refFactor/ (etaRatio * sqrt(1 - (1 - cosThetaI * cosThetaI)*etaRatio*etaRatio) + cosThetaI);
	redFactor = refFactor * refFactor;

	// Transform vertex
	gl_TexCoord[0] = gl_MultiTexCoord0;
	gl_Position = ftransform();
}