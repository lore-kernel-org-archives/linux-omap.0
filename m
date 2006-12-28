From: Dirk Behme <dirk.behme@googlemail.com>
Subject: Re: OMAP: small patch fixes "fs/jffs2/malloc.c:126: error:
 dereferencing pointer to incomplete type"
Date: Thu, 28 Dec 2006 07:48:12 +0100
Message-ID: <459368AC.4080902@gmail.com>
References: <25c21ceb0612271239v5c245656ha1c467e04338aea9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <25c21ceb0612271239v5c245656ha1c467e04338aea9@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: =?ISO-8859-1?Q?Ragner_N_Magalh=E3es?= <ragner@users.sourceforge.net>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Ragner N Magalh=E3es wrote:
> Hi all,
> this is other small patch that fixes this error below
>=20
> fs/jffs2/malloc.c: In function 'jffs2_alloc_full_dirent':
> fs/jffs2/malloc.c:126: error: dereferencing pointer to incomplete type

Hmh. For me it looks like using recent git on OSK=20
fs/jffs2/malloc.c compiles without any issues.

For me, jffs2_alloc_full_dirent() is:

struct jffs2_full_dirent *jffs2_alloc_full_dirent(int namesize)
{
	struct jffs2_full_dirent *ret;
	ret =3D kmalloc(sizeof(struct jffs2_full_dirent) + namesize,=20
GFP_KERNEL);
126: dbg_memalloc("%p\n", ret);
	return ret;
}

with line 126 being dbg_memalloc("%p\n", ret). What's wrong=20
here that should be fixed by additional linux/sched.h?

Dirk
