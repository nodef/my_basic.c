#define MY_BASIC_IMPLEMENTATION
#include <my_basic.h>
#include <stdio.h>

static int custom_function(struct mb_interpreter_t* bas, void** l) {
    const char* message = "Custom function called!";
    mb_push_string(bas, l, message);
    return MB_FUNC_OK;
}

int main() {
    struct mb_interpreter_t* bas = NULL;

    mb_init();
    mb_open(&bas);

    mb_register_func(bas, "custom_func", custom_function);

    const char* script = "print custom_func()";
    mb_load_string(bas, script, true);
    mb_run(bas, true);

    mb_close(&bas);
    mb_dispose();

    return 0;
}
