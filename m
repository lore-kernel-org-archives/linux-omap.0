From: "=?ISO-8859-1?Q?Lu=EDs_Vit=F3rio_Cargnini?=" <lvcargnini@ieee.org>
Subject: dsp gateway usage help need
Date: Tue, 17 Oct 2006 17:23:35 -0200
Message-ID: <ae36f8040610171223n3f2f7240w325ef47939879c62@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: OMAP <Linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Hi,
I trying to make an example work sing dsp gateway I'm basing on test2
example, I'm trying pass 3.14 as char vector
it is ok and dsp return it as char, but when i try to catch this on dsp
modify the values an then repass to arm  strange errors happens,  any help
is welcome, follow my code:
DSP:
/*
 * Copyright (c) 2002-2006, Nokia Corporation. All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are
met:
 *
 * Redistributions of source code must retain the above copyright notice,
this
 * list of conditions and the following disclaimer.
 *
 * Redistributions in binary form must reproduce the above copyright notice=
,

 * this list of conditions and the following disclaimer in the documentatio=
n

 * and/or other materials provided with the distribution.
 *
 * Neither the name of Nokia nor the names of its contributors may be used
to
 * endorse or promote products derived from this software without specific
 * prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
IS"
 * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, TH=
E

 * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
PURPOSE
 * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
 * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
 * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
 * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
 * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
 * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
 * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF
THE
 * POSSIBILITY OF SUCH DAMAGE.
 *
 * Toshihiro Kobayashi <toshihiro.kobayashi@nokia.com>
 * 2004/07/15:  DSP Gateway version 3.3
 */

#include <std.h>
#include <sys.h>
#include <mem.h>
#include <sem.h>
#include <tsk.h>
#include <stdlib.h>
#include "tokliBIOS.h"

double x;
char transfer[128];

static Int strcpy16to8(Char *d, Char *s)
{
    Int cnt =3D 0;

    for (; *s; s++, d++) {
        *d =3D *s;
        *d |=3D *++s << 8;
        cnt++;
        if (!*s)
            return cnt;
    }
    *d =3D '\0';
    return cnt;
}

static Uns t2_rcv_bksnd(struct dsptask *task, Uns bid, Uns cnt)
{
    memcpy(task->udata, ipbuf_d[bid], cnt);
    unuse_ipbuf(task, bid);

    return 0;
}

static Uns t2_rcv_bkreq(struct dsptask *task, Uns cnt)
{
    Uns bid;
    int icnt;

    bid =3D get_free_ipbuf(task);
    if (bid =3D=3D MBCMD_BID_NULL)
        return MBCMD_EID_STVBUF;

    x=3Dstrtod(task->udata,0);
    x++;
    sprintf(transfer,"%g",x);
    icnt =3D strcpy16to8((Char *)ipbuf_d[bid],"Hello DSP");
    dbg(task, " t2_rcv_bkreq() transfer =3D %s %d %d\n","Hello DSP", cnt,
icnt);


    //memcpy(ipbuf_d[bid], "Hello DSP", icnt);
    bksnd(task, bid, icnt);

    return 0;
}

static Uns bkdata[128];

#pragma DATA_SECTION(task_test2, "dspgw_task")
struct dsptask task_test2 =3D {
    TID_MAGIC,    /* tid */
    "test2",    /* name */
    MBCMD_TTYP_GBDM | MBCMD_TTYP_GBMD |
    MBCMD_TTYP_BKDM | MBCMD_TTYP_BKMD |
    MBCMD_TTYP_PSND | MBCMD_TTYP_PRCV,
            /* ttyp: passive block snd, passive block rcv */
    t2_rcv_bksnd,    /* rcv_snd */
    t2_rcv_bkreq,    /* rcv_req */
    NULL,        /* rcv_tctl */
    NULL,        /* tsk_attrs */
    NULL,        /* mmap_info */
    bkdata        /* udata */
};


