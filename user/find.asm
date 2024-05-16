
user/_find:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <fmtname>:
#include "kernel/fs.h"

// return name of file
char*
fmtname(char *path)
{
   0:	1101                	addi	sp,sp,-32
   2:	ec06                	sd	ra,24(sp)
   4:	e822                	sd	s0,16(sp)
   6:	e426                	sd	s1,8(sp)
   8:	1000                	addi	s0,sp,32
   a:	84aa                	mv	s1,a0
//   static char buf[DIRSIZ+1];
  char *p;

  // Find first character after last slash.
  for(p=path+strlen(path); p >= path && *p != '/'; p--)
   c:	00000097          	auipc	ra,0x0
  10:	2b4080e7          	jalr	692(ra) # 2c0 <strlen>
  14:	02051793          	slli	a5,a0,0x20
  18:	9381                	srli	a5,a5,0x20
  1a:	97a6                	add	a5,a5,s1
  1c:	02f00693          	li	a3,47
  20:	0097e963          	bltu	a5,s1,32 <fmtname+0x32>
  24:	0007c703          	lbu	a4,0(a5)
  28:	00d70563          	beq	a4,a3,32 <fmtname+0x32>
  2c:	17fd                	addi	a5,a5,-1
  2e:	fe97fbe3          	bgeu	a5,s1,24 <fmtname+0x24>
    ;
  p++;
  32:	00178493          	addi	s1,a5,1

  // Return blank-padded name.
  if(strlen(p) >= DIRSIZ)
  36:	8526                	mv	a0,s1
  38:	00000097          	auipc	ra,0x0
  3c:	288080e7          	jalr	648(ra) # 2c0 <strlen>
    return p;
//   memmove(buf, p, strlen(p));
//   memset(buf+strlen(p), ' ', DIRSIZ-strlen(p));
  return p;
}
  40:	8526                	mv	a0,s1
  42:	60e2                	ld	ra,24(sp)
  44:	6442                	ld	s0,16(sp)
  46:	64a2                	ld	s1,8(sp)
  48:	6105                	addi	sp,sp,32
  4a:	8082                	ret

000000000000004c <search>:
// if not, check if the file name matches the search string
// if it does, print the file name



