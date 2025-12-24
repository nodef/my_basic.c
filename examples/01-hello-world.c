#define MY_BASIC_IMPLEMENTATION
#include <my_basic.h>
#include <stdio.h>

int main(int argc, char** argv) {
    struct mb_interpreter_t* bas = NULL;
    char script[1024 * 1024];

    mb_init();
    mb_open(&bas);

    FILE *file = fopen(argv[1], "r");
    fseek(file, 0, SEEK_END);
    size_t script_size = ftell(file);
    fseek(file, 0, SEEK_SET);
    fread(script, 1, script_size, file);
    fclose(file);
    printf("Loaded script %s:\n%s\n", argv[1], script);

    printf("Executing script...\n");
    mb_load_string(bas, script, true);
    mb_run(bas, true);

    mb_close(&bas);
    mb_dispose();

    return 0;
}
