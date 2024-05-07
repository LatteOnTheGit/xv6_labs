#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"

#define SIZE 4

int
main(int argc, char *argv[])
{
    // create pipe
    int p[2];
    pipe(p);
    // create buffer
    char buf[SIZE];
    if (fork() > 0) {
        // parent
        write(p[1], "ping", SIZE);
        wait(0);
        read(p[0], buf, SIZE);
        printf("%d: received %s\n", getpid(), buf);
        exit(0);
    } else {
        // child
        read(p[0], buf, SIZE);
        printf("%d: received %s\n", getpid(), buf);
        write(p[1], "pong", SIZE);
        exit(0);
    }
}