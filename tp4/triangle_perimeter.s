.globl _ZNK9CTriangle12PerimeterAsmEv

_ZNK9CTriangle12PerimeterAsmEv:
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
        # +12   float mSides[2]


        mov     8(%ebp), %eax           # %eax = Objet Triangle;
        fld     4(%eax)                 # st[0] = mSides[0];
        fld     8(%eax)                 # st[0] = mSides[1];    st[1] = mSides[0];
        faddp                           # st[0] = mSides[0] + mSides[1];
        fld     12(%eax)                # st[0] = mSides[2];    st[1] = mSides[0] + mSides[1];
        faddp                           # st[0] = mSides[0] + mSides[1] +mSides[2];
        
        leave          /* restore ebp and esp */
        ret            /* return to the caller */