void search(char *path, char *searchName) {
  4c:	d8010113          	addi	sp,sp,-640
  50:	26113c23          	sd	ra,632(sp)
  54:	26813823          	sd	s0,624(sp)
  58:	26913423          	sd	s1,616(sp)
  5c:	27213023          	sd	s2,608(sp)
  60:	25313c23          	sd	s3,600(sp)
  64:	25413823          	sd	s4,592(sp)
  68:	25513423          	sd	s5,584(sp)
  6c:	25613023          	sd	s6,576(sp)
  70:	23713c23          	sd	s7,568(sp)
  74:	0500                	addi	s0,sp,640
  76:	892a                	mv	s2,a0
  78:	89ae                	mv	s3,a1
    char *p;
    int fd;
    struct dirent de;
    struct stat st;

    if((fd = open(path, 0)) < 0) {
  7a:	4581                	li	a1,0
  7c:	00000097          	auipc	ra,0x0
  80:	4b2080e7          	jalr	1202(ra) # 52e <open>
  84:	06054a63          	bltz	a0,f8 <search+0xac>
  88:	84aa                	mv	s1,a0
        fprintf(2, "find: cannot open %s\n", path);
        return;
    }

    if(fstat(fd, &st) < 0) {
  8a:	d8840593          	addi	a1,s0,-632
  8e:	00000097          	auipc	ra,0x0
  92:	4b8080e7          	jalr	1208(ra) # 546 <fstat>
  96:	06054c63          	bltz	a0,10e <search+0xc2>
        fprintf(2, "find: cannot stat %s\n", path);
        close(fd);
        return;
    }

    switch(st.type){
  9a:	d9041783          	lh	a5,-624(s0)
  9e:	0007869b          	sext.w	a3,a5
  a2:	4705                	li	a4,1
  a4:	08e68f63          	beq	a3,a4,142 <search+0xf6>
  a8:	4709                	li	a4,2
  aa:	00e69d63          	bne	a3,a4,c4 <search+0x78>
  case T_FILE:
    if(strcmp(fmtname(path), searchName) == 0) {
  ae:	854a                	mv	a0,s2
  b0:	00000097          	auipc	ra,0x0
  b4:	f50080e7          	jalr	-176(ra) # 0 <fmtname>
  b8:	85ce                	mv	a1,s3
  ba:	00000097          	auipc	ra,0x0
  be:	1da080e7          	jalr	474(ra) # 294 <strcmp>
  c2:	c535                	beqz	a0,12e <search+0xe2>
      }
      search(buf, searchName);
    }
    break;
  }
  close(fd);
  c4:	8526                	mv	a0,s1
  c6:	00000097          	auipc	ra,0x0
  ca:	450080e7          	jalr	1104(ra) # 516 <close>
}
  ce:	27813083          	ld	ra,632(sp)
  d2:	27013403          	ld	s0,624(sp)
  d6:	26813483          	ld	s1,616(sp)
  da:	26013903          	ld	s2,608(sp)
  de:	25813983          	ld	s3,600(sp)
  e2:	25013a03          	ld	s4,592(sp)
  e6:	24813a83          	ld	s5,584(sp)
  ea:	24013b03          	ld	s6,576(sp)
  ee:	23813b83          	ld	s7,568(sp)
  f2:	28010113          	addi	sp,sp,640
  f6:	8082                	ret
        fprintf(2, "find: cannot open %s\n", path);
  f8:	864a                	mv	a2,s2
  fa:	00001597          	auipc	a1,0x1
  fe:	90e58593          	addi	a1,a1,-1778 # a08 <malloc+0xe4>
 102:	4509                	li	a0,2
 104:	00000097          	auipc	ra,0x0
 108:	734080e7          	jalr	1844(ra) # 838 <fprintf>
        return;
 10c:	b7c9                	j	ce <search+0x82>
        fprintf(2, "find: cannot stat %s\n", path);
 10e:	864a                	mv	a2,s2
 110:	00001597          	auipc	a1,0x1
 114:	91058593          	addi	a1,a1,-1776 # a20 <malloc+0xfc>
 118:	4509                	li	a0,2
 11a:	00000097          	auipc	ra,0x0
 11e:	71e080e7          	jalr	1822(ra) # 838 <fprintf>
        close(fd);
 122:	8526                	mv	a0,s1
 124:	00000097          	auipc	ra,0x0
 128:	3f2080e7          	jalr	1010(ra) # 516 <close>
        return;
 12c:	b74d                	j	ce <search+0x82>
        printf("%s\n", path);
 12e:	85ca                	mv	a1,s2
 130:	00001517          	auipc	a0,0x1
 134:	94050513          	addi	a0,a0,-1728 # a70 <malloc+0x14c>
 138:	00000097          	auipc	ra,0x0
 13c:	72e080e7          	jalr	1838(ra) # 866 <printf>
 140:	b751                	j	c4 <search+0x78>
    if(strlen(path) + 1 + DIRSIZ + 1 > sizeof buf){
 142:	854a                	mv	a0,s2
 144:	00000097          	auipc	ra,0x0
 148:	17c080e7          	jalr	380(ra) # 2c0 <strlen>
 14c:	2541                	addiw	a0,a0,16
 14e:	20000793          	li	a5,512
 152:	00a7fb63          	bgeu	a5,a0,168 <search+0x11c>
      printf("ls: path too long\n");
 156:	00001517          	auipc	a0,0x1
 15a:	8e250513          	addi	a0,a0,-1822 # a38 <malloc+0x114>
 15e:	00000097          	auipc	ra,0x0
 162:	708080e7          	jalr	1800(ra) # 866 <printf>
      break;
 166:	bfb9                	j	c4 <search+0x78>
    strcpy(buf, path);
 168:	85ca                	mv	a1,s2
 16a:	db040513          	addi	a0,s0,-592
 16e:	00000097          	auipc	ra,0x0
 172:	10a080e7          	jalr	266(ra) # 278 <strcpy>
    p = buf+strlen(buf);
 176:	db040513          	addi	a0,s0,-592
 17a:	00000097          	auipc	ra,0x0
 17e:	146080e7          	jalr	326(ra) # 2c0 <strlen>
 182:	02051913          	slli	s2,a0,0x20
 186:	02095913          	srli	s2,s2,0x20
 18a:	db040793          	addi	a5,s0,-592
 18e:	993e                	add	s2,s2,a5
    *p++ = '/';
 190:	00190b13          	addi	s6,s2,1
 194:	02f00793          	li	a5,47
 198:	00f90023          	sb	a5,0(s2)
      if(de.inum == 0 || strcmp(de.name, ".") == 0 || strcmp(de.name, "..") == 0)
 19c:	00001a97          	auipc	s5,0x1
 1a0:	8b4a8a93          	addi	s5,s5,-1868 # a50 <malloc+0x12c>
 1a4:	00001b97          	auipc	s7,0x1
 1a8:	8b4b8b93          	addi	s7,s7,-1868 # a58 <malloc+0x134>
 1ac:	da240a13          	addi	s4,s0,-606
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
 1b0:	4641                	li	a2,16
 1b2:	da040593          	addi	a1,s0,-608
 1b6:	8526                	mv	a0,s1
 1b8:	00000097          	auipc	ra,0x0
 1bc:	34e080e7          	jalr	846(ra) # 506 <read>
 1c0:	47c1                	li	a5,16
 1c2:	f0f511e3          	bne	a0,a5,c4 <search+0x78>
      if(de.inum == 0 || strcmp(de.name, ".") == 0 || strcmp(de.name, "..") == 0)
 1c6:	da045783          	lhu	a5,-608(s0)
 1ca:	d3fd                	beqz	a5,1b0 <search+0x164>
 1cc:	85d6                	mv	a1,s5
 1ce:	8552                	mv	a0,s4
 1d0:	00000097          	auipc	ra,0x0
 1d4:	0c4080e7          	jalr	196(ra) # 294 <strcmp>
 1d8:	dd61                	beqz	a0,1b0 <search+0x164>
 1da:	85de                	mv	a1,s7
 1dc:	8552                	mv	a0,s4
 1de:	00000097          	auipc	ra,0x0
 1e2:	0b6080e7          	jalr	182(ra) # 294 <strcmp>
 1e6:	d569                	beqz	a0,1b0 <search+0x164>
      memmove(p, de.name, DIRSIZ);
 1e8:	4639                	li	a2,14
 1ea:	da240593          	addi	a1,s0,-606
 1ee:	855a                	mv	a0,s6
 1f0:	00000097          	auipc	ra,0x0
 1f4:	248080e7          	jalr	584(ra) # 438 <memmove>
      p[DIRSIZ] = 0;
 1f8:	000907a3          	sb	zero,15(s2)
      if(stat(buf, &st) < 0){
 1fc:	d8840593          	addi	a1,s0,-632
 200:	db040513          	addi	a0,s0,-592
 204:	00000097          	auipc	ra,0x0
 208:	1a4080e7          	jalr	420(ra) # 3a8 <stat>
 20c:	00054a63          	bltz	a0,220 <search+0x1d4>
      search(buf, searchName);
 210:	85ce                	mv	a1,s3
 212:	db040513          	addi	a0,s0,-592
 216:	00000097          	auipc	ra,0x0
 21a:	e36080e7          	jalr	-458(ra) # 4c <search>
 21e:	bf49                	j	1b0 <search+0x164>
        printf("ls: cannot stat %s\n", buf);
 220:	db040593          	addi	a1,s0,-592
 224:	00001517          	auipc	a0,0x1
 228:	83c50513          	addi	a0,a0,-1988 # a60 <malloc+0x13c>
 22c:	00000097          	auipc	ra,0x0
 230:	63a080e7          	jalr	1594(ra) # 866 <printf>
        continue;
 234:	bfb5                	j	1b0 <search+0x164>

0000000000000236 <main>:

int
main(int argc, char *argv[]) {
 236:	1141                	addi	sp,sp,-16
 238:	e406                	sd	ra,8(sp)
 23a:	e022                	sd	s0,0(sp)
 23c:	0800                	addi	s0,sp,16
    // Check if the number of arguments is correct
    if (argc != 3) {
 23e:	470d                	li	a4,3
 240:	02e50063          	beq	a0,a4,260 <main+0x2a>
        fprintf(2, "Usage: find <path> <search>\n");
 244:	00001597          	auipc	a1,0x1
 248:	83458593          	addi	a1,a1,-1996 # a78 <malloc+0x154>
 24c:	4509                	li	a0,2
 24e:	00000097          	auipc	ra,0x0
 252:	5ea080e7          	jalr	1514(ra) # 838 <fprintf>
        exit(1);
 256:	4505                	li	a0,1
 258:	00000097          	auipc	ra,0x0
 25c:	296080e7          	jalr	662(ra) # 4ee <exit>
 260:	87ae                	mv	a5,a1
    }
    search(argv[1], argv[2]);
 262:	698c                	ld	a1,16(a1)
 264:	6788                	ld	a0,8(a5)
 266:	00000097          	auipc	ra,0x0
 26a:	de6080e7          	jalr	-538(ra) # 4c <search>
    // Open file
    // Check if the file is a directory
    // if its, recursively call find on all files in the directory
    // if not, check if the file name matches the search string
    // if it does, print the file name
    exit(0);
 26e:	4501                	li	a0,0
 270:	00000097          	auipc	ra,0x0
 274:	27e080e7          	jalr	638(ra) # 4ee <exit>

0000000000000278 <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
 278:	1141                	addi	sp,sp,-16
 27a:	e422                	sd	s0,8(sp)
 27c:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 27e:	87aa                	mv	a5,a0
 280:	0585                	addi	a1,a1,1
 282:	0785                	addi	a5,a5,1
 284:	fff5c703          	lbu	a4,-1(a1)
 288:	fee78fa3          	sb	a4,-1(a5)
 28c:	fb75                	bnez	a4,280 <strcpy+0x8>
    ;
  return os;
}
 28e:	6422                	ld	s0,8(sp)
 290:	0141                	addi	sp,sp,16
 292:	8082                	ret

0000000000000294 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 294:	1141                	addi	sp,sp,-16
 296:	e422                	sd	s0,8(sp)
 298:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 29a:	00054783          	lbu	a5,0(a0)
 29e:	cb91                	beqz	a5,2b2 <strcmp+0x1e>
 2a0:	0005c703          	lbu	a4,0(a1)
 2a4:	00f71763          	bne	a4,a5,2b2 <strcmp+0x1e>
    p++, q++;
 2a8:	0505                	addi	a0,a0,1
 2aa:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 2ac:	00054783          	lbu	a5,0(a0)
 2b0:	fbe5                	bnez	a5,2a0 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 2b2:	0005c503          	lbu	a0,0(a1)
}
 2b6:	40a7853b          	subw	a0,a5,a0
 2ba:	6422                	ld	s0,8(sp)
 2bc:	0141                	addi	sp,sp,16
 2be:	8082                	ret

00000000000002c0 <strlen>:

uint
strlen(const char *s)
{
 2c0:	1141                	addi	sp,sp,-16
 2c2:	e422                	sd	s0,8(sp)
 2c4:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 2c6:	00054783          	lbu	a5,0(a0)
 2ca:	cf91                	beqz	a5,2e6 <strlen+0x26>
 2cc:	0505                	addi	a0,a0,1
 2ce:	87aa                	mv	a5,a0
 2d0:	4685                	li	a3,1
 2d2:	9e89                	subw	a3,a3,a0
 2d4:	00f6853b          	addw	a0,a3,a5
 2d8:	0785                	addi	a5,a5,1
 2da:	fff7c703          	lbu	a4,-1(a5)
 2de:	fb7d                	bnez	a4,2d4 <strlen+0x14>
    ;
  return n;
}
 2e0:	6422                	ld	s0,8(sp)
 2e2:	0141                	addi	sp,sp,16
 2e4:	8082                	ret
  for(n = 0; s[n]; n++)
 2e6:	4501                	li	a0,0
 2e8:	bfe5                	j	2e0 <strlen+0x20>

00000000000002ea <memset>:

void*
memset(void *dst, int c, uint n)
{
 2ea:	1141                	addi	sp,sp,-16
 2ec:	e422                	sd	s0,8(sp)
 2ee:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 2f0:	ce09                	beqz	a2,30a <memset+0x20>
 2f2:	87aa                	mv	a5,a0
 2f4:	fff6071b          	addiw	a4,a2,-1
 2f8:	1702                	slli	a4,a4,0x20
 2fa:	9301                	srli	a4,a4,0x20
 2fc:	0705                	addi	a4,a4,1
 2fe:	972a                	add	a4,a4,a0
    cdst[i] = c;
 300:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 304:	0785                	addi	a5,a5,1
 306:	fee79de3          	bne	a5,a4,300 <memset+0x16>
  }
  return dst;
}
 30a:	6422                	ld	s0,8(sp)
 30c:	0141                	addi	sp,sp,16
 30e:	8082                	ret

