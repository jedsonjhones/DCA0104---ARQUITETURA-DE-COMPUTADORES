#include <stdio.h>

int tag[256];

int main( )
{
    int addr,i, j, t, falhas, accessos,acertos;
    FILE *fp;

 fp = fopen("C:\\Users\\jhoni\\Desktop\\Cache\\enderecos.dat", "r");
    falhas = 0;
    accessos = 0;
    acertos = 0;
    while (fscanf(fp, "%x", &addr) > 0) {
        accessos += 1;
        i = (addr >> 2) & 7;
        t = addr | 0x1f;
        if (tag[i] == t) {
            falhas += 1;
        } else {
            acertos +=1;
            tag[i] = t;
        }
    }
    printf("Falhas = %d, Acertos = %d,Total = %d", falhas, acertos, accessos);
    close(fp);
}
