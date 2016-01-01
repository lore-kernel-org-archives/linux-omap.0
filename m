From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: [PATCH] ARM: omapfb: Add early framebuffer memory allocator
Date: Fri, 1 Jan 2016 13:01:27 +0100
Message-ID: <201601011301.27415@pali>
References: <52A062A0.3070005@ti.com> <1388013159-3036-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1609143.9HvMzFJ6Dh";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1388013159-3036-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, tony@atomide.com, linux@arm.linux.org.uk, pavel@ucw.cz, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Ivaylo Dimitrov <freemangordon@abv.bg>
List-Id: linux-omap@vger.kernel.org

--nextPart1609143.9HvMzFJ6Dh
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Tomi! Can you review this patch? It is waiting here for two years!

On Thursday 26 December 2013 00:12:39 Ivaylo Dimitrov wrote:
> From: Ivaylo Dimitrov <freemangordon@abv.bg>
>=20
> On memory limited devices, CMA fails easily when asked to allocate
> big chunks of memory like framebuffer memory needed for video
> playback.
>=20
> Add boot parameter "omapfb_memsize" which allocates memory to be used
> as dma coherent memory, so dma_alloc_attrs won't hit CMA allocator
> when trying to allocate memory for the framebuffers
>=20
> Signed-off-by: Ivaylo Dimitrov <freemangordon@abv.bg>
> ---
>  arch/arm/mach-omap2/common.c |    1 +
>  arch/arm/mach-omap2/common.h |    2 +
>  arch/arm/mach-omap2/fb.c     |   46
> +++++++++++++++++++++++++++++++++++++++++- 3 files changed, 48
> insertions(+), 1 deletions(-)
>=20
> diff --git a/arch/arm/mach-omap2/common.c
> b/arch/arm/mach-omap2/common.c index 2dabb9e..9beecde 100644
> --- a/arch/arm/mach-omap2/common.c
> +++ b/arch/arm/mach-omap2/common.c
> @@ -33,4 +33,5 @@ void __init omap_reserve(void)
>  	omap_dsp_reserve_sdram_memblock();
>  	omap_secure_ram_reserve_memblock();
>  	omap_barrier_reserve_memblock();
> +	omap_fb_reserve_memblock();
>  }
> diff --git a/arch/arm/mach-omap2/common.h
> b/arch/arm/mach-omap2/common.h index e30ef67..21afdc0 100644
> --- a/arch/arm/mach-omap2/common.h
> +++ b/arch/arm/mach-omap2/common.h
> @@ -304,6 +304,8 @@ extern void omap_reserve(void);
>  struct omap_hwmod;
>  extern int omap_dss_reset(struct omap_hwmod *);
>=20
> +extern void omap_fb_reserve_memblock(void);
> +
>  /* SoC specific clock initializer */
>  extern int (*omap_clk_init)(void);
>=20
> diff --git a/arch/arm/mach-omap2/fb.c b/arch/arm/mach-omap2/fb.c
> index 26e28e9..0eacbe9 100644
> --- a/arch/arm/mach-omap2/fb.c
> +++ b/arch/arm/mach-omap2/fb.c
> @@ -30,6 +30,7 @@
>  #include <linux/dma-mapping.h>
>=20
>  #include <asm/mach/map.h>
> +#include <asm/memblock.h>
>=20
>  #include "soc.h"
>  #include "display.h"
> @@ -106,10 +107,53 @@ static struct platform_device omap_fb_device =3D
> { .num_resources =3D 0,
>  };
>=20
> +static phys_addr_t omapfb_mem_base __initdata;
> +static phys_addr_t omapfb_mem_size __initdata;
> +
> +void __init omap_fb_reserve_memblock(void)
> +{
> +	if (omapfb_mem_size) {
> +		omapfb_mem_base =3D arm_memblock_steal(omapfb_mem_size, SZ_1M);
> +		if (omapfb_mem_base)
> +			pr_info("omapfb: reserved %u bytes at %x\n",
> +				omapfb_mem_size, omapfb_mem_base);
> +		else
> +			pr_err("omapfb: arm_memblock_steal failed\n");
> +	}
> +}
> +
>  int __init omap_init_fb(void)
>  {
> -	return platform_device_register(&omap_fb_device);
> +	int ret;
> +
> +	ret =3D platform_device_register(&omap_fb_device);
> +
> +	if (ret)
> +		return ret;
> +
> +	if (!omapfb_mem_base)
> +		return 0;
> +
> +	ret =3D dma_declare_coherent_memory(&omap_fb_device.dev,
> +					  omapfb_mem_base, omapfb_mem_base,
> +					  omapfb_mem_size, DMA_MEMORY_MAP |
> +					  DMA_MEMORY_EXCLUSIVE);
> +	if (!(ret & DMA_MEMORY_MAP))
> +		pr_err("omapfb: dma_declare_coherent_memory failed\n");
> +
> +	return 0;
> +}
> +
> +static int __init early_omapfb_memsize(char *p)
> +{
> +	omapfb_mem_size =3D ALIGN(memparse(p, &p), SZ_1M);
> +
> +	if(!omapfb_mem_size)
> +		pr_err("omapfb: bad memsize parameter\n");
> +
> +	return 0;
>  }
> +early_param("omapfb_memsize", early_omapfb_memsize);
>  #else
>  int __init omap_init_fb(void) { return 0; }
>  #endif

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart1609143.9HvMzFJ6Dh
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlaGapcACgkQi/DJPQPkQ1JM+gCfcP51wObaZ1NDiIuz6WuNTKHG
/y4An3jlR1IoEk3sGFHQeZH1rPgiuimk
=jCYw
-----END PGP SIGNATURE-----

--nextPart1609143.9HvMzFJ6Dh--
