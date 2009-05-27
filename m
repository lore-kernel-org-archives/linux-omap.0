From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/4] ARM: OMAP4: Add minimal support for omap4
Date: Wed, 27 May 2009 16:36:57 -0700
Message-ID: <20090527233655.GG6267@atomide.com>
References: <1242824343-5956-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:51350 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752845AbZE0XhP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 27 May 2009 19:37:15 -0400
Content-Disposition: inline
In-Reply-To: <1242824343-5956-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux@arm.linux.org.uk, linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org

* Santosh Shilimkar <santosh.shilimkar@ti.com> [090520 05:59]:
> This patch adds the support for OMAP4. The platform and machine speci=
fic
> headers and sources updated for OMAP4430 SDP platform.
>=20
> OMAP4430 is Texas Instrument's SOC based on ARM Cortex-A9 SMP archite=
cture.
> It's a dual core SOC with GIC used for interrupt handling and SCU for=
 cache
> coherency.

I've added these to omap for-next branch.

Tony


=20
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  arch/arm/mach-omap2/gpmc.c                    |    6 +
>  arch/arm/mach-omap2/id.c                      |    8 ++-
>  arch/arm/mach-omap2/io.c                      |   52 +++++++++-
>  arch/arm/mach-omap2/serial.c                  |    7 ++
>  arch/arm/mach-omap2/timer-gp.c                |    9 ++-
>  arch/arm/plat-omap/common.c                   |   31 ++++++
>  arch/arm/plat-omap/devices.c                  |    2 +
>  arch/arm/plat-omap/dma.c                      |   23 ++++-
>  arch/arm/plat-omap/dmtimer.c                  |   59 ++++++++++-
>  arch/arm/plat-omap/gpio.c                     |  134 +++++++++++++++=
+++------
>  arch/arm/plat-omap/include/mach/clock.h       |    8 +-
>  arch/arm/plat-omap/include/mach/common.h      |    1 +
>  arch/arm/plat-omap/include/mach/control.h     |    7 +-
>  arch/arm/plat-omap/include/mach/cpu.h         |   21 ++++-
>  arch/arm/plat-omap/include/mach/debug-macro.S |    2 +-
>  arch/arm/plat-omap/include/mach/dma.h         |    1 +
>  arch/arm/plat-omap/include/mach/entry-macro.S |   46 ++++++++-
>  arch/arm/plat-omap/include/mach/hardware.h    |    1 +
>  arch/arm/plat-omap/include/mach/io.h          |   37 +++++++
>  arch/arm/plat-omap/include/mach/irqs.h        |   89 +++++++++++++++=
+
>  arch/arm/plat-omap/include/mach/memory.h      |    3 +-
>  arch/arm/plat-omap/include/mach/omap44xx.h    |   46 +++++++++
>  arch/arm/plat-omap/include/mach/serial.h      |   16 +++-
>  arch/arm/plat-omap/io.c                       |   29 +++++-
>  arch/arm/plat-omap/mux.c                      |    3 +
>  arch/arm/plat-omap/sram.c                     |   21 ++++
>  26 files changed, 600 insertions(+), 62 deletions(-)
>  create mode 100644 arch/arm/plat-omap/include/mach/omap44xx.h
>=20
> diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
> index 2249049..f91934b 100644
> --- a/arch/arm/mach-omap2/gpmc.c
> +++ b/arch/arm/mach-omap2/gpmc.c
> @@ -5,6 +5,9 @@
>   *
>   * Author: Juha Yrjola
>   *
> + * Copyright (C) 2009 Texas Instruments
> + * Added OMAP4 support - Santosh Shilimkar <santosh.shilimkar@ti.com=
>
> + *
>   * This program is free software; you can redistribute it and/or mod=
ify
>   * it under the terms of the GNU General Public License version 2 as
>   * published by the Free Software Foundation.
> @@ -424,6 +427,9 @@ void __init gpmc_init(void)
>  	} else if (cpu_is_omap34xx()) {
>  		ck =3D "gpmc_fck";
>  		l =3D OMAP34XX_GPMC_BASE;
> +	} else if (cpu_is_omap44xx()) {
> +		ck =3D "gpmc_fck";
> +		l =3D OMAP44XX_GPMC_BASE;
>  	}
> =20
>  	gpmc_l3_clk =3D clk_get(NULL, ck);
> diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
> index 34b5914..458990e 100644
> --- a/arch/arm/mach-omap2/id.c
> +++ b/arch/arm/mach-omap2/id.c
> @@ -6,6 +6,9 @@
>   * Copyright (C) 2005 Nokia Corporation
>   * Written by Tony Lindgren <tony@atomide.com>
>   *
> + * Copyright (C) 2009 Texas Instruments
> + * Added OMAP4 support - Santosh Shilimkar <santosh.shilimkar@ti.com=
>
> + *
>   * This program is free software; you can redistribute it and/or mod=
ify
>   * it under the terms of the GNU General Public License version 2 as
>   * published by the Free Software Foundation.
> @@ -200,7 +203,10 @@ void __init omap2_check_revision(void)
>  		omap24xx_check_revision();
>  	else if (cpu_is_omap34xx())
>  		omap34xx_check_revision();
> -	else
> +	else if (cpu_is_omap44xx()) {
> +		printk(KERN_INFO "FIXME: CPU revision =3D OMAP4430\n");
> +		return;
> +	} else
>  		pr_err("OMAP revision unknown, please fix!\n");
> =20
>  	/*
> diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
> index 916fcd3..32afd94 100644
> --- a/arch/arm/mach-omap2/io.c
> +++ b/arch/arm/mach-omap2/io.c
> @@ -4,12 +4,14 @@
>   * OMAP2 I/O mapping code
>   *
>   * Copyright (C) 2005 Nokia Corporation
> - * Copyright (C) 2007 Texas Instruments
> + * Copyright (C) 2007-2009 Texas Instruments
>   *
>   * Author:
>   *	Juha Yrjola <juha.yrjola@nokia.com>
>   *	Syed Khasim <x0khasim@ti.com>
>   *
> + * Added OMAP4 support - Santosh Shilimkar <santosh.shilimkar@ti.com=
>
> + *
>   * This program is free software; you can redistribute it and/or mod=
ify
>   * it under the terms of the GNU General Public License version 2 as
>   * published by the Free Software Foundation.
> @@ -30,6 +32,7 @@
>  #include <mach/sdrc.h>
>  #include <mach/gpmc.h>
> =20
> +#ifndef CONFIG_ARCH_OMAP4	/* FIXME: Remove this once clkdev is ready=
 */
