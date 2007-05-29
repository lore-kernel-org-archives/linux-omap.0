From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 5/11] Adding OMAP3430 support to mach-omap2
Date: Tue, 29 May 2007 09:49:00 -0700
Message-ID: <20070529164859.GA26322@atomide.com>
References: <9C23CDD79DA20A479D4615857B2E2C47FF0E31@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <9C23CDD79DA20A479D4615857B2E2C47FF0E31@dlee13.ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Cc: Linux OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

* Syed Mohammed, Khasim <x0khasim@ti.com> [070528 23:26]:
> Adding OMAP 3430 support to arch/arm/mach-omap2
> 
> Signed-off-by: Syed Mohammed Khasim  <x0khasim@ti.com>
> 
> Files Changed:
>  Kconfig      |   14
>  Makefile     |    6
>  clock.h      |    1
>  clock_34xx.c | 1255 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

<snip>

Well clock_34xx.c can be merged to existing clock.c. With Pau's PRCM
patches, only few registers are different now.


> diff -purN linux-omap/arch/arm/mach-omap2/gpmc.c val_3430_GIT/arch/arm/mach-omap2/gpmc.c
> --- linux-omap/arch/arm/mach-omap2/gpmc.c	2007-05-16 14:32:40.000000000 -0500
> +++ val_3430_GIT/arch/arm/mach-omap2/gpmc.c	2007-05-28 12:47:13.000000000 -0500
> @@ -22,12 +22,12 @@
>  
>  #undef DEBUG
>  
> -#ifdef CONFIG_ARCH_OMAP2420
> +#if defined(CONFIG_ARCH_OMAP2420)
>  #define GPMC_BASE		0x6800a000
> -#endif
> -
> -#ifdef CONFIG_ARCH_OMAP2430
> -#define GPMC_BASE		0x6E000000
> +#elif defined(CONFIG_ARCH_OMAP2430)
> +#define GPMC_BASE		0x6e000000
> +#elif defined(CONFIG_ARCH_OMAP3430)
> +#define GPMC_BASE		0x6e000000
>  #endif
>  
>  #define GPMC_REVISION		0x00

The above should be defined(CONFIG_ARCH_OMAP2430) || defined(CONFIG_ARCH_OMAP3430)


> diff -purN linux-omap/arch/arm/mach-omap2/id.c val_3430_GIT/arch/arm/mach-omap2/id.c
> --- linux-omap/arch/arm/mach-omap2/id.c	2006-11-20 21:54:01.000000000 -0600
> +++ val_3430_GIT/arch/arm/mach-omap2/id.c	2007-05-28 12:47:13.000000000 -0500
> @@ -18,11 +18,11 @@
>  #include <asm/io.h>
>  
>  #if defined(CONFIG_ARCH_OMAP2420)
> -#define OMAP24XX_TAP_BASE	io_p2v(0x48014000)
> -#endif
> -
> -#if defined(CONFIG_ARCH_OMAP2430)
> -#define OMAP24XX_TAP_BASE	io_p2v(0x4900A000)
> +#define TAP_BASE	io_p2v(0x48014000)
> +#elif defined(CONFIG_ARCH_OMAP2430)
> +#define TAP_BASE	io_p2v(0x4900A000)
> +#elif defined(CONFIG_ARCH_OMAP34XX)
> +#define TAP_BASE	io_p2v(0x54004000)
>  #endif
>  
>  #define OMAP_TAP_IDCODE		0x0204
> @@ -58,7 +58,7 @@ static struct omap_id omap_ids[] __initd
>  
>  static u32 __init read_tap_reg(int reg)
>  {
> -	return __raw_readl(OMAP24XX_TAP_BASE + reg);
> +	return __raw_readl(TAP_BASE + reg);
>  }
>  
>  void __init omap2_check_revision(void)
> @@ -119,7 +119,11 @@ void __init omap2_check_revision(void)
>  	system_rev |= rev << 8;
>  
>  	/* Add the cpu class info (24xx) */
> +#ifndef CONFIG_ARCH_OMAP3
>  	system_rev |= 0x24;
> +#else
> +	system_rev |= 0x34;
> +#endif
>  
>  	pr_info("OMAP%04x", system_rev >> 16);
>  	if ((system_rev >> 8) & 0x0f)

This is yet another artificial barrier to compile in many revisions,
let's try to avoid that. You should be able to set system_rev based
on the hardware register values.


