.model small
.stack 100h
.data
DTA db 50 dup(?)   ; khoi tao bo nh
file db "bai3.*",0          ; kieu dang file
s db 200,?,200 dup(?)
xuongdong db 10,13,'$'
.code

Main:
mov ax,@data
mov ds,ax

;mov ax, es
mov dx, offset DTA ; dua bien vao trong dx khoi tao bo nho
mov ah,1Ah
int 21h
mov ah,4eh       ; tim kiem tap tin khop dau tien
mov dx, offset file                            ;kiem thu
mov cx,0fh        ; so sanh voi ofh
int 21h
jc thoat                          ; thoat
Lap:
mov dx,offset [DTA+30]      ; dua con tro den ten file
mov si,dx
mov byte ptr [si+16],'$'  ; khai bao do dai cua bien va dua dau $ vao bien de phan biet hien thij
mov ah,9
int 21h 
mov ah,9
lea dx,xuongdong
int 21h
mov ah,4fh       ; so sanh - tim tep doi sanh voi nhau
int 21h
jc thoat
jmp Lap

thoat:
mov ax,4ch
int 21h

end Main

