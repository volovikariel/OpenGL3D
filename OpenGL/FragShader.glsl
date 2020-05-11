#version 330 core
out vec4 FragColour;

in vec3 normal;
in vec3 fragPos;

uniform vec3 objectColour;
uniform vec3 lightColour;
uniform vec3 lightPos;
uniform vec3 viewPos;


void main() {

	// Ambient
	float ambientStrength = 0.1;
	vec3 ambientLight = ambientStrength * lightColour;

	// Diffuse
	vec3 norm = normalize(normal);
	vec3 lightDirection = normalize(lightPos - fragPos);

	float diffuseImpact = max(dot(norm, lightDirection), 0.0);
	vec3 diffuse = diffuseImpact * lightColour;

	// Specular 
	float specularStrength = 0.5;
	vec3 viewDirection = normalize(viewPos - fragPos);
	vec3 reflectDirection = reflect(-lightDirection, norm); // -light because expects light FROM the object 

	float spec = pow(max(dot(viewDirection, reflectDirection), 0.0), 32);
	vec3 specular = specularStrength * spec * lightColour;

	vec3 result = (ambientLight + diffuse + specular) * objectColour;

	FragColour = vec4(result, 1.0);
}