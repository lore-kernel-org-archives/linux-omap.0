From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: [PATCH 3/9 v3] omap: generic: introduce a single check_revision
Date: Fri, 25 Jun 2010 22:11:29 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02C5D167DB@dbde02.ent.ti.com>
References: <1277483122-3616-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:38882 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752419Ab0FYQlz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 25 Jun 2010 12:41:55 -0400
In-Reply-To: <1277483122-3616-1-git-send-email-nm@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Angelo Arrifano <miknix@gmail.com>, "Zebediah C. McClure" <zmc@lurian.net>, Alistair Buxton <a.j.buxton@gmail.com>, Grazvydas Ignotas <notasas@gmail.com>, Paul Walmsley <paul@pwsan.com>, "Premi, Sanjeev" <premi@ti.com>, "Guruswamy, Senthilvadivu" <svadivu@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>, Tomi Valkeinen <tomi.valkeinen@nokia.com>, Aaro Koskinen <aaro.koskinen@nokia.com>, "Pandita, Vikram" <vikram.pandita@ti.com>, "S, Vishwanath" <vishwa.s@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: Menon, Nishanth
> Sent: Friday, June 25, 2010 9:55 PM
> To: linux-omap
> Cc: Tony Lindgren; Menon, Nishanth; Angelo Arrifano; Zebediah C. McClure; Alistair Buxton; Grazvydas
> Ignotas; Paul Walmsley; Premi, Sanjeev; Shilimkar, Santosh; Guruswamy, Senthilvadivu; Kevin Hilman;
> DebBarma, Tarun Kanti; Tomi Valkeinen; Aaro Koskinen; Pandita, Vikram; S, Vishwanath; linux-
> omap@vger.kernel.org
> Subject: [PATCH 3/9 v3] omap: generic: introduce a single check_revision
> 
> Introduce a single omap generic check_revision that routes the
> request to the right revision of check_revision.
> 
> Note: OMAP1 and OMAP2+ are not built into a single kernel. This
> allows for the headers definitions of omap1_check_revision() and
> omap2_check_revision() to be used without #ifdefs and additional cpu
> checks in our single check_revision.
> 
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Angelo Arrifano <miknix@gmail.com>
> Cc: "Zebediah C. McClure" <zmc@lurian.net>
> Cc: Alistair Buxton <a.j.buxton@gmail.com>
> Cc: Grazvydas Ignotas <notasas@gmail.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Sanjeev Premi <premi@ti.com>
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: Senthilvadivu Gurusamy <svadivu@ti.com>
> Cc: Kevin Hilman <khilman@deeprootsystems.com>
> Cc: Tarun Kanti DebBarma <tarun.kanti@ti.com>
> Cc: Tomi Valkeinen <tomi.valkeinen@nokia.com>
> Cc: Aaro Koskinen <aaro.koskinen@nokia.com>
> Cc: Vikram Pandita <vikram.pandita@ti.com>
> Cc: Vishwanath S <vishwa.s@ti.com>
> Cc: linux-omap@vger.kernel.org
> 
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
> V3: comments from http://marc.info/?t=127747252000003&r=1&w=2
> 	fixed
> V2: comments from http://marc.info/?t=127725956100006&r=1&w=2
> 	fixed
> V1: original
>  arch/arm/mach-omap1/io.c              |    3 +--
>  arch/arm/mach-omap2/io.c              |    2 +-
>  arch/arm/plat-omap/common.c           |    6 ++++++
>  arch/arm/plat-omap/include/plat/cpu.h |   13 ++++++++++++-
>  4 files changed, 20 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/mach-omap1/io.c b/arch/arm/mach-omap1/io.c
> index e4d8680..4f9ee73 100644
> --- a/arch/arm/mach-omap1/io.c
> +++ b/arch/arm/mach-omap1/io.c
> @@ -20,7 +20,6 @@
> 
>  #include "clock.h"
> 
> -extern void omap1_check_revision(void);
>  extern void omap_sram_init(void);
> 
>  /*
> @@ -102,7 +101,7 @@ void __init omap1_map_common_io(void)
>  	/* We want to check CPU revision early for cpu_is_omapxxxx() macros.
>  	 * IO space mapping must be initialized before we can do that.
>  	 */
> -	omap1_check_revision();
> +	omap_check_revision();
> 
>  #if defined (CONFIG_ARCH_OMAP730) || defined (CONFIG_ARCH_OMAP850)
>  	if (cpu_is_omap7xx()) {
> diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
> index 4e1f53d..eeb0e30 100644
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
I think codingstyle suggest empty function braces to be on next line
like
static inline void omap2_check_revision(void)
{}
> +#endif
> +
> +#ifdef CONFIG_ARCH_OMAP1
> +extern void omap1_check_revision(void);
> +#else
> +static inline void omap1_check_revision(void) {}
> +#endif
> +void omap_check_revision(void);
> 
>  /*
>   * Runtime detection of OMAP3 features

Otherwise patch looks good to me. 
> --
> 1.6.3.3

