EXIT_NR  = 1
READ_NR  = 3
WRITE_NR = 4
N = 100 #zamien to 


STDOUT = 1
EXIT_CODE_SUCCESS = 0

.data
	num: .float 2.0
	n: .float 1.0 #i to dla n
	snum: .float 10
	silnied: .float 1.0
	x: .float 1.0
	one: .float 1.0
	forpow: .float 1.0
	trash: .float 1.0
	sum: .float 1.0
	cos: .float 1.0

#.data
#    num:    .tfloat 2.0
#    n:      .tfloat 1.0      # i to dla n
#    snum:   .tfloat 10
#    silnied: .tfloat 1.0
#    x:      .tfloat 1.0
#    one:    .tfloat 1.0
#    forpow: .tfloat 1.0
#    trash:  .tfloat 1.0
#    sum:    .tfloat 1.0
#    cos:    .tfloat 1.0

.global taylor

taylor:

pushl %ebp
movl %esp,%ebp
subl $80,%esp
pushl %edi
pushl %esi
pushl %ebx

mov $1,%ebx
finit
loop:

#................ (2n)
fld n
fld num
fmulp %st(0),%st(1)

jmp silnia
#................
AfterS:
fstp snum
fstp snum
fstp silnied

fld x
fld n
fld num
fmulp %st(0),%st(1)

jmp pow
aPow:

fld silnied
fdivr %st(1)
fxch %st(1)
fstp trash

plusorminus:
mov %ebx,%eax
cdq
mov $2,%ecx
idiv %ecx
cmp $1,%edx
jz minus

plus:
fld sum
fadd %st(1)
fstp sum
fstp trash
jmp endLoop

minus:
fld sum
fsub %st(1)
fstp sum
fstp trash

endLoop:
fld n
fld1 
faddp %st(1)
fstp n
fstp trash
inc %ebx

cmp $N,%ebx
jz end
jmp loop

end:

fld1
fsincos
fstp %st(1)

fld sum

movl %edi,%eax
xorl %eax,%eax
popl %ebx
popl %esi
popl %edi
leave
ret


silnia: #(2n)!

fld1
fld %st(1)

sloop:

fsub %st(1),%st(0)

fcom %st(1)
fstsw %ax
sahf
jbe AfterS

fmul %st(0),%st(2)

jmp sloop

pow:

fxch %st(1)
fldln2
fxch %st(1)
fyl2x
fmulp

fldl2e
fmulp
fld %st(0)
frndint
fsubr %st(0), %st(1)
fxch %st(1)
f2xm1
fld1
faddp
fscale
fstp %st(1)

jmp aPow

