#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"

int
main(int argc, char *argv[])
{
    if (argc != 2) {
        fprintf(2, "Uasage of sleep : sleep number of ticks");
        exit(1);
    } else {
        sleep(atoi(argv[1]));
        exit(0);
    }
    exit(0);
}