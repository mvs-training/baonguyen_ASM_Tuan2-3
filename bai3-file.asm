
.model small 
.data 
.stack 
     
     buffer dw 256 dup(?)  
     table db '0123456789abcdef' 
.code 
main:        
MOV AX,@DATA
MOV DS,AX 
mov es, ax
xor ax, ax  
mov ax, 0201h ; AH = 02 (disk read), AL = 01 (number of sectors to read) 
mov cx, 01h    ; cylinder 0, sector 1
mov cx, word ptr mboot [si+2] ; sector cytlinder
mov dh,byte ptr mboot[si+1];head
mov bx, offset buffer 
int 13h
lea si,buffer
mov cx,128       ; khai bao vong lap loop

lap:
lodsb      ; tai by ty tanh ds
mov dl,al  

push cx           ; dua 128 vao trong stack
mov cl,4  
shr al,cl     ; dich cac bit sang phai 4 bit

lea bx,table 
; hien thi cac by thap ra tr
xlat           ; giai hoa viec tra cuu   chuye ?ôi giai ma sang ki?u dec
mov ah,0eh
int 10h  

mov al,dl
and al,0fh
;hient hi cac bit cao      
xlat          ; 
mov ah,0eh
int 10h
pop cx        ; lay lai gia tri cx
loop lap

mov ax, 4ch
int 21h  

ends

end main 