
user/_xargs:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "user/user.h"
#include "kernel/param.h"

int
main(int argc, char *argv[]) 
{
   0:	710d                	addi	sp,sp,-352
   2:	ee86                	sd	ra,344(sp)
   4:	eaa2                	sd	s0,336(sp)
   6:	e6a6                	sd	s1,328(sp)
   8:	e2ca                	sd	s2,320(sp)
   a:	fe4e                	sd	s3,312(sp)
   c:	fa52                	sd	s4,304(sp)
   e:	f656                	sd	s5,296(sp)
  10:	f25a                	sd	s6,288(sp)
  12:	1280                	addi	s0,sp,352
  14:	892a                	mv	s2,a0
  16:	84ae                	mv	s1,a1
    char buf[MAXARG];
    // get standard input
    while (read(0, &buf, MAXARG) == 0) {}
  18:	02000613          	li	a2,32
  1c:	fa040593          	addi	a1,s0,-96
  20:	4501                	li	a0,0
  22:	00000097          	auipc	ra,0x0
  26:	350080e7          	jalr	848(ra) # 372 <read>
  2a:	d57d                	beqz	a0,18 <main+0x18>

    // get arguments from xargs
    char *xargv[MAXARG];
    int xargc = 0;
    for (int i = 1; i < argc; i++) {
  2c:	4785                	li	a5,1
  2e:	0527d063          	bge	a5,s2,6e <main+0x6e>
  32:	00848713          	addi	a4,s1,8
  36:	ea040793          	addi	a5,s0,-352
  3a:	0009059b          	sext.w	a1,s2
  3e:	ffe9069b          	addiw	a3,s2,-2
  42:	1682                	slli	a3,a3,0x20
  44:	9281                	srli	a3,a3,0x20
  46:	068e                	slli	a3,a3,0x3
  48:	ea840613          	addi	a2,s0,-344
  4c:	96b2                	add	a3,a3,a2
        xargv[xargc++] = argv[i];
  4e:	6310                	ld	a2,0(a4)
  50:	e390                	sd	a2,0(a5)
    for (int i = 1; i < argc; i++) {
  52:	0721                	addi	a4,a4,8
  54:	07a1                	addi	a5,a5,8
  56:	fed79ce3          	bne	a5,a3,4e <main+0x4e>
  5a:	fff58b1b          	addiw	s6,a1,-1
    }

    char *p = buf;
    // excute the command with the arguments
    for (int i = 0; i < MAXARG; i++) {
  5e:	fa040493          	addi	s1,s0,-96
  62:	4901                	li	s2,0
    char *p = buf;
  64:	8aa6                	mv	s5,s1
        if (buf[i] == '\n') {
  66:	49a9                	li	s3,10
    for (int i = 0; i < MAXARG; i++) {
  68:	02000a13          	li	s4,32
  6c:	a0b1                	j	b8 <main+0xb8>
    int xargc = 0;
  6e:	4b01                	li	s6,0
  70:	b7fd                	j	5e <main+0x5e>
            if (fork() == 0) {
                // child
                buf[i] = 0;
  72:	fc040793          	addi	a5,s0,-64
  76:	993e                	add	s2,s2,a5
  78:	fe090023          	sb	zero,-32(s2)
                xargv[xargc++] = p;
  7c:	003b1793          	slli	a5,s6,0x3
  80:	fc040713          	addi	a4,s0,-64
  84:	97ba                	add	a5,a5,a4
  86:	ef57b023          	sd	s5,-288(a5)
                xargv[xargc++] = 0;
  8a:	001b079b          	addiw	a5,s6,1
  8e:	078e                	slli	a5,a5,0x3
  90:	97ba                	add	a5,a5,a4
  92:	ee07b023          	sd	zero,-288(a5)
                exec(xargv[0], xargv);
  96:	ea040593          	addi	a1,s0,-352
  9a:	ea043503          	ld	a0,-352(s0)
  9e:	00000097          	auipc	ra,0x0
  a2:	2f4080e7          	jalr	756(ra) # 392 <exec>
                exit(0);
  a6:	4501                	li	a0,0
  a8:	00000097          	auipc	ra,0x0
  ac:	2b2080e7          	jalr	690(ra) # 35a <exit>
    for (int i = 0; i < MAXARG; i++) {
  b0:	2905                	addiw	s2,s2,1
  b2:	0485                	addi	s1,s1,1
  b4:	03490363          	beq	s2,s4,da <main+0xda>
        if (buf[i] == '\n') {
  b8:	0004c783          	lbu	a5,0(s1)
  bc:	ff379ae3          	bne	a5,s3,b0 <main+0xb0>
            if (fork() == 0) {
  c0:	00000097          	auipc	ra,0x0
  c4:	292080e7          	jalr	658(ra) # 352 <fork>
  c8:	d54d                	beqz	a0,72 <main+0x72>
            } else {
                wait(0);
  ca:	4501                	li	a0,0
  cc:	00000097          	auipc	ra,0x0
  d0:	296080e7          	jalr	662(ra) # 362 <wait>
                p = buf + i + 1;
  d4:	00148a93          	addi	s5,s1,1
  d8:	bfe1                	j	b0 <main+0xb0>
            }
        }
    }
    exit(0);
  da:	4501                	li	a0,0
  dc:	00000097          	auipc	ra,0x0
  e0:	27e080e7          	jalr	638(ra) # 35a <exit>

00000000000000e4 <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
  e4:	1141                	addi	sp,sp,-16
  e6:	e422                	sd	s0,8(sp)
  e8:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  ea:	87aa                	mv	a5,a0
  ec:	0585                	addi	a1,a1,1
  ee:	0785                	addi	a5,a5,1
  f0:	fff5c703          	lbu	a4,-1(a1)
  f4:	fee78fa3          	sb	a4,-1(a5)
  f8:	fb75                	bnez	a4,ec <strcpy+0x8>
    ;
  return os;
}
  fa:	6422                	ld	s0,8(sp)
  fc:	0141                	addi	sp,sp,16
  fe:	8082                	ret

0000000000000100 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 100:	1141                	addi	sp,sp,-16
 102:	e422                	sd	s0,8(sp)
 104:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 106:	00054783          	lbu	a5,0(a0)
 10a:	cb91                	beqz	a5,11e <strcmp+0x1e>
 10c:	0005c703          	lbu	a4,0(a1)
 110:	00f71763          	bne	a4,a5,11e <strcmp+0x1e>
    p++, q++;
 114:	0505                	addi	a0,a0,1
 116:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 118:	00054783          	lbu	a5,0(a0)
 11c:	fbe5                	bnez	a5,10c <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 11e:	0005c503          	lbu	a0,0(a1)
}
 122:	40a7853b          	subw	a0,a5,a0
 126:	6422                	ld	s0,8(sp)
 128:	0141                	addi	sp,sp,16
 12a:	8082                	ret

000000000000012c <strlen>:

uint
strlen(const char *s)
{
 12c:	1141                	addi	sp,sp,-16
 12e:	e422                	sd	s0,8(sp)
 130:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 132:	00054783          	lbu	a5,0(a0)
 136:	cf91                	beqz	a5,152 <strlen+0x26>
 138:	0505                	addi	a0,a0,1
 13a:	87aa                	mv	a5,a0
 13c:	4685                	li	a3,1
 13e:	9e89                	subw	a3,a3,a0
 140:	00f6853b          	addw	a0,a3,a5
 144:	0785                	addi	a5,a5,1
 146:	fff7c703          	lbu	a4,-1(a5)
 14a:	fb7d                	bnez	a4,140 <strlen+0x14>
    ;
  return n;
}
 14c:	6422                	ld	s0,8(sp)
 14e:	0141                	addi	sp,sp,16
 150:	8082                	ret
  for(n = 0; s[n]; n++)
 152:	4501                	li	a0,0
 154:	bfe5                	j	14c <strlen+0x20>

0000000000000156 <memset>:

void*
memset(void *dst, int c, uint n)
{
 156:	1141                	addi	sp,sp,-16
 158:	e422                	sd	s0,8(sp)
 15a:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 15c:	ce09                	beqz	a2,176 <memset+0x20>
 15e:	87aa                	mv	a5,a0
 160:	fff6071b          	addiw	a4,a2,-1
 164:	1702                	slli	a4,a4,0x20
 166:	9301                	srli	a4,a4,0x20
 168:	0705                	addi	a4,a4,1
 16a:	972a                	add	a4,a4,a0
    cdst[i] = c;
 16c:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 170:	0785                	addi	a5,a5,1
 172:	fee79de3          	bne	a5,a4,16c <memset+0x16>
  }
  return dst;
}
 176:	6422                	ld	s0,8(sp)
 178:	0141                	addi	sp,sp,16
 17a:	8082                	ret

000000000000017c <strchr>:

char*
strchr(const char *s, char c)
{
 17c:	1141                	addi	sp,sp,-16
 17e:	e422                	sd	s0,8(sp)
 180:	0800                	addi	s0,sp,16
  for(; *s; s++)
 182:	00054783          	lbu	a5,0(a0)
 186:	cb99                	beqz	a5,19c <strchr+0x20>
    if(*s == c)
 188:	00f58763          	beq	a1,a5,196 <strchr+0x1a>
  for(; *s; s++)
 18c:	0505                	addi	a0,a0,1
 18e:	00054783          	lbu	a5,0(a0)
 192:	fbfd                	bnez	a5,188 <strchr+0xc>
      return (char*)s;
  return 0;
 194:	4501                	li	a0,0
}
 196:	6422                	ld	s0,8(sp)
 198:	0141                	addi	sp,sp,16
 19a:	8082                	ret
  return 0;
 19c:	4501                	li	a0,0
 19e:	bfe5                	j	196 <strchr+0x1a>

00000000000001a0 <gets>:

char*
gets(char *buf, int max)
{
 1a0:	711d                	addi	sp,sp,-96
 1a2:	ec86                	sd	ra,88(sp)
 1a4:	e8a2                	sd	s0,80(sp)
 1a6:	e4a6                	sd	s1,72(sp)
 1a8:	e0ca                	sd	s2,64(sp)
 1aa:	fc4e                	sd	s3,56(sp)
 1ac:	f852                	sd	s4,48(sp)
 1ae:	f456                	sd	s5,40(sp)
 1b0:	f05a                	sd	s6,32(sp)
 1b2:	ec5e                	sd	s7,24(sp)
 1b4:	1080                	addi	s0,sp,96
 1b6:	8baa                	mv	s7,a0
 1b8:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1ba:	892a                	mv	s2,a0
 1bc:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 1be:	4aa9                	li	s5,10
 1c0:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 1c2:	89a6                	mv	s3,s1
 1c4:	2485                	addiw	s1,s1,1
 1c6:	0344d863          	bge	s1,s4,1f6 <gets+0x56>
    cc = read(0, &c, 1);
 1ca:	4605                	li	a2,1
 1cc:	faf40593          	addi	a1,s0,-81
 1d0:	4501                	li	a0,0
 1d2:	00000097          	auipc	ra,0x0
 1d6:	1a0080e7          	jalr	416(ra) # 372 <read>
    if(cc < 1)
 1da:	00a05e63          	blez	a0,1f6 <gets+0x56>
    buf[i++] = c;
 1de:	faf44783          	lbu	a5,-81(s0)
 1e2:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 1e6:	01578763          	beq	a5,s5,1f4 <gets+0x54>
 1ea:	0905                	addi	s2,s2,1
 1ec:	fd679be3          	bne	a5,s6,1c2 <gets+0x22>
  for(i=0; i+1 < max; ){
 1f0:	89a6                	mv	s3,s1
 1f2:	a011                	j	1f6 <gets+0x56>
 1f4:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 1f6:	99de                	add	s3,s3,s7
 1f8:	00098023          	sb	zero,0(s3)
  return buf;
}
 1fc:	855e                	mv	a0,s7
 1fe:	60e6                	ld	ra,88(sp)
 200:	6446                	ld	s0,80(sp)
 202:	64a6                	ld	s1,72(sp)
 204:	6906                	ld	s2,64(sp)
 206:	79e2                	ld	s3,56(sp)
 208:	7a42                	ld	s4,48(sp)
 20a:	7aa2                	ld	s5,40(sp)
 20c:	7b02                	ld	s6,32(sp)
 20e:	6be2                	ld	s7,24(sp)
 210:	6125                	addi	sp,sp,96
 212:	8082                	ret

0000000000000214 <stat>:

int
stat(const char *n, struct stat *st)
{
 214:	1101                	addi	sp,sp,-32
 216:	ec06                	sd	ra,24(sp)
 218:	e822                	sd	s0,16(sp)
 21a:	e426                	sd	s1,8(sp)
 21c:	e04a                	sd	s2,0(sp)
 21e:	1000                	addi	s0,sp,32
 220:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 222:	4581                	li	a1,0
 224:	00000097          	auipc	ra,0x0
 228:	176080e7          	jalr	374(ra) # 39a <open>
  if(fd < 0)
 22c:	02054563          	bltz	a0,256 <stat+0x42>
 230:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 232:	85ca                	mv	a1,s2
 234:	00000097          	auipc	ra,0x0
 238:	17e080e7          	jalr	382(ra) # 3b2 <fstat>
 23c:	892a                	mv	s2,a0
  close(fd);
 23e:	8526                	mv	a0,s1
 240:	00000097          	auipc	ra,0x0
 244:	142080e7          	jalr	322(ra) # 382 <close>
  return r;
}
 248:	854a                	mv	a0,s2
 24a:	60e2                	ld	ra,24(sp)
 24c:	6442                	ld	s0,16(sp)
 24e:	64a2                	ld	s1,8(sp)
 250:	6902                	ld	s2,0(sp)
 252:	6105                	addi	sp,sp,32
 254:	8082                	ret
    return -1;
 256:	597d                	li	s2,-1
 258:	bfc5                	j	248 <stat+0x34>

000000000000025a <atoi>:

int
atoi(const char *s)
{
 25a:	1141                	addi	sp,sp,-16
 25c:	e422                	sd	s0,8(sp)
 25e:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 260:	00054603          	lbu	a2,0(a0)
 264:	fd06079b          	addiw	a5,a2,-48
 268:	0ff7f793          	andi	a5,a5,255
 26c:	4725                	li	a4,9
 26e:	02f76963          	bltu	a4,a5,2a0 <atoi+0x46>
 272:	86aa                	mv	a3,a0
  n = 0;
 274:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
 276:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
 278:	0685                	addi	a3,a3,1
 27a:	0025179b          	slliw	a5,a0,0x2
 27e:	9fa9                	addw	a5,a5,a0
 280:	0017979b          	slliw	a5,a5,0x1
 284:	9fb1                	addw	a5,a5,a2
 286:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 28a:	0006c603          	lbu	a2,0(a3)
 28e:	fd06071b          	addiw	a4,a2,-48
 292:	0ff77713          	andi	a4,a4,255
 296:	fee5f1e3          	bgeu	a1,a4,278 <atoi+0x1e>
  return n;
}
 29a:	6422                	ld	s0,8(sp)
 29c:	0141                	addi	sp,sp,16
 29e:	8082                	ret
  n = 0;
 2a0:	4501                	li	a0,0
 2a2:	bfe5                	j	29a <atoi+0x40>

00000000000002a4 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 2a4:	1141                	addi	sp,sp,-16
 2a6:	e422                	sd	s0,8(sp)
 2a8:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 2aa:	02b57663          	bgeu	a0,a1,2d6 <memmove+0x32>
    while(n-- > 0)
 2ae:	02c05163          	blez	a2,2d0 <memmove+0x2c>
 2b2:	fff6079b          	addiw	a5,a2,-1
 2b6:	1782                	slli	a5,a5,0x20
 2b8:	9381                	srli	a5,a5,0x20
 2ba:	0785                	addi	a5,a5,1
 2bc:	97aa                	add	a5,a5,a0
  dst = vdst;
 2be:	872a                	mv	a4,a0
      *dst++ = *src++;
 2c0:	0585                	addi	a1,a1,1
 2c2:	0705                	addi	a4,a4,1
 2c4:	fff5c683          	lbu	a3,-1(a1)
 2c8:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 2cc:	fee79ae3          	bne	a5,a4,2c0 <memmove+0x1c>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 2d0:	6422                	ld	s0,8(sp)
 2d2:	0141                	addi	sp,sp,16
 2d4:	8082                	ret
    dst += n;
 2d6:	00c50733          	add	a4,a0,a2
    src += n;
 2da:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 2dc:	fec05ae3          	blez	a2,2d0 <memmove+0x2c>
 2e0:	fff6079b          	addiw	a5,a2,-1
 2e4:	1782                	slli	a5,a5,0x20
 2e6:	9381                	srli	a5,a5,0x20
 2e8:	fff7c793          	not	a5,a5
 2ec:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 2ee:	15fd                	addi	a1,a1,-1
 2f0:	177d                	addi	a4,a4,-1
 2f2:	0005c683          	lbu	a3,0(a1)
 2f6:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 2fa:	fee79ae3          	bne	a5,a4,2ee <memmove+0x4a>
 2fe:	bfc9                	j	2d0 <memmove+0x2c>

0000000000000300 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 300:	1141                	addi	sp,sp,-16
 302:	e422                	sd	s0,8(sp)
 304:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 306:	ca05                	beqz	a2,336 <memcmp+0x36>
 308:	fff6069b          	addiw	a3,a2,-1
 30c:	1682                	slli	a3,a3,0x20
 30e:	9281                	srli	a3,a3,0x20
 310:	0685                	addi	a3,a3,1
 312:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 314:	00054783          	lbu	a5,0(a0)
 318:	0005c703          	lbu	a4,0(a1)
 31c:	00e79863          	bne	a5,a4,32c <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 320:	0505                	addi	a0,a0,1
    p2++;
 322:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 324:	fed518e3          	bne	a0,a3,314 <memcmp+0x14>
  }
  return 0;
 328:	4501                	li	a0,0
 32a:	a019                	j	330 <memcmp+0x30>
      return *p1 - *p2;
 32c:	40e7853b          	subw	a0,a5,a4
}
 330:	6422                	ld	s0,8(sp)
 332:	0141                	addi	sp,sp,16
 334:	8082                	ret
  return 0;
 336:	4501                	li	a0,0
 338:	bfe5                	j	330 <memcmp+0x30>

000000000000033a <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 33a:	1141                	addi	sp,sp,-16
 33c:	e406                	sd	ra,8(sp)
 33e:	e022                	sd	s0,0(sp)
 340:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 342:	00000097          	auipc	ra,0x0
 346:	f62080e7          	jalr	-158(ra) # 2a4 <memmove>
}
 34a:	60a2                	ld	ra,8(sp)
 34c:	6402                	ld	s0,0(sp)
 34e:	0141                	addi	sp,sp,16
 350:	8082                	ret

0000000000000352 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 352:	4885                	li	a7,1
 ecall
 354:	00000073          	ecall
 ret
 358:	8082                	ret

000000000000035a <exit>:
.global exit
exit:
 li a7, SYS_exit
 35a:	4889                	li	a7,2
 ecall
 35c:	00000073          	ecall
 ret
 360:	8082                	ret

0000000000000362 <wait>:
.global wait
wait:
 li a7, SYS_wait
 362:	488d                	li	a7,3
 ecall
 364:	00000073          	ecall
 ret
 368:	8082                	ret

000000000000036a <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 36a:	4891                	li	a7,4
 ecall
 36c:	00000073          	ecall
 ret
 370:	8082                	ret

0000000000000372 <read>:
.global read
read:
 li a7, SYS_read
 372:	4895                	li	a7,5
 ecall
 374:	00000073          	ecall
 ret
 378:	8082                	ret

000000000000037a <write>:
.global write
write:
 li a7, SYS_write
 37a:	48c1                	li	a7,16
 ecall
 37c:	00000073          	ecall
 ret
 380:	8082                	ret

0000000000000382 <close>:
.global close
close:
 li a7, SYS_close
 382:	48d5                	li	a7,21
 ecall
 384:	00000073          	ecall
 ret
 388:	8082                	ret

000000000000038a <kill>:
.global kill
kill:
 li a7, SYS_kill
 38a:	4899                	li	a7,6
 ecall
 38c:	00000073          	ecall
 ret
 390:	8082                	ret

0000000000000392 <exec>:
.global exec
exec:
 li a7, SYS_exec
 392:	489d                	li	a7,7
 ecall
 394:	00000073          	ecall
 ret
 398:	8082                	ret

000000000000039a <open>:
.global open
open:
 li a7, SYS_open
 39a:	48bd                	li	a7,15
 ecall
 39c:	00000073          	ecall
 ret
 3a0:	8082                	ret

00000000000003a2 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 3a2:	48c5                	li	a7,17
 ecall
 3a4:	00000073          	ecall
 ret
 3a8:	8082                	ret

00000000000003aa <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 3aa:	48c9                	li	a7,18
 ecall
 3ac:	00000073          	ecall
 ret
 3b0:	8082                	ret

00000000000003b2 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 3b2:	48a1                	li	a7,8
 ecall
 3b4:	00000073          	ecall
 ret
 3b8:	8082                	ret

00000000000003ba <link>:
.global link
link:
 li a7, SYS_link
 3ba:	48cd                	li	a7,19
 ecall
 3bc:	00000073          	ecall
 ret
 3c0:	8082                	ret

00000000000003c2 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 3c2:	48d1                	li	a7,20
 ecall
 3c4:	00000073          	ecall
 ret
 3c8:	8082                	ret

00000000000003ca <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 3ca:	48a5                	li	a7,9
 ecall
 3cc:	00000073          	ecall
 ret
 3d0:	8082                	ret

00000000000003d2 <dup>:
.global dup
dup:
 li a7, SYS_dup
 3d2:	48a9                	li	a7,10
 ecall
 3d4:	00000073          	ecall
 ret
 3d8:	8082                	ret

00000000000003da <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 3da:	48ad                	li	a7,11
 ecall
 3dc:	00000073          	ecall
 ret
 3e0:	8082                	ret

00000000000003e2 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 3e2:	48b1                	li	a7,12
 ecall
 3e4:	00000073          	ecall
 ret
 3e8:	8082                	ret

00000000000003ea <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 3ea:	48b5                	li	a7,13
 ecall
 3ec:	00000073          	ecall
 ret
 3f0:	8082                	ret

00000000000003f2 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 3f2:	48b9                	li	a7,14
 ecall
 3f4:	00000073          	ecall
 ret
 3f8:	8082                	ret

00000000000003fa <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 3fa:	1101                	addi	sp,sp,-32
 3fc:	ec06                	sd	ra,24(sp)
 3fe:	e822                	sd	s0,16(sp)
 400:	1000                	addi	s0,sp,32
 402:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 406:	4605                	li	a2,1
 408:	fef40593          	addi	a1,s0,-17
 40c:	00000097          	auipc	ra,0x0
 410:	f6e080e7          	jalr	-146(ra) # 37a <write>
}
 414:	60e2                	ld	ra,24(sp)
 416:	6442                	ld	s0,16(sp)
 418:	6105                	addi	sp,sp,32
 41a:	8082                	ret

