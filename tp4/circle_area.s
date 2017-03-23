.globl _ZNK7CCircle7AreaAsmEv

_ZNK7CCircle7AreaAsmEv:
        push %ebp      /* save old base pointer */
        mov %esp, %ebp /* set ebp to current esp */
        
        #   SUR LA PILE
        # +0    ancienne valeur de %ebp
        # +4    ancienne valeur de %eip (adresse de retour)
        # +8    adresse de l'objet Cercle
        
        #   DANS L'OBJET CERCLE
        # +0    Taille de VTable
        # +4    Premier attribut (float mRadius)
        
        mov     8(%ebp), %ebx   # %ebx = objet Cercle
        fld     4(%ebx)         # st[0] = mRadius;
        fldpi                   # st[0] = PI;           st[1] = mRadius;
        fmulp                   # st[0] = PI * mRadius; st[1] = PI * mRadius;
        fld     4(%ebx)         # st[0] = mRadius;      st[1] = PI * mRadius;
        fmulp                   # st[0] = PI * mRadius * mRadius;

        #Pour retourner un float en sortant d'une fonction, il faut
        #la laisser dans st[0].

        leave          /* restore ebp and esp */
        ret            /* return to the caller */
