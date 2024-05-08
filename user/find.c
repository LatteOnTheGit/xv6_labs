#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"
#include "kernel/fs.h"

// return name of file
char*
fmtname(char *path)
{
  static char buf[DIRSIZ+1];
  char *p;

  // Find first character after last slash.
  for(p=path+strlen(path); p >= path && *p != '/'; p--)
    ;
  p++;

  // Return blank-padded name.
  if(strlen(p) >= DIRSIZ)
    return p;
  memmove(buf, p, strlen(p));
  memset(buf+strlen(p), ' ', DIRSIZ-strlen(p));
  return buf;
}

// search in current directory
// if any file is a directory, recursively call search on that directory
// if not, check if the file name matches the search string
// if it does, print the file name



void search(char *path, char *searchName) {
    // char buf[512];
    // char *p;
    int fd;
    // struct dirent de;
    struct stat st;

    if((fd = open(path, 0)) < 0) {
        fprintf(2, "find: cannot open %s\n", path);
        return;
    }

    if(fstat(fd, &st) < 0) {
        fprintf(2, "find: cannot stat %s\n", path);
        close(fd);
        return;
    }

    switch(st.type){
  case T_FILE:
    if(strcmp(fmtname(path), searchName) == 0) {
    printf("%s\n", path);
    }
    break;

//   case T_DIR:
//     if(strlen(path) + 1 + DIRSIZ + 1 > sizeof buf){
//       printf("ls: path too long\n");
//       break;
//     }
//     strcpy(buf, path);
//     p = buf+strlen(buf);
//     *p++ = '/';
//     while(read(fd, &de, sizeof(de)) == sizeof(de)){
//       if(de.inum == 0)
//         continue;
//       memmove(p, de.name, DIRSIZ);
//       p[DIRSIZ] = 0;
//       if(stat(buf, &st) < 0){
//         printf("ls: cannot stat %s\n", buf);
//         continue;
//       }
//       search(buf, searchName);
//     }
//     break;
  }
  close(fd);
}

int
main(int argc, char *argv[]) {
    // Check if the number of arguments is correct
    if (argc != 3) {
        fprintf(2, "Usage: find <path> <search>\n");
        exit(1);
    }
    search(argv[1], argv[2]);
    
    // Open file
    // Check if the file is a directory
    // if its, recursively call find on all files in the directory
    // if not, check if the file name matches the search string
    // if it does, print the file name
    exit(0);
}