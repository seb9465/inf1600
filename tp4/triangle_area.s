.data
        factor: .float 2.0
        tmp:    .float 0
        pSide:   .float 0
        dSide:   .float 0
.text
.globl _ZNK9CTriangle7AreaAsmEv

_ZNK9CTriangle7AreaAsmEv:
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
        call    *8(%ebx)                # st[0] = PerimeterCpp();
        pop     %edx
        fld     factor                  # st[0] = factor;       st[1] = PerimeterCpp();
        fdivrp                          # st[0] = PerimeterCpp() / factor;
        fstp    tmp                     # tmp = p;  st[0] = p;


        fld     tmp                     # st[0] = p;
        fld     4(%eax)                 # st[0] = mSides[0];    st[1] = p;
        fsubrp                          # st[0] = p - mSides[0];
        fstp    pSide                   # pSide = p - mSides[0];


        fld     8(%eax)                 # st[0] = mSides[1];    st[1] = p-mSides[0];
        fld     tmp                     # st[0] = tmp;          st[1] = mSides[1]
        fsubp                           # st[0] = p - mSides[1];
        fstp    dSide                   # pSide = p - mSides[1];

        fld     12(%eax)                # st[0] = mSides[2];    st[1] = p-mSides[1];
        fld     tmp                     # st[0] = tmp;          st[1] = mSides[2]
        fsubp                           # st[0] = p - mSides[2];
        
        fld     dSide                   # st[0] = p - mSides[1];        st[1] = p - mSides[2];
        fmulp                           # st[0] = (p - mSides[1]) * (p - mSides[2]);
        fld     pSide                   # st[0] = p -  mSides[0];       st[0] = (p - mSides[1]) * (p - mSides[2]);
        fmulp                           # st[0] = (p -  mSides[0]) * (p - mSides[1]) * (p - mSides[2]);
        fld     tmp                     # st[0] = tmp;                  st[0] = (p -  mSides[0]) * (p - mSides[1]) * (p - mSides[2]);
        fmulp                           # st[0] = st[0] = p * (p -  mSides[0]) * (p - mSides[1]) * (p - mSides[2]);
        fsqrt                           # st[0] = sqrt(p * (p -  mSides[0]) * (p - mSides[1]) * (p - mSides[2]));



        
        leave          /* restore ebp and esp */
        ret            /* return to the caller */
