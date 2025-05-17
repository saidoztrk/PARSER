#include <stdio.h>

extern FILE *yyin;
int yyparse();

int main(int argc, char *argv[])
{
    if (argc < 2)
    {
        printf("Kullanım: %s <giriş_dosyası>\n", argv[0]);
        return 1;
    }

    FILE *file = fopen(argv[1], "r");
    if (!file)
    {
        perror("Dosya açılamadı");
        return 1;
    }

    yyin = file;
    yyparse();

    fclose(file);
    return 0;
}