0000000000000310 <strchr>:

char*
strchr(const char *s, char c)
{
 310:	1141                	addi	sp,sp,-16
 312:	e422                	sd	s0,8(sp)
 314:	0800                	addi	s0,sp,16
  for(; *s; s++)
 316:	00054783          	lbu	a5,0(a0)
 31a:	cb99                	beqz	a5,330 <strchr+0x20>
    if(*s == c)
 31c:	00f58763          	beq	a1,a5,32a <strchr+0x1a>
  for(; *s; s++)
 320:	0505                	addi	a0,a0,1
 322:	00054783          	lbu	a5,0(a0)
 326:	fbfd                	bnez	a5,31c <strchr+0xc>
      return (char*)s;
  return 0;
 328:	4501                	li	a0,0
}
 32a:	6422                	ld	s0,8(sp)
 32c:	0141                	addi	sp,sp,16
 32e:	8082                	ret
  return 0;
 330:	4501                	li	a0,0
 332:	bfe5                	j	32a <strchr+0x1a>

0000000000000334 <gets>:

char*
gets(char *buf, int max)
{
 334:	711d                	addi	sp,sp,-96
 336:	ec86                	sd	ra,88(sp)
 338:	e8a2                	sd	s0,80(sp)
 33a:	e4a6                	sd	s1,72(sp)
 33c:	e0ca                	sd	s2,64(sp)
 33e:	fc4e                	sd	s3,56(sp)
 340:	f852                	sd	s4,48(sp)
 342:	f456                	sd	s5,40(sp)
 344:	f05a                	sd	s6,32(sp)
 346:	ec5e                	sd	s7,24(sp)
 348:	1080                	addi	s0,sp,96
 34a:	8baa                	mv	s7,a0
 34c:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 34e:	892a                	mv	s2,a0
 350:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 352:	4aa9                	li	s5,10
 354:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 356:	89a6                	mv	s3,s1
 358:	2485                	addiw	s1,s1,1
 35a:	0344d863          	bge	s1,s4,38a <gets+0x56>
    cc = read(0, &c, 1);
 35e:	4605                	li	a2,1
 360:	faf40593          	addi	a1,s0,-81
 364:	4501                	li	a0,0
 366:	00000097          	auipc	ra,0x0
 36a:	1a0080e7          	jalr	416(ra) # 506 <read>
    if(cc < 1)
 36e:	00a05e63          	blez	a0,38a <gets+0x56>
    buf[i++] = c;
 372:	faf44783          	lbu	a5,-81(s0)
 376:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 37a:	01578763          	beq	a5,s5,388 <gets+0x54>
 37e:	0905                	addi	s2,s2,1
 380:	fd679be3          	bne	a5,s6,356 <gets+0x22>
  for(i=0; i+1 < max; ){
 384:	89a6                	mv	s3,s1
 386:	a011                	j	38a <gets+0x56>
 388:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 38a:	99de                	add	s3,s3,s7
 38c:	00098023          	sb	zero,0(s3)
  return buf;
}
 390:	855e                	mv	a0,s7
 392:	60e6                	ld	ra,88(sp)
 394:	6446                	ld	s0,80(sp)
 396:	64a6                	ld	s1,72(sp)
 398:	6906                	ld	s2,64(sp)
 39a:	79e2                	ld	s3,56(sp)
 39c:	7a42                	ld	s4,48(sp)
 39e:	7aa2                	ld	s5,40(sp)
 3a0:	7b02                	ld	s6,32(sp)
 3a2:	6be2                	ld	s7,24(sp)
 3a4:	6125                	addi	sp,sp,96
 3a6:	8082                	ret

00000000000003a8 <stat>:

int
stat(const char *n, struct stat *st)
{
 3a8:	1101                	addi	sp,sp,-32
 3aa:	ec06                	sd	ra,24(sp)
 3ac:	e822                	sd	s0,16(sp)
 3ae:	e426                	sd	s1,8(sp)
 3b0:	e04a                	sd	s2,0(sp)
 3b2:	1000                	addi	s0,sp,32
 3b4:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 3b6:	4581                	li	a1,0
 3b8:	00000097          	auipc	ra,0x0
 3bc:	176080e7          	jalr	374(ra) # 52e <open>
  if(fd < 0)
 3c0:	02054563          	bltz	a0,3ea <stat+0x42>
 3c4:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 3c6:	85ca                	mv	a1,s2
 3c8:	00000097          	auipc	ra,0x0
 3cc:	17e080e7          	jalr	382(ra) # 546 <fstat>
 3d0:	892a                	mv	s2,a0
  close(fd);
 3d2:	8526                	mv	a0,s1
 3d4:	00000097          	auipc	ra,0x0
 3d8:	142080e7          	jalr	322(ra) # 516 <close>
  return r;
}
 3dc:	854a                	mv	a0,s2
 3de:	60e2                	ld	ra,24(sp)
 3e0:	6442                	ld	s0,16(sp)
 3e2:	64a2                	ld	s1,8(sp)
 3e4:	6902                	ld	s2,0(sp)
 3e6:	6105                	addi	sp,sp,32
 3e8:	8082                	ret
    return -1;
 3ea:	597d                	li	s2,-1
 3ec:	bfc5                	j	3dc <stat+0x34>

00000000000003ee <atoi>:

int
atoi(const char *s)
{
 3ee:	1141                	addi	sp,sp,-16
 3f0:	e422                	sd	s0,8(sp)
 3f2:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 3f4:	00054603          	lbu	a2,0(a0)
 3f8:	fd06079b          	addiw	a5,a2,-48
 3fc:	0ff7f793          	andi	a5,a5,255
 400:	4725                	li	a4,9
 402:	02f76963          	bltu	a4,a5,434 <atoi+0x46>
 406:	86aa                	mv	a3,a0
  n = 0;
 408:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
 40a:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
 40c:	0685                	addi	a3,a3,1
 40e:	0025179b          	slliw	a5,a0,0x2
 412:	9fa9                	addw	a5,a5,a0
 414:	0017979b          	slliw	a5,a5,0x1
 418:	9fb1                	addw	a5,a5,a2
 41a:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 41e:	0006c603          	lbu	a2,0(a3)
 422:	fd06071b          	addiw	a4,a2,-48
 426:	0ff77713          	andi	a4,a4,255
 42a:	fee5f1e3          	bgeu	a1,a4,40c <atoi+0x1e>
  return n;
}
 42e:	6422                	ld	s0,8(sp)
 430:	0141                	addi	sp,sp,16
 432:	8082                	ret
  n = 0;
 434:	4501                	li	a0,0
 436:	bfe5                	j	42e <atoi+0x40>

0000000000000438 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 438:	1141                	addi	sp,sp,-16
 43a:	e422                	sd	s0,8(sp)
 43c:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 43e:	02b57663          	bgeu	a0,a1,46a <memmove+0x32>
    while(n-- > 0)
 442:	02c05163          	blez	a2,464 <memmove+0x2c>
 446:	fff6079b          	addiw	a5,a2,-1
 44a:	1782                	slli	a5,a5,0x20
 44c:	9381                	srli	a5,a5,0x20
 44e:	0785                	addi	a5,a5,1
 450:	97aa                	add	a5,a5,a0
  dst = vdst;
 452:	872a                	mv	a4,a0
      *dst++ = *src++;
 454:	0585                	addi	a1,a1,1
 456:	0705                	addi	a4,a4,1
 458:	fff5c683          	lbu	a3,-1(a1)
 45c:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 460:	fee79ae3          	bne	a5,a4,454 <memmove+0x1c>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 464:	6422                	ld	s0,8(sp)
 466:	0141                	addi	sp,sp,16
 468:	8082                	ret
    dst += n;
 46a:	00c50733          	add	a4,a0,a2
    src += n;
 46e:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 470:	fec05ae3          	blez	a2,464 <memmove+0x2c>
 474:	fff6079b          	addiw	a5,a2,-1
 478:	1782                	slli	a5,a5,0x20
 47a:	9381                	srli	a5,a5,0x20
 47c:	fff7c793          	not	a5,a5
 480:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 482:	15fd                	addi	a1,a1,-1
 484:	177d                	addi	a4,a4,-1
 486:	0005c683          	lbu	a3,0(a1)
 48a:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 48e:	fee79ae3          	bne	a5,a4,482 <memmove+0x4a>
 492:	bfc9                	j	464 <memmove+0x2c>

0000000000000494 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 494:	1141                	addi	sp,sp,-16
 496:	e422                	sd	s0,8(sp)
 498:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 49a:	ca05                	beqz	a2,4ca <memcmp+0x36>
 49c:	fff6069b          	addiw	a3,a2,-1
 4a0:	1682                	slli	a3,a3,0x20
 4a2:	9281                	srli	a3,a3,0x20
 4a4:	0685                	addi	a3,a3,1
 4a6:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 4a8:	00054783          	lbu	a5,0(a0)
 4ac:	0005c703          	lbu	a4,0(a1)
 4b0:	00e79863          	bne	a5,a4,4c0 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 4b4:	0505                	addi	a0,a0,1
    p2++;
 4b6:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 4b8:	fed518e3          	bne	a0,a3,4a8 <memcmp+0x14>
  }
  return 0;
 4bc:	4501                	li	a0,0
 4be:	a019                	j	4c4 <memcmp+0x30>
      return *p1 - *p2;
 4c0:	40e7853b          	subw	a0,a5,a4
}
 4c4:	6422                	ld	s0,8(sp)
 4c6:	0141                	addi	sp,sp,16
 4c8:	8082                	ret
  return 0;
 4ca:	4501                	li	a0,0
 4cc:	bfe5                	j	4c4 <memcmp+0x30>

