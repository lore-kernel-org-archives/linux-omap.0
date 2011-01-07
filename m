From: Tony Lindgren <tony@atomide.com>
Subject: Re: Latest regressions
Date: Fri, 7 Jan 2011 08:56:26 -0800
Message-ID: <20110107165626.GD880@atomide.com>
References: <20110107115744.GL1198@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:42900 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754470Ab1AGQ4k (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Jan 2011 11:56:40 -0500
Content-Disposition: inline
In-Reply-To: <20110107115744.GL1198@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [110107 03:57]:
> 
> So, this is what I currently have to get that far:
> 
> diff --git a/arch/arm/mach-omap2/include/mach/entry-macro.S b/arch/arm/mach-omap2/include/mach/entry-macro.S
> index befa321..81985a6 100644
> --- a/arch/arm/mach-omap2/include/mach/entry-macro.S
> +++ b/arch/arm/mach-omap2/include/mach/entry-macro.S
> @@ -38,20 +38,6 @@
>   */
>  
>  #ifdef MULTI_OMAP2
> -
> -/*
> - * We use __glue to avoid errors with multiple definitions of
> - * .globl omap_irq_base as it's included from entry-armv.S but not
> - * from entry-common.S.
> - */
> -#ifdef __glue
> -		.pushsection .data
> -		.globl	omap_irq_base
> -omap_irq_base:
> -		.word	0
> -		.popsection
> -#endif
> -
>  		/*
>  		 * Configure the interrupt base on the first interrupt.
>  		 * See also omap_irq_base_init for setting omap_irq_base.
> diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
> index e66687b..c203204 100644
> --- a/arch/arm/mach-omap2/io.c
> +++ b/arch/arm/mach-omap2/io.c
> @@ -314,14 +314,13 @@ static int _set_hwmod_postsetup_state(struct omap_hwmod *oh, void *data)
>  	return omap_hwmod_set_postsetup_state(oh, *(u8 *)data);
>  }
>  
> +void __iomem *omap_irq_base;
> +
>  /*
>   * Initialize asm_irq_base for entry-macro.S
>   */
>  static inline void omap_irq_base_init(void)
>  {
> -	extern void __iomem *omap_irq_base;
> -
> -#ifdef MULTI_OMAP2
>  	if (cpu_is_omap24xx())
>  		omap_irq_base = OMAP2_L4_IO_ADDRESS(OMAP24XX_IC_BASE);
>  	else if (cpu_is_omap34xx())
> @@ -330,7 +329,6 @@ static inline void omap_irq_base_init(void)
>  		omap_irq_base = OMAP2_L4_IO_ADDRESS(OMAP44XX_GIC_CPU_BASE);
>  	else
>  		pr_err("Could not initialize omap_irq_base\n");
> -#endif
>  }
>  
>  void __init omap2_init_common_infrastructure(void)

This looks good to me.

> diff --git a/arch/arm/mach-omap2/mux.c b/arch/arm/mach-omap2/mux.c
> index 17bd639..9eaa28c 100644
> --- a/arch/arm/mach-omap2/mux.c
> +++ b/arch/arm/mach-omap2/mux.c
> @@ -160,7 +160,7 @@ static int __init _omap_mux_get_by_name(struct omap_mux_partition *partition,
>  	struct omap_mux *mux = NULL;
>  	struct omap_mux_entry *e;
>  	const char *mode_name;
> -	int found = 0, found_mode, mode0_len = 0;
> +	int found = 0, found_mode = 0, mode0_len = 0;
>  	struct list_head *muxmodes = &partition->muxmodes;
>  
>  	mode_name = strchr(muxname, '.');

Ack.

> diff --git a/arch/arm/plat-omap/include/plat/voltage.h b/arch/arm/plat-omap/include/plat/voltage.h
> index 0ff1233..ffcdff9 100644
> --- a/arch/arm/plat-omap/include/plat/voltage.h
> +++ b/arch/arm/plat-omap/include/plat/voltage.h
> @@ -14,6 +14,8 @@
>  #ifndef __ARCH_ARM_MACH_OMAP2_VOLTAGE_H
>  #define __ARCH_ARM_MACH_OMAP2_VOLTAGE_H
>  
> +#include <linux/errno.h>
> +
>  #define VOLTSCALE_VPFORCEUPDATE		1
>  #define VOLTSCALE_VCBYPASS		2

This fix is already queued up by Kevin, but missing..
  
> @@ -133,9 +135,9 @@ void omap_change_voltscale_method(struct voltagedomain *voltdm,
>  		int voltscale_method);
>  int omap_voltage_late_init(void);
>  #else
> -static inline int omap_voltage_register_pmic(struct voltagedomain *voltdm,
> +static inline void omap_voltage_register_pmic(struct voltagedomain *voltdm,
>  		struct omap_volt_pmic_info *pmic_info) {}
> -static inline  void omap_change_voltscale_method(struct voltagedomain *voltdm,
> +static inline void omap_change_voltscale_method(struct voltagedomain *voltdm,
>  		int voltscale_method) {}
>  static inline int omap_voltage_late_init(void)
>  {

..this change.

Regards,

Tony
