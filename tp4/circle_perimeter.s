.data
        factor: .float 2.0 /* use this to multiply by two */

.text
.globl _ZNK7CCircle12PerimeterAsmEv

_ZNK7CCircle12PerimeterAsmEv:
        push %ebp      /* save old base pointer */
        mov %esp, %ebp /* set ebp to current esp */

        #   SUR LA PILE
        # +0    ancienne valeur de %ebp
        # +4    ancienne valeur de %eip (adresse de retour)
        # +8    adresse de l'objet Cercle
        
        #   DANS L'OBJET CERCLE
        # +0    Taille de VTable
        # +4    Premier attribut (float mRadius)
        
        mov     8(%ebp), %ebx
        fld     factor          # st[0] = 2.0f;
        fldpi                   # st[0] = PI;           st[1] = 2.0f;
        fmulp                   # st[0] = 2.0f * PI;    st[1] = 2.0f * PI;
        fld     4(%ebx)         # st[0] = mRadius;      st[1] = 2.0f * PI;
        fmulp                   # st[0] = 2.0f * PI * mRadius;

        #Pour retourner un float en sortant d'une fonction, il faut
        #la laisser dans st[0].

        leave          /* restore ebp and esp */
        ret            /* return to the caller */
