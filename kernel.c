__asm__ (".pushsection .text.start\r\n" \
         "jmp main\r\n" \
         ".popsection\r\n"
         );


int main(){
    char mess[28]="My first OS has been loaded!";
    char* mem = (char*) 0xb8000;
    int ind = 0;
    for(int i=0;i<28;i++){
        mem[ind] = mess[i];
        ind = ind+2;
    }
  
    return 0; /* return back to bootloader */
}
