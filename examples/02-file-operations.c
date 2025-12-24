#define MY_BASIC_IMPLEMENTATION
#include <my_basic.h>
#include <stdio.h>

int main() {
    struct mb_interpreter_t* bas = NULL;

    mb_init();
    mb_open(&bas);

    const char* script =
        "open \"examples\\example.txt\" for output as #1\n"
        "print #1, \"This is a test file.\"\n"
        "close #1\n"
        "open \"examples\\example.txt\" for input as #1\n"
        "input #1, line$\n"
        "print \"Read from file: \"; line$\n"
        "close #1";

    mb_load_string(bas, script, true);
    mb_run(bas, true);

    mb_close(&bas);
    mb_dispose();

    return 0;
}
