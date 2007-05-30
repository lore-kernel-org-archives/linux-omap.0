From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: [PATCH/RFC] Reduce OMAP2420 active current by ~30%
Date: Tue, 29 May 2007 22:51:01 -0500
Message-ID: <3B6D69C3A9EBCA4BA5DA60D91302742901158C9E@dlee13.ent.ti.com>
References: <3B6D69C3A9EBCA4BA5DA60D91302742901158C39@dlee13.ent.ti.com>
	<Pine.LNX.4.64.0705292005550.19832@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <Pine.LNX.4.64.0705292005550.19832@utopia.booyaka.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Paul Walmsley <paul@booyaka.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi Paul,

> took a quick look at the patch - is there any reason why this stuff
can't
> use the new PRCM register and bit definitions?  That way you could
drop
> stuff like this:

There is no reason it can't use it. I wrote this up in an hour to see
what the difference would be.

> +#define CM_FCLKEN1_CORE                __REG32(0x48008200)
> +#define CM_FCLKEN2_CORE                __REG32(0x48008204)
> +#define CM_FCLKEN_WKUP         __REG32(0x48008400)
> +#define CM_ICLKEN1_CORE                __REG32(0x48008210)
> +#define CM_ICLKEN2_CORE                __REG32(0x48008214)
> +#define CM_ICLKEN4_CORE                __REG32(0x4800821c)
> +#define CM_ICLKEN_WKUP         __REG32(0x48008410)
>=20
> and make code like this a little more self-documenting:
>=20
> +       CM_FCLKEN1_CORE =3D 0xbfffffff;
> +       CM_FCLKEN2_CORE =3D 0x00000006;
> +       CM_FCLKEN_WKUP =3D 0x5;
> +       CM_ICLKEN1_CORE =3D 0xcffffff9;
> +       CM_ICLKEN2_CORE =3D 0x00000006;

Yes it could be.  Basically I did it as quickly as possible.

The bits above represent valid OMAP2420 bit positions, minus watchdog
bits.

Cleaning it to be OMAP243x and OMAP242x is a next step in making it
better.  It could be reorganized any number of ways.

Generally, the results were good enough that I thought I'd send a patch
out to allow anyone to test with.

Regards,
Richard W.
