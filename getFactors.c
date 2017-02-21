#include <stdio.h>
#include <stdlib.h> 
#include <string.h>

int main(int argc,char *argv[]) {
        
char ligne[255];
FILE *f=fopen("/home/TP1/resultofFactoring.txt","r");
int cpt=0,stop=0;

while((!feof(f))&&(stop==0))
{
fgets(ligne,255,f);
if(strstr(ligne,"lanczos")) stop=1;
}
fgets(ligne,255,f);
fgets(ligne,255,f);// clé P
while(ligne[cpt]!=58) cpt++;
cpt=cpt+2;
FILE *P=fopen("/home/TP1/brokenP.txt","w");
FILE *Q=fopen("/home/TP1/brokenQ.txt","w");
while(ligne[cpt]!='\n')
{
fputc(ligne[cpt],P);//facteur p
cpt++;
}
fgets(ligne,255,f);
cpt=0;
while(ligne[cpt]!=58) cpt++;
cpt=cpt+2;
while(ligne[cpt]!='\n')
{
fputc(ligne[cpt],Q);// facteur q
cpt++;
}
fclose(P);
fclose(Q);
fclose(f);
return 0;

}