> diff -purN linux-omap/arch/arm/mach-omap2/io.c val_3430_GIT/arch/arm/mach-omap2/io.c
> --- linux-omap/arch/arm/mach-omap2/io.c	2007-05-16 14:32:40.000000000 -0500
> +++ val_3430_GIT/arch/arm/mach-omap2/io.c	2007-05-28 13:12:04.000000000 -0500
> @@ -4,8 +4,11 @@
>   * OMAP2 I/O mapping code
>   *
>   * Copyright (C) 2005 Nokia Corporation
> - * Author: Juha Yrjola<juha.yrjola@nokia.com>
> - * Updated map desc to add 2430 support : <x0khasim@ti.com>
> + * Copyright (C) 2007 Texas Instruments
> + *
> + * Author:
> + * Juha Yrjola <juha.yrjola@nokia.com>
> + * Syed Khasim <x0khasim@ti.com>
>   *
>   * This program is free software; you can redistribute it and/or modify
>   * it under the terms of the GNU General Public License version 2 as
> @@ -31,36 +34,104 @@ extern void omap2_init_memory(void);
>  extern void gpmc_init(void);
>  extern void omapfb_reserve_sdram(void);
>  
> +#if defined(CONFIG_ARCH_OMAP24XX)
> +
> +#define L3_VIRT		L3_24XX_VIRT
> +#define L3_PHYS		L3_24XX_PHYS
> +#define L3_SIZE		L3_24XX_SIZE
> +
> +#define L4_VIRT		L4_24XX_VIRT
> +#define L4_PHYS		L4_24XX_PHYS
> +#define L4_SIZE		L4_24XX_SIZE
> +
> +#define L4_WK_VIRT	L4_WK_243X_VIRT
> +#define L4_WK_PHYS	L4_WK_243X_PHYS
> +#define L4_WK_SIZE	L4_WK_243X_SIZE
> +
> +#define GPMC_VIRT	OMAP243X_GPMC_VIRT
> +#define GPMC_PHYS	OMAP243X_GPMC_PHYS
> +#define GPMC_SIZE	OMAP243X_GPMC_SIZE
> +
> +#define DSP_MEM_VIRT	DSP_MEM_24XX_VIRT
> +#define DSP_MEM_PHYS	DSP_MEM_24XX_PHYS
> +#define DSP_MEM_SIZE	DSP_MEM_24XX_SIZE
> +
> +#define DSP_IPI_VIRT	DSP_IPI_24XX_VIRT
> +#define DSP_IPI_PHYS	DSP_IPI_24XX_PHYS
> +#define DSP_IPI_SIZE	DSP_IPI_24XX_SIZE
> +
> +#define DSP_MMU_VIRT	DSP_MMU_24XX_VIRT
> +#define DSP_MMU_PHYS	DSP_MMU_24XX_PHYS
> +#define DSP_MMU_SIZE	DSP_MMU_24XX_SIZE
> +
> +#elif defined(CONFIG_ARCH_OMAP34XX)
> +
> +#define L3_VIRT		L3_34XX_VIRT
> +#define L3_PHYS		L3_34XX_PHYS
> +#define L3_SIZE		L3_34XX_SIZE
> +
> +#define L4_VIRT		L4_34XX_VIRT
> +#define L4_PHYS		L4_34XX_PHYS
> +#define L4_SIZE		L4_34XX_SIZE
> +
> +#define L4_PER_VIRT	L4_PER_34XX_VIRT
> +#define L4_PER_PHYS	L4_PER_34XX_PHYS
> +#define L4_PER_SIZE	L4_PER_34XX_SIZE
> +
> +#define L4_WK_VIRT	L4_WK_34XX_VIRT
> +#define L4_WK_PHYS	L4_WK_34XX_PHYS
> +#define L4_WK_SIZE	L4_WK_34XX_SIZE
> +
> +#define GPMC_VIRT	OMAP34XX_GPMC_VIRT
> +#define GPMC_PHYS	OMAP34XX_GPMC_PHYS
> +#define GPMC_SIZE	OMAP34XX_GPMC_SIZE
> +
> +#define DSP_MEM_VIRT	DSP_MEM_34XX_VIRT
> +#define DSP_MEM_PHYS	DSP_MEM_34XX_PHYS
> +#define DSP_MEM_SIZE	DSP_MEM_34XX_SIZE
> +
> +#define DSP_IPI_VIRT	DSP_IPI_34XX_VIRT
> +#define DSP_IPI_PHYS	DSP_IPI_34XX_PHYS
> +#define DSP_IPI_SIZE	DSP_IPI_34XX_SIZE
> +
> +#define DSP_MMU_VIRT	DSP_MMU_34XX_VIRT
> +#define DSP_MMU_PHYS	DSP_MMU_34XX_PHYS
> +#define DSP_MMU_SIZE	DSP_MMU_34XX_SIZE
> +
> +#endif

Let's rather change the #elif to #if to potentially compile in both
(altought unoptimized). I guess that also means changing L3_VIRT to be
L3_VIRT_34XX and so on.


> diff -purN linux-omap/arch/arm/mach-omap2/irq.c val_3430_GIT/arch/arm/mach-omap2/irq.c
> --- linux-omap/arch/arm/mach-omap2/irq.c	2007-01-08 18:55:58.000000000 -0600
> +++ val_3430_GIT/arch/arm/mach-omap2/irq.c	2007-05-28 12:47:13.000000000 -0500
> @@ -18,6 +18,12 @@
>  #include <asm/irq.h>
>  #include <asm/io.h>
>  
> +#if defined(CONFIG_ARCH_OMAP24XX)
> +#define IC_BASE		OMAP24XX_IC_BASE
> +#elif defined(CONFIG_ARCH_OMAP34XX)
> +#define IC_BASE		OMAP34XX_IC_BASE
> +#endif
> +
>  #define INTC_REVISION	0x0000
>  #define INTC_SYSCONFIG	0x0010
>  #define INTC_SYSSTATUS	0x0014
> @@ -37,7 +43,7 @@ static struct omap_irq_bank {
>  } __attribute__ ((aligned(4))) irq_banks[] = {
>  	{
>  		/* MPU INTC */
> -		.base_reg	= IO_ADDRESS(OMAP24XX_IC_BASE),
> +		.base_reg	= IO_ADDRESS(IC_BASE),
>  		.nr_irqs	= 96,
>  	}, {
>  		/* XXX: DSP INTC */

the .base_reg should be really set with if (cpu_is_omap24xx()) 
during the initialization to allow compiling in them both. Then the
#elif above can be just #if.

Regards,

Tony