00000000000004ce <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 4ce:	1141                	addi	sp,sp,-16
 4d0:	e406                	sd	ra,8(sp)
 4d2:	e022                	sd	s0,0(sp)
 4d4:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 4d6:	00000097          	auipc	ra,0x0
 4da:	f62080e7          	jalr	-158(ra) # 438 <memmove>
}
 4de:	60a2                	ld	ra,8(sp)
 4e0:	6402                	ld	s0,0(sp)
 4e2:	0141                	addi	sp,sp,16
 4e4:	8082                	ret

00000000000004e6 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 4e6:	4885                	li	a7,1
 ecall
 4e8:	00000073          	ecall
 ret
 4ec:	8082                	ret

00000000000004ee <exit>:
.global exit
exit:
 li a7, SYS_exit
 4ee:	4889                	li	a7,2
 ecall
 4f0:	00000073          	ecall
 ret
 4f4:	8082                	ret

00000000000004f6 <wait>:
.global wait
wait:
 li a7, SYS_wait
 4f6:	488d                	li	a7,3
 ecall
 4f8:	00000073          	ecall
 ret
 4fc:	8082                	ret

00000000000004fe <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 4fe:	4891                	li	a7,4
 ecall
 500:	00000073          	ecall
 ret
 504:	8082                	ret