ARM:
/*
 * This file is part of DSP Gateway version 3.3.1
 *
 * Copyright (C) 2002-2006 Nokia Corporation. All rights reserved.
 *
 * Contact: Toshihiro Kobayashi < toshihiro.kobayashi@nokia.com>
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * version 2 as published by the Free Software Foundation.
 *
 * This program is distributed in the hope that it will be useful, but
 * WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
 * 02110-1301 USA
 *
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <fcntl.h>

#define BUFSZ    256

void t1(int fd);
void t2(int fd);
void t3(int fd);

void usage(char *cmd)
{
    fprintf(stderr, "%s\n", cmd);
}

char *data01 =3D "VITORIO_";
char *data02 =3D "DIOGO_";
char *data03 =3D " 3.14";
char *data04 =3D "3.64";
char *data05 =3D "-0.324";

int main(int argc, char **argv)
{
    char *devfn =3D "/dev/dsptask/test2";
    int fd;
    int i;

    fd =3D open(devfn, O_RDWR);
    if (fd < 0) {
        fprintf(stderr, "cannot open %s\n", devfn);
        return 1;
    }

    t1(fd);
    t2(fd);
    t3(fd);

    for (i =3D 0; i < 20; i++) {
        t1(fd);
        usleep(1000);
        t2(fd);
        usleep(1000);
        t3(fd);
        usleep(1000);
    }

    close(fd);

    return 0;
}

void t1(int fd)
{
    int len;
    int cnt;
    char buf[BUFSZ];

    printf("test1: write and read\n");

    len =3D strlen(data03);
    cnt =3D write(fd, data03, len);
    printf("written \"%s\", %d bytes\n", data03, cnt);
    cnt =3D read(fd, buf, len*2);
    buf[cnt] =3D '\0';
    printf("read    \"%s\", %d bytes\n", buf, cnt);

    len =3D strlen(data04);
    cnt =3D write(fd, data04, len*2);
    printf("written \"%s\", %d bytes\n", data04, cnt);
    cnt =3D read(fd, buf, len*2);
    buf[cnt] =3D '\0';
    printf("read    \"%s\", %d bytes\n", buf, cnt);

    putchar('\n');
}

void t2(int fd)
{
    int cnt;

    printf("test2: write flood\n");

    //cnt =3D write(fd, data01, strlen(data01));
    //printf("written \"%s\", %d bytes\n", data01, cnt);
    //cnt =3D write(fd, data02, strlen(data02));
    //printf("written \"%s\", %d bytes\n", data02, cnt);
    cnt =3D write(fd, data03, strlen(data03));
    printf("written \"%s\", %d bytes\n", data03, cnt);
    cnt =3D write(fd, data04, strlen(data04));
    printf("written \"%s\", %d bytes\n", data04, cnt);
    cnt =3D write(fd, data05, strlen(data05));
    printf("written \"%s\", %d bytes\n", data05, cnt);

    putchar('\n');
}

void t3(int fd)
{
    int len;
    int cnt;
    char buf[BUFSZ];

    printf("test3: read flood\n");

    len =3D strlen(data03);
    cnt =3D write(fd, data03, len);
    printf("written \"%s\", %d bytes\n", data03, cnt);
    cnt =3D read(fd, buf, len*2);
    buf[cnt] =3D '\0';
    printf("read    \"%s\", %d bytes\n", buf, cnt);
    cnt =3D read(fd, buf, len*2);
    buf[cnt] =3D '\0';
    printf("read    \"%s\", %d bytes\n", buf, cnt);
    cnt =3D read(fd, buf, len*2);
    buf[cnt] =3D '\0';
    printf("read    \"%s\", %d bytes\n", buf, cnt);
    cnt =3D read(fd, buf, len*2);
    buf[cnt] =3D '\0';
    printf("read    \"%s\", %d bytes\n", buf, cnt);
    cnt =3D read(fd, buf, len*2);
    buf[cnt] =3D '\0';
    printf("read    \"%s\", %d bytes\n", buf, cnt);

    putchar('\n');
}



--=20
Thanks && Regards
Msc. Bsc. Lu=EDs Vit=F3rio Cargnini
IEEE Member
Mastering Degree student @ PUC-RS Electrical Engineer Faculty
