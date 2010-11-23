From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] ARM: io: Fix namespace conflicts.
Date: Tue, 23 Nov 2010 15:01:17 +0100
Message-ID: <20101123140116.GP4693@pengutronix.de>
References: <1286967121-5888-1-git-send-email-charu@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:49328 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751061Ab0KWOBT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 23 Nov 2010 09:01:19 -0500
Content-Disposition: inline
In-Reply-To: <1286967121-5888-1-git-send-email-charu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Varadarajan, Charulatha" <charu@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, Sourav Poddar <sourav.poddar@ti.com>, linux@arm.linux.org.uk

Hello,

On Wed, Oct 13, 2010 at 04:22:01PM +0530, Varadarajan, Charulatha wrote=
:
> From: Sourav Poddar <sourav.poddar@ti.com>
>=20
> Having __v as the variable name for the definition of different macro=
s leads to
> the namespace pollution. For example,
> readl(p)
> unrolls to:
> ({ u32 __v =3D ({ u32 __v =3D (( __u32)(__le32)(( __le32) ((void)0,
> *(volatile unsigned int *)((p))))); __v; }); __asm__ __volatile__ ("m=
cr
> p15,
> , %0, c7, c10, 5" : : "r" (0) : "memory"); __v; });
>=20
> ({ u32 __v =3D ({ u32 __v
> causes sparse warning: "warning: symbol '__v' shadows an earlier one"
>=20
> Using variable names which use the function name prefix across the
> various macros avoids the namespace pollution.
>=20
> With this change, ~200 sparse warnings in omap2plus_defconfig build a=
re
> fixed.
>=20
> Signed-off-by: Sourav Poddar <sourav.poddar@ti.com>
> Signed-off-by: Charulatha V <charu@ti.com>
> Reviewed by: Nishanth Menon <nm@ti.com>
> ---
>  Links related to the previous discussions are as follows:
> =20
>  http://www.spinics.net/lists/linux-omap/msg38569.html
>  http://marc.info/?t=3D128506336700011&r=3D1&w=3D2
>=20
>  arch/arm/include/asm/io.h |   32 +++++++++++++++++++++-----------
>  1 files changed, 21 insertions(+), 11 deletions(-)
>=20
> diff --git a/arch/arm/include/asm/io.h b/arch/arm/include/asm/io.h
> index 1261b1f..01e4a7b 100644
> --- a/arch/arm/include/asm/io.h
> +++ b/arch/arm/include/asm/io.h
> @@ -131,11 +131,11 @@ static inline void __iomem *__typesafe_io(unsig=
ned long addr)
>  #define outl(v,p)		__raw_writel((__force __u32) \
>  					cpu_to_le32(v),__io(p))
> =20
> -#define inb(p)	({ __u8 __v =3D __raw_readb(__io(p)); __v; })
> -#define inw(p)	({ __u16 __v =3D le16_to_cpu((__force __le16) \
> -			__raw_readw(__io(p))); __v; })
> -#define inl(p)	({ __u32 __v =3D le32_to_cpu((__force __le32) \
> -			__raw_readl(__io(p))); __v; })
> +#define inb(p)	({ __u8 __inbv =3D __raw_readb(__io(p)); __inbv; })
> +#define inw(p)	({ __u16 __inwv =3D le16_to_cpu((__force __le16) \
> +			__raw_readw(__io(p))); __inwv; })
> +#define inl(p)	({ __u32 __inlv =3D le32_to_cpu((__force __le32) \
> +			__raw_readl(__io(p))); __inlv; })
I wonder if it's not better to make these static inlines instead.  Then
no naming conflicts can occur.  And maybe we'd catch some more strange
things because p gets a proper type.

I don't know how this influences gcc though.

Ah, and maybe some more tricks need to be applied, because at least som=
e
macros can be overwritten per architecture.

Just my 0.02=E2=82=AC
Uwe

> =20
>  #define outsb(p,d,l)		__raw_writesb(__io(p),d,l)
>  #define outsw(p,d,l)		__raw_writesw(__io(p),d,l)
> @@ -200,9 +200,12 @@ extern void _memset_io(volatile void __iomem *, =
int, size_t);
>  #define __iowmb()		do { } while (0)
>  #endif
> =20
> -#define readb(c)		({ u8  __v =3D readb_relaxed(c); __iormb(); __v; }=
)
> -#define readw(c)		({ u16 __v =3D readw_relaxed(c); __iormb(); __v; }=
)
> -#define readl(c)		({ u32 __v =3D readl_relaxed(c); __iormb(); __v; }=
)
> +#define readb(c)		({ u8  __readbv =3D readb_relaxed(c); \
> +					 __iormb(); __readbv; })
> +#define readw(c)		({ u16 __readwv =3D readw_relaxed(c); \
> +					 __iormb(); __readwv; })
> +#define readl(c)		({ u32 __readlv =3D readl_relaxed(c);\
> +					 __iormb(); __readlv; })
> =20
>  #define writeb(v,c)		({ __iowmb(); writeb_relaxed(v,c); })
>  #define writew(v,c)		({ __iowmb(); writew_relaxed(v,c); })
> @@ -258,9 +261,16 @@ extern void _memset_io(volatile void __iomem *, =
int, size_t);
>   * io{read,write}{8,16,32} macros
>   */
>  #ifndef ioread8
> -#define ioread8(p)	({ unsigned int __v =3D __raw_readb(p); __iormb()=
; __v; })
> -#define ioread16(p)	({ unsigned int __v =3D le16_to_cpu((__force __l=
e16)__raw_readw(p)); __iormb(); __v; })
> -#define ioread32(p)	({ unsigned int __v =3D le32_to_cpu((__force __l=
e32)__raw_readl(p)); __iormb(); __v; })
> +#define ioread8(p)	({ unsigned int __ioread8v =3D __raw_readb(p); \
> +					 __iormb(); __ioread8v; })
> +#define ioread16(p)	({ unsigned int __ioread16v =3D \
> +					 le16_to_cpu((__force __le16) \
> +					__raw_readw(p)); __iormb(); \
> +					 __ioread16v; })
> +#define ioread32(p)	({ unsigned int __ioread32v =3D \
> +					 le32_to_cpu((__force __le32) \
> +					__raw_readl(p)); __iormb(); \
> +					 __ioread32v; })
> =20
>  #define iowrite8(v,p)	({ __iowmb(); (void)__raw_writeb(v, p); })
>  #define iowrite16(v,p)	({ __iowmb(); (void)__raw_writew((__force __u=
16)cpu_to_le16(v), p); })
> --=20
> 1.7.0.4
>=20
>=20
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>=20

--=20
Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig     =
       |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