000000000000041c <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 41c:	7139                	addi	sp,sp,-64
 41e:	fc06                	sd	ra,56(sp)
 420:	f822                	sd	s0,48(sp)
 422:	f426                	sd	s1,40(sp)
 424:	f04a                	sd	s2,32(sp)
 426:	ec4e                	sd	s3,24(sp)
 428:	0080                	addi	s0,sp,64
 42a:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 42c:	c299                	beqz	a3,432 <printint+0x16>
 42e:	0805c863          	bltz	a1,4be <printint+0xa2>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 432:	2581                	sext.w	a1,a1
  neg = 0;
 434:	4881                	li	a7,0
 436:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 43a:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 43c:	2601                	sext.w	a2,a2
 43e:	00000517          	auipc	a0,0x0
 442:	44250513          	addi	a0,a0,1090 # 880 <digits>
 446:	883a                	mv	a6,a4
 448:	2705                	addiw	a4,a4,1
 44a:	02c5f7bb          	remuw	a5,a1,a2
 44e:	1782                	slli	a5,a5,0x20
 450:	9381                	srli	a5,a5,0x20
 452:	97aa                	add	a5,a5,a0
 454:	0007c783          	lbu	a5,0(a5)
 458:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 45c:	0005879b          	sext.w	a5,a1
 460:	02c5d5bb          	divuw	a1,a1,a2
 464:	0685                	addi	a3,a3,1
 466:	fec7f0e3          	bgeu	a5,a2,446 <printint+0x2a>
  if(neg)
 46a:	00088b63          	beqz	a7,480 <printint+0x64>
    buf[i++] = '-';
 46e:	fd040793          	addi	a5,s0,-48
 472:	973e                	add	a4,a4,a5
 474:	02d00793          	li	a5,45
 478:	fef70823          	sb	a5,-16(a4)
 47c:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 480:	02e05863          	blez	a4,4b0 <printint+0x94>
 484:	fc040793          	addi	a5,s0,-64
 488:	00e78933          	add	s2,a5,a4
 48c:	fff78993          	addi	s3,a5,-1
 490:	99ba                	add	s3,s3,a4
 492:	377d                	addiw	a4,a4,-1
 494:	1702                	slli	a4,a4,0x20
 496:	9301                	srli	a4,a4,0x20
 498:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 49c:	fff94583          	lbu	a1,-1(s2)
 4a0:	8526                	mv	a0,s1
 4a2:	00000097          	auipc	ra,0x0
 4a6:	f58080e7          	jalr	-168(ra) # 3fa <putc>
  while(--i >= 0)
 4aa:	197d                	addi	s2,s2,-1
 4ac:	ff3918e3          	bne	s2,s3,49c <printint+0x80>
}
 4b0:	70e2                	ld	ra,56(sp)
 4b2:	7442                	ld	s0,48(sp)
 4b4:	74a2                	ld	s1,40(sp)
 4b6:	7902                	ld	s2,32(sp)
 4b8:	69e2                	ld	s3,24(sp)
 4ba:	6121                	addi	sp,sp,64
 4bc:	8082                	ret
    x = -xx;
 4be:	40b005bb          	negw	a1,a1
    neg = 1;
 4c2:	4885                	li	a7,1
    x = -xx;
 4c4:	bf8d                	j	436 <printint+0x1a>