0000000000000506 <read>:
.global read
read:
 li a7, SYS_read
 506:	4895                	li	a7,5
 ecall
 508:	00000073          	ecall
 ret
 50c:	8082                	ret

000000000000050e <write>:
.global write
write:
 li a7, SYS_write
 50e:	48c1                	li	a7,16
 ecall
 510:	00000073          	ecall
 ret
 514:	8082                	ret

0000000000000516 <close>:
.global close
close:
 li a7, SYS_close
 516:	48d5                	li	a7,21
 ecall
 518:	00000073          	ecall
 ret
 51c:	8082                	ret

000000000000051e <kill>:
.global kill
kill:
 li a7, SYS_kill
 51e:	4899                	li	a7,6
 ecall
 520:	00000073          	ecall
 ret
 524:	8082                	ret

0000000000000526 <exec>:
.global exec
exec:
 li a7, SYS_exec
 526:	489d                	li	a7,7
 ecall
 528:	00000073          	ecall
 ret
 52c:	8082                	ret

000000000000052e <open>:
.global open
open:
 li a7, SYS_open
 52e:	48bd                	li	a7,15
 ecall
 530:	00000073          	ecall
 ret
 534:	8082                	ret

0000000000000536 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 536:	48c5                	li	a7,17
 ecall
 538:	00000073          	ecall
 ret
 53c:	8082                	ret

000000000000053e <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 53e:	48c9                	li	a7,18
 ecall
 540:	00000073          	ecall
 ret
 544:	8082                	ret

0000000000000546 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 546:	48a1                	li	a7,8
 ecall
 548:	00000073          	ecall
 ret
 54c:	8082                	ret

000000000000054e <link>:
.global link
link:
 li a7, SYS_link
 54e:	48cd                	li	a7,19
 ecall
 550:	00000073          	ecall
 ret
 554:	8082                	ret

0000000000000556 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 556:	48d1                	li	a7,20
 ecall
 558:	00000073          	ecall
 ret
 55c:	8082                	ret

000000000000055e <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 55e:	48a5                	li	a7,9
 ecall
 560:	00000073          	ecall
 ret
 564:	8082                	ret

0000000000000566 <dup>:
.global dup
dup:
 li a7, SYS_dup
 566:	48a9                	li	a7,10
 ecall
 568:	00000073          	ecall
 ret
 56c:	8082                	ret

000000000000056e <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 56e:	48ad                	li	a7,11
 ecall
 570:	00000073          	ecall
 ret
 574:	8082                	ret

0000000000000576 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 576:	48b1                	li	a7,12
 ecall
 578:	00000073          	ecall
 ret
 57c:	8082                	ret

000000000000057e <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 57e:	48b5                	li	a7,13
 ecall
 580:	00000073          	ecall
 ret
 584:	8082                	ret

0000000000000586 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 586:	48b9                	li	a7,14
 ecall
 588:	00000073          	ecall
 ret
 58c:	8082                	ret

000000000000058e <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 58e:	1101                	addi	sp,sp,-32
 590:	ec06                	sd	ra,24(sp)
 592:	e822                	sd	s0,16(sp)
 594:	1000                	addi	s0,sp,32
 596:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 59a:	4605                	li	a2,1
 59c:	fef40593          	addi	a1,s0,-17
 5a0:	00000097          	auipc	ra,0x0
 5a4:	f6e080e7          	jalr	-146(ra) # 50e <write>
}
 5a8:	60e2                	ld	ra,24(sp)
 5aa:	6442                	ld	s0,16(sp)
 5ac:	6105                	addi	sp,sp,32
 5ae:	8082                	ret

00000000000005b0 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 5b0:	7139                	addi	sp,sp,-64
 5b2:	fc06                	sd	ra,56(sp)
 5b4:	f822                	sd	s0,48(sp)
 5b6:	f426                	sd	s1,40(sp)
 5b8:	f04a                	sd	s2,32(sp)
 5ba:	ec4e                	sd	s3,24(sp)
 5bc:	0080                	addi	s0,sp,64
 5be:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 5c0:	c299                	beqz	a3,5c6 <printint+0x16>
 5c2:	0805c863          	bltz	a1,652 <printint+0xa2>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 5c6:	2581                	sext.w	a1,a1
  neg = 0;
 5c8:	4881                	li	a7,0
 5ca:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 5ce:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 5d0:	2601                	sext.w	a2,a2
 5d2:	00000517          	auipc	a0,0x0
 5d6:	4ce50513          	addi	a0,a0,1230 # aa0 <digits>
 5da:	883a                	mv	a6,a4
 5dc:	2705                	addiw	a4,a4,1
 5de:	02c5f7bb          	remuw	a5,a1,a2
 5e2:	1782                	slli	a5,a5,0x20
 5e4:	9381                	srli	a5,a5,0x20
 5e6:	97aa                	add	a5,a5,a0
 5e8:	0007c783          	lbu	a5,0(a5)
 5ec:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 5f0:	0005879b          	sext.w	a5,a1
 5f4:	02c5d5bb          	divuw	a1,a1,a2
 5f8:	0685                	addi	a3,a3,1
 5fa:	fec7f0e3          	bgeu	a5,a2,5da <printint+0x2a>
  if(neg)
 5fe:	00088b63          	beqz	a7,614 <printint+0x64>
    buf[i++] = '-';
 602:	fd040793          	addi	a5,s0,-48
 606:	973e                	add	a4,a4,a5
 608:	02d00793          	li	a5,45
 60c:	fef70823          	sb	a5,-16(a4)
 610:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 614:	02e05863          	blez	a4,644 <printint+0x94>
 618:	fc040793          	addi	a5,s0,-64
 61c:	00e78933          	add	s2,a5,a4
 620:	fff78993          	addi	s3,a5,-1
 624:	99ba                	add	s3,s3,a4
 626:	377d                	addiw	a4,a4,-1
 628:	1702                	slli	a4,a4,0x20
 62a:	9301                	srli	a4,a4,0x20
 62c:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 630:	fff94583          	lbu	a1,-1(s2)
 634:	8526                	mv	a0,s1
 636:	00000097          	auipc	ra,0x0
 63a:	f58080e7          	jalr	-168(ra) # 58e <putc>
  while(--i >= 0)
 63e:	197d                	addi	s2,s2,-1
 640:	ff3918e3          	bne	s2,s3,630 <printint+0x80>
}
 644:	70e2                	ld	ra,56(sp)
 646:	7442                	ld	s0,48(sp)
 648:	74a2                	ld	s1,40(sp)
 64a:	7902                	ld	s2,32(sp)
 64c:	69e2                	ld	s3,24(sp)
 64e:	6121                	addi	sp,sp,64
 650:	8082                	ret
    x = -xx;
 652:	40b005bb          	negw	a1,a1
    neg = 1;
 656:	4885                	li	a7,1
    x = -xx;
 658:	bf8d                	j	5ca <printint+0x1a>

