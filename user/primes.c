#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"

void childFunction(int p[2]) {
    // child
    // read a number from the pipe
    // print first prime
    // wive out all multiples of the prime
    // create a new pipe and a new child
    // until there are no more numbers in the pipe
    close(p[1]);
    int prime = 0;
    read(p[0], &prime, sizeof(prime));
    if (prime == 0) {
        close(p[0]);
        exit(0);
    }
    printf("prime %d\n", prime);
    int newp[2];
    pipe(newp);
    if (fork() > 0) {
        close(newp[0]);
        // father
        int buffer = 0;
        while (read(p[0], &buffer, sizeof(buffer))) {
            if (buffer % prime) {
                write(newp[1], &buffer, sizeof(buffer));
            }
        }
        close(p[0]);
        close(newp[1]);
        // why wait here?
        wait(0);
    } else {
        // child
        close(p[0]);
        childFunction(newp);
    }
    

}

int
main(int argc, char *argv[])
{
    if (argc != 1) {
        fprintf(2, "usage: primes\n");
        exit(1);
    }

    int p[2];
    pipe(p);
    if (fork() > 0) {
        // father
        // fill the pipe with numbers from 2 to 35
        close(p[0]);
        for (int i = 2; i <= 35; i++) {
            write(p[1], &i, sizeof(i));
        }
        close(p[1]);
        // wait for the child to finish
        wait(0);
    } else {
        // child
        // read a number from the pipe
        // print first prime
        // wive out all multiples of the prime
        // create a new pipe and a new child
        // until there are no more numbers in the pipe
        
        childFunction(p);
    }
    exit(0);
}