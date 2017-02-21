#include <stdio.h>
#include <stdlib.h> /* for atoi() */
#include <string.h>

int main(int argc,char *argv[]) {
        
        if (argc != 2) {
            printf("Usage: %s stdout \n",argv[0]);
            //return 1;
        }
char modulus[64];
FILE* f=fopen("/home/TP1/Modulus.txt","w");
int i;
for ( i=178;i<242;i++ ) fputc(argv[1][i],f);
//modulus[64]='\0';
//printf("--  %s\n",modulus);

fclose(f);

return 0;
  
}