00000000000004c6 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 4c6:	7119                	addi	sp,sp,-128
 4c8:	fc86                	sd	ra,120(sp)
 4ca:	f8a2                	sd	s0,112(sp)
 4cc:	f4a6                	sd	s1,104(sp)
 4ce:	f0ca                	sd	s2,96(sp)
 4d0:	ecce                	sd	s3,88(sp)
 4d2:	e8d2                	sd	s4,80(sp)
 4d4:	e4d6                	sd	s5,72(sp)
 4d6:	e0da                	sd	s6,64(sp)
 4d8:	fc5e                	sd	s7,56(sp)
 4da:	f862                	sd	s8,48(sp)
 4dc:	f466                	sd	s9,40(sp)
 4de:	f06a                	sd	s10,32(sp)
 4e0:	ec6e                	sd	s11,24(sp)
 4e2:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 4e4:	0005c903          	lbu	s2,0(a1)
 4e8:	18090f63          	beqz	s2,686 <vprintf+0x1c0>
 4ec:	8aaa                	mv	s5,a0
 4ee:	8b32                	mv	s6,a2
 4f0:	00158493          	addi	s1,a1,1
  state = 0;
 4f4:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 4f6:	02500a13          	li	s4,37
      if(c == 'd'){
 4fa:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
 4fe:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
 502:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
 506:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 50a:	00000b97          	auipc	s7,0x0
 50e:	376b8b93          	addi	s7,s7,886 # 880 <digits>
 512:	a839                	j	530 <vprintf+0x6a>
        putc(fd, c);
 514:	85ca                	mv	a1,s2
 516:	8556                	mv	a0,s5
 518:	00000097          	auipc	ra,0x0
 51c:	ee2080e7          	jalr	-286(ra) # 3fa <putc>
 520:	a019                	j	526 <vprintf+0x60>
    } else if(state == '%'){
 522:	01498f63          	beq	s3,s4,540 <vprintf+0x7a>
  for(i = 0; fmt[i]; i++){
 526:	0485                	addi	s1,s1,1
 528:	fff4c903          	lbu	s2,-1(s1)
 52c:	14090d63          	beqz	s2,686 <vprintf+0x1c0>
    c = fmt[i] & 0xff;
 530:	0009079b          	sext.w	a5,s2
    if(state == 0){
 534:	fe0997e3          	bnez	s3,522 <vprintf+0x5c>
      if(c == '%'){
 538:	fd479ee3          	bne	a5,s4,514 <vprintf+0x4e>
        state = '%';
 53c:	89be                	mv	s3,a5
 53e:	b7e5                	j	526 <vprintf+0x60>
      if(c == 'd'){
 540:	05878063          	beq	a5,s8,580 <vprintf+0xba>
      } else if(c == 'l') {
 544:	05978c63          	beq	a5,s9,59c <vprintf+0xd6>
      } else if(c == 'x') {
 548:	07a78863          	beq	a5,s10,5b8 <vprintf+0xf2>
      } else if(c == 'p') {
 54c:	09b78463          	beq	a5,s11,5d4 <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
 550:	07300713          	li	a4,115
 554:	0ce78663          	beq	a5,a4,620 <vprintf+0x15a>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 558:	06300713          	li	a4,99
 55c:	0ee78e63          	beq	a5,a4,658 <vprintf+0x192>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
 560:	11478863          	beq	a5,s4,670 <vprintf+0x1aa>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 564:	85d2                	mv	a1,s4
 566:	8556                	mv	a0,s5
 568:	00000097          	auipc	ra,0x0
 56c:	e92080e7          	jalr	-366(ra) # 3fa <putc>
        putc(fd, c);
 570:	85ca                	mv	a1,s2
 572:	8556                	mv	a0,s5
 574:	00000097          	auipc	ra,0x0
 578:	e86080e7          	jalr	-378(ra) # 3fa <putc>
      }
      state = 0;
 57c:	4981                	li	s3,0
 57e:	b765                	j	526 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
 580:	008b0913          	addi	s2,s6,8
 584:	4685                	li	a3,1
 586:	4629                	li	a2,10
 588:	000b2583          	lw	a1,0(s6)
 58c:	8556                	mv	a0,s5
 58e:	00000097          	auipc	ra,0x0
 592:	e8e080e7          	jalr	-370(ra) # 41c <printint>
 596:	8b4a                	mv	s6,s2
      state = 0;
 598:	4981                	li	s3,0
 59a:	b771                	j	526 <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 59c:	008b0913          	addi	s2,s6,8
 5a0:	4681                	li	a3,0
 5a2:	4629                	li	a2,10
 5a4:	000b2583          	lw	a1,0(s6)
 5a8:	8556                	mv	a0,s5
 5aa:	00000097          	auipc	ra,0x0
 5ae:	e72080e7          	jalr	-398(ra) # 41c <printint>
 5b2:	8b4a                	mv	s6,s2
      state = 0;
 5b4:	4981                	li	s3,0
 5b6:	bf85                	j	526 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 5b8:	008b0913          	addi	s2,s6,8
 5bc:	4681                	li	a3,0
 5be:	4641                	li	a2,16
 5c0:	000b2583          	lw	a1,0(s6)
 5c4:	8556                	mv	a0,s5
 5c6:	00000097          	auipc	ra,0x0
 5ca:	e56080e7          	jalr	-426(ra) # 41c <printint>
 5ce:	8b4a                	mv	s6,s2
      state = 0;
 5d0:	4981                	li	s3,0
 5d2:	bf91                	j	526 <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 5d4:	008b0793          	addi	a5,s6,8
 5d8:	f8f43423          	sd	a5,-120(s0)
 5dc:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 5e0:	03000593          	li	a1,48
 5e4:	8556                	mv	a0,s5
 5e6:	00000097          	auipc	ra,0x0
 5ea:	e14080e7          	jalr	-492(ra) # 3fa <putc>
  putc(fd, 'x');
 5ee:	85ea                	mv	a1,s10
 5f0:	8556                	mv	a0,s5
 5f2:	00000097          	auipc	ra,0x0
 5f6:	e08080e7          	jalr	-504(ra) # 3fa <putc>
 5fa:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 5fc:	03c9d793          	srli	a5,s3,0x3c
 600:	97de                	add	a5,a5,s7
 602:	0007c583          	lbu	a1,0(a5)
 606:	8556                	mv	a0,s5
 608:	00000097          	auipc	ra,0x0
 60c:	df2080e7          	jalr	-526(ra) # 3fa <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 610:	0992                	slli	s3,s3,0x4
 612:	397d                	addiw	s2,s2,-1
 614:	fe0914e3          	bnez	s2,5fc <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
 618:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 61c:	4981                	li	s3,0
 61e:	b721                	j	526 <vprintf+0x60>
        s = va_arg(ap, char*);
 620:	008b0993          	addi	s3,s6,8
 624:	000b3903          	ld	s2,0(s6)
        if(s == 0)
 628:	02090163          	beqz	s2,64a <vprintf+0x184>
        while(*s != 0){
 62c:	00094583          	lbu	a1,0(s2)
 630:	c9a1                	beqz	a1,680 <vprintf+0x1ba>
          putc(fd, *s);
 632:	8556                	mv	a0,s5
 634:	00000097          	auipc	ra,0x0
 638:	dc6080e7          	jalr	-570(ra) # 3fa <putc>
          s++;
 63c:	0905                	addi	s2,s2,1
        while(*s != 0){
 63e:	00094583          	lbu	a1,0(s2)
 642:	f9e5                	bnez	a1,632 <vprintf+0x16c>
        s = va_arg(ap, char*);
 644:	8b4e                	mv	s6,s3
      state = 0;
 646:	4981                	li	s3,0
 648:	bdf9                	j	526 <vprintf+0x60>
          s = "(null)";
 64a:	00000917          	auipc	s2,0x0
 64e:	22e90913          	addi	s2,s2,558 # 878 <malloc+0xe8>
        while(*s != 0){
 652:	02800593          	li	a1,40
 656:	bff1                	j	632 <vprintf+0x16c>
        putc(fd, va_arg(ap, uint));
 658:	008b0913          	addi	s2,s6,8
 65c:	000b4583          	lbu	a1,0(s6)
 660:	8556                	mv	a0,s5
 662:	00000097          	auipc	ra,0x0
 666:	d98080e7          	jalr	-616(ra) # 3fa <putc>
 66a:	8b4a                	mv	s6,s2
      state = 0;
 66c:	4981                	li	s3,0
 66e:	bd65                	j	526 <vprintf+0x60>
        putc(fd, c);
 670:	85d2                	mv	a1,s4
 672:	8556                	mv	a0,s5
 674:	00000097          	auipc	ra,0x0
 678:	d86080e7          	jalr	-634(ra) # 3fa <putc>
      state = 0;
 67c:	4981                	li	s3,0
 67e:	b565                	j	526 <vprintf+0x60>
        s = va_arg(ap, char*);
 680:	8b4e                	mv	s6,s3
      state = 0;
 682:	4981                	li	s3,0
 684:	b54d                	j	526 <vprintf+0x60>
    }
  }
}
 686:	70e6                	ld	ra,120(sp)
 688:	7446                	ld	s0,112(sp)
 68a:	74a6                	ld	s1,104(sp)
 68c:	7906                	ld	s2,96(sp)
 68e:	69e6                	ld	s3,88(sp)
 690:	6a46                	ld	s4,80(sp)
 692:	6aa6                	ld	s5,72(sp)
 694:	6b06                	ld	s6,64(sp)
 696:	7be2                	ld	s7,56(sp)
 698:	7c42                	ld	s8,48(sp)
 69a:	7ca2                	ld	s9,40(sp)
 69c:	7d02                	ld	s10,32(sp)
 69e:	6de2                	ld	s11,24(sp)
 6a0:	6109                	addi	sp,sp,128
 6a2:	8082                	ret

00000000000006a4 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 6a4:	715d                	addi	sp,sp,-80
 6a6:	ec06                	sd	ra,24(sp)
 6a8:	e822                	sd	s0,16(sp)
 6aa:	1000                	addi	s0,sp,32
 6ac:	e010                	sd	a2,0(s0)
 6ae:	e414                	sd	a3,8(s0)
 6b0:	e818                	sd	a4,16(s0)
 6b2:	ec1c                	sd	a5,24(s0)
 6b4:	03043023          	sd	a6,32(s0)
 6b8:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 6bc:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 6c0:	8622                	mv	a2,s0
 6c2:	00000097          	auipc	ra,0x0
 6c6:	e04080e7          	jalr	-508(ra) # 4c6 <vprintf>
}
 6ca:	60e2                	ld	ra,24(sp)
 6cc:	6442                	ld	s0,16(sp)
 6ce:	6161                	addi	sp,sp,80
 6d0:	8082                	ret

00000000000006d2 <printf>:

void
printf(const char *fmt, ...)
{
 6d2:	711d                	addi	sp,sp,-96
 6d4:	ec06                	sd	ra,24(sp)
 6d6:	e822                	sd	s0,16(sp)
 6d8:	1000                	addi	s0,sp,32
 6da:	e40c                	sd	a1,8(s0)
 6dc:	e810                	sd	a2,16(s0)
 6de:	ec14                	sd	a3,24(s0)
 6e0:	f018                	sd	a4,32(s0)
 6e2:	f41c                	sd	a5,40(s0)
 6e4:	03043823          	sd	a6,48(s0)
 6e8:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 6ec:	00840613          	addi	a2,s0,8
 6f0:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 6f4:	85aa                	mv	a1,a0
 6f6:	4505                	li	a0,1
 6f8:	00000097          	auipc	ra,0x0
 6fc:	dce080e7          	jalr	-562(ra) # 4c6 <vprintf>
}
 700:	60e2                	ld	ra,24(sp)
 702:	6442                	ld	s0,16(sp)
 704:	6125                	addi	sp,sp,96
 706:	8082                	ret

0000000000000708 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 708:	1141                	addi	sp,sp,-16
 70a:	e422                	sd	s0,8(sp)
 70c:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 70e:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 712:	00000797          	auipc	a5,0x0
 716:	1867b783          	ld	a5,390(a5) # 898 <freep>
 71a:	a805                	j	74a <free+0x42>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 71c:	4618                	lw	a4,8(a2)
 71e:	9db9                	addw	a1,a1,a4
 720:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 724:	6398                	ld	a4,0(a5)
 726:	6318                	ld	a4,0(a4)
 728:	fee53823          	sd	a4,-16(a0)
 72c:	a091                	j	770 <free+0x68>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 72e:	ff852703          	lw	a4,-8(a0)
 732:	9e39                	addw	a2,a2,a4
 734:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
 736:	ff053703          	ld	a4,-16(a0)
 73a:	e398                	sd	a4,0(a5)
 73c:	a099                	j	782 <free+0x7a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 73e:	6398                	ld	a4,0(a5)
 740:	00e7e463          	bltu	a5,a4,748 <free+0x40>
 744:	00e6ea63          	bltu	a3,a4,758 <free+0x50>
{
 748:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 74a:	fed7fae3          	bgeu	a5,a3,73e <free+0x36>
 74e:	6398                	ld	a4,0(a5)
 750:	00e6e463          	bltu	a3,a4,758 <free+0x50>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 754:	fee7eae3          	bltu	a5,a4,748 <free+0x40>
  if(bp + bp->s.size == p->s.ptr){
 758:	ff852583          	lw	a1,-8(a0)
 75c:	6390                	ld	a2,0(a5)
 75e:	02059713          	slli	a4,a1,0x20
 762:	9301                	srli	a4,a4,0x20
 764:	0712                	slli	a4,a4,0x4
 766:	9736                	add	a4,a4,a3
 768:	fae60ae3          	beq	a2,a4,71c <free+0x14>
    bp->s.ptr = p->s.ptr;
 76c:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 770:	4790                	lw	a2,8(a5)
 772:	02061713          	slli	a4,a2,0x20
 776:	9301                	srli	a4,a4,0x20
 778:	0712                	slli	a4,a4,0x4
 77a:	973e                	add	a4,a4,a5
 77c:	fae689e3          	beq	a3,a4,72e <free+0x26>
  } else
    p->s.ptr = bp;
 780:	e394                	sd	a3,0(a5)
  freep = p;
 782:	00000717          	auipc	a4,0x0
 786:	10f73b23          	sd	a5,278(a4) # 898 <freep>
}
 78a:	6422                	ld	s0,8(sp)
 78c:	0141                	addi	sp,sp,16
 78e:	8082                	ret

0000000000000790 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 790:	7139                	addi	sp,sp,-64
 792:	fc06                	sd	ra,56(sp)
 794:	f822                	sd	s0,48(sp)
 796:	f426                	sd	s1,40(sp)
 798:	f04a                	sd	s2,32(sp)
 79a:	ec4e                	sd	s3,24(sp)
 79c:	e852                	sd	s4,16(sp)
 79e:	e456                	sd	s5,8(sp)
 7a0:	e05a                	sd	s6,0(sp)
 7a2:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 7a4:	02051493          	slli	s1,a0,0x20
 7a8:	9081                	srli	s1,s1,0x20
 7aa:	04bd                	addi	s1,s1,15
 7ac:	8091                	srli	s1,s1,0x4
 7ae:	0014899b          	addiw	s3,s1,1
 7b2:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 7b4:	00000517          	auipc	a0,0x0
 7b8:	0e453503          	ld	a0,228(a0) # 898 <freep>
 7bc:	c515                	beqz	a0,7e8 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7be:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 7c0:	4798                	lw	a4,8(a5)
 7c2:	02977f63          	bgeu	a4,s1,800 <malloc+0x70>
 7c6:	8a4e                	mv	s4,s3
 7c8:	0009871b          	sext.w	a4,s3
 7cc:	6685                	lui	a3,0x1
 7ce:	00d77363          	bgeu	a4,a3,7d4 <malloc+0x44>
 7d2:	6a05                	lui	s4,0x1
 7d4:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 7d8:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 7dc:	00000917          	auipc	s2,0x0
 7e0:	0bc90913          	addi	s2,s2,188 # 898 <freep>
  if(p == (char*)-1)
 7e4:	5afd                	li	s5,-1
 7e6:	a88d                	j	858 <malloc+0xc8>
    base.s.ptr = freep = prevp = &base;
 7e8:	00000797          	auipc	a5,0x0
 7ec:	0b878793          	addi	a5,a5,184 # 8a0 <base>
 7f0:	00000717          	auipc	a4,0x0
 7f4:	0af73423          	sd	a5,168(a4) # 898 <freep>
 7f8:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 7fa:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 7fe:	b7e1                	j	7c6 <malloc+0x36>
      if(p->s.size == nunits)
 800:	02e48b63          	beq	s1,a4,836 <malloc+0xa6>
        p->s.size -= nunits;
 804:	4137073b          	subw	a4,a4,s3
 808:	c798                	sw	a4,8(a5)
        p += p->s.size;
 80a:	1702                	slli	a4,a4,0x20
 80c:	9301                	srli	a4,a4,0x20
 80e:	0712                	slli	a4,a4,0x4
 810:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 812:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 816:	00000717          	auipc	a4,0x0
 81a:	08a73123          	sd	a0,130(a4) # 898 <freep>
      return (void*)(p + 1);
 81e:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 822:	70e2                	ld	ra,56(sp)
 824:	7442                	ld	s0,48(sp)
 826:	74a2                	ld	s1,40(sp)
 828:	7902                	ld	s2,32(sp)
 82a:	69e2                	ld	s3,24(sp)
 82c:	6a42                	ld	s4,16(sp)
 82e:	6aa2                	ld	s5,8(sp)
 830:	6b02                	ld	s6,0(sp)
 832:	6121                	addi	sp,sp,64
 834:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 836:	6398                	ld	a4,0(a5)
 838:	e118                	sd	a4,0(a0)
 83a:	bff1                	j	816 <malloc+0x86>
  hp->s.size = nu;
 83c:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 840:	0541                	addi	a0,a0,16
 842:	00000097          	auipc	ra,0x0
 846:	ec6080e7          	jalr	-314(ra) # 708 <free>
  return freep;
 84a:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 84e:	d971                	beqz	a0,822 <malloc+0x92>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 850:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 852:	4798                	lw	a4,8(a5)
 854:	fa9776e3          	bgeu	a4,s1,800 <malloc+0x70>
    if(p == freep)
 858:	00093703          	ld	a4,0(s2)
 85c:	853e                	mv	a0,a5
 85e:	fef719e3          	bne	a4,a5,850 <malloc+0xc0>
  p = sbrk(nu * sizeof(Header));
 862:	8552                	mv	a0,s4
 864:	00000097          	auipc	ra,0x0
 868:	b7e080e7          	jalr	-1154(ra) # 3e2 <sbrk>
  if(p == (char*)-1)
 86c:	fd5518e3          	bne	a0,s5,83c <malloc+0xac>
        return 0;
 870:	4501                	li	a0,0
 872:	bf45                	j	822 <malloc+0x92>
