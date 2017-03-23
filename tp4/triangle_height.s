.data
        factor: .float 2.0 
.text
.globl	_ZNK9CTriangle9HeightAsmEv
           

_ZNK9CTriangle9HeightAsmEv:
        push %ebp      /* save old base pointer */
        mov %esp, %ebp /* set ebp to current esp */
        
        #   SUR LA PILE
        # +0    ancienne valeur de %ebp
        # +4    ancienne valeur de %eip (adresse de retour)
        # +8    adresse de l'objet Triangle
        
        #   DANS L'OBJET TRIANGLE
        # +0    Taille de VTable
        # +4    float mSides[0]
        # +8    float mSides[1]
        # +12   flaot mSides[2]

        mov     8(%ebp), %eax           # %eax = Objet Triangle;
        mov     0(%eax), %ebx           # %ebx = VTable;
        push    %eax
        call    *16(%ebx)               # Appel de la fonction AreaCpp().
                                        # st[0] = A;
        fld     factor                  # st[0] = 2.0f; st[1] = A;
        fmulp                           # st[0] = 2.0f * A
        
        //mov     4(%eax), %ebx           # %ebx = mSides[];
        fld     12(%eax)                # st[0] = mSides[2]; st[1] = 2.0f * A;
        fdivrp                          # st[0] = 2.0f * A / mSides[2];

        
        leave          /* restore ebp and esp */
        ret            /* return to the caller */