000000000000065a <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 65a:	7119                	addi	sp,sp,-128
 65c:	fc86                	sd	ra,120(sp)
 65e:	f8a2                	sd	s0,112(sp)
 660:	f4a6                	sd	s1,104(sp)
 662:	f0ca                	sd	s2,96(sp)
 664:	ecce                	sd	s3,88(sp)
 666:	e8d2                	sd	s4,80(sp)
 668:	e4d6                	sd	s5,72(sp)
 66a:	e0da                	sd	s6,64(sp)
 66c:	fc5e                	sd	s7,56(sp)
 66e:	f862                	sd	s8,48(sp)
 670:	f466                	sd	s9,40(sp)
 672:	f06a                	sd	s10,32(sp)
 674:	ec6e                	sd	s11,24(sp)
 676:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 678:	0005c903          	lbu	s2,0(a1)
 67c:	18090f63          	beqz	s2,81a <vprintf+0x1c0>
 680:	8aaa                	mv	s5,a0
 682:	8b32                	mv	s6,a2
 684:	00158493          	addi	s1,a1,1
  state = 0;
 688:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 68a:	02500a13          	li	s4,37
      if(c == 'd'){
 68e:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
 692:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
 696:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
 69a:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 69e:	00000b97          	auipc	s7,0x0
 6a2:	402b8b93          	addi	s7,s7,1026 # aa0 <digits>
 6a6:	a839                	j	6c4 <vprintf+0x6a>
        putc(fd, c);
 6a8:	85ca                	mv	a1,s2
 6aa:	8556                	mv	a0,s5
 6ac:	00000097          	auipc	ra,0x0
 6b0:	ee2080e7          	jalr	-286(ra) # 58e <putc>
 6b4:	a019                	j	6ba <vprintf+0x60>
    } else if(state == '%'){
 6b6:	01498f63          	beq	s3,s4,6d4 <vprintf+0x7a>
  for(i = 0; fmt[i]; i++){
 6ba:	0485                	addi	s1,s1,1
 6bc:	fff4c903          	lbu	s2,-1(s1)
 6c0:	14090d63          	beqz	s2,81a <vprintf+0x1c0>
    c = fmt[i] & 0xff;
 6c4:	0009079b          	sext.w	a5,s2
    if(state == 0){
 6c8:	fe0997e3          	bnez	s3,6b6 <vprintf+0x5c>
      if(c == '%'){
 6cc:	fd479ee3          	bne	a5,s4,6a8 <vprintf+0x4e>
        state = '%';
 6d0:	89be                	mv	s3,a5
 6d2:	b7e5                	j	6ba <vprintf+0x60>
      if(c == 'd'){
 6d4:	05878063          	beq	a5,s8,714 <vprintf+0xba>
      } else if(c == 'l') {
 6d8:	05978c63          	beq	a5,s9,730 <vprintf+0xd6>
      } else if(c == 'x') {
 6dc:	07a78863          	beq	a5,s10,74c <vprintf+0xf2>
      } else if(c == 'p') {
 6e0:	09b78463          	beq	a5,s11,768 <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
 6e4:	07300713          	li	a4,115
 6e8:	0ce78663          	beq	a5,a4,7b4 <vprintf+0x15a>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 6ec:	06300713          	li	a4,99
 6f0:	0ee78e63          	beq	a5,a4,7ec <vprintf+0x192>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
 6f4:	11478863          	beq	a5,s4,804 <vprintf+0x1aa>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 6f8:	85d2                	mv	a1,s4
 6fa:	8556                	mv	a0,s5
 6fc:	00000097          	auipc	ra,0x0
 700:	e92080e7          	jalr	-366(ra) # 58e <putc>
        putc(fd, c);
 704:	85ca                	mv	a1,s2
 706:	8556                	mv	a0,s5
 708:	00000097          	auipc	ra,0x0
 70c:	e86080e7          	jalr	-378(ra) # 58e <putc>
      }
      state = 0;
 710:	4981                	li	s3,0
 712:	b765                	j	6ba <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
 714:	008b0913          	addi	s2,s6,8
 718:	4685                	li	a3,1
 71a:	4629                	li	a2,10
 71c:	000b2583          	lw	a1,0(s6)
 720:	8556                	mv	a0,s5
 722:	00000097          	auipc	ra,0x0
 726:	e8e080e7          	jalr	-370(ra) # 5b0 <printint>
 72a:	8b4a                	mv	s6,s2
      state = 0;
 72c:	4981                	li	s3,0
 72e:	b771                	j	6ba <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 730:	008b0913          	addi	s2,s6,8
 734:	4681                	li	a3,0
 736:	4629                	li	a2,10
 738:	000b2583          	lw	a1,0(s6)
 73c:	8556                	mv	a0,s5
 73e:	00000097          	auipc	ra,0x0
 742:	e72080e7          	jalr	-398(ra) # 5b0 <printint>
 746:	8b4a                	mv	s6,s2
      state = 0;
 748:	4981                	li	s3,0
 74a:	bf85                	j	6ba <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 74c:	008b0913          	addi	s2,s6,8
 750:	4681                	li	a3,0
 752:	4641                	li	a2,16
 754:	000b2583          	lw	a1,0(s6)
 758:	8556                	mv	a0,s5
 75a:	00000097          	auipc	ra,0x0
 75e:	e56080e7          	jalr	-426(ra) # 5b0 <printint>
 762:	8b4a                	mv	s6,s2
      state = 0;
 764:	4981                	li	s3,0
 766:	bf91                	j	6ba <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 768:	008b0793          	addi	a5,s6,8
 76c:	f8f43423          	sd	a5,-120(s0)
 770:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 774:	03000593          	li	a1,48
 778:	8556                	mv	a0,s5
 77a:	00000097          	auipc	ra,0x0
 77e:	e14080e7          	jalr	-492(ra) # 58e <putc>
  putc(fd, 'x');
 782:	85ea                	mv	a1,s10
 784:	8556                	mv	a0,s5
 786:	00000097          	auipc	ra,0x0
 78a:	e08080e7          	jalr	-504(ra) # 58e <putc>
 78e:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 790:	03c9d793          	srli	a5,s3,0x3c
 794:	97de                	add	a5,a5,s7
 796:	0007c583          	lbu	a1,0(a5)
 79a:	8556                	mv	a0,s5
 79c:	00000097          	auipc	ra,0x0
 7a0:	df2080e7          	jalr	-526(ra) # 58e <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 7a4:	0992                	slli	s3,s3,0x4
 7a6:	397d                	addiw	s2,s2,-1
 7a8:	fe0914e3          	bnez	s2,790 <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
 7ac:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 7b0:	4981                	li	s3,0
 7b2:	b721                	j	6ba <vprintf+0x60>
        s = va_arg(ap, char*);
 7b4:	008b0993          	addi	s3,s6,8
 7b8:	000b3903          	ld	s2,0(s6)
        if(s == 0)
 7bc:	02090163          	beqz	s2,7de <vprintf+0x184>
        while(*s != 0){
 7c0:	00094583          	lbu	a1,0(s2)
 7c4:	c9a1                	beqz	a1,814 <vprintf+0x1ba>
          putc(fd, *s);
 7c6:	8556                	mv	a0,s5
 7c8:	00000097          	auipc	ra,0x0
 7cc:	dc6080e7          	jalr	-570(ra) # 58e <putc>
          s++;
 7d0:	0905                	addi	s2,s2,1
        while(*s != 0){
 7d2:	00094583          	lbu	a1,0(s2)
 7d6:	f9e5                	bnez	a1,7c6 <vprintf+0x16c>
        s = va_arg(ap, char*);
 7d8:	8b4e                	mv	s6,s3
      state = 0;
 7da:	4981                	li	s3,0
 7dc:	bdf9                	j	6ba <vprintf+0x60>
          s = "(null)";
 7de:	00000917          	auipc	s2,0x0
 7e2:	2ba90913          	addi	s2,s2,698 # a98 <malloc+0x174>
        while(*s != 0){
 7e6:	02800593          	li	a1,40
 7ea:	bff1                	j	7c6 <vprintf+0x16c>
        putc(fd, va_arg(ap, uint));
 7ec:	008b0913          	addi	s2,s6,8
 7f0:	000b4583          	lbu	a1,0(s6)
 7f4:	8556                	mv	a0,s5
 7f6:	00000097          	auipc	ra,0x0
 7fa:	d98080e7          	jalr	-616(ra) # 58e <putc>
 7fe:	8b4a                	mv	s6,s2
      state = 0;
 800:	4981                	li	s3,0
 802:	bd65                	j	6ba <vprintf+0x60>
        putc(fd, c);
 804:	85d2                	mv	a1,s4
 806:	8556                	mv	a0,s5
 808:	00000097          	auipc	ra,0x0
 80c:	d86080e7          	jalr	-634(ra) # 58e <putc>
      state = 0;
 810:	4981                	li	s3,0
 812:	b565                	j	6ba <vprintf+0x60>
        s = va_arg(ap, char*);
 814:	8b4e                	mv	s6,s3
      state = 0;
 816:	4981                	li	s3,0
 818:	b54d                	j	6ba <vprintf+0x60>
    }
  }
}
 81a:	70e6                	ld	ra,120(sp)
 81c:	7446                	ld	s0,112(sp)
 81e:	74a6                	ld	s1,104(sp)
 820:	7906                	ld	s2,96(sp)
 822:	69e6                	ld	s3,88(sp)
 824:	6a46                	ld	s4,80(sp)
 826:	6aa6                	ld	s5,72(sp)
 828:	6b06                	ld	s6,64(sp)
 82a:	7be2                	ld	s7,56(sp)
 82c:	7c42                	ld	s8,48(sp)
 82e:	7ca2                	ld	s9,40(sp)
 830:	7d02                	ld	s10,32(sp)
 832:	6de2                	ld	s11,24(sp)
 834:	6109                	addi	sp,sp,128
 836:	8082                	ret

0000000000000838 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 838:	715d                	addi	sp,sp,-80
 83a:	ec06                	sd	ra,24(sp)
 83c:	e822                	sd	s0,16(sp)
 83e:	1000                	addi	s0,sp,32
 840:	e010                	sd	a2,0(s0)
 842:	e414                	sd	a3,8(s0)
 844:	e818                	sd	a4,16(s0)
 846:	ec1c                	sd	a5,24(s0)
 848:	03043023          	sd	a6,32(s0)
 84c:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 850:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 854:	8622                	mv	a2,s0
 856:	00000097          	auipc	ra,0x0
 85a:	e04080e7          	jalr	-508(ra) # 65a <vprintf>
}
 85e:	60e2                	ld	ra,24(sp)
 860:	6442                	ld	s0,16(sp)
 862:	6161                	addi	sp,sp,80
 864:	8082                	ret

0000000000000866 <printf>:

void
printf(const char *fmt, ...)
{
 866:	711d                	addi	sp,sp,-96
 868:	ec06                	sd	ra,24(sp)
 86a:	e822                	sd	s0,16(sp)
 86c:	1000                	addi	s0,sp,32
 86e:	e40c                	sd	a1,8(s0)
 870:	e810                	sd	a2,16(s0)
 872:	ec14                	sd	a3,24(s0)
 874:	f018                	sd	a4,32(s0)
 876:	f41c                	sd	a5,40(s0)
 878:	03043823          	sd	a6,48(s0)
 87c:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 880:	00840613          	addi	a2,s0,8
 884:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 888:	85aa                	mv	a1,a0
 88a:	4505                	li	a0,1
 88c:	00000097          	auipc	ra,0x0
 890:	dce080e7          	jalr	-562(ra) # 65a <vprintf>
}
 894:	60e2                	ld	ra,24(sp)
 896:	6442                	ld	s0,16(sp)
 898:	6125                	addi	sp,sp,96
 89a:	8082                	ret

000000000000089c <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 89c:	1141                	addi	sp,sp,-16
 89e:	e422                	sd	s0,8(sp)
 8a0:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 8a2:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8a6:	00000797          	auipc	a5,0x0
 8aa:	2127b783          	ld	a5,530(a5) # ab8 <freep>
 8ae:	a805                	j	8de <free+0x42>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 8b0:	4618                	lw	a4,8(a2)
 8b2:	9db9                	addw	a1,a1,a4
 8b4:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 8b8:	6398                	ld	a4,0(a5)
 8ba:	6318                	ld	a4,0(a4)
 8bc:	fee53823          	sd	a4,-16(a0)
 8c0:	a091                	j	904 <free+0x68>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 8c2:	ff852703          	lw	a4,-8(a0)
 8c6:	9e39                	addw	a2,a2,a4
 8c8:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
 8ca:	ff053703          	ld	a4,-16(a0)
 8ce:	e398                	sd	a4,0(a5)
 8d0:	a099                	j	916 <free+0x7a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8d2:	6398                	ld	a4,0(a5)
 8d4:	00e7e463          	bltu	a5,a4,8dc <free+0x40>
 8d8:	00e6ea63          	bltu	a3,a4,8ec <free+0x50>
{
 8dc:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8de:	fed7fae3          	bgeu	a5,a3,8d2 <free+0x36>
 8e2:	6398                	ld	a4,0(a5)
 8e4:	00e6e463          	bltu	a3,a4,8ec <free+0x50>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8e8:	fee7eae3          	bltu	a5,a4,8dc <free+0x40>
  if(bp + bp->s.size == p->s.ptr){
 8ec:	ff852583          	lw	a1,-8(a0)
 8f0:	6390                	ld	a2,0(a5)
 8f2:	02059713          	slli	a4,a1,0x20
 8f6:	9301                	srli	a4,a4,0x20
 8f8:	0712                	slli	a4,a4,0x4
 8fa:	9736                	add	a4,a4,a3
 8fc:	fae60ae3          	beq	a2,a4,8b0 <free+0x14>
    bp->s.ptr = p->s.ptr;
 900:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 904:	4790                	lw	a2,8(a5)
 906:	02061713          	slli	a4,a2,0x20
 90a:	9301                	srli	a4,a4,0x20
 90c:	0712                	slli	a4,a4,0x4
 90e:	973e                	add	a4,a4,a5
 910:	fae689e3          	beq	a3,a4,8c2 <free+0x26>
  } else
    p->s.ptr = bp;
 914:	e394                	sd	a3,0(a5)
  freep = p;
 916:	00000717          	auipc	a4,0x0
 91a:	1af73123          	sd	a5,418(a4) # ab8 <freep>
}
 91e:	6422                	ld	s0,8(sp)
 920:	0141                	addi	sp,sp,16
 922:	8082                	ret

0000000000000924 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 924:	7139                	addi	sp,sp,-64
 926:	fc06                	sd	ra,56(sp)
 928:	f822                	sd	s0,48(sp)
 92a:	f426                	sd	s1,40(sp)
 92c:	f04a                	sd	s2,32(sp)
 92e:	ec4e                	sd	s3,24(sp)
 930:	e852                	sd	s4,16(sp)
 932:	e456                	sd	s5,8(sp)
 934:	e05a                	sd	s6,0(sp)
 936:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 938:	02051493          	slli	s1,a0,0x20
 93c:	9081                	srli	s1,s1,0x20
 93e:	04bd                	addi	s1,s1,15
 940:	8091                	srli	s1,s1,0x4
 942:	0014899b          	addiw	s3,s1,1
 946:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 948:	00000517          	auipc	a0,0x0
 94c:	17053503          	ld	a0,368(a0) # ab8 <freep>
 950:	c515                	beqz	a0,97c <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 952:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 954:	4798                	lw	a4,8(a5)
 956:	02977f63          	bgeu	a4,s1,994 <malloc+0x70>
 95a:	8a4e                	mv	s4,s3
 95c:	0009871b          	sext.w	a4,s3
 960:	6685                	lui	a3,0x1
 962:	00d77363          	bgeu	a4,a3,968 <malloc+0x44>
 966:	6a05                	lui	s4,0x1
 968:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 96c:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 970:	00000917          	auipc	s2,0x0
 974:	14890913          	addi	s2,s2,328 # ab8 <freep>
  if(p == (char*)-1)
 978:	5afd                	li	s5,-1
 97a:	a88d                	j	9ec <malloc+0xc8>
    base.s.ptr = freep = prevp = &base;
 97c:	00000797          	auipc	a5,0x0
 980:	14478793          	addi	a5,a5,324 # ac0 <base>
 984:	00000717          	auipc	a4,0x0
 988:	12f73a23          	sd	a5,308(a4) # ab8 <freep>
 98c:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 98e:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 992:	b7e1                	j	95a <malloc+0x36>
      if(p->s.size == nunits)
 994:	02e48b63          	beq	s1,a4,9ca <malloc+0xa6>
        p->s.size -= nunits;
 998:	4137073b          	subw	a4,a4,s3
 99c:	c798                	sw	a4,8(a5)
        p += p->s.size;
 99e:	1702                	slli	a4,a4,0x20
 9a0:	9301                	srli	a4,a4,0x20
 9a2:	0712                	slli	a4,a4,0x4
 9a4:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 9a6:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 9aa:	00000717          	auipc	a4,0x0
 9ae:	10a73723          	sd	a0,270(a4) # ab8 <freep>
      return (void*)(p + 1);
 9b2:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 9b6:	70e2                	ld	ra,56(sp)
 9b8:	7442                	ld	s0,48(sp)
 9ba:	74a2                	ld	s1,40(sp)
 9bc:	7902                	ld	s2,32(sp)
 9be:	69e2                	ld	s3,24(sp)
 9c0:	6a42                	ld	s4,16(sp)
 9c2:	6aa2                	ld	s5,8(sp)
 9c4:	6b02                	ld	s6,0(sp)
 9c6:	6121                	addi	sp,sp,64
 9c8:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 9ca:	6398                	ld	a4,0(a5)
 9cc:	e118                	sd	a4,0(a0)
 9ce:	bff1                	j	9aa <malloc+0x86>
  hp->s.size = nu;
 9d0:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 9d4:	0541                	addi	a0,a0,16
 9d6:	00000097          	auipc	ra,0x0
 9da:	ec6080e7          	jalr	-314(ra) # 89c <free>
  return freep;
 9de:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 9e2:	d971                	beqz	a0,9b6 <malloc+0x92>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 9e4:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 9e6:	4798                	lw	a4,8(a5)
 9e8:	fa9776e3          	bgeu	a4,s1,994 <malloc+0x70>
    if(p == freep)
 9ec:	00093703          	ld	a4,0(s2)
 9f0:	853e                	mv	a0,a5
 9f2:	fef719e3          	bne	a4,a5,9e4 <malloc+0xc0>
  p = sbrk(nu * sizeof(Header));
 9f6:	8552                	mv	a0,s4
 9f8:	00000097          	auipc	ra,0x0
 9fc:	b7e080e7          	jalr	-1154(ra) # 576 <sbrk>
  if(p == (char*)-1)
 a00:	fd5518e3          	bne	a0,s5,9d0 <malloc+0xac>
        return 0;
 a04:	4501                	li	a0,0
 a06:	bf45                	j	9b6 <malloc+0x92>
