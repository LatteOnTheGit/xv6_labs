#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"
#include "kernel/param.h"

int
main(int argc, char *argv[]) 
{
    char buf[MAXARG];
    // get standard input
    while (read(0, &buf, MAXARG) == 0) {}

    // get arguments from xargs
    char *xargv[MAXARG];
    int xargc = 0;
    for (int i = 1; i < argc; i++) {
        xargv[xargc++] = argv[i];
    }

    char *p = buf;
    // excute the command with the arguments
    for (int i = 0; i < MAXARG; i++) {
        if (buf[i] == '\n') {
            if (fork() == 0) {
                // child
                buf[i] = 0;
                xargv[xargc++] = p;
                xargv[xargc++] = 0;
                exec(xargv[0], xargv);
                exit(0);
            } else {
                wait(0);
                p = buf + i + 1;
            }
        }
    }
    exit(0);

}