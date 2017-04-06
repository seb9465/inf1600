
#include <stdio.h>

unsigned int Decryption_fct(unsigned int le)
{
	unsigned int be;

	/*
	 * Remplacez le code suivant par de l'assembleur en ligne
	 * en utilisant le moins d'instructions possible
	 */
	 //be = (le & 0xff000000) | (le&0xff) << 16  | (le & 0xff00) | (le & 0xff0000) >> 16;
	 
	

	asm volatile ( "movl %1, %0;"
			"rol $8, %0;"		//Rotate left
		  	"bswap %0;"		//Byte swap
		 	: "=r"(be)		//Sorties (s'il y a lieu)
		 	: "r"(le)    		//Entrées
		 	: 		 	//Registres modifiés (s'il y a lieu)
	);

	return be;
}

int main()
{
	unsigned int data = 0xeeaabbff;

	printf("Représentation crypte en little-endian:   %08x\n"
	       "Représentation decrypte en big-endian:    %08x\n",
	       data,
	       Decryption_fct(data));

	return 0;
}
