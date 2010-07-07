From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 3/9 v3] omap: generic: introduce a single check_revision
Date: Wed, 7 Jul 2010 15:36:33 +0300
Message-ID: <20100707123633.GT1920@atomide.com>
References: <1277483122-3616-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:65441 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753671Ab0GGMgo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Jul 2010 08:36:44 -0400
Content-Disposition: inline
In-Reply-To: <1277483122-3616-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Angelo Arrifano <miknix@gmail.com>, "Zebediah C. McClure" <zmc@lurian.net>, Alistair Buxton <a.j.buxton@gmail.com>, Grazvydas Ignotas <notasas@gmail.com>, Paul Walmsley <paul@pwsan.com>, Sanjeev Premi <premi@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Senthilvadivu Gurusamy <svadivu@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Tarun Kanti DebBarma <tarun.kanti@ti.com>, Tomi Valkeinen <tomi.valkeinen@nokia.com>, Aaro Koskinen <aaro.koskinen@nokia.com>, Vikram Pandita <vikram.pandita@ti.com>, Vishwanath S <vishwa.s@ti.com>

* Nishanth Menon <nm@ti.com> [100625 19:19]:
> --- a/arch/arm/mach-omap2/io.c
> +++ b/arch/arm/mach-omap2/io.c
> @@ -238,7 +238,7 @@ static void __init _omap2_map_common_io(void)
>  	local_flush_tlb_all();
>  	flush_cache_all();
>  
> -	omap2_check_revision();
> +	omap_check_revision();
>  	omap_sram_init();
>  }
>  
> diff --git a/arch/arm/plat-omap/common.c b/arch/arm/plat-omap/common.c
> index fca73cd..4a0e333 100644
> --- a/arch/arm/plat-omap/common.c
> +++ b/arch/arm/plat-omap/common.c
> @@ -89,6 +89,12 @@ void __init omap_reserve(void)
>  	omap_vram_reserve_sdram_lmb();
>  }
>  
> +void __init omap_check_revision(void)
> +{
> +	omap1_check_revision();
> +	omap2_check_revision();
> +}
> +
>  /*
>   * 32KHz clocksource ... always available, on pretty most chips except
>   * OMAP 730 and 1510.  Other timers could be used as clocksources, with
> diff --git a/arch/arm/plat-omap/include/plat/cpu.h b/arch/arm/plat-omap/include/plat/cpu.h
> index 7514174..5f12a0b 100644
> --- a/arch/arm/plat-omap/include/plat/cpu.h
> +++ b/arch/arm/plat-omap/include/plat/cpu.h
> @@ -431,7 +431,18 @@ IS_OMAP_TYPE(3517, 0x3517)
>  
>  
>  int omap_chip_is(struct omap_chip_id oci);
> -void omap2_check_revision(void);
> +#ifdef CONFIG_ARCH_OMAP2PLUS
> +extern void omap2_check_revision(void);
> +#else
> +static inline void omap2_check_revision(void) {}
> +#endif
> +
> +#ifdef CONFIG_ARCH_OMAP1
> +extern void omap1_check_revision(void);
> +#else
> +static inline void omap1_check_revision(void) {}
> +#endif
> +void omap_check_revision(void);

Hmm, to me it seems like we should have static omap_check_revision
in both mach-omap1/id.c and mach-omap2/id.c. Or do we need to call
these anywhere else outside both id.c files?

Then these can set u32 omap_revision flags in plat-omap/common.c,
and then we can have a common omap_get_revision() or something
in plat-omap/common.c?

There should not be need for cpu_is_omapxxxx tests for getting
the revision after it's initialized.

Regards,

Tony
