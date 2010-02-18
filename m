From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 2/9] omap2/3/4: ioremap omap_globals module
Date: Thu, 18 Feb 2010 10:35:19 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1002181029390.24812@utopia.booyaka.com>
References: <1266483554-15044-1-git-send-email-santosh.shilimkar@ti.com> <1266483554-15044-2-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:33848 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758488Ab0BRRfT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Feb 2010 12:35:19 -0500
In-Reply-To: <1266483554-15044-2-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@deeprootsystems.com>

One nitpicky comment on this one also:

On Thu, 18 Feb 2010, Santosh Shilimkar wrote:

> This is a clean-up patch towards dynamic allocation of IO space
> instead of using harcoded macros to calculate virtual addresses.
> 
> Also update the sdrc, prcm, tap and control module to
> allocate iospace dynamically
> 
> As per Tony's suggestion V2 version drops tap changes
> becasue ioremap uses cpu_is_omap2420() and cpu_is_omap2430(),
> so we can't use that for setting tap_base. Hence ioremap()
> won't work for tap until omap2_check_revision() is done
> 
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> CC: Kevin Hilman <khilman@deeprootsystems.com>
> CC: Tony Lindgren <tony@atomide.com>
> ---
>  arch/arm/mach-omap2/control.c            |    6 ++++-
>  arch/arm/mach-omap2/prcm.c               |   16 ++++++++++--
>  arch/arm/mach-omap2/sdrc.c               |   11 +++++++-
>  arch/arm/plat-omap/common.c              |   38 +++++++++++++++---------------
>  arch/arm/plat-omap/include/plat/common.h |   17 ++++++++-----
>  5 files changed, 56 insertions(+), 32 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/control.c b/arch/arm/mach-omap2/control.c
> index cdd1f35..43f8a33 100644
> --- a/arch/arm/mach-omap2/control.c
> +++ b/arch/arm/mach-omap2/control.c
> @@ -140,7 +140,11 @@ static struct omap3_control_regs control_context;
>  
>  void __init omap2_set_globals_control(struct omap_globals *omap2_globals)
>  {
> -	omap2_ctrl_base = omap2_globals->ctrl;
> +	/* Static mapping, never released */
> +	if (omap2_globals->ctrl) {
> +		omap2_ctrl_base = ioremap(omap2_globals->ctrl, SZ_4K);
> +		WARN_ON(!omap2_ctrl_base);
> +	}
>  }
>  
>  void __iomem *omap_ctrl_base_get(void)
> diff --git a/arch/arm/mach-omap2/prcm.c b/arch/arm/mach-omap2/prcm.c
> index e8e121a..338d5f6 100644
> --- a/arch/arm/mach-omap2/prcm.c
> +++ b/arch/arm/mach-omap2/prcm.c
> @@ -279,9 +279,19 @@ int omap2_cm_wait_idlest(void __iomem *reg, u32 mask, const char *name)
>  
>  void __init omap2_set_globals_prcm(struct omap_globals *omap2_globals)
>  {
> -	prm_base = omap2_globals->prm;
> -	cm_base = omap2_globals->cm;
> -	cm2_base = omap2_globals->cm2;
> +	/* Static mapping, never released */
> +	if (omap2_globals->prm) {
> +		prm_base = ioremap(omap2_globals->prm, SZ_8K);
> +		WARN_ON(!prm_base);
> +	}
> +	if (omap2_globals->cm) {
> +		cm_base = ioremap(omap2_globals->cm, SZ_8K);
> +		WARN_ON(!cm_base);
> +	}
> +	if (omap2_globals->cm2) {
> +		cm2_base = ioremap(omap2_globals->cm2, SZ_8K);
> +		WARN_ON(!cm2_base);
> +	}
>  }
>  
>  #ifdef CONFIG_ARCH_OMAP3
> diff --git a/arch/arm/mach-omap2/sdrc.c b/arch/arm/mach-omap2/sdrc.c
> index cbfbd14..4c65f56 100644
> --- a/arch/arm/mach-omap2/sdrc.c
> +++ b/arch/arm/mach-omap2/sdrc.c
> @@ -119,8 +119,15 @@ int omap2_sdrc_get_params(unsigned long r,
>  
>  void __init omap2_set_globals_sdrc(struct omap_globals *omap2_globals)
>  {
> -	omap2_sdrc_base = omap2_globals->sdrc;
> -	omap2_sms_base = omap2_globals->sms;
> +	/* Static mapping, never released */
> +	if (omap2_globals->sdrc) {
> +		omap2_sdrc_base = ioremap(omap2_globals->sdrc, SZ_64K);
> +		WARN_ON(!omap2_sdrc_base);
> +	}
> +	if (omap2_globals->sms) {
> +		omap2_sms_base = ioremap(omap2_globals->sms, SZ_64K);
> +		WARN_ON(!omap2_sms_base);
> +	}
>  }
>  
>  /**
> diff --git a/arch/arm/plat-omap/common.c b/arch/arm/plat-omap/common.c
> index 4f29e8c..088c1a0 100644
> --- a/arch/arm/plat-omap/common.c
> +++ b/arch/arm/plat-omap/common.c
> @@ -256,11 +256,11 @@ static void __init __omap2_set_globals(struct omap_globals *omap2_globals)
>  static struct omap_globals omap242x_globals = {
>  	.class	= OMAP242X_CLASS,
>  	.tap	= OMAP2_L4_IO_ADDRESS(0x48014000),
> -	.sdrc	= OMAP2_L3_IO_ADDRESS(OMAP2420_SDRC_BASE),
> -	.sms	= OMAP2_L3_IO_ADDRESS(OMAP2420_SMS_BASE),
> -	.ctrl	= OMAP2_L4_IO_ADDRESS(OMAP2420_CTRL_BASE),
> -	.prm	= OMAP2_L4_IO_ADDRESS(OMAP2420_PRM_BASE),
> -	.cm	= OMAP2_L4_IO_ADDRESS(OMAP2420_CM_BASE),
> +	.sdrc	= OMAP2420_SDRC_BASE,
> +	.sms	= OMAP2420_SMS_BASE,
> +	.ctrl	= OMAP2420_CTRL_BASE,
> +	.prm	= OMAP2420_PRM_BASE,
> +	.cm	= OMAP2420_CM_BASE,
>  	.uart1_phys	= OMAP2_UART1_BASE,
>  	.uart2_phys	= OMAP2_UART2_BASE,
>  	.uart3_phys	= OMAP2_UART3_BASE,
> @@ -277,11 +277,11 @@ void __init omap2_set_globals_242x(void)
>  static struct omap_globals omap243x_globals = {
>  	.class	= OMAP243X_CLASS,
>  	.tap	= OMAP2_L4_IO_ADDRESS(0x4900a000),
> -	.sdrc	= OMAP2_L3_IO_ADDRESS(OMAP243X_SDRC_BASE),
> -	.sms	= OMAP2_L3_IO_ADDRESS(OMAP243X_SMS_BASE),
> -	.ctrl	= OMAP2_L4_IO_ADDRESS(OMAP243X_CTRL_BASE),
> -	.prm	= OMAP2_L4_IO_ADDRESS(OMAP2430_PRM_BASE),
> -	.cm	= OMAP2_L4_IO_ADDRESS(OMAP2430_CM_BASE),
> +	.sdrc	= OMAP243X_SDRC_BASE,
> +	.sms	= OMAP243X_SMS_BASE,
> +	.ctrl	= OMAP243X_CTRL_BASE,
> +	.prm	= OMAP2430_PRM_BASE,
> +	.cm	= OMAP2430_CM_BASE,
>  	.uart1_phys	= OMAP2_UART1_BASE,
>  	.uart2_phys	= OMAP2_UART2_BASE,
>  	.uart3_phys	= OMAP2_UART3_BASE,
> @@ -298,11 +298,11 @@ void __init omap2_set_globals_243x(void)
>  static struct omap_globals omap3_globals = {
>  	.class	= OMAP343X_CLASS,
>  	.tap	= OMAP2_L4_IO_ADDRESS(0x4830A000),
> -	.sdrc	= OMAP2_L3_IO_ADDRESS(OMAP343X_SDRC_BASE),
> -	.sms	= OMAP2_L3_IO_ADDRESS(OMAP343X_SMS_BASE),
> -	.ctrl	= OMAP2_L4_IO_ADDRESS(OMAP343X_CTRL_BASE),
> -	.prm	= OMAP2_L4_IO_ADDRESS(OMAP3430_PRM_BASE),
> -	.cm	= OMAP2_L4_IO_ADDRESS(OMAP3430_CM_BASE),
> +	.sdrc	= OMAP343X_SDRC_BASE,
> +	.sms	= OMAP343X_SMS_BASE,
> +	.ctrl	= OMAP343X_CTRL_BASE,
> +	.prm	= OMAP3430_PRM_BASE,
> +	.cm	= OMAP3430_CM_BASE,
>  	.uart1_phys	= OMAP3_UART1_BASE,
>  	.uart2_phys	= OMAP3_UART2_BASE,
>  	.uart3_phys	= OMAP3_UART3_BASE,
> @@ -325,10 +325,10 @@ void __init omap2_set_globals_36xx(void)
>  static struct omap_globals omap4_globals = {
>  	.class	= OMAP443X_CLASS,
>  	.tap	= OMAP2_L4_IO_ADDRESS(OMAP443X_SCM_BASE),
> -	.ctrl	= OMAP2_L4_IO_ADDRESS(OMAP443X_CTRL_BASE),
> -	.prm	= OMAP2_L4_IO_ADDRESS(OMAP4430_PRM_BASE),
> -	.cm	= OMAP2_L4_IO_ADDRESS(OMAP4430_CM_BASE),
> -	.cm2	= OMAP2_L4_IO_ADDRESS(OMAP4430_CM2_BASE),
> +	.ctrl	= OMAP443X_CTRL_BASE,
> +	.prm	= OMAP4430_PRM_BASE,
> +	.cm	= OMAP4430_CM_BASE,
> +	.cm2	= OMAP4430_CM2_BASE,
>  	.uart1_phys	= OMAP4_UART1_BASE,
>  	.uart2_phys	= OMAP4_UART2_BASE,
>  	.uart3_phys	= OMAP4_UART3_BASE,
> diff --git a/arch/arm/plat-omap/include/plat/common.h b/arch/arm/plat-omap/include/plat/common.h
> index e04a58e..d0faff0 100644
> --- a/arch/arm/plat-omap/include/plat/common.h
> +++ b/arch/arm/plat-omap/include/plat/common.h
> @@ -37,16 +37,19 @@ extern void __iomem *gic_cpu_base_addr;
>  extern void omap_map_common_io(void);
>  extern struct sys_timer omap_timer;
>  
> -/* IO bases for various OMAP processors */
> +/* IO bases for various OMAP processors
> + * Except the tap base, rest all the io bases
> + * listed are physical addresses.
> + */

Please be careful with CodingStyle, this should follow the rules for 
multiline comments.

>  struct omap_globals {
>  	u32		class;		/* OMAP class to detect */
>  	void __iomem	*tap;		/* Control module ID code */
> -	void __iomem	*sdrc;		/* SDRAM Controller */
> -	void __iomem	*sms;		/* SDRAM Memory Scheduler */
> -	void __iomem	*ctrl;		/* System Control Module */
> -	void __iomem	*prm;		/* Power and Reset Management */
> -	void __iomem	*cm;		/* Clock Management */
> -	void __iomem	*cm2;
> +	unsigned long   sdrc;           /* SDRAM Controller */
> +	unsigned long   sms;            /* SDRAM Memory Scheduler */
> +	unsigned long   ctrl;           /* System Control Module */
> +	unsigned long   prm;            /* Power and Reset Management */
> +	unsigned long   cm;             /* Clock Management */
> +	unsigned long   cm2;
>  	unsigned long	uart1_phys;
>  	unsigned long	uart2_phys;
>  	unsigned long	uart3_phys;
> -- 
> 1.6.0.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


- Paul
