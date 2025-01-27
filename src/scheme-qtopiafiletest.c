
#include <stdio.h>
#include "scheme-qtopiafiletest.h"

int main(int argc, char **argv) {
    char buf[255];

    if (argc != 2) exit (1);
    memset (&buf, 0x00, 255);
    getQtopiaFilename(argv[1], buf);
    if (strlen (buf) == 0) {
        exit (1);
    } else {
        printf ("%s\n", buf);
        exit (0);        
    }
}
