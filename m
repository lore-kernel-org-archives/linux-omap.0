From: Dirk Behme <dirk.behme@googlemail.com>
Subject: Re: OMAP: small patch fixes "fs/jffs2/malloc.c:126: error:
 dereferencing pointer to incomplete type"
Date: Thu, 28 Dec 2006 12:46:52 +0100
Message-ID: <4593AEAC.4080207@gmail.com>
References: <25c21ceb0612271239v5c245656ha1c467e04338aea9@mail.gmail.com>	
	<459368AC.4080902@gmail.com>
	<25c21ceb0612280333h55488c55le0523c31c204e206@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <25c21ceb0612280333h55488c55le0523c31c204e206@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: =?UTF-8?B?wq5hZ25lcg==?= <ragner.magalhaes@gmail.com>
Cc: OMAP-Linux <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

=C2=AEagner wrote:
> The additional linux/sched.h fixes the  wrong caused by=20
> dbg_memalloc("%p\n", ret); in
> line 126,defined in  fs/jffs2/debug.h line 168 , that is an
> JFFS2_DEBUG(fmt, ##__VA_ARGS__),defined in  fs/jffs2/debug.h line 101.
>=20
> #define JFFS2_DEBUG(fmt, ...)                        \
>     do {                                \
>         printk(JFFS2_DBG_MSG_PREFIX                \
>             " (%d) %s: " fmt, current->pid,            \
>             __FUNCTION__ , ##__VA_ARGS__);            \
>  } while(0)
>=20
> the variable "current" is defined in linux/sched.h, the message "error:=
=20
> dereferencing pointer to incomplete type"
> is caused  because this.

For me it compiles without any issues. I wonder if the error=20
happens only with some debugging enabled?

Anyway, I think fixes in fs/jffs2/malloc.c should go to=20
JFFS2 maintainers.

Dirk

> On 12/28/06, *Dirk Behme* <dirk.behme@googlemail.com=20
> <mailto:dirk.behme@googlemail.com> > wrote:
>=20
>     Ragner N Magalh=C3=A3es wrote:
>      > Hi all,
>      > this is other small patch that fixes this error below
>      >
>      > fs/jffs2/malloc.c: In function 'jffs2_alloc_full_dirent':
>      > fs/jffs2/malloc.c:126: error: dereferencing pointer to incomplet=
e
>     type
>=20
>     Hmh. For me it looks like using recent git on OSK
>     fs/jffs2/malloc.c compiles without any issues.
>=20
>     For me, jffs2_alloc_full_dirent() is:
>=20
>     struct jffs2_full_dirent *jffs2_alloc_full_dirent(int namesize)
>     {
>             struct jffs2_full_dirent *ret;
>             ret =3D kmalloc(sizeof(struct jffs2_full_dirent) + namesize=
,
>     GFP_KERNEL);
>     126: dbg_memalloc("%p\n", ret);
>             return ret;
>     }
>=20
>     with line 126 being dbg_memalloc("%p\n", ret). What's wrong
>     here that should be fixed by additional linux/sched.h?
>=20
>     Dirk
>=20
>=20
>=20
>=20
> --=20
> Ragner N Magalh=C3=A3es
> Instituto Nokia de Tecnologia (INdT) - OSMRC
> E-mail: ragner.magalhaes@indt.org.br <mailto:ragner.magalhaes@indt.org.=
br>
