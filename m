From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 6 / 12] Mach omap2 updation for 3430
Date: Thu, 14 Jun 2007 04:46:52 -0700
Message-ID: <20070614114651.GF28804@atomide.com>
References: <9C23CDD79DA20A479D4615857B2E2C47011E6095@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <9C23CDD79DA20A479D4615857B2E2C47011E6095@dlee13.ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Cc: Linux OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

* Syed Mohammed, Khasim <x0khasim@ti.com> [070613 22:10]:
> 
> Mach omap2 file updates for 3430
> 

<snip>

> diff -purN linux-omap/arch/arm/mach-omap2/io.c val_3430_GIT/arch/arm/mach-omap2/io.c
> --- linux-omap/arch/arm/mach-omap2/io.c	2007-05-30 14:02:43.000000000 -0500
> +++ val_3430_GIT/arch/arm/mach-omap2/io.c	2007-06-12 15:12:08.000000000 -0500
> @@ -4,8 +4,11 @@
>   * OMAP2 I/O mapping code
>   *
>   * Copyright (C) 2005 Nokia Corporation
> - * Author: Juha Yrjola<juha.yrjola@nokia.com>
> - * Updated map desc to add 2430 support : <x0khasim@ti.com>
> + * Copyright (C) 2007 Texas Instruments
> + *
> + * Author:
> + *	Juha Yrjola <juha.yrjola@nokia.com>
> + *	Syed Khasim <x0khasim@ti.com>
>   *
>   * This program is free software; you can redistribute it and/or modify
>   * it under the terms of the GNU General Public License version 2 as
> @@ -35,7 +38,9 @@ extern void omapfb_reserve_sdram(void);
>   * The machine specific code may provide the extra mapping besides the
>   * default mapping provided here.
>   */
> -static struct map_desc omap2_io_desc[] __initdata = {
> +
> +#ifdef CONFIG_ARCH_OMAP24XX
> +static struct map_desc omap24xx_io_desc[] __initdata = {
>  	{
>  		.virtual	= L3_24XX_VIRT,
>  		.pfn		= __phys_to_pfn(L3_24XX_PHYS),
> @@ -48,7 +53,34 @@ static struct map_desc omap2_io_desc[] _
>  		.length		= L4_24XX_SIZE,
>  		.type		= MT_DEVICE
>  	},
> +};
> +
> +#ifdef CONFIG_ARCH_OMAP2420
> +static struct map_desc omap242x_io_desc[] __initdata = {
> +	{
> +		.virtual	= DSP_MEM_24XX_VIRT,
> +		.pfn		= __phys_to_pfn(DSP_MEM_24XX_PHYS),
> +		.length		= DSP_MEM_24XX_SIZE,
> +		.type		= MT_DEVICE
> +	},
> +	{
> +		.virtual	= DSP_IPI_24XX_VIRT,
> +		.pfn		= __phys_to_pfn(DSP_IPI_24XX_PHYS),
> +		.length		= DSP_IPI_24XX_SIZE,
> +		.type		= MT_DEVICE
> +	},
> +	{
> +		.virtual	= DSP_MMU_24XX_VIRT,
> +		.pfn		= __phys_to_pfn(DSP_MMU_24XX_PHYS),
> +		.length		= DSP_MMU_24XX_SIZE,
> +		.type		= MT_DEVICE
> +	},
> +};
> +
> +#endif
> +
>  #ifdef CONFIG_ARCH_OMAP2430
> +static struct map_desc omap243x_io_desc[] __initdata = {
>  	{
>  		.virtual	= L4_WK_243X_VIRT,
>  		.pfn		= __phys_to_pfn(L4_WK_243X_PHYS),
> @@ -73,33 +105,74 @@ static struct map_desc omap2_io_desc[] _
>  		.length		= OMAP243X_SMS_SIZE,
>  		.type		= MT_DEVICE
>  	},
> +};
> +#endif

Can you please split this patch so we can apply the changes for 2420
and 2430 first as a pre-3430 patch? And then a separate patch that
adds the 3430 io.c changes. This way we can send io.c changes upstream
before we send 3430 changes.

> --- linux-omap/arch/arm/mach-omap2/irq.c	2007-01-08 18:55:58.000000000 -0600
> +++ val_3430_GIT/arch/arm/mach-omap2/irq.c	2007-06-12 15:12:08.000000000 -0500
> @@ -37,11 +37,9 @@ static struct omap_irq_bank {
>  } __attribute__ ((aligned(4))) irq_banks[] = {
>  	{
>  		/* MPU INTC */
> -		.base_reg	= IO_ADDRESS(OMAP24XX_IC_BASE),
> +		.base_reg	= 0,
>  		.nr_irqs	= 96,
> -	}, {
> -		/* XXX: DSP INTC */
> -	}
> +	},
>  };
>  
>  /* XXX: FIQ and additional INTC support (only MPU at the moment) */
> @@ -118,10 +116,16 @@ void __init omap_init_irq(void)
>  	for (i = 0; i < ARRAY_SIZE(irq_banks); i++) {
>  		struct omap_irq_bank *bank = irq_banks + i;
>  
> -		/* XXX */
> -		if (!bank->base_reg)
> -			continue;
> -
> +#ifdef CONFIG_ARCH_OMAP24XX
> +		if (cpu_is_omap24xx()) {
> +			bank->base_reg = IO_ADDRESS(OMAP24XX_IC_BASE);
> +		}
> +#endif
> +#ifdef CONFIG_ARCH_OMAP34XX
> +		if (cpu_is_omap34xx()) {
> +			bank->base_reg = IO_ADDRESS(OMAP34XX_IC_BASE);
> +		}
> +#endif
>  		omap_irq_bank_init_one(bank);
>  
>  		nr_irqs += bank->nr_irqs;
> 

You should be able to leave out the ifdefs above, if one of the omaps
is disabled, then it will get optimized out as it will be if (0) {}.
This is assuming the _IC_BASE defines are visible to both, of course.

Tony
