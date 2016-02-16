From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] ARM: omapfb: Add early framebuffer memory allocator
Date: Tue, 16 Feb 2016 15:51:34 +0200
Message-ID: <56C32966.9020105@ti.com>
References: <52A062A0.3070005@ti.com>
 <1388013159-3036-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
 <201601011301.27415@pali> <568A5970.2000201@ti.com>
 <568A6DD1.5050700@gmail.com> <5693F5B7.8040608@ti.com>
 <56BEDA57.4030300@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Kw5o9xVV9Jx0IOUFmFsm5Ars8BiXmuuJE"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <56BEDA57.4030300@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali.rohar@gmail.com>
Cc: tony@atomide.com, linux@arm.linux.org.uk, pavel@ucw.cz, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Ivaylo Dimitrov <freemangordon@abv.bg>
List-Id: linux-omap@vger.kernel.org

--Kw5o9xVV9Jx0IOUFmFsm5Ars8BiXmuuJE
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 13/02/16 09:25, Ivaylo Dimitrov wrote:
> Hi Tomi,
>=20
> On 11.01.2016 20:34, Tomi Valkeinen wrote:
>>
>> So, I'm not very enthusiastic about adding this feature as an omapfb
>> specific boot parameter.
>>
>=20
> What about something like (not properly formatted, just want your
> opinion on the idea):
>=20
> diff --git a/arch/arm/mach-omap2/fb.c b/arch/arm/mach-omap2/fb.c
> index 1f1ecf8..0d109d8 100644
> --- a/arch/arm/mach-omap2/fb.c
> +++ b/arch/arm/mach-omap2/fb.c
> @@ -28,6 +28,7 @@
>  #include <linux/io.h>
>  #include <linux/omapfb.h>
>  #include <linux/dma-mapping.h>
> +#include <linux/of_reserved_mem.h>
>=20
>  #include <asm/mach/map.h>
>=20
> @@ -110,6 +111,49 @@ int __init omap_init_fb(void)
>  {
>         return platform_device_register(&omap_fb_device);
>  }
> +
> +static int rmem_omapfb_device_init(struct reserved_mem *rmem, struct
> device *dev)
> +{
> +       int dma;
> +
> +       if (rmem->priv)
> +               return 0;
> +
> +       dma =3D dma_declare_coherent_memory(&omap_fb_device.dev, rmem->=
base,
> +                                         rmem->base, rmem->size,
> +                                         DMA_MEMORY_MAP |
> +                                         DMA_MEMORY_EXCLUSIVE);
> +
> +       if (!(dma & DMA_MEMORY_MAP)) {
> +               pr_err("omapfb: dma_declare_coherent_memory failed\n");=

> +               return -ENOMEM;
> +       }
> +       else
> +               rmem->priv =3D omap_fb_device.dev.dma_mem;
> +
> +       return 0;
> +}
> +
> +static void rmem_omapfb_device_release(struct reserved_mem *rmem,
> +                                      struct device *dev)
> +{
> +       dma_release_declared_memory(&omap_fb_device.dev);
> +}
> +
> +static const struct reserved_mem_ops rmem_omapfb_ops =3D {
> +       .device_init    =3D rmem_omapfb_device_init,
> +       .device_release =3D rmem_omapfb_device_release,
> +};
> +
> +static int __init rmem_omapfb_setup(struct reserved_mem *rmem)
> +{
> +       rmem->ops =3D &rmem_omapfb_ops;
> +       pr_info("omapfb: reserved %d bytes at %pa\n", rmem->size,
> &rmem->base);
> +
> +       return 0;
> +}
> +
> +RESERVEDMEM_OF_DECLARE(dss, "ti,omapfb-memsize", rmem_omapfb_setup);
>  #else
>  int __init omap_init_fb(void) { return 0; }
>  #endif
>=20
> diff --git a/arch/arm/mach-omap2/display.c b/arch/arm/mach-omap2/displa=
y.c
> index 6ab13d1..6f0ba03 100644
> --- a/arch/arm/mach-omap2/display.c
> +++ b/arch/arm/mach-omap2/display.c
> @@ -28,6 +28,7 @@
>  #include <linux/slab.h>
>  #include <linux/mfd/syscon.h>
>  #include <linux/regmap.h>
> +#include <linux/of_reserved_mem.h>
>=20
>  #include <video/omapdss.h>
>  #include "omap_hwmod.h"
> @@ -640,6 +641,7 @@ int __init omapdss_init_of(void)
>         omap_display_device.dev.platform_data =3D &board_data;
>=20
>         r =3D platform_device_register(&omap_display_device);
> +
>         if (r < 0) {
>                 pr_err("Unable to register omapdss device\n");
>                 return r;
> @@ -666,6 +668,9 @@ int __init omapdss_init_of(void)
>                 return r;
>         }
>=20
> +       /* Init fb reserved memory, there may be none so ignore the
> result */
> +       of_reserved_mem_device_init(&pdev->dev);
> +

Does it work for you? I haven't used DT reserved-memory, do you have an
example .dts change?

Now, having to support DT bindings is not any better than supporting
cmdline options. But with a quick read of reserved-memory.txt I like the
idea. However we should have "reserved memory for display", not for
omapfb, so that the same reserved area could be used by omapdrm too.

Another thing, with v4.5, omapfb has moved into maintenance mode. I
don't want to merge new features there. Are you planning to move to
omapdrm, and if not, why? I'd rather see all this done for omapdrm only.

 Tomi


--Kw5o9xVV9Jx0IOUFmFsm5Ars8BiXmuuJE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWwylmAAoJEPo9qoy8lh715BcP/2YLrQlZt3lFYpF5guRaFp2M
YWWm+FyKkrYysVbn/taFfYlPdhtm3ORK2Lv8dhQK2s6F758+TJ1nZNdgaup6igo5
Yx5otmajAtq6imT9GWpc+YuO66oa+FVWajBClqFlK2U9VXxI1jGd25FjxMO1LNP4
hzgB30xTFGIPd99I8PLe39IuD6NvVwJkzUiKvY7sv3GAXC6FMacHy65W9ukWBSmh
myw/KFB1tzqJc47b/VJ6amUm+4TMNltlRJcS3NA8t4k7E/DgSvHHBNDgdRdD2Xaa
0vUeJcfg2md16nzree8fwGA+7I69fOoUZ9CAlnfgBrZg8NthcBThq6rGgzJco7eX
QnVDI0nbhc2EfEomym6YzqW1oqNfF6pbMzswg++nXbomcH7cAEYvCIx58y/1203G
mk6XQLbUnJwrhgx4Kjady3c5Xn3qQhMPtOwCl6eaTm5kbfEMOMOxC5SmN3uo+Pr0
TuRFptYhHneBfYBXNo45lLw/FXUCLx+f+ETIekhr/kUIKRPux8NE+C4G83FYR8JS
d98AAVpsK92+z3nEk1J4O0s3g1K0iIsrLPtg2qG5exOZtDvzgyupjshFN0zdxX8B
phxK0opqaSmRA89lIDFy3vGE9ByCisBfTpvAk78PDflpgiZKpFn4FT9qpRfWNRKQ
Mi4P0rwdoDvN/AgtVLl7
=fvA3
-----END PGP SIGNATURE-----

--Kw5o9xVV9Jx0IOUFmFsm5Ars8BiXmuuJE--
