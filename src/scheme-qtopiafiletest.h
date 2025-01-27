
#include <stdio.h>

void getQtopiaFilename (char* filein, char* bufout) {
    FILE *fin;
    char cbuf;
    char buf[255];
    int ilen;
    int i;
    
    /* read 4 bytes */
    fin = fopen(filein, "r");
    if (fin == 0) return;
    
    while (!feof(fin)) {
        fread (&cbuf, 1, 1, fin);
        if (cbuf == 's') {
            memset (&buf, 0x00, 255);
            fread (&buf, 1, 10, fin);
            if (strncmp (buf, "etDocument", 10) == 0) {
                fread (&buf, 1, 14, fin); /* toss out another 14 bytes */
                memset (&buf, 0x00, 255);
                fread (&buf, 4, 1, fin);
                ilen = buf[3]; /* unlikely the path won't exceed 256 char */
                /* unicode, so skip every other one */
                for (i=0; i <= ilen; i++) {
                    fread (&cbuf, 1, 1, fin);
                    fread (&bufout[i], 1, 1, fin);                      
                }
            }
        }
    }
    fclose (fin);
}
