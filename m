From: Tony Lindgren <tony@atomide.com>
Subject: Re: Mainline OMAP3 breakage (and other OMAP?)
Date: Thu, 2 Dec 2010 13:58:38 -0800
Message-ID: <20101202215837.GW17222@atomide.com>
References: <20101202211421.GG10461@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:30251 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757782Ab0LBV66 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 2 Dec 2010 16:58:58 -0500
Content-Disposition: inline
In-Reply-To: <20101202211421.GG10461@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@nokia.com>

* Russell King - ARM Linux <linux@arm.linux.org.uk> [101202 13:04]:
> This has been around since October:
>=20
> drivers/video/omap2/vram.c: In function =E2=96=A0omap_vram_reserve_sd=
ram_memblock=E2=96=A0:
> drivers/video/omap2/vram.c:573: error: =E2=96=A0MEMBLOCK_REAL_LIMIT=E2=
=96=A0 undeclared (first use in this function)
> drivers/video/omap2/vram.c:573: error: (Each undeclared identifier is=
 reported only once
> drivers/video/omap2/vram.c:573: error: for each function it appears i=
n.)
>=20
> This requires a trivial one-liner compile fix:
>=20
> diff --git a/drivers/video/omap2/vram.c b/drivers/video/omap2/vram.c
> index fed2a72..a8973f0 100644
> --- a/drivers/video/omap2/vram.c
> +++ b/drivers/video/omap2/vram.c
> @@ -570,7 +570,7 @@ void __init omap_vram_reserve_sdram_memblock(void=
)
>  			return;
>  		}
>  	} else {
> -		paddr =3D memblock_alloc_base(size, PAGE_SIZE, MEMBLOCK_REAL_LIMIT=
);
> +		paddr =3D memblock_alloc(size, PAGE_SIZE);
>  	}
> =20
>  	omap_vram_add_region(paddr, size);
>=20
> which restores the old behaviour before the X86 memblock changes went
> in.  Yes, there may be other changes due to the ioremap stuff, but
> that's really no excuse for not fixing the compile error itself.

Great. Adding fbdev and Tomi to Cc.

Acked-by: Tony Lindgren <tony@atomide.com>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
