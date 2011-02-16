From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: RE: [PATCH 3/5] ARM: l2x0: Errata fix for flush by Way operation can
 cause data corruption
Date: Wed, 16 Feb 2011 18:02:07 +0530
Message-ID: <f566e4c9a488fc0e70eab1a91b04224e@mail.gmail.com>
References: <1297510187-31547-1-git-send-email-santosh.shilimkar@ti.com><1297510187-31547-4-git-send-email-santosh.shilimkar@ti.com><AANLkTimkqZ5datA+7shggbWz3+j=TDg5beUkQK=b1AmK@mail.gmail.com><13596bec9184b117d6a1d02da8e017bf@mail.gmail.com>
 <AANLkTimjXG5-kEW=1vodnGo3Ct_xOS_HihdqN0TeL9ba@mail.gmail.com>
 <33573d5cfc91cf45dc58ee861cccc2ae@mail.gmail.com> <4dfaffa99292bf8e36791ea9a68de75e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:41871 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755173Ab1BPMcJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 16 Feb 2011 07:32:09 -0500
Received: by mail-qw0-f54.google.com with SMTP id 9so1212412qwj.13
        for <linux-omap@vger.kernel.org>; Wed, 16 Feb 2011 04:32:08 -0800 (PST)
In-Reply-To: <4dfaffa99292bf8e36791ea9a68de75e@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-omap@vger.kernel.org, Kevin Hilman <khilman@ti.com>, tony@atomide.com, linux-arm-kernel@lists.infradead.org

Catalin,
> -----Original Message-----
> From: Santosh Shilimkar [mailto:santosh.shilimkar@ti.com]
> Sent: Tuesday, February 15, 2011 12:44 PM
> To: linux-arm-kernel@lists.infradead.org; Andrei Warkentin
> Cc: linux-omap@vger.kernel.org; Kevin Hilman; tony@atomide.com;
> Catalin Marinas
> Subject: RE: [PATCH 3/5] ARM: l2x0: Errata fix for flush by Way
> operation can cause data corruption
>
> > -----Original Message-----
> > From: Santosh Shilimkar [mailto:santosh.shilimkar@ti.com]
> > Sent: Monday, February 14, 2011 10:39 AM
> > To: Andrei Warkentin
> > Cc: linux-omap@vger.kernel.org; Kevin Hilman; tony@atomide.com;
> > linux-arm-kernel@lists.infradead.org; Catalin Marinas
> > Subject: RE: [PATCH 3/5] ARM: l2x0: Errata fix for flush by Way
> > operation can cause data corruption
> >
>
> [....]
>
> > > ...
> > I understood that from first comment. But I am not in favor
> > of polluting common ARM files with SOC specific #ifdeffery.
> > We have gone over this when first errata support
> > was added for PL310
> >
> > I have a better way to handle this scenario.
> > Expect an updated patch for this.
> >
>
> Below is the updated version which should remove any
> OMAP dependency on these errata's. Attached same.
>
> ----
> From: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Date: Fri, 14 Jan 2011 14:16:04 +0530
> Subject: [v2 PATCH 3/5] ARM: l2x0: Errata fix for flush by Way
> operation
> can cause data corruption
>
> PL310 implements the Clean & Invalidate by Way L2 cache maintenance
> operation (offset 0x7FC). This operation runs in background so that
> PL310 can handle normal accesses while it is in progress. Under very
> rare circumstances, due to this erratum, write data can be lost when
> PL310 treats a cacheable write transaction during a Clean &
> Invalidate
> by Way operation.
>
> Workaround:
> Disable Write-Back and Cache Linefill (Debug Control Register)
> Clean & Invalidate by Way (0x7FC)
> Re-enable Write-Back and Cache Linefill (Debug Control Register)
>
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> ---

Ack , Nak ?