>  #include "clock.h"
> =20
>  #include <mach/powerdomain.h>
> @@ -38,7 +41,7 @@
> =20
>  #include <mach/clockdomain.h>
>  #include "clockdomains.h"
> -
> +#endif
>  /*
>   * The machine specific code may provide the extra mapping besides t=
he
>   * default mapping provided here.
> @@ -166,6 +169,46 @@ static struct map_desc omap34xx_io_desc[] __init=
data =3D {
>  	},
>  };
>  #endif
> +#ifdef	CONFIG_ARCH_OMAP4
> +static struct map_desc omap44xx_io_desc[] __initdata =3D {
> +	{
> +		.virtual	=3D L3_44XX_VIRT,
> +		.pfn		=3D __phys_to_pfn(L3_44XX_PHYS),
> +		.length		=3D L3_44XX_SIZE,
> +		.type		=3D MT_DEVICE,
> +	},
> +	{
> +		.virtual	=3D L4_44XX_VIRT,
> +		.pfn		=3D __phys_to_pfn(L4_44XX_PHYS),
> +		.length		=3D L4_44XX_SIZE,
> +		.type		=3D MT_DEVICE,
> +	},
> +	{
> +		.virtual	=3D L4_WK_44XX_VIRT,
> +		.pfn		=3D __phys_to_pfn(L4_WK_44XX_PHYS),
> +		.length		=3D L4_WK_44XX_SIZE,
> +		.type		=3D MT_DEVICE,
> +	},
> +	{
> +		.virtual	=3D OMAP44XX_GPMC_VIRT,
> +		.pfn		=3D __phys_to_pfn(OMAP44XX_GPMC_PHYS),
> +		.length		=3D OMAP44XX_GPMC_SIZE,
> +		.type		=3D MT_DEVICE,
> +	},
> +	{
> +		.virtual	=3D L4_PER_44XX_VIRT,
> +		.pfn		=3D __phys_to_pfn(L4_PER_44XX_PHYS),
> +		.length		=3D L4_PER_44XX_SIZE,
> +		.type		=3D MT_DEVICE,
> +	},
> +	{
> +		.virtual	=3D L4_EMU_44XX_VIRT,
> +		.pfn		=3D __phys_to_pfn(L4_EMU_44XX_PHYS),
> +		.length		=3D L4_EMU_44XX_SIZE,
> +		.type		=3D MT_DEVICE,
> +	},
> +};
> +#endif
> =20
>  void __init omap2_map_common_io(void)
>  {
> @@ -183,6 +226,9 @@ void __init omap2_map_common_io(void)
>  	iotable_init(omap34xx_io_desc, ARRAY_SIZE(omap34xx_io_desc));
>  #endif
> =20
> +#if defined(CONFIG_ARCH_OMAP4)
> +	iotable_init(omap44xx_io_desc, ARRAY_SIZE(omap44xx_io_desc));
> +#endif
>  	/* Normally devicemaps_init() would flush caches and tlb after
>  	 * mdesc->map_io(), but we must also do it here because of the CPU
>  	 * revision check below.
> @@ -198,9 +244,11 @@ void __init omap2_map_common_io(void)
>  void __init omap2_init_common_hw(struct omap_sdrc_params *sp)
>  {
>  	omap2_mux_init();
> +#ifndef CONFIG_ARCH_OMAP4 /* FIXME: Remove this once the clkdev is r=
eady */
>  	pwrdm_init(powerdomains_omap);
>  	clkdm_init(clockdomains_omap, clkdm_pwrdm_autodeps);
>  	omap2_clk_init();
>  	omap2_sdrc_init(sp);
> +#endif
>  	gpmc_init();
>  }
> diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/seria=
l.c
> index 4dcf39c..5f29a42 100644
> --- a/arch/arm/mach-omap2/serial.c
> +++ b/arch/arm/mach-omap2/serial.c
> @@ -8,6 +8,9 @@
>   *
>   * Based off of arch/arm/mach-omap/omap1/serial.c
>   *
> + * Copyright (C) 2009 Texas Instruments
> + * Added OMAP4 support - Santosh Shilimkar <santosh.shilimkar@ti.com
> + *
>   * This file is subject to the terms and conditions of the GNU Gener=
al Public
>   * License. See the file "COPYING" in the main directory of this arc=
hive
>   * for more details.
> @@ -114,6 +117,10 @@ void __init omap_serial_init(void)
> =20
>  	if (info =3D=3D NULL)
>  		return;
> +	if (cpu_is_omap44xx()) {
> +		for (i =3D 0; i < OMAP_MAX_NR_PORTS; i++)
> +			serial_platform_data[i].irq +=3D 32;
> +	}
> =20
>  	for (i =3D 0; i < OMAP_MAX_NR_PORTS; i++) {
>  		struct plat_serial8250_port *p =3D serial_platform_data + i;
> diff --git a/arch/arm/mach-omap2/timer-gp.c b/arch/arm/mach-omap2/tim=
er-gp.c
> index f36aba1..6cc8fa8 100644
> --- a/arch/arm/mach-omap2/timer-gp.c
> +++ b/arch/arm/mach-omap2/timer-gp.c
> @@ -17,9 +17,10 @@
>   *
>   * Some parts based off of TI's 24xx code:
>   *
> - *   Copyright (C) 2004 Texas Instruments, Inc.
> + * Copyright (C) 2004-2009 Texas Instruments, Inc.
>   *
>   * Roughly modelled after the OMAP1 MPU timer code.
> + * Added OMAP4 support - Santosh Shilimkar <santosh.shilimkar@ti.com=
>
>   *
>   * This file is subject to the terms and conditions of the GNU Gener=
al Public
>   * License. See the file "COPYING" in the main directory of this arc=
hive
> @@ -82,7 +83,8 @@ static void omap2_gp_timer_set_mode(enum clock_even=
t_mode mode,
>  	case CLOCK_EVT_MODE_PERIODIC:
>  		period =3D clk_get_rate(omap_dm_timer_get_fclk(gptimer)) / HZ;
>  		period -=3D 1;
> -
> +		if (cpu_is_omap44xx())
> +			period =3D 0xFF;	/* FIXME: */
>  		omap_dm_timer_set_load_start(gptimer, 1, 0xffffffff - period);
>  		break;
>  	case CLOCK_EVT_MODE_ONESHOT:
> @@ -145,6 +147,9 @@ static void __init omap2_gp_clockevent_init(void)
>  		     "timer-gp: omap_dm_timer_set_source() failed\n");
> =20
>  	tick_rate =3D clk_get_rate(omap_dm_timer_get_fclk(gptimer));
> +	if (cpu_is_omap44xx())
> +		/* Assuming 32kHz clk is driving GPT1 */
> +		tick_rate =3D 32768;	/* FIXME: */
> =20
>  	pr_info("OMAP clockevent source: GPTIMER%d at %u Hz\n",
>  		gptimer_id, tick_rate);
> diff --git a/arch/arm/plat-omap/common.c b/arch/arm/plat-omap/common.=
c
> index 70b68ef..66738c3 100644
> --- a/arch/arm/plat-omap/common.c
> +++ b/arch/arm/plat-omap/common.c
> @@ -2,6 +2,10 @@
>   * linux/arch/arm/plat-omap/common.c
>   *
>   * Code common to all OMAP machines.
> + * The file is created by Tony Lindgren <tony@atomide.com>
> + *
> + * Copyright (C) 2009 Texas Instruments
> + * Added OMAP4 support - Santosh Shilimkar <santosh.shilimkar@ti.com=
>
>   *
>   * This program is free software; you can redistribute it and/or mod=
ify
>   * it under the terms of the GNU General Public License version 2 as
> @@ -217,6 +221,15 @@ static cycle_t omap34xx_32k_read(struct clocksou=
rce *cs)
>  #define omap34xx_32k_read	NULL
>  #endif
> =20
> +#ifdef CONFIG_ARCH_OMAP4
> +static cycle_t omap44xx_32k_read(struct clocksource *cs)
> +{
> +	return omap_readl(OMAP4430_32KSYNCT_BASE + 0x10);
> +}
> +#else
> +#define omap44xx_32k_read	NULL
> +#endif
> +
>  /*
>   * Kernel assumes that sched_clock can be called early but may not h=
ave
>   * things ready yet.
> @@ -264,6 +277,8 @@ static int __init omap_init_clocksource_32k(void)
>  			clocksource_32k.read =3D omap2430_32k_read;
>  		else if (cpu_is_omap34xx())
>  			clocksource_32k.read =3D omap34xx_32k_read;
> +		else if (cpu_is_omap44xx())
> +			clocksource_32k.read =3D omap44xx_32k_read;
>  		else
>  			return -ENODEV;
> =20
> @@ -351,3 +366,19 @@ void __init omap2_set_globals_343x(void)
>  }
>  #endif
> =20
> +#if defined(CONFIG_ARCH_OMAP4)
> +static struct omap_globals omap4_globals =3D {
> +	.class	=3D OMAP443X_CLASS,
> +	.tap	=3D OMAP2_IO_ADDRESS(0x4830a000),
> +	.ctrl	=3D OMAP2_IO_ADDRESS(OMAP443X_CTRL_BASE),
> +	.prm	=3D OMAP2_IO_ADDRESS(OMAP4430_PRM_BASE),
> +	.cm	=3D OMAP2_IO_ADDRESS(OMAP4430_CM_BASE),
> +};
> +
> +void __init omap2_set_globals_443x(void)
> +{
> +	omap2_set_globals_tap(&omap4_globals);
> +	omap2_set_globals_control(&omap4_globals);
> +}
> +#endif
> +
> diff --git a/arch/arm/plat-omap/devices.c b/arch/arm/plat-omap/device=
s.c
> index 87fb7ff..a64b692 100644
> --- a/arch/arm/plat-omap/devices.c
> +++ b/arch/arm/plat-omap/devices.c
> @@ -311,6 +311,8 @@ static void omap_init_wdt(void)
>  		wdt_resources[0].start =3D 0x49016000; /* WDT2 */
>  	else if (cpu_is_omap343x())
>  		wdt_resources[0].start =3D 0x48314000; /* WDT2 */
> +	else if (cpu_is_omap44xx())
> +		wdt_resources[0].start =3D 0x4a314000;
>  	else
>  		return;
> =20
> diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
> index 7fc8c04..a1b88fb 100644
> --- a/arch/arm/plat-omap/dma.c
> +++ b/arch/arm/plat-omap/dma.c
> @@ -10,6 +10,9 @@
>   * Merged to support both OMAP1 and OMAP2 by Tony Lindgren <tony@ato=
mide.com>
>   * Some functions based on earlier dma-omap.c Copyright (C) 2001 Rid=
geRun, Inc.
>   *
> + * Copyright (C) 2009 Texas Instruments
> + * Added OMAP4 support - Santosh Shilimkar <santosh.shilimkar@ti.com=
>
> + *
>   * Support functions for the OMAP internal DMA channels.
>   *
>   * This program is free software; you can redistribute it and/or mod=
ify
> @@ -851,7 +854,7 @@ omap_dma_set_prio_lch(int lch, unsigned char read=
_prio,
>  	}
>  	l =3D dma_read(CCR(lch));
>  	l &=3D ~((1 << 6) | (1 << 26));
> -	if (cpu_is_omap2430() || cpu_is_omap34xx())
> +	if (cpu_is_omap2430() || cpu_is_omap34xx() ||  cpu_is_omap44xx())
>  		l |=3D ((read_prio & 0x1) << 6) | ((write_prio & 0x1) << 26);
>  	else
>  		l |=3D ((read_prio & 0x1) << 6);
> @@ -1823,7 +1826,8 @@ static irqreturn_t omap1_dma_irq_handler(int ir=
q, void *dev_id)
>  #define omap1_dma_irq_handler	NULL
>  #endif
> =20
> -#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
> +#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3) || \
> +			defined(CONFIG_ARCH_OMAP4)
> =20
>  static int omap2_dma_handle_ch(int ch)
>  {
> @@ -2318,6 +2322,9 @@ static int __init omap_init_dma(void)
>  	} else if (cpu_is_omap34xx()) {
>  		omap_dma_base =3D IO_ADDRESS(OMAP34XX_DMA4_BASE);
>  		dma_lch_count =3D OMAP_DMA4_LOGICAL_DMA_CH_COUNT;
> +	} else if (cpu_is_omap44xx()) {
> +		omap_dma_base =3D IO_ADDRESS(OMAP44XX_DMA4_BASE);
> +		dma_lch_count =3D OMAP_DMA4_LOGICAL_DMA_CH_COUNT;
>  	} else {
>  		pr_err("DMA init failed for unsupported omap\n");
>  		return -ENODEV;
> @@ -2416,12 +2423,18 @@ static int __init omap_init_dma(void)
>  		}
>  	}
> =20
> -	if (cpu_is_omap2430() || cpu_is_omap34xx())
> +	if (cpu_is_omap2430() || cpu_is_omap34xx() || cpu_is_omap44xx())
>  		omap_dma_set_global_params(DMA_DEFAULT_ARB_RATE,
>  				DMA_DEFAULT_FIFO_DEPTH, 0);
> =20
> -	if (cpu_class_is_omap2())
> -		setup_irq(INT_24XX_SDMA_IRQ0, &omap24xx_dma_irq);
> +	if (cpu_class_is_omap2()) {
> +		int irq;
> +		if (cpu_is_omap44xx())
> +			irq =3D INT_44XX_SDMA_IRQ0;
> +		else
> +			irq =3D INT_24XX_SDMA_IRQ0;
> +		setup_irq(irq, &omap24xx_dma_irq);
> +	}
> =20
>  	/* FIXME: Update LCD DMA to work on 24xx */
>  	if (cpu_class_is_omap1()) {
> diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtime=
r.c
> index ee20612..7f50b61 100644
> --- a/arch/arm/plat-omap/dmtimer.c
> +++ b/arch/arm/plat-omap/dmtimer.c
> @@ -7,6 +7,9 @@
>   * OMAP2 support by Juha Yrjola
>   * API improvements and OMAP2 clock framework support by Timo Teras
>   *
> + * Copyright (C) 2009 Texas Instruments
> + * Added OMAP4 support - Santosh Shilimkar <santosh.shilimkar@ti.com=
>
> + *
>   * This program is free software; you can redistribute it and/or mod=
ify it
>   * under the terms of the GNU General Public License as published by=
 the
>   * Free Software Foundation; either version 2 of the License, or (at=
 your
> @@ -150,7 +153,8 @@
>  struct omap_dm_timer {
>  	unsigned long phys_base;
>  	int irq;
> -#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
> +#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3) || \
> +			defined(CONFIG_ARCH_OMAP4)
>  	struct clk *iclk, *fclk;
>  #endif
>  	void __iomem *io_base;
> @@ -169,6 +173,9 @@ struct omap_dm_timer {
>  #define omap3_dm_timers			NULL
>  #define omap3_dm_source_names		NULL
>  #define omap3_dm_source_clocks		NULL
> +#define omap4_dm_timers			NULL
> +#define omap4_dm_source_names		NULL
> +#define omap4_dm_source_clocks		NULL
> =20
>  static struct omap_dm_timer omap1_dm_timers[] =3D {
>  	{ .phys_base =3D 0xfffb1400, .irq =3D INT_1610_GPTIMER1 },
> @@ -191,6 +198,9 @@ static const int dm_timer_count =3D ARRAY_SIZE(om=
ap1_dm_timers);
>  #define omap3_dm_timers			NULL
>  #define omap3_dm_source_names		NULL
>  #define omap3_dm_source_clocks		NULL
> +#define omap4_dm_timers			NULL
> +#define omap4_dm_source_names		NULL
> +#define omap4_dm_source_clocks		NULL
> =20
>  static struct omap_dm_timer omap2_dm_timers[] =3D {
>  	{ .phys_base =3D 0x48028000, .irq =3D INT_24XX_GPTIMER1 },
> @@ -225,6 +235,9 @@ static const int dm_timer_count =3D ARRAY_SIZE(om=
ap2_dm_timers);
>  #define omap2_dm_timers			NULL
>  #define omap2_dm_source_names		NULL
>  #define omap2_dm_source_clocks		NULL
> +#define omap4_dm_timers			NULL
> +#define omap4_dm_source_names		NULL
> +#define omap4_dm_source_clocks		NULL
> =20
>  static struct omap_dm_timer omap3_dm_timers[] =3D {
>  	{ .phys_base =3D 0x48318000, .irq =3D INT_24XX_GPTIMER1 },
> @@ -250,6 +263,40 @@ static const char *omap3_dm_source_names[] __ini=
tdata =3D {
>  static struct clk *omap3_dm_source_clocks[2];
>  static const int dm_timer_count =3D ARRAY_SIZE(omap3_dm_timers);
> =20
> +#elif defined(CONFIG_ARCH_OMAP4)
> +
> +#define omap_dm_clk_enable(x)		clk_enable(x)
> +#define omap_dm_clk_disable(x)		clk_disable(x)
> +#define omap1_dm_timers			NULL
> +#define omap2_dm_timers			NULL
> +#define omap2_dm_source_names		NULL
> +#define omap2_dm_source_clocks		NULL
> +#define omap3_dm_timers			NULL
> +#define omap3_dm_source_names		NULL
> +#define omap3_dm_source_clocks		NULL
> +
> +static struct omap_dm_timer omap4_dm_timers[] =3D {
> +	{ .phys_base =3D 0x4a318000, .irq =3D INT_44XX_GPTIMER1 },
> +	{ .phys_base =3D 0x48032000, .irq =3D INT_44XX_GPTIMER2 },
> +	{ .phys_base =3D 0x48034000, .irq =3D INT_44XX_GPTIMER3 },
> +	{ .phys_base =3D 0x48036000, .irq =3D INT_44XX_GPTIMER4 },
> +	{ .phys_base =3D 0x40138000, .irq =3D INT_44XX_GPTIMER5 },
> +	{ .phys_base =3D 0x4013a000, .irq =3D INT_44XX_GPTIMER6 },
> +	{ .phys_base =3D 0x4013a000, .irq =3D INT_44XX_GPTIMER7 },
> +	{ .phys_base =3D 0x4013e000, .irq =3D INT_44XX_GPTIMER8 },
> +	{ .phys_base =3D 0x4803e000, .irq =3D INT_44XX_GPTIMER9 },
> +	{ .phys_base =3D 0x48086000, .irq =3D INT_44XX_GPTIMER10 },
> +	{ .phys_base =3D 0x48088000, .irq =3D INT_44XX_GPTIMER11 },
> +	{ .phys_base =3D 0x4a320000, .irq =3D INT_44XX_GPTIMER12 },
> +};
> +static const char *omap4_dm_source_names[] __initdata =3D {
> +	"sys_ck",
> +	"omap_32k_fck",
> +	NULL
> +};
> +static struct clk *omap4_dm_source_clocks[2];
> +static const int dm_timer_count =3D ARRAY_SIZE(omap4_dm_timers);
> +
>  #else
> =20
>  #error OMAP architecture not supported!
> @@ -459,7 +506,8 @@ __u32 omap_dm_timer_modify_idlect_mask(__u32 inpu=
tmask)
>  }
>  EXPORT_SYMBOL_GPL(omap_dm_timer_modify_idlect_mask);
> =20
> -#elif defined(CONFIG_ARCH_OMAP2) || defined (CONFIG_ARCH_OMAP3)
> +#elif defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3) || \
> +				defined(CONFIG_ARCH_OMAP4)
> =20
>  struct clk *omap_dm_timer_get_fclk(struct omap_dm_timer *timer)
>  {
> @@ -711,6 +759,10 @@ int __init omap_dm_timer_init(void)
>  		dm_timers =3D omap3_dm_timers;
>  		dm_source_names =3D omap3_dm_source_names;
>  		dm_source_clocks =3D omap3_dm_source_clocks;
> +	} else if (cpu_is_omap44xx()) {
> +		dm_timers =3D omap4_dm_timers;
> +		dm_source_names =3D omap4_dm_source_names;
> +		dm_source_clocks =3D omap4_dm_source_clocks;
>  	}
> =20
>  	if (cpu_class_is_omap2())
> @@ -723,7 +775,8 @@ int __init omap_dm_timer_init(void)
>  	for (i =3D 0; i < dm_timer_count; i++) {
>  		timer =3D &dm_timers[i];
>  		timer->io_base =3D IO_ADDRESS(timer->phys_base);
> -#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
> +#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3) || \
> +					defined(CONFIG_ARCH_OMAP4)
>  		if (cpu_class_is_omap2()) {
>  			char clk_name[16];
>  			sprintf(clk_name, "gpt%d_ick", i + 1);
> diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
> index 17d7afe..19c2488 100644
> --- a/arch/arm/plat-omap/gpio.c
> +++ b/arch/arm/plat-omap/gpio.c
> @@ -6,6 +6,9 @@
>   * Copyright (C) 2003-2005 Nokia Corporation
>   * Written by Juha Yrj=C3=B6l=C3=A4 <juha.yrjola@nokia.com>
>   *
> + * Copyright (C) 2009 Texas Instruments
> + * Added OMAP4 support - Santosh Shilimkar <santosh.shilimkar@ti.com=
>
> + *
>   * This program is free software; you can redistribute it and/or mod=
ify
>   * it under the terms of the GNU General Public License version 2 as
>   * published by the Free Software Foundation.
> @@ -146,6 +149,16 @@
>  #define OMAP34XX_GPIO5_BASE		IO_ADDRESS(0x49056000)
>  #define OMAP34XX_GPIO6_BASE		IO_ADDRESS(0x49058000)
> =20
> +/*
> + * OMAP44XX  specific GPIO registers
> + */
> +#define OMAP44XX_GPIO1_BASE             IO_ADDRESS(0x4a310000)
> +#define OMAP44XX_GPIO2_BASE             IO_ADDRESS(0x48055000)
> +#define OMAP44XX_GPIO3_BASE             IO_ADDRESS(0x48057000)
> +#define OMAP44XX_GPIO4_BASE             IO_ADDRESS(0x48059000)
> +#define OMAP44XX_GPIO5_BASE             IO_ADDRESS(0x4805B000)
> +#define OMAP44XX_GPIO6_BASE             IO_ADDRESS(0x4805D000)
> +
>  #define OMAP_MPUIO_VBASE		IO_ADDRESS(OMAP_MPUIO_BASE)
> =20
>  struct gpio_bank {
> @@ -153,11 +166,13 @@ struct gpio_bank {
>  	u16 irq;
>  	u16 virtual_irq_start;
>  	int method;
> -#if defined(CONFIG_ARCH_OMAP16XX) || defined(CONFIG_ARCH_OMAP24XX) |=
| defined(CONFIG_ARCH_OMAP34XX)
> +#if defined(CONFIG_ARCH_OMAP16XX) || defined(CONFIG_ARCH_OMAP24XX) |=
|  \
> +		defined(CONFIG_ARCH_OMAP34XX) || defined(CONFIG_ARCH_OMAP4)
>  	u32 suspend_wakeup;
>  	u32 saved_wakeup;
>  #endif
> -#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
> +#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX) |=
| \
> +			defined(CONFIG_ARCH_OMAP4)
>  	u32 non_wakeup_gpios;
>  	u32 enabled_non_wakeup_gpios;
> =20
> @@ -251,6 +266,24 @@ static struct gpio_bank gpio_bank_34xx[6] =3D {
> =20
>  #endif
> =20
> +#ifdef CONFIG_ARCH_OMAP4
> +static struct gpio_bank gpio_bank_44xx[6] =3D {
> +	{ OMAP44XX_GPIO1_BASE, INT_44XX_GPIO_BANK1, IH_GPIO_BASE,	\
> +		METHOD_GPIO_24XX },
> +	{ OMAP44XX_GPIO2_BASE, INT_44XX_GPIO_BANK2, IH_GPIO_BASE + 32,	\
> +		METHOD_GPIO_24XX },
> +	{ OMAP44XX_GPIO3_BASE, INT_44XX_GPIO_BANK3, IH_GPIO_BASE + 64,	\
> +		METHOD_GPIO_24XX },
> +	{ OMAP44XX_GPIO4_BASE, INT_44XX_GPIO_BANK4, IH_GPIO_BASE + 96,	\
> +		METHOD_GPIO_24XX },
> +	{ OMAP44XX_GPIO5_BASE, INT_44XX_GPIO_BANK5, IH_GPIO_BASE + 128, \
> +		METHOD_GPIO_24XX },
> +	{ OMAP44XX_GPIO6_BASE, INT_44XX_GPIO_BANK6, IH_GPIO_BASE + 160, \
> +		METHOD_GPIO_24XX },
> +};
> +
> +#endif
> +
>  static struct gpio_bank *gpio_bank;
>  static int gpio_bank_count;
> =20
> @@ -273,7 +306,7 @@ static inline struct gpio_bank *get_gpio_bank(int=
 gpio)
>  	}
>  	if (cpu_is_omap24xx())
>  		return &gpio_bank[gpio >> 5];
> -	if (cpu_is_omap34xx())
> +	if (cpu_is_omap34xx() || cpu_is_omap44xx())
>  		return &gpio_bank[gpio >> 5];
>  	BUG();
>  	return NULL;
> @@ -285,7 +318,7 @@ static inline int get_gpio_index(int gpio)
>  		return gpio & 0x1f;
>  	if (cpu_is_omap24xx())
>  		return gpio & 0x1f;
> -	if (cpu_is_omap34xx())
> +	if (cpu_is_omap34xx() || cpu_is_omap44xx())
>  		return gpio & 0x1f;
>  	return gpio & 0x0f;
>  }
> @@ -307,7 +340,7 @@ static inline int gpio_valid(int gpio)
>  		return 0;
>  	if (cpu_is_omap24xx() && gpio < 128)
>  		return 0;
> -	if (cpu_is_omap34xx() && gpio < 160)
> +	if ((cpu_is_omap34xx() || cpu_is_omap44xx()) && gpio < 160)
>  		return 0;
>  	return -1;
>  }
> @@ -353,7 +386,8 @@ static void _set_gpio_direction(struct gpio_bank =
*bank, int gpio, int is_input)
>  		reg +=3D OMAP850_GPIO_DIR_CONTROL;
>  		break;
>  #endif
> -#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
> +#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX) |=
| \
> +			defined(CONFIG_ARCH_OMAP4)
>  	case METHOD_GPIO_24XX:
>  		reg +=3D OMAP24XX_GPIO_OE;
>  		break;
> @@ -425,7 +459,8 @@ static void _set_gpio_dataout(struct gpio_bank *b=
ank, int gpio, int enable)
>  			l &=3D ~(1 << gpio);
>  		break;
>  #endif
> -#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
> +#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX) |=
| \
> +			defined(CONFIG_ARCH_OMAP4)
>  	case METHOD_GPIO_24XX:
>  		if (enable)
>  			reg +=3D OMAP24XX_GPIO_SETDATAOUT;
> @@ -476,7 +511,8 @@ static int __omap_get_gpio_datain(int gpio)
>  		reg +=3D OMAP850_GPIO_DATA_INPUT;
>  		break;
>  #endif
> -#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
> +#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX) |=
| \
> +			defined(CONFIG_ARCH_OMAP4)
>  	case METHOD_GPIO_24XX:
>  		reg +=3D OMAP24XX_GPIO_DATAIN;
>  		break;
> @@ -520,7 +556,7 @@ void omap_set_gpio_debounce(int gpio, int enable)
>  	else
>  		goto done;
> =20
> -	if (cpu_is_omap34xx()) {
> +	if (cpu_is_omap34xx() || cpu_is_omap44xx()) {
>  		if (enable)
>  			clk_enable(bank->dbck);
>  		else
> @@ -550,7 +586,8 @@ void omap_set_gpio_debounce_time(int gpio, int en=
c_time)
>  }
>  EXPORT_SYMBOL(omap_set_gpio_debounce_time);
> =20
> -#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
> +#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX) |=
| \
> +				defined(CONFIG_ARCH_OMAP4)
>  static inline void set_24xx_gpio_triggering(struct gpio_bank *bank, =
int gpio,
>  						int trigger)
>  {
> @@ -660,7 +697,8 @@ static int _set_gpio_triggering(struct gpio_bank =
*bank, int gpio, int trigger)
>  			goto bad;
>  		break;
>  #endif
> -#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
> +#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX) |=
| \
> +				defined(CONFIG_ARCH_OMAP4)
>  	case METHOD_GPIO_24XX:
>  		set_24xx_gpio_triggering(bank, gpio, trigger);
>  		break;
> @@ -745,7 +783,8 @@ static void _clear_gpio_irqbank(struct gpio_bank =
*bank, int gpio_mask)
>  		reg +=3D OMAP850_GPIO_INT_STATUS;
>  		break;
>  #endif
> -#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
> +#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX) |=
| \
> +				defined(CONFIG_ARCH_OMAP4)
>  	case METHOD_GPIO_24XX:
>  		reg +=3D OMAP24XX_GPIO_IRQSTATUS1;
>  		break;
> @@ -814,7 +853,8 @@ static u32 _get_gpio_irqbank_mask(struct gpio_ban=
k *bank)
>  		inv =3D 1;
>  		break;
>  #endif
> -#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
> +#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX) |=
| \
> +				defined(CONFIG_ARCH_OMAP4)
>  	case METHOD_GPIO_24XX:
>  		reg +=3D OMAP24XX_GPIO_IRQENABLE1;
>  		mask =3D 0xffffffff;
> @@ -887,7 +927,8 @@ static void _enable_gpio_irqbank(struct gpio_bank=
 *bank, int gpio_mask, int enab
>  			l |=3D gpio_mask;
>  		break;
>  #endif
> -#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
> +#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX) |=
| \
> +		defined(CONFIG_ARCH_OMAP4)
>  	case METHOD_GPIO_24XX:
>  		if (enable)
>  			reg +=3D OMAP24XX_GPIO_SETIRQENABLE1;
> @@ -932,7 +973,8 @@ static int _set_gpio_wakeup(struct gpio_bank *ban=
k, int gpio, int enable)
>  		spin_unlock_irqrestore(&bank->lock, flags);
>  		return 0;
>  #endif
> -#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
> +#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX) |=
| \
> +				defined(CONFIG_ARCH_OMAP4)
>  	case METHOD_GPIO_24XX:
>  		if (bank->non_wakeup_gpios & (1 << gpio)) {
>  			printk(KERN_ERR "Unable to modify wakeup on "
> @@ -1017,7 +1059,8 @@ static void omap_gpio_free(struct gpio_chip *ch=
ip, unsigned offset)
>  		__raw_writel(1 << offset, reg);
>  	}
>  #endif
> -#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
> +#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX) |=
| \
> +				defined(CONFIG_ARCH_OMAP4)
>  	if (bank->method =3D=3D METHOD_GPIO_24XX) {
>  		/* Disable wake-up during idle for dynamic tick */
>  		void __iomem *reg =3D bank->base + OMAP24XX_GPIO_CLEARWKUENA;
> @@ -1069,7 +1112,8 @@ static void gpio_irq_handler(unsigned int irq, =
struct irq_desc *desc)
>  	if (bank->method =3D=3D METHOD_GPIO_850)
>  		isr_reg =3D bank->base + OMAP850_GPIO_INT_STATUS;
>  #endif
> -#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
> +#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX) |=
| \
> +				defined(CONFIG_ARCH_OMAP4)
>  	if (bank->method =3D=3D METHOD_GPIO_24XX)
>  		isr_reg =3D bank->base + OMAP24XX_GPIO_IRQSTATUS1;
>  #endif
> @@ -1346,7 +1390,7 @@ static int gpio_2irq(struct gpio_chip *chip, un=
signed offset)
>  /*------------------------------------------------------------------=
---*/
> =20
>  static int initialized;
> -#if !defined(CONFIG_ARCH_OMAP3)
> +#if !(defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_ARCH_OMAP4))
>  static struct clk * gpio_ick;
>  #endif
> =20
> @@ -1359,7 +1403,7 @@ static struct clk * gpio5_ick;
>  static struct clk * gpio5_fck;
>  #endif
> =20
> -#if defined(CONFIG_ARCH_OMAP3)
> +#if defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_ARCH_OMAP4)
>  static struct clk *gpio_iclks[OMAP34XX_NR_GPIOS];
>  #endif
> =20
> @@ -1419,8 +1463,8 @@ static int __init _omap_gpio_init(void)
>  	}
>  #endif
> =20
> -#if defined(CONFIG_ARCH_OMAP3)
> -	if (cpu_is_omap34xx()) {
> +#if defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_ARCH_OMAP4)
> +	if (cpu_is_omap34xx() || cpu_is_omap44xx()) {
>  		for (i =3D 0; i < OMAP34XX_NR_GPIOS; i++) {
>  			sprintf(clk_name, "gpio%d_ick", i + 1);
>  			gpio_iclks[i] =3D clk_get(NULL, clk_name);
> @@ -1497,6 +1541,17 @@ static int __init _omap_gpio_init(void)
>  			(rev >> 4) & 0x0f, rev & 0x0f);
>  	}
>  #endif
> +#ifdef CONFIG_ARCH_OMAP4
> +	if (cpu_is_omap44xx()) {
> +		int rev;
> +
> +		gpio_bank_count =3D OMAP34XX_NR_GPIOS;
> +		gpio_bank =3D gpio_bank_44xx;
> +		rev =3D __raw_readl(gpio_bank[0].base + OMAP24XX_GPIO_REVISION);
> +		printk(KERN_INFO "OMAP44xx GPIO hardware version %d.%d\n",
> +			(rev >> 4) & 0x0f, rev & 0x0f);
> +	}
> +#endif
>  	for (i =3D 0; i < gpio_bank_count; i++) {
>  		int j, gpio_count =3D 16;
> =20
> @@ -1520,7 +1575,8 @@ static int __init _omap_gpio_init(void)
>  			gpio_count =3D 32; /* 730 has 32-bit GPIOs */
>  		}
> =20
> -#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
> +#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX) |=
| \
> +				defined(CONFIG_ARCH_OMAP4)
>  		if (bank->method =3D=3D METHOD_GPIO_24XX) {
>  			static const u32 non_wakeup_gpios[] =3D {
>  				0xe203ffc0, 0x08700040
> @@ -1577,7 +1633,7 @@ static int __init _omap_gpio_init(void)
>  		set_irq_chained_handler(bank->irq, gpio_irq_handler);
>  		set_irq_data(bank->irq, bank);
> =20
> -		if (cpu_is_omap34xx()) {
> +		if (cpu_is_omap34xx() || cpu_is_omap44xx()) {
>  			sprintf(clk_name, "gpio%d_dbck", i + 1);
>  			bank->dbck =3D clk_get(NULL, clk_name);
>  			if (IS_ERR(bank->dbck))
> @@ -1599,7 +1655,8 @@ static int __init _omap_gpio_init(void)
>  	return 0;
>  }
> =20
> -#if defined(CONFIG_ARCH_OMAP16XX) || defined(CONFIG_ARCH_OMAP24XX) |=
| defined(CONFIG_ARCH_OMAP34XX)
> +#if defined(CONFIG_ARCH_OMAP16XX) || defined(CONFIG_ARCH_OMAP24XX) |=
| \
> +		defined(CONFIG_ARCH_OMAP34XX) || defined(CONFIG_ARCH_OMAP4)
>  static int omap_gpio_suspend(struct sys_device *dev, pm_message_t me=
sg)
>  {
>  	int i;
> @@ -1622,7 +1679,8 @@ static int omap_gpio_suspend(struct sys_device =
*dev, pm_message_t mesg)
>  			wake_set =3D bank->base + OMAP1610_GPIO_SET_WAKEUPENA;
>  			break;
>  #endif
> -#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
> +#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX) |=
| \
> +				defined(CONFIG_ARCH_OMAP4)
>  		case METHOD_GPIO_24XX:
>  			wake_status =3D bank->base + OMAP24XX_GPIO_WAKE_EN;
>  			wake_clear =3D bank->base + OMAP24XX_GPIO_CLEARWKUENA;
> @@ -1663,7 +1721,8 @@ static int omap_gpio_resume(struct sys_device *=
dev)
>  			wake_set =3D bank->base + OMAP1610_GPIO_SET_WAKEUPENA;
>  			break;
>  #endif
> -#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
> +#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX) |=
| \
> +			defined(CONFIG_ARCH_OMAP4)
>  		case METHOD_GPIO_24XX:
>  			wake_clear =3D bank->base + OMAP24XX_GPIO_CLEARWKUENA;
>  			wake_set =3D bank->base + OMAP24XX_GPIO_SETWKUENA;
> @@ -1695,7 +1754,8 @@ static struct sys_device omap_gpio_device =3D {
> =20
>  #endif
> =20
> -#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
> +#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX) |=
| \
> +				defined(CONFIG_ARCH_OMAP4)
> =20
>  static int workaround_enabled;
> =20
> @@ -1711,7 +1771,8 @@ void omap2_gpio_prepare_for_retention(void)
> =20
>  		if (!(bank->enabled_non_wakeup_gpios))
>  			continue;
> -#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
> +#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX) |=
| \
> +				defined(CONFIG_ARCH_OMAP4)
>  		bank->saved_datain =3D __raw_readl(bank->base + OMAP24XX_GPIO_DATA=
IN);
>  		l1 =3D __raw_readl(bank->base + OMAP24XX_GPIO_FALLINGDETECT);
>  		l2 =3D __raw_readl(bank->base + OMAP24XX_GPIO_RISINGDETECT);
> @@ -1720,7 +1781,8 @@ void omap2_gpio_prepare_for_retention(void)
>  		bank->saved_risingdetect =3D l2;
>  		l1 &=3D ~bank->enabled_non_wakeup_gpios;
>  		l2 &=3D ~bank->enabled_non_wakeup_gpios;
> -#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
> +#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX) |=
| \
> +			defined(CONFIG_ARCH_OMAP4)
>  		__raw_writel(l1, bank->base + OMAP24XX_GPIO_FALLINGDETECT);
>  		__raw_writel(l2, bank->base + OMAP24XX_GPIO_RISINGDETECT);
>  #endif
> @@ -1745,7 +1807,8 @@ void omap2_gpio_resume_after_retention(void)
> =20
>  		if (!(bank->enabled_non_wakeup_gpios))
>  			continue;
> -#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
> +#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX) |=
| \
> +			defined(CONFIG_ARCH_OMAP4)
>  		__raw_writel(bank->saved_fallingdetect,
>  				 bank->base + OMAP24XX_GPIO_FALLINGDETECT);
>  		__raw_writel(bank->saved_risingdetect,
> @@ -1755,14 +1818,16 @@ void omap2_gpio_resume_after_retention(void)
>  		 * state.  If so, generate an IRQ by software.  This is
>  		 * horribly racy, but it's the best we can do to work around
>  		 * this silicon bug. */
> -#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
> +#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX) |=
| \
> +			defined(CONFIG_ARCH_OMAP4)
>  		l =3D __raw_readl(bank->base + OMAP24XX_GPIO_DATAIN);
>  #endif
>  		l ^=3D bank->saved_datain;
>  		l &=3D bank->non_wakeup_gpios;
>  		if (l) {
>  			u32 old0, old1;
> -#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
> +#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX) |=
| \
> +			defined(CONFIG_ARCH_OMAP4)
>  			old0 =3D __raw_readl(bank->base + OMAP24XX_GPIO_LEVELDETECT0);
>  			old1 =3D __raw_readl(bank->base + OMAP24XX_GPIO_LEVELDETECT1);
>  			__raw_writel(old0 | l, bank->base + OMAP24XX_GPIO_LEVELDETECT0);
> @@ -1798,7 +1863,8 @@ static int __init omap_gpio_sysinit(void)
> =20
>  	mpuio_init();
> =20
> -#if defined(CONFIG_ARCH_OMAP16XX) || defined(CONFIG_ARCH_OMAP24XX) |=
| defined(CONFIG_ARCH_OMAP34XX)
> +#if defined(CONFIG_ARCH_OMAP16XX) || defined(CONFIG_ARCH_OMAP24XX) |=
| \
> +		defined(CONFIG_ARCH_OMAP34XX) || defined(CONFIG_ARCH_OMAP4)
>  	if (cpu_is_omap16xx() || cpu_class_is_omap2()) {
>  		if (ret =3D=3D 0) {
>  			ret =3D sysdev_class_register(&omap_gpio_sysclass);
> @@ -1887,7 +1953,7 @@ static int dbg_gpio_show(struct seq_file *s, vo=
id *unused)
> =20
>  			irqstat =3D irq_desc[irq].status;
>  #if defined(CONFIG_ARCH_OMAP16XX) || defined(CONFIG_ARCH_OMAP24XX) |=
|	\
> -		defined(CONFIG_ARCH_OMAP34XX)
> +		defined(CONFIG_ARCH_OMAP34XX) || defined(CONFIG_ARCH_OMAP4)
>  			if (is_in && ((bank->suspend_wakeup & mask)
>  					|| irqstat & IRQ_TYPE_SENSE_MASK)) {
>  				char	*trigger =3D NULL;
> diff --git a/arch/arm/plat-omap/include/mach/clock.h b/arch/arm/plat-=
omap/include/mach/clock.h
> index 073a2c5..c20e02e 100644
> --- a/arch/arm/plat-omap/include/mach/clock.h
> +++ b/arch/arm/plat-omap/include/mach/clock.h
> @@ -22,7 +22,8 @@ struct clkops {
>  	void			(*disable)(struct clk *);
>  };
> =20
> -#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
> +#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3) || \
> +		defined(CONFIG_ARCH_OMAP4)
> =20
>  struct clksel_rate {
>  	u32			val;
> @@ -51,7 +52,7 @@ struct dpll_data {
>  	u8			max_divider;
>  	u32			max_tolerance;
>  	u16			max_multiplier;
> -#  if defined(CONFIG_ARCH_OMAP3)
> +#if defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_ARCH_OMAP4)
>  	u8			modes;
>  	void __iomem		*autoidle_reg;
>  	void __iomem		*idlest_reg;
> @@ -83,7 +84,8 @@ struct clk {
>  	void			(*init)(struct clk *);
>  	__u8			enable_bit;
>  	__s8			usecount;
> -#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
> +#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3) || \
> +		defined(CONFIG_ARCH_OMAP4)
>  	u8			fixed_div;
>  	void __iomem		*clksel_reg;
>  	u32			clksel_mask;
> diff --git a/arch/arm/plat-omap/include/mach/common.h b/arch/arm/plat=
-omap/include/mach/common.h
> index 0ecf36d..4b18833 100644
> --- a/arch/arm/plat-omap/include/mach/common.h
> +++ b/arch/arm/plat-omap/include/mach/common.h
> @@ -62,6 +62,7 @@ struct omap_globals {
>  void omap2_set_globals_242x(void);
>  void omap2_set_globals_243x(void);
>  void omap2_set_globals_343x(void);
> +void omap2_set_globals_443x(void);
> =20
>  /* These get called from omap2_set_globals_xxxx(), do not call these=
 */
>  void omap2_set_globals_tap(struct omap_globals *);
> diff --git a/arch/arm/plat-omap/include/mach/control.h b/arch/arm/pla=
t-omap/include/mach/control.h
> index 269147f..f45ec62 100644
> --- a/arch/arm/plat-omap/include/mach/control.h
> +++ b/arch/arm/plat-omap/include/mach/control.h
> @@ -1,9 +1,9 @@
>  /*
>   * arch/arm/plat-omap/include/mach/control.h
>   *
> - * OMAP2/3 System Control Module definitions
> + * OMAP2/3/4 System Control Module definitions
>   *
> - * Copyright (C) 2007-2008 Texas Instruments, Inc.
> + * Copyright (C) 2007-2009 Texas Instruments, Inc.
>   * Copyright (C) 2007-2008 Nokia Corporation
>   *
>   * Written by Paul Walmsley
> @@ -190,7 +190,8 @@
>  #define OMAP2_PBIASLITEVMODE0		(1 << 0)
> =20
>  #ifndef __ASSEMBLY__
> -#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
> +#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3) || \
> +		defined(CONFIG_ARCH_OMAP4)
>  extern void __iomem *omap_ctrl_base_get(void);
>  extern u8 omap_ctrl_readb(u16 offset);
>  extern u16 omap_ctrl_readw(u16 offset);
> diff --git a/arch/arm/plat-omap/include/mach/cpu.h b/arch/arm/plat-om=
ap/include/mach/cpu.h
> index 98b1442..fc60c4e 100644
> --- a/arch/arm/plat-omap/include/mach/cpu.h
> +++ b/arch/arm/plat-omap/include/mach/cpu.h
> @@ -5,8 +5,12 @@
>   *
>   * Copyright (C) 2004, 2008 Nokia Corporation
>   *
> + * Copyright (C) 2009 Texas Instruments.
> + *
>   * Written by Tony Lindgren <tony.lindgren@nokia.com>
>   *
> + * Added OMAP4 specific defines - Santosh Shilimkar<santosh.shilimka=
r@ti.com>
> + *
>   * This program is free software; you can redistribute it and/or mod=
ify
>   * it under the terms of the GNU General Public License as published=
 by
>   * the Free Software Foundation; either version 2 of the License, or
> @@ -155,6 +159,8 @@ IS_OMAP_SUBCLASS(343x, 0x343)
>  #define cpu_is_omap243x()		0
>  #define cpu_is_omap34xx()		0
>  #define cpu_is_omap343x()		0
> +#define cpu_is_omap44xx()		0
> +#define cpu_is_omap443x()		0
> =20
>  #if defined(MULTI_OMAP1)
>  # if defined(CONFIG_ARCH_OMAP730)
> @@ -348,12 +354,21 @@ IS_OMAP_TYPE(3430, 0x3430)
>  # define cpu_is_omap3430()		is_omap3430()
>  #endif
> =20
> +# if defined(CONFIG_ARCH_OMAP4)
> +# undef cpu_is_omap44xx
> +# undef cpu_is_omap443x
> +# define cpu_is_omap44xx()		1
> +# define cpu_is_omap443x()		1
> +# endif
> +
>  /* Macros to detect if we have OMAP1 or OMAP2 */
>  #define cpu_class_is_omap1()	(cpu_is_omap7xx() || cpu_is_omap15xx() =
|| \
>  				cpu_is_omap16xx())
> -#define cpu_class_is_omap2()	(cpu_is_omap24xx() || cpu_is_omap34xx()=
)
> +#define cpu_class_is_omap2()	(cpu_is_omap24xx() || cpu_is_omap34xx()=
 || \
> +				cpu_is_omap44xx())
> =20
> -#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
> +#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3) || \
> +			defined(CONFIG_ARCH_OMAP4)
> =20
>  /* Various silicon revisions for omap2 */
>  #define OMAP242X_CLASS		0x24200024
> @@ -370,6 +385,8 @@ IS_OMAP_TYPE(3430, 0x3430)
>  #define OMAP3430_REV_ES3_0	0x34303034
>  #define OMAP3430_REV_ES3_1	0x34304034
> =20
> +#define OMAP443X_CLASS		0x44300034
> +
>  /*
>   * omap_chip bits
>   *
> diff --git a/arch/arm/plat-omap/include/mach/debug-macro.S b/arch/arm=
/plat-omap/include/mach/debug-macro.S
> index 1b11f5c..ac24050 100644
> --- a/arch/arm/plat-omap/include/mach/debug-macro.S
> +++ b/arch/arm/plat-omap/include/mach/debug-macro.S
> @@ -36,7 +36,7 @@
>  		add	\rx, \rx, #0x00004000	@ UART 3
>  #endif
> =20
> -#elif	CONFIG_ARCH_OMAP3
> +#elif defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_ARCH_OMAP4)
>  		moveq	\rx, #0x48000000	@ physical base address
>  		movne	\rx, #0xd8000000	@ virtual base
>  		orr	\rx, \rx, #0x0006a000
> diff --git a/arch/arm/plat-omap/include/mach/dma.h b/arch/arm/plat-om=
ap/include/mach/dma.h
> index 54fe966..8e05b6a 100644
> --- a/arch/arm/plat-omap/include/mach/dma.h
> +++ b/arch/arm/plat-omap/include/mach/dma.h
> @@ -48,6 +48,7 @@
>  /* Hardware registers for omap2 and omap3 */
>  #define OMAP24XX_DMA4_BASE		(L4_24XX_BASE + 0x56000)
>  #define OMAP34XX_DMA4_BASE		(L4_34XX_BASE + 0x56000)
> +#define OMAP44XX_DMA4_BASE		(L4_44XX_BASE + 0x56000)
> =20
>  #define OMAP_DMA4_REVISION		0x00
>  #define OMAP_DMA4_GCR			0x78
> diff --git a/arch/arm/plat-omap/include/mach/entry-macro.S b/arch/arm=
/plat-omap/include/mach/entry-macro.S
> index 33256a0..00f45c0 100644
> --- a/arch/arm/plat-omap/include/mach/entry-macro.S
> +++ b/arch/arm/plat-omap/include/mach/entry-macro.S
> @@ -3,6 +3,9 @@
>   *
>   * Low-level IRQ helper macros for OMAP-based platforms
>   *
> + * Copyright (C) 2009 Texas Instruments
> + * Added OMAP4 support - Santosh Shilimkar <santosh.shilimkar@ti.com=
>
> + *
>   * This file is licensed under  the terms of the GNU General Public
>   * License version 2. This program is licensed "as is" without any
>   * warranty of any kind, whether express or implied.
> @@ -10,6 +13,7 @@
>  #include <mach/hardware.h>
>  #include <mach/io.h>
>  #include <mach/irqs.h>
> +#include <asm/hardware/gic.h>
> =20
>  #if defined(CONFIG_ARCH_OMAP1)
> =20
> @@ -56,7 +60,8 @@
>  		.endm
> =20
>  #endif
> -#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
> +#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX) |=
| \
> +			defined(CONFIG_ARCH_OMAP4)
> =20
>  #include <mach/omap24xx.h>
>  #include <mach/omap34xx.h>
> @@ -67,7 +72,9 @@
>  #elif defined(CONFIG_ARCH_OMAP34XX)
>  #define OMAP2_VA_IC_BASE		IO_ADDRESS(OMAP34XX_IC_BASE)
>  #endif
> -
> +#if defined(CONFIG_ARCH_OMAP4)
> +#include <mach/omap44xx.h>
> +#endif
>  #define INTCPS_SIR_IRQ_OFFSET	0x0040		/* Active interrupt offset */
>  #define	ACTIVEIRQ_MASK		0x7f		/* Active interrupt bits */
> =20
> @@ -80,6 +87,7 @@
>  		.macro  arch_ret_to_user, tmp1, tmp2
>  		.endm
> =20
> +#ifndef CONFIG_ARCH_OMAP4
>  		.macro	get_irqnr_and_base, irqnr, irqstat, base, tmp
>  		ldr	\base, =3DOMAP2_VA_IC_BASE
>  		ldr	\irqnr, [\base, #0x98] /* IRQ pending reg 1 */
> @@ -95,6 +103,40 @@
>  		and	\irqnr, \irqnr, #ACTIVEIRQ_MASK /* Clear spurious bits */
> =20
>  		.endm
> +#else
> +		/*
> +		 * The interrupt numbering scheme is defined in the
> +		 * interrupt controller spec.  To wit:
> +		 *
> +		 * Interrupts 0-15 are IPI
> +		 * 16-28 are reserved
> +		 * 29-31 are local.  We allow 30 to be used for the watchdog.
> +		 * 32-1020 are global
> +		 * 1021-1022 are reserved
> +		 * 1023 is "spurious" (no interrupt)
> +		 *
> +		 * For now, we ignore all local interrupts so only return an
> +		 * interrupt if it's between 30 and 1020.  The test_for_ipi
> +		 * routine below will pick up on IPIs.
> +		 * A simple read from the controller will tell us the number
> +		 * of the highest priority enabled interrupt.
> +		 * We then just need to check whether it is in the
> +		 * valid range for an IRQ (30-1020 inclusive).
> +		 */
> +		.macro  get_irqnr_and_base, irqnr, irqstat, base, tmp
> +		ldr     \base, =3DOMAP44XX_VA_GIC_CPU_BASE
> +		ldr     \irqstat, [\base, #GIC_CPU_INTACK]
> +
> +		ldr     \tmp, =3D1021
> +
> +		bic     \irqnr, \irqstat, #0x1c00
> +
> +		cmp     \irqnr, #29
> +		cmpcc   \irqnr, \irqnr
> +		cmpne   \irqnr, \tmp
> +		cmpcs   \irqnr, \irqnr
> +		.endm
> +#endif
> =20
>  		.macro	irq_prio_table
>  		.endm
> diff --git a/arch/arm/plat-omap/include/mach/hardware.h b/arch/arm/pl=
at-omap/include/mach/hardware.h
> index 3dc423e..26c1fbf 100644
> --- a/arch/arm/plat-omap/include/mach/hardware.h
> +++ b/arch/arm/plat-omap/include/mach/hardware.h
> @@ -285,5 +285,6 @@
>  #include "omap16xx.h"
>  #include "omap24xx.h"
>  #include "omap34xx.h"
> +#include "omap44xx.h"
> =20
>  #endif	/* __ASM_ARCH_OMAP_HARDWARE_H */
> diff --git a/arch/arm/plat-omap/include/mach/io.h b/arch/arm/plat-oma=
p/include/mach/io.h
> index 0610d7e..3b28147 100644
> --- a/arch/arm/plat-omap/include/mach/io.h
> +++ b/arch/arm/plat-omap/include/mach/io.h
> @@ -6,6 +6,9 @@
>   * Copied from arch/arm/mach-sa1100/include/mach/io.h
>   * Copyright (C) 1997-1999 Russell King
>   *
> + * Copyright (C) 2009 Texas Instruments
> + * Added OMAP4 support - Santosh Shilimkar <santosh.shilimkar@ti.com=
>
> + *
>   * This program is free software; you can redistribute it and/or mod=
ify it
>   * under the terms of the GNU General Public License as published by=
 the
>   * Free Software Foundation; either version 2 of the License, or (at=
 your
> @@ -157,6 +160,40 @@
>  #define DSP_MMU_34XX_VIRT	0xe2000000
>  #define DSP_MMU_34XX_SIZE	SZ_4K
> =20
> +
> +#elif defined(CONFIG_ARCH_OMAP4)
> +/* We map both L3 and L4 on OMAP4 */
> +#define L3_44XX_PHYS		L3_44XX_BASE
> +#define L3_44XX_VIRT		0xd4000000
> +#define L3_44XX_SIZE		SZ_1M
> +
> +#define L4_44XX_PHYS		L4_44XX_BASE
> +#define L4_44XX_VIRT		0xda000000
> +#define L4_44XX_SIZE		SZ_4M
> +
> +
> +#define L4_WK_44XX_PHYS		L4_WK_44XX_BASE
> +#define L4_WK_44XX_VIRT		0xda300000
> +#define L4_WK_44XX_SIZE		SZ_1M
> +
> +#define L4_PER_44XX_PHYS	L4_PER_44XX_BASE
> +#define L4_PER_44XX_VIRT	0xd8000000
> +#define L4_PER_44XX_SIZE	SZ_4M
> +
> +#define L4_EMU_44XX_PHYS	L4_EMU_44XX_BASE
> +#define L4_EMU_44XX_VIRT	0xe4000000
> +#define L4_EMU_44XX_SIZE	SZ_64M
> +
> +#define OMAP44XX_GPMC_PHYS	OMAP44XX_GPMC_BASE
> +#define OMAP44XX_GPMC_VIRT	0xe0000000
> +#define OMAP44XX_GPMC_SIZE	SZ_1M
> +
> +
> +#define IO_OFFSET		0x90000000
> +#define __IO_ADDRESS(pa)	((pa) + IO_OFFSET)/* Works for L3 and L4 */
> +#define __OMAP2_IO_ADDRESS(pa)	((pa) + IO_OFFSET)/* Works for L3 and=
 L4 */
> +#define io_v2p(va)		((va) - IO_OFFSET)/* Works for L3 and L4 */
> +
>  #endif
> =20
>  #define IO_ADDRESS(pa)		IOMEM(__IO_ADDRESS(pa))
> diff --git a/arch/arm/plat-omap/include/mach/irqs.h b/arch/arm/plat-o=
map/include/mach/irqs.h
> index 7f57ee6..5bc331e 100644
> --- a/arch/arm/plat-omap/include/mach/irqs.h
> +++ b/arch/arm/plat-omap/include/mach/irqs.h
> @@ -4,6 +4,9 @@
>   *  Copyright (C) Greg Lonnon 2001
>   *  Updated for OMAP-1610 by Tony Lindgren <tony@atomide.com>
>   *
> + * Copyright (C) 2009 Texas Instruments
> + * Added OMAP4 support - Santosh Shilimkar <santosh.shilimkar@ti.com=
>
> + *
>   * This program is free software; you can redistribute it and/or mod=
ify
>   * it under the terms of the GNU General Public License as published=
 by
>   * the Free Software Foundation; either version 2 of the License, or
> @@ -422,6 +425,92 @@
> =20
>  #define	INT_34XX_BENCH_MPU_EMUL	3
> =20
> +
> +#define IRQ_GIC_START		32
> +
> +#define INT_44XX_BENCH_MPU_EMUL	(3 + IRQ_GIC_START)
> +#define INT_44XX_SSM_ABORT_IRQ	(6 + IRQ_GIC_START)
> +#define INT_44XX_SYS_NIRQ	(7 + IRQ_GIC_START)
> +#define INT_44XX_D2D_FW_IRQ	(8 + IRQ_GIC_START)
> +#define INT_44XX_PRCM_MPU_IRQ	(11 + IRQ_GIC_START)
> +#define INT_44XX_SDMA_IRQ0	(12 + IRQ_GIC_START)
> +#define INT_44XX_SDMA_IRQ1	(13 + IRQ_GIC_START)
> +#define INT_44XX_SDMA_IRQ2	(14 + IRQ_GIC_START)
> +#define INT_44XX_SDMA_IRQ3	(15 + IRQ_GIC_START)
> +#define INT_44XX_ISS_IRQ	(24 + IRQ_GIC_START)
> +#define INT_44XX_DSS_IRQ	(25 + IRQ_GIC_START)
> +#define INT_44XX_MAIL_U0_MPU	(26 + IRQ_GIC_START)
> +#define INT_44XX_DSP_MMU	(28 + IRQ_GIC_START)
> +#define INT_44XX_GPTIMER1	(37 + IRQ_GIC_START)
> +#define INT_44XX_GPTIMER2	(38 + IRQ_GIC_START)
> +#define INT_44XX_GPTIMER3	(39 + IRQ_GIC_START)
> +#define INT_44XX_GPTIMER4	(40 + IRQ_GIC_START)
> +#define INT_44XX_GPTIMER5	(41 + IRQ_GIC_START)
> +#define INT_44XX_GPTIMER6	(42 + IRQ_GIC_START)
> +#define INT_44XX_GPTIMER7	(43 + IRQ_GIC_START)
> +#define INT_44XX_GPTIMER8	(44 + IRQ_GIC_START)
> +#define INT_44XX_GPTIMER9	(45 + IRQ_GIC_START)
> +#define INT_44XX_GPTIMER10	(46 + IRQ_GIC_START)
> +#define INT_44XX_GPTIMER11	(47 + IRQ_GIC_START)
> +#define INT_44XX_GPTIMER12	(95 + IRQ_GIC_START)
> +#define INT_44XX_SHA1MD5	(51 + IRQ_GIC_START)
> +#define INT_44XX_I2C1_IRQ	(56 + IRQ_GIC_START)
> +#define INT_44XX_I2C2_IRQ	(57 + IRQ_GIC_START)
> +#define INT_44XX_HDQ_IRQ	(58 + IRQ_GIC_START)
> +#define INT_44XX_SPI1_IRQ	(65 + IRQ_GIC_START)
> +#define INT_44XX_SPI2_IRQ	(66 + IRQ_GIC_START)
> +#define INT_44XX_HSI_1_IRQ0	(67 + IRQ_GIC_START)
> +#define INT_44XX_HSI_2_IRQ1	(68 + IRQ_GIC_START)
> +#define INT_44XX_HSI_1_DMAIRQ	(71 + IRQ_GIC_START)
> +#define INT_44XX_UART1_IRQ	(72 + IRQ_GIC_START)
> +#define INT_44XX_UART2_IRQ	(73 + IRQ_GIC_START)
> +#define INT_44XX_UART3_IRQ	(74 + IRQ_GIC_START)
> +#define INT_44XX_UART4_IRQ	(70 + IRQ_GIC_START)
> +#define INT_44XX_USB_IRQ_NISO	(76 + IRQ_GIC_START)
> +#define INT_44XX_USB_IRQ_ISO	(77 + IRQ_GIC_START)
> +#define INT_44XX_USB_IRQ_HGEN	(78 + IRQ_GIC_START)
> +#define INT_44XX_USB_IRQ_HSOF	(79 + IRQ_GIC_START)
> +#define INT_44XX_USB_IRQ_OTG	(80 + IRQ_GIC_START)
> +#define INT_44XX_MCBSP4_IRQ_TX	(81 + IRQ_GIC_START)
> +#define INT_44XX_MCBSP4_IRQ_RX	(82 + IRQ_GIC_START)
> +#define INT_44XX_MMC_IRQ	(83 + IRQ_GIC_START)
> +#define INT_44XX_MMC2_IRQ	(86 + IRQ_GIC_START)
> +#define INT_44XX_MCBSP2_IRQ_TX	(89 + IRQ_GIC_START)
> +#define INT_44XX_MCBSP2_IRQ_RX	(90 + IRQ_GIC_START)
> +#define INT_44XX_SPI3_IRQ	(91 + IRQ_GIC_START)
> +#define INT_44XX_SPI5_IRQ	(69 + IRQ_GIC_START)
> +
> +#define INT_44XX_MCBSP5_IRQ	(16 + IRQ_GIC_START)
> +#define INT_44xX_MCBSP1_IRQ	(17 + IRQ_GIC_START)
> +#define INT_44XX_MCBSP2_IRQ	(22 + IRQ_GIC_START)
> +#define INT_44XX_MCBSP3_IRQ	(23 + IRQ_GIC_START)
> +#define INT_44XX_MCBSP4_IRQ	(27 + IRQ_GIC_START)
> +#define INT_44XX_HS_USB_MC	(92 + IRQ_GIC_START)
> +#define INT_44XX_HS_USB_DMA	(93 + IRQ_GIC_START)
> +
> +#define INT_44XX_GPIO_BANK1	(29 + IRQ_GIC_START)
> +#define INT_44XX_GPIO_BANK2	(30 + IRQ_GIC_START)
> +#define INT_44XX_GPIO_BANK3	(31 + IRQ_GIC_START)
> +#define INT_44XX_GPIO_BANK4	(32 + IRQ_GIC_START)
> +#define INT_44XX_GPIO_BANK5	(33 + IRQ_GIC_START)
> +#define INT_44XX_GPIO_BANK6	(34 + IRQ_GIC_START)
> +#define INT_44XX_USIM_IRQ	(35 + IRQ_GIC_START)
> +#define INT_44XX_WDT3_IRQ	(36 + IRQ_GIC_START)
> +#define INT_44XX_SPI4_IRQ	(48 + IRQ_GIC_START)
> +#define INT_44XX_SHA1MD52_IRQ	(49 + IRQ_GIC_START)
> +#define INT_44XX_FPKA_READY_IRQ	(50 + IRQ_GIC_START)
> +#define INT_44XX_SHA1MD51_IRQ	(51 + IRQ_GIC_START)
> +#define INT_44XX_RNG_IRQ	(52 + IRQ_GIC_START)
> +#define INT_44XX_I2C3_IRQ	(61 + IRQ_GIC_START)
> +#define INT_44XX_FPKA_ERROR_IRQ	(64 + IRQ_GIC_START)
> +#define INT_44XX_PBIAS_IRQ	(75 + IRQ_GIC_START)
> +#define INT_44XX_OHCI_IRQ	(76 + IRQ_GIC_START)
> +#define INT_44XX_EHCI_IRQ	(77 + IRQ_GIC_START)
> +#define INT_44XX_TLL_IRQ	(78 + IRQ_GIC_START)
> +#define INT_44XX_PARTHASH_IRQ	(79 + IRQ_GIC_START)
> +#define INT_44XX_MMC3_IRQ	(94 + IRQ_GIC_START)
> +
> +
>  /* Max. 128 level 2 IRQs (OMAP1610), 192 GPIOs (OMAP730/850) and
>   * 16 MPUIO lines */
>  #define OMAP_MAX_GPIO_LINES	192
> diff --git a/arch/arm/plat-omap/include/mach/memory.h b/arch/arm/plat=
-omap/include/mach/memory.h
> index 99ed564..9ad41dc 100644
> --- a/arch/arm/plat-omap/include/mach/memory.h
> +++ b/arch/arm/plat-omap/include/mach/memory.h
> @@ -38,7 +38,8 @@
>   */
>  #if defined(CONFIG_ARCH_OMAP1)
>  #define PHYS_OFFSET		UL(0x10000000)
> -#elif defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
> +#elif defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3) || \
> +			defined(CONFIG_ARCH_OMAP4)
>  #define PHYS_OFFSET		UL(0x80000000)
>  #endif
> =20
> diff --git a/arch/arm/plat-omap/include/mach/omap44xx.h b/arch/arm/pl=
at-omap/include/mach/omap44xx.h
> new file mode 100644
> index 0000000..15dec7f
> --- /dev/null
> +++ b/arch/arm/plat-omap/include/mach/omap44xx.h
> @@ -0,0 +1,46 @@
> +/*:
> + * Address mappings and base address for OMAP4 interconnects
> + * and peripherals.
> + *
> + * Copyright (C) 2009 Texas Instruments
> + *
> + * Author: Santosh Shilimkar <santosh.shilimkar@ti.com>
> + *
> + * This program is free software; you can redistribute it and/or mod=
ify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +#ifndef __ASM_ARCH_OMAP44XX_H
> +#define __ASM_ARCH_OMAP44XX_H
> +
> +/*
> + * Please place only base defines here and put the rest in device
> + * specific headers.
> + */
> +#define L4_44XX_BASE			0x4a000000
> +#define L4_WK_44XX_BASE			0x4a300000
> +#define L4_PER_44XX_BASE		0x48000000
> +#define L4_EMU_44XX_BASE		0x54000000
> +#define L3_44XX_BASE			0x44000000
> +#define OMAP4430_32KSYNCT_BASE		0x4a304000
> +#define OMAP4430_CM_BASE		0x4a004000
> +#define OMAP4430_PRM_BASE		0x48306000
> +#define OMAP44XX_GPMC_BASE		0x50000000
> +#define OMAP443X_SCM_BASE		0x4a002000
> +#define OMAP443X_CTRL_BASE		OMAP443X_SCM_BASE
> +#define OMAP44XX_IC_BASE		0x48200000
> +#define OMAP44XX_IVA_INTC_BASE		0x40000000
> +#define IRQ_SIR_IRQ			0x0040
> +#define OMAP44XX_GIC_DIST_BASE		0x48241000
> +#define OMAP44XX_GIC_CPU_BASE		0x48240100
> +#define OMAP44XX_VA_GIC_CPU_BASE	IO_ADDRESS(OMAP44XX_GIC_CPU_BASE)
> +#define OMAP44XX_SCU_BASE		0x48240000
> +#define OMAP44XX_VA_SCU_BASE		IO_ADDRESS(OMAP44XX_SCU_BASE)
> +#define OMAP44XX_LOCAL_TWD_BASE		0x48240600
> +#define OMAP44XX_VA_LOCAL_TWD_BASE	IO_ADDRESS(OMAP44XX_LOCAL_TWD_BAS=
E)
> +#define OMAP44XX_LOCAL_TWD_SIZE		0x00000100
> +#define OMAP44XX_WKUPGEN_BASE		0x48281000
> +#define OMAP44XX_VA_WKUPGEN_BASE	IO_ADDRESS(OMAP44XX_WKUPGEN_BASE)
> +
> +#endif /* __ASM_ARCH_OMAP44XX_H */
> +
> diff --git a/arch/arm/plat-omap/include/mach/serial.h b/arch/arm/plat=
-omap/include/mach/serial.h
> index 8a676a0..e37894e 100644
> --- a/arch/arm/plat-omap/include/mach/serial.h
> +++ b/arch/arm/plat-omap/include/mach/serial.h
> @@ -1,5 +1,8 @@
>  /*
> - *  arch/arm/plat-omap/include/mach/serial.h
> + * arch/arm/plat-omap/include/mach/serial.h
> + *
> + * Copyright (C) 2009 Texas Instruments
> + * Addded OMAP4 support- Santosh Shilimkar <santosh.shilimkar@ti.com=
>
>   *
>   * This program is distributed in the hope that it will be useful,
>   * but WITHOUT ANY WARRANTY; without even the implied warranty of
> @@ -15,19 +18,28 @@
>  #define OMAP_UART1_BASE		0xfffb0000
>  #define OMAP_UART2_BASE		0xfffb0800
>  #define OMAP_UART3_BASE		0xfffb9800
> +#define OMAP_MAX_NR_PORTS	3
>  #elif defined(CONFIG_ARCH_OMAP2)
>  /* OMAP2 serial ports */
>  #define OMAP_UART1_BASE		0x4806a000
>  #define OMAP_UART2_BASE		0x4806c000
>  #define OMAP_UART3_BASE		0x4806e000
> +#define OMAP_MAX_NR_PORTS	3
>  #elif defined(CONFIG_ARCH_OMAP3)
>  /* OMAP3 serial ports */
>  #define OMAP_UART1_BASE		0x4806a000
>  #define OMAP_UART2_BASE		0x4806c000
>  #define OMAP_UART3_BASE		0x49020000
> +#define OMAP_MAX_NR_PORTS	3
> +#elif defined(CONFIG_ARCH_OMAP4)
> +/* OMAP4 serial ports */
> +#define OMAP_UART1_BASE		0x4806a000
> +#define OMAP_UART2_BASE		0x4806c000
> +#define OMAP_UART3_BASE		0x48020000
> +#define OMAP_UART4_BASE		0x4806e000
> +#define OMAP_MAX_NR_PORTS	4
>  #endif
> =20
> -#define OMAP_MAX_NR_PORTS	3
>  #define OMAP1510_BASE_BAUD	(12000000/16)
>  #define OMAP16XX_BASE_BAUD	(48000000/16)
>  #define OMAP24XX_BASE_BAUD	(48000000/16)
> diff --git a/arch/arm/plat-omap/io.c b/arch/arm/plat-omap/io.c
> index af326ef..9b42d72 100644
> --- a/arch/arm/plat-omap/io.c
> +++ b/arch/arm/plat-omap/io.c
> @@ -1,3 +1,14 @@
> +/*
> + * Common io.c file
> + * This file is created by Russell King <rmk+kernel@arm.linux.org.uk=
>
> + *
> + * Copyright (C) 2009 Texas Instruments
> + * Added OMAP4 support - Santosh Shilimkar <santosh.shilimkar@ti.com=
>
> + *
> + * This program is free software; you can redistribute it and/or mod=
ify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
>  #include <linux/module.h>
>  #include <linux/io.h>
>  #include <linux/mm.h>
> @@ -7,6 +18,7 @@
>  #include <mach/omap16xx.h>
>  #include <mach/omap24xx.h>
>  #include <mach/omap34xx.h>
> +#include <mach/omap44xx.h>
> =20
>  #define BETWEEN(p,st,sz)	((p) >=3D (st) && (p) < ((st) + (sz)))
>  #define XLATE(p,pst,vst)	((void __iomem *)((p) - (pst) + (vst)))
> @@ -92,7 +104,22 @@ void __iomem *omap_ioremap(unsigned long p, size_=
t size, unsigned int type)
>  			return XLATE(p, L4_EMU_34XX_PHYS, L4_EMU_34XX_VIRT);
>  	}
>  #endif
> -
> +#ifdef CONFIG_ARCH_OMAP4
> +	if (cpu_is_omap44xx()) {
> +		if (BETWEEN(p, L3_44XX_PHYS, L3_44XX_SIZE))
> +			return XLATE(p, L3_44XX_PHYS, L3_44XX_VIRT);
> +		if (BETWEEN(p, L4_44XX_PHYS, L4_44XX_SIZE))
> +			return XLATE(p, L4_44XX_PHYS, L4_44XX_VIRT);
> +		if (BETWEEN(p, L4_WK_44XX_PHYS, L4_WK_44XX_SIZE))
> +			return XLATE(p, L4_WK_44XX_PHYS, L4_WK_44XX_VIRT);
> +		if (BETWEEN(p, OMAP44XX_GPMC_PHYS, OMAP44XX_GPMC_SIZE))
> +			return XLATE(p, OMAP44XX_GPMC_PHYS, OMAP44XX_GPMC_VIRT);
> +		if (BETWEEN(p, L4_PER_44XX_PHYS, L4_PER_44XX_SIZE))
> +			return XLATE(p, L4_PER_44XX_PHYS, L4_PER_44XX_VIRT);
> +		if (BETWEEN(p, L4_EMU_44XX_PHYS, L4_EMU_44XX_SIZE))
> +			return XLATE(p, L4_EMU_44XX_PHYS, L4_EMU_44XX_VIRT);
> +	}
> +#endif
>  	return __arm_ioremap(p, size, type);
>  }
>  EXPORT_SYMBOL(omap_ioremap);
> diff --git a/arch/arm/plat-omap/mux.c b/arch/arm/plat-omap/mux.c
> index 80b040f..8d329fb 100644
> --- a/arch/arm/plat-omap/mux.c
> +++ b/arch/arm/plat-omap/mux.c
> @@ -54,6 +54,9 @@ int __init_or_module omap_cfg_reg(const unsigned lo=
ng index)
>  {
>  	struct pin_config *reg;
> =20
> +	if (cpu_is_omap44xx())
> +		return 0;
> +
>  	if (mux_cfg =3D=3D NULL) {
>  		printk(KERN_ERR "Pin mux table not initialized\n");
>  		return -ENODEV;
> diff --git a/arch/arm/plat-omap/sram.c b/arch/arm/plat-omap/sram.c
> index e1493d8..902f16c 100644
> --- a/arch/arm/plat-omap/sram.c
> +++ b/arch/arm/plat-omap/sram.c
> @@ -6,6 +6,9 @@
>   * Copyright (C) 2005 Nokia Corporation
>   * Written by Tony Lindgren <tony@atomide.com>
>   *
> + * Copyright (C) 2009 Texas Instruments
> + * Added OMAP4 support - Santosh Shilimkar <santosh.shilimkar@ti.com=
>
> + *
>   * This program is free software; you can redistribute it and/or mod=
ify
>   * it under the terms of the GNU General Public License version 2 as
>   * published by the Free Software Foundation.
> @@ -44,6 +47,8 @@
>  #define OMAP3_SRAM_VA           0xd7000000
>  #define OMAP3_SRAM_PUB_PA       0x40208000
>  #define OMAP3_SRAM_PUB_VA       0xd7008000
> +#define OMAP4_SRAM_PA		0x40200000		/*0x402f0000*/
> +#define OMAP4_SRAM_VA		0xd7000000		/*0xd70f0000*/
> =20
>  #if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
>  #define SRAM_BOOTLOADER_SZ	0x00
> @@ -87,6 +92,10 @@ static int is_sram_locked(void)
>  {
>  	int type =3D 0;
> =20
> +	if (cpu_is_omap44xx())
> +		/* Not yet supported */
> +		return 0;
> +
>  	if (cpu_is_omap242x())
>  		type =3D omap_rev() & OMAP2_DEVICETYPE_MASK;
> =20
> @@ -135,6 +144,10 @@ void __init omap_detect_sram(void)
>  				omap_sram_base =3D OMAP3_SRAM_VA;
>  				omap_sram_start =3D OMAP3_SRAM_PA;
>  				omap_sram_size =3D 0x10000; /* 64K */
> +			} else if (cpu_is_omap44xx()) {
> +				omap_sram_base =3D OMAP4_SRAM_VA;
> +				omap_sram_start =3D OMAP4_SRAM_PA;
> +				omap_sram_size =3D 0x8000; /* 32K */
>  			} else {
>  				omap_sram_base =3D OMAP2_SRAM_VA;
>  				omap_sram_start =3D OMAP2_SRAM_PA;
> @@ -203,6 +216,12 @@ void __init omap_map_sram(void)
>  		omap_sram_io_desc[0].pfn =3D __phys_to_pfn(base);
>  	}
> =20
> +	if (cpu_is_omap44xx()) {
> +		omap_sram_io_desc[0].virtual =3D OMAP4_SRAM_VA;
> +		base =3D OMAP4_SRAM_PA;
> +		base =3D ROUND_DOWN(base, PAGE_SIZE);
> +		omap_sram_io_desc[0].pfn =3D __phys_to_pfn(base);
> +	}
>  	omap_sram_io_desc[0].length =3D 1024 * 1024;	/* Use section desc */
>  	iotable_init(omap_sram_io_desc, ARRAY_SIZE(omap_sram_io_desc));
> =20
> @@ -391,6 +410,8 @@ int __init omap_sram_init(void)
>  		omap243x_sram_init();
>  	else if (cpu_is_omap34xx())
>  		omap34xx_sram_init();
> +	else if (cpu_is_omap44xx())
> +		omap34xx_sram_init(); /* FIXME: */
> =20
>  	return 0;
>  }
> --=20
> 1.5.4.7
>=20
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