>  arch/arm/Kconfig                   |   13 ++++++++++++-
>  arch/arm/include/asm/outercache.h  |    1 +
>  arch/arm/mach-omap2/Kconfig        |    3 +++
>  arch/arm/mach-omap2/omap4-common.c |    7 +++++++
>  arch/arm/mm/cache-l2x0.c           |   28 +++++++++++++++----------
> ---
>  5 files changed, 38 insertions(+), 14 deletions(-)
>
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 5cff165..ebadd95 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1140,7 +1140,7 @@ config ARM_ERRATA_742231
>
>  config PL310_ERRATA_588369
>  	bool "Clean & Invalidate maintenance operations do not
> invalidate
> clean lines"
> -	depends on CACHE_L2X0 && ARCH_OMAP4
> +	depends on CACHE_L2X0 && CACHE_PL310
>  	help
>  	   The PL310 L2 cache controller implements three types of
> Clean &
>  	   Invalidate maintenance operations: by Physical Address
> @@ -1177,6 +1177,17 @@ config ARM_ERRATA_743622
>  	  visible impact on the overall performance or power
> consumption
> of the
>  	  processor.
>
> +config PL310_ERRATA_727915
> +	bool "Background Clean & Invalidate by Way operation can cause
> data corruption"
> +	depends on CACHE_L2X0 && CACHE_PL310
> +	help
> +	  PL310 implements the Clean & Invalidate by Way L2 cache
> maintenance
> +	  operation (offset 0x7FC). This operation runs in background
> so
> that
> +	  PL310 can handle normal accesses while it is in progress.
> Under
> very
> +	  rare circumstances, due to this erratum, write data can be
> lost
> when
> +	  PL310 treats a cacheable write transaction during a Clean &
> +	  Invalidate by Way operation Note that this errata uses Texas
> +	  Instrument's secure monitor api to implement the work
> around.
>  endmenu
>
>  source "arch/arm/common/Kconfig"
> diff --git a/arch/arm/include/asm/outercache.h
> b/arch/arm/include/asm/outercache.h
> index fc19009..348d513 100644
> --- a/arch/arm/include/asm/outercache.h
> +++ b/arch/arm/include/asm/outercache.h
> @@ -31,6 +31,7 @@ struct outer_cache_fns {
>  #ifdef CONFIG_OUTER_CACHE_SYNC
>  	void (*sync)(void);
>  #endif
> +	void (*set_debug)(unsigned long);
>  };
>
>  #ifdef CONFIG_OUTER_CACHE
> diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-
> omap2/Kconfig
> index f285dd7..fd11ab4 100644
> --- a/arch/arm/mach-omap2/Kconfig
> +++ b/arch/arm/mach-omap2/Kconfig
> @@ -45,7 +45,10 @@ config ARCH_OMAP4
>  	select CPU_V7
>  	select ARM_GIC
>  	select LOCAL_TIMERS
> +	select CACHE_L2X0
> +	select CACHE_PL310
>  	select PL310_ERRATA_588369
> +	select PL310_ERRATA_727915
>  	select ARM_ERRATA_720789
>  	select ARCH_HAS_OPP
>  	select PM_OPP if PM
> diff --git a/arch/arm/mach-omap2/omap4-common.c
> b/arch/arm/mach-omap2/omap4-common.c
> index 1926864..9ef8c29 100644
> --- a/arch/arm/mach-omap2/omap4-common.c
> +++ b/arch/arm/mach-omap2/omap4-common.c
> @@ -52,6 +52,12 @@ static void omap4_l2x0_disable(void)
>  	omap_smc1(0x102, 0x0);
>  }
>
> +static void omap4_l2x0_set_debug(unsigned long val)
> +{
> +	/* Program PL310 L2 Cache controller debug register */
> +	omap_smc1(0x100, val);
> +}
> +
>  static int __init omap_l2_cache_init(void)
>  {
>  	u32 aux_ctrl = 0;
> @@ -99,6 +105,7 @@ static int __init omap_l2_cache_init(void)
>  	 * specific one
>  	*/
>  	outer_cache.disable = omap4_l2x0_disable;
> +	outer_cache.set_debug = omap4_l2x0_set_debug;
>
>  	return 0;
>  }
> diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
> index 170c9bb..a8caee4 100644
> --- a/arch/arm/mm/cache-l2x0.c
> +++ b/arch/arm/mm/cache-l2x0.c
> @@ -67,18 +67,22 @@ static inline void l2x0_inv_line(unsigned long
> addr)
>  	writel_relaxed(addr, base + L2X0_INV_LINE_PA);
>  }
>
> -#ifdef CONFIG_PL310_ERRATA_588369
> +#if defined(CONFIG_PL310_ERRATA_588369) ||
> defined(CONFIG_PL310_ERRATA_727915)
>  static void debug_writel(unsigned long val)
>  {
> -	extern void omap_smc1(u32 fn, u32 arg);
> -
> -	/*
> -	 * Texas Instrument secure monitor api to modify the
> -	 * PL310 Debug Control Register.
> -	 */
> -	omap_smc1(0x100, val);
> +	if (outer_cache.set_debug)
> +		outer_cache.set_debug(val);
> +	else
> +		writel(val, l2x0_base + L2X0_DEBUG_CTRL);
> +}
> +#else
> +/* Optimised out for non-errata case */
> +static inline void debug_writel(unsigned long val)
> +{
>  }
> +#endif
>
> +#ifdef CONFIG_PL310_ERRATA_588369
>  static inline void l2x0_flush_line(unsigned long addr)
>  {
>  	void __iomem *base = l2x0_base;
> @@ -91,11 +95,6 @@ static inline void l2x0_flush_line(unsigned long
> addr)
>  }
>  #else
>
> -/* Optimised out for non-errata case */
> -static inline void debug_writel(unsigned long val)
> -{
> -}
> -
>  static inline void l2x0_flush_line(unsigned long addr)
>  {
>  	void __iomem *base = l2x0_base;
> @@ -119,9 +118,11 @@ static void l2x0_flush_all(void)
>
>  	/* clean all ways */
>  	spin_lock_irqsave(&l2x0_lock, flags);
> +	debug_writel(0x03);
>  	writel_relaxed(l2x0_way_mask, l2x0_base + L2X0_CLEAN_INV_WAY);
>  	cache_wait_way(l2x0_base + L2X0_CLEAN_INV_WAY, l2x0_way_mask);
>  	cache_sync();
> +	debug_writel(0x00);
>  	spin_unlock_irqrestore(&l2x0_lock, flags);
>  }
>
> @@ -329,6 +330,7 @@ void __init l2x0_init(void __iomem *base, __u32
> aux_val, __u32 aux_mask)
>  	outer_cache.flush_all = l2x0_flush_all;
>  	outer_cache.inv_all = l2x0_inv_all;
>  	outer_cache.disable = l2x0_disable;
> +	outer_cache.set_debug = NULL;
>
>  	printk(KERN_INFO "%s cache controller enabled\n", type);
>  	printk(KERN_INFO "l2x0: %d ways, CACHE_ID 0x%08x, AUX_CTRL
> 0x%08x,
> Cache size: %d B\n",
> --
> 1.6.0.4
