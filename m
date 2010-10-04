From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: [PATCH 08/10] OMAP: split plat-omap/common.c
Date: Mon, 4 Oct 2010 11:04:48 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB030CDFE3C6@dbde02.ent.ti.com>
References: <20101001213119.1408.65395.stgit@twilight.localdomain>
 <20101001213532.1408.55832.stgit@twilight.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:54896 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752017Ab0JDFfA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 4 Oct 2010 01:35:00 -0400
In-Reply-To: <20101001213532.1408.55832.stgit@twilight.localdomain>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Balbi, Felipe" <balbi@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Felipe,

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Paul Walmsley
> Sent: Saturday, October 02, 2010 3:06 AM
> To: linux-omap@vger.kernel.org; linux-arm-kernel@lists.infradead.org
> Subject: [PATCH 08/10] OMAP: split plat-omap/common.c
>
> Split plat-omap/common.c into three pieces:
>
> 1. the 32KiHz sync timer and clocksource code, which now lives in
>    plat-omap/32ksynctimer.c;
>
I remember you have converted the 32k sync time code to a platform driver.
That was also addressing the multi-omap build and was removing all
the compile time switches.
Do you plan to rebase it and post it again ?

> 2. the OMAP2+ common code, which has been moved to mach-omap2/common.c;
>
> 3. and the remainder of the OMAP-wide common code, which includes the
>    deprecated ATAGs code and a deprecated video RAM reservation function.
>
> The primary motivation for doing this is to move the OMAP2+-specific parts
> into an OMAP2+-specific file, so that build breakage related to the
> System Control Module code can be resolved.
>
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> ---
>  arch/arm/mach-omap2/Makefile      |    3
>  arch/arm/mach-omap2/common.c      |  138 ++++++++++++++++++
>  arch/arm/plat-omap/32ksynctimer.c |  184 +++++++++++++++++++++++
>  arch/arm/plat-omap/Makefile       |    2
>  arch/arm/plat-omap/common.c       |  291 --------------------------------
> -----
>  arch/arm/plat-omap/devices.c      |    1
>  arch/arm/plat-omap/sram.c         |    3
>  7 files changed, 325 insertions(+), 297 deletions(-)
>  create mode 100644 arch/arm/mach-omap2/common.c
>  create mode 100644 arch/arm/plat-omap/32ksynctimer.c
>
> diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
> index 9edacb0..d543533 100644
> --- a/arch/arm/mach-omap2/Makefile
> +++ b/arch/arm/mach-omap2/Makefile
> @@ -3,7 +3,8 @@
>  #
>
>  # Common support
> -obj-y := id.o io.o control.o mux.o devices.o serial.o gpmc.o timer-gp.o
> pm.o
> +obj-y := id.o io.o control.o mux.o devices.o serial.o gpmc.o timer-gp.o
> pm.o \
> +      common.o
>
>  omap-2-3-common                              = irq.o sdrc.o prm2xxx_3xxx.o
>  hwmod-common                         = omap_hwmod.o \
> diff --git a/arch/arm/mach-omap2/common.c b/arch/arm/mach-omap2/common.c
> new file mode 100644
> index 0000000..4e0469d
> --- /dev/null
> +++ b/arch/arm/mach-omap2/common.c
> @@ -0,0 +1,138 @@
> +/*
> + * linux/arch/arm/mach-omap2/common.c
> + *
> + * Code common to all OMAP2+ machines.
> + *
> + * Copyright (C) 2009 Texas Instruments
> + * Copyright (C) 2010 Nokia Corporation
> + * Tony Lindgren <tony@atomide.com>
> + * Added OMAP4 support - Santosh Shilimkar <santosh.shilimkar@ti.com>
> + * Paul Walmsley
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/clk.h>
> +#include <linux/io.h>
> +
> +#include <plat/common.h>
> +#include <plat/board.h>
> +#include <plat/control.h>
> +#include <plat/mux.h>
> +
> +#include <plat/clock.h>
> +
> +#include "sdrc.h"
> +
> +/* Global address base setup code */
> +
> +#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
> +
> +static void __init __omap2_set_globals(struct omap_globals
> *omap2_globals)
> +{
> +     omap2_set_globals_tap(omap2_globals);
> +     omap2_set_globals_sdrc(omap2_globals);
> +     omap2_set_globals_control(omap2_globals);
> +     omap2_set_globals_prcm(omap2_globals);
> +     omap2_set_globals_uart(omap2_globals);
> +}
> +
> +#endif
> +
> +#if defined(CONFIG_ARCH_OMAP2420)
> +
> +static struct omap_globals omap242x_globals = {
> +     .class  = OMAP242X_CLASS,
> +     .tap    = OMAP2_L4_IO_ADDRESS(0x48014000),
> +     .sdrc   = OMAP2420_SDRC_BASE,
> +     .sms    = OMAP2420_SMS_BASE,
> +     .ctrl   = OMAP242X_CTRL_BASE,
> +     .prm    = OMAP2420_PRM_BASE,
> +     .cm     = OMAP2420_CM_BASE,
> +     .uart1_phys     = OMAP2_UART1_BASE,
> +     .uart2_phys     = OMAP2_UART2_BASE,
> +     .uart3_phys     = OMAP2_UART3_BASE,
> +};
> +
> +void __init omap2_set_globals_242x(void)
> +{
> +     __omap2_set_globals(&omap242x_globals);
> +}
> +#endif
> +
> +#if defined(CONFIG_ARCH_OMAP2430)
> +
> +static struct omap_globals omap243x_globals = {
> +     .class  = OMAP243X_CLASS,
> +     .tap    = OMAP2_L4_IO_ADDRESS(0x4900a000),
> +     .sdrc   = OMAP243X_SDRC_BASE,
> +     .sms    = OMAP243X_SMS_BASE,
> +     .ctrl   = OMAP243X_CTRL_BASE,
> +     .prm    = OMAP2430_PRM_BASE,
> +     .cm     = OMAP2430_CM_BASE,
> +     .uart1_phys     = OMAP2_UART1_BASE,
> +     .uart2_phys     = OMAP2_UART2_BASE,
> +     .uart3_phys     = OMAP2_UART3_BASE,
> +};
> +
> +void __init omap2_set_globals_243x(void)
> +{
> +     __omap2_set_globals(&omap243x_globals);
> +}
> +#endif
> +
> +#if defined(CONFIG_ARCH_OMAP3)
> +
> +static struct omap_globals omap3_globals = {
> +     .class  = OMAP343X_CLASS,
> +     .tap    = OMAP2_L4_IO_ADDRESS(0x4830A000),
> +     .sdrc   = OMAP343X_SDRC_BASE,
> +     .sms    = OMAP343X_SMS_BASE,
> +     .ctrl   = OMAP343X_CTRL_BASE,
> +     .prm    = OMAP3430_PRM_BASE,
> +     .cm     = OMAP3430_CM_BASE,
> +     .uart1_phys     = OMAP3_UART1_BASE,
> +     .uart2_phys     = OMAP3_UART2_BASE,
> +     .uart3_phys     = OMAP3_UART3_BASE,
> +     .uart4_phys     = OMAP3_UART4_BASE,     /* Only on 3630 */
> +};
> +
> +void __init omap2_set_globals_3xxx(void)
> +{
> +     __omap2_set_globals(&omap3_globals);
> +}
> +
> +void __init omap3_map_io(void)
> +{
> +     omap2_set_globals_3xxx();
> +     omap34xx_map_common_io();
> +}
> +#endif
> +
> +#if defined(CONFIG_ARCH_OMAP4)
> +static struct omap_globals omap4_globals = {
> +     .class  = OMAP443X_CLASS,
> +     .tap    = OMAP2_L4_IO_ADDRESS(OMAP443X_SCM_BASE),
> +     .ctrl   = OMAP443X_SCM_BASE,
> +     .ctrl_pad       = OMAP443X_CTRL_BASE,
> +     .prm    = OMAP4430_PRM_BASE,
> +     .cm     = OMAP4430_CM_BASE,
> +     .cm2    = OMAP4430_CM2_BASE,
> +     .uart1_phys     = OMAP4_UART1_BASE,
> +     .uart2_phys     = OMAP4_UART2_BASE,
> +     .uart3_phys     = OMAP4_UART3_BASE,
> +     .uart4_phys     = OMAP4_UART4_BASE,
> +};
> +
> +void __init omap2_set_globals_443x(void)
> +{
> +     omap2_set_globals_tap(&omap4_globals);
> +     omap2_set_globals_control(&omap4_globals);
> +     omap2_set_globals_prcm(&omap4_globals);
> +     omap2_set_globals_uart(&omap4_globals);
> +}
> +#endif
> +
> diff --git a/arch/arm/plat-omap/32ksynctimer.c b/arch/arm/plat-
> omap/32ksynctimer.c
> new file mode 100644
> index 0000000..b7f458c
> --- /dev/null
> +++ b/arch/arm/plat-omap/32ksynctimer.c
> @@ -0,0 +1,184 @@
> +/*
> + * linux/arch/arm/plat-omap/clocksource.c
> + *
> + * OMAP clocksource-related code
> + *
> + * Copyright (C) 2009 Texas Instruments
> + * Copyright (C) 2010 Nokia Corporation
> + * Tony Lindgren <tony@atomide.com>
> + * Added OMAP4 support - Santosh Shilimkar <santosh.shilimkar@ti.com>
> + * Paul Walmsley
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/clk.h>
> +#include <linux/io.h>
> +
> +#include <plat/common.h>
> +#include <plat/board.h>
> +
> +#include <plat/clock.h>
> +
> +
> +/*
> + * 32KHz clocksource ... always available, on pretty most chips except
> + * OMAP 730 and 1510.  Other timers could be used as clocksources, with
> + * higher resolution in free-running counter modes (e.g. 12 MHz xtal),
> + * but systems won't necessarily want to spend resources that way.
> + */
> +
> +#define OMAP16XX_TIMER_32K_SYNCHRONIZED              0xfffbc410
> +
> +#if !(defined(CONFIG_ARCH_OMAP730) || defined(CONFIG_ARCH_OMAP15XX))
> +
> +#include <linux/clocksource.h>
> +
> +/*
> + * offset_32k holds the init time counter value. It is then subtracted
> + * from every counter read to achieve a counter that counts time from the
> + * kernel boot (needed for sched_clock()).
> + */
> +static u32 offset_32k __read_mostly;
> +
> +#ifdef CONFIG_ARCH_OMAP16XX
> +static cycle_t omap16xx_32k_read(struct clocksource *cs)
> +{
> +     return omap_readl(OMAP16XX_TIMER_32K_SYNCHRONIZED) - offset_32k;
> +}
> +#else
> +#define omap16xx_32k_read    NULL
> +#endif
> +
> +#ifdef CONFIG_ARCH_OMAP2420
> +static cycle_t omap2420_32k_read(struct clocksource *cs)
> +{
> +     return omap_readl(OMAP2420_32KSYNCT_BASE + 0x10) - offset_32k;
> +}
> +#else
> +#define omap2420_32k_read    NULL
> +#endif
> +
> +#ifdef CONFIG_ARCH_OMAP2430
> +static cycle_t omap2430_32k_read(struct clocksource *cs)
> +{
> +     return omap_readl(OMAP2430_32KSYNCT_BASE + 0x10) - offset_32k;
> +}
> +#else
> +#define omap2430_32k_read    NULL
> +#endif
> +
> +#ifdef CONFIG_ARCH_OMAP3
> +static cycle_t omap34xx_32k_read(struct clocksource *cs)
> +{
> +     return omap_readl(OMAP3430_32KSYNCT_BASE + 0x10) - offset_32k;
> +}
> +#else
> +#define omap34xx_32k_read    NULL
> +#endif
> +
> +#ifdef CONFIG_ARCH_OMAP4
> +static cycle_t omap44xx_32k_read(struct clocksource *cs)
> +{
> +     return omap_readl(OMAP4430_32KSYNCT_BASE + 0x10) - offset_32k;
> +}
> +#else
> +#define omap44xx_32k_read    NULL
> +#endif
> +
> +/*
> + * Kernel assumes that sched_clock can be called early but may not have
> + * things ready yet.
> + */
> +static cycle_t omap_32k_read_dummy(struct clocksource *cs)
> +{
> +     return 0;
> +}
> +
> +static struct clocksource clocksource_32k = {
> +     .name           = "32k_counter",
> +     .rating         = 250,
> +     .read           = omap_32k_read_dummy,
> +     .mask           = CLOCKSOURCE_MASK(32),
> +     .shift          = 10,
> +     .flags          = CLOCK_SOURCE_IS_CONTINUOUS,
> +};
> +
> +/*
> + * Returns current time from boot in nsecs. It's OK for this to wrap
> + * around for now, as it's just a relative time stamp.
> + */
> +unsigned long long sched_clock(void)
> +{
> +     return clocksource_cyc2ns(clocksource_32k.read(&clocksource_32k),
> +                               clocksource_32k.mult, clocksource_32k.shift);
> +}
> +
> +/**
> + * read_persistent_clock -  Return time from a persistent clock.
> + *
> + * Reads the time from a source which isn't disabled during PM, the
> + * 32k sync timer.  Convert the cycles elapsed since last read into
> + * nsecs and adds to a monotonically increasing timespec.
> + */
> +static struct timespec persistent_ts;
> +static cycles_t cycles, last_cycles;
> +void read_persistent_clock(struct timespec *ts)
> +{
> +     unsigned long long nsecs;
> +     cycles_t delta;
> +     struct timespec *tsp = &persistent_ts;
> +
> +     last_cycles = cycles;
> +     cycles = clocksource_32k.read(&clocksource_32k);
> +     delta = cycles - last_cycles;
> +
> +     nsecs = clocksource_cyc2ns(delta,
> +                                clocksource_32k.mult, clocksource_32k.shift);
> +
> +     timespec_add_ns(tsp, nsecs);
> +     *ts = *tsp;
> +}
> +
> +static int __init omap_init_clocksource_32k(void)
> +{
> +     static char err[] __initdata = KERN_ERR
> +                     "%s: can't register clocksource!\n";
> +
> +     if (cpu_is_omap16xx() || cpu_class_is_omap2()) {
> +             struct clk *sync_32k_ick;
> +
> +             if (cpu_is_omap16xx())
> +                     clocksource_32k.read = omap16xx_32k_read;
> +             else if (cpu_is_omap2420())
> +                     clocksource_32k.read = omap2420_32k_read;
> +             else if (cpu_is_omap2430())
> +                     clocksource_32k.read = omap2430_32k_read;
> +             else if (cpu_is_omap34xx())
> +                     clocksource_32k.read = omap34xx_32k_read;
> +             else if (cpu_is_omap44xx())
> +                     clocksource_32k.read = omap44xx_32k_read;
> +             else
> +                     return -ENODEV;
> +
> +             sync_32k_ick = clk_get(NULL, "omap_32ksync_ick");
> +             if (sync_32k_ick)
> +                     clk_enable(sync_32k_ick);
> +
> +             clocksource_32k.mult = clocksource_hz2mult(32768,
> +                                         clocksource_32k.shift);
> +
> +             offset_32k = clocksource_32k.read(&clocksource_32k);
> +
> +             if (clocksource_register(&clocksource_32k))
> +                     printk(err, clocksource_32k.name);
> +     }
> +     return 0;
> +}
> +arch_initcall(omap_init_clocksource_32k);
> +
> +#endif       /* !(defined(CONFIG_ARCH_OMAP730) ||
> defined(CONFIG_ARCH_OMAP15XX)) */
> +
> diff --git a/arch/arm/plat-omap/Makefile b/arch/arm/plat-omap/Makefile
> index 2a15191..32a5959 100644
> --- a/arch/arm/plat-omap/Makefile
> +++ b/arch/arm/plat-omap/Makefile
> @@ -4,7 +4,7 @@
>
>  # Common support
>  obj-y := common.o sram.o clock.o devices.o dma.o mux.o gpio.o \
> -      usb.o fb.o io.o
> +      usb.o fb.o io.o 32ksynctimer.o
>  obj-m :=
>  obj-n :=
>  obj-  :=
> diff --git a/arch/arm/plat-omap/common.c b/arch/arm/plat-omap/common.c
> index 9200ea7..221a675 100644
> --- a/arch/arm/plat-omap/common.c
> +++ b/arch/arm/plat-omap/common.c
> @@ -11,38 +11,15 @@
>   * it under the terms of the GNU General Public License version 2 as
>   * published by the Free Software Foundation.
>   */
> -#include <linux/module.h>
>  #include <linux/kernel.h>
>  #include <linux/init.h>
> -#include <linux/delay.h>
> -#include <linux/console.h>
> -#include <linux/serial.h>
> -#include <linux/tty.h>
> -#include <linux/serial_8250.h>
> -#include <linux/serial_reg.h>
> -#include <linux/clk.h>
>  #include <linux/io.h>
>  #include <linux/omapfb.h>
>
> -#include <mach/hardware.h>
> -#include <asm/system.h>
> -#include <asm/pgtable.h>
> -#include <asm/mach/map.h>
> -#include <asm/setup.h>
> -
>  #include <plat/common.h>
>  #include <plat/board.h>
> -#include <plat/control.h>
> -#include <plat/mux.h>
> -#include <plat/fpga.h>
> -#include <plat/serial.h>
>  #include <plat/vram.h>
>
> -#include <plat/clock.h>
> -
> -#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
> -# include "../mach-omap2/sdrc.h"
> -#endif
>
>  #define NO_LENGTH_CHECK 0xffffffff
>
> @@ -88,271 +65,3 @@ void __init omap_reserve(void)
>       omapfb_reserve_sdram_memblock();
>       omap_vram_reserve_sdram_memblock();
>  }
> -
> -/*
> - * 32KHz clocksource ... always available, on pretty most chips except
> - * OMAP 730 and 1510.  Other timers could be used as clocksources, with
> - * higher resolution in free-running counter modes (e.g. 12 MHz xtal),
> - * but systems won't necessarily want to spend resources that way.
> - */
> -
> -#define OMAP16XX_TIMER_32K_SYNCHRONIZED              0xfffbc410
> -
> -#if !(defined(CONFIG_ARCH_OMAP730) || defined(CONFIG_ARCH_OMAP15XX))
> -
> -#include <linux/clocksource.h>
> -
> -/*
> - * offset_32k holds the init time counter value. It is then subtracted
> - * from every counter read to achieve a counter that counts time from the
> - * kernel boot (needed for sched_clock()).
> - */
> -static u32 offset_32k __read_mostly;
> -
> -#ifdef CONFIG_ARCH_OMAP16XX
> -static cycle_t omap16xx_32k_read(struct clocksource *cs)
> -{
> -     return omap_readl(OMAP16XX_TIMER_32K_SYNCHRONIZED) - offset_32k;
> -}
> -#else
> -#define omap16xx_32k_read    NULL
> -#endif
> -
> -#ifdef CONFIG_ARCH_OMAP2420
> -static cycle_t omap2420_32k_read(struct clocksource *cs)
> -{
> -     return omap_readl(OMAP2420_32KSYNCT_BASE + 0x10) - offset_32k;
> -}
> -#else
> -#define omap2420_32k_read    NULL
> -#endif
> -
> -#ifdef CONFIG_ARCH_OMAP2430
> -static cycle_t omap2430_32k_read(struct clocksource *cs)
> -{
> -     return omap_readl(OMAP2430_32KSYNCT_BASE + 0x10) - offset_32k;
> -}
> -#else
> -#define omap2430_32k_read    NULL
> -#endif
> -
> -#ifdef CONFIG_ARCH_OMAP3
> -static cycle_t omap34xx_32k_read(struct clocksource *cs)
> -{
> -     return omap_readl(OMAP3430_32KSYNCT_BASE + 0x10) - offset_32k;
> -}
> -#else
> -#define omap34xx_32k_read    NULL
> -#endif
> -
> -#ifdef CONFIG_ARCH_OMAP4
> -static cycle_t omap44xx_32k_read(struct clocksource *cs)
> -{
> -     return omap_readl(OMAP4430_32KSYNCT_BASE + 0x10) - offset_32k;
> -}
> -#else
> -#define omap44xx_32k_read    NULL
> -#endif
> -
> -/*
> - * Kernel assumes that sched_clock can be called early but may not have
> - * things ready yet.
> - */
> -static cycle_t omap_32k_read_dummy(struct clocksource *cs)
> -{
> -     return 0;
> -}
> -
> -static struct clocksource clocksource_32k = {
> -     .name           = "32k_counter",
> -     .rating         = 250,
> -     .read           = omap_32k_read_dummy,
> -     .mask           = CLOCKSOURCE_MASK(32),
> -     .shift          = 10,
> -     .flags          = CLOCK_SOURCE_IS_CONTINUOUS,
> -};
> -
> -/*
> - * Returns current time from boot in nsecs. It's OK for this to wrap
> - * around for now, as it's just a relative time stamp.
> - */
> -unsigned long long sched_clock(void)
> -{
> -     return clocksource_cyc2ns(clocksource_32k.read(&clocksource_32k),
> -                               clocksource_32k.mult, clocksource_32k.shift);
> -}
> -
> -/**
> - * read_persistent_clock -  Return time from a persistent clock.
> - *
> - * Reads the time from a source which isn't disabled during PM, the
> - * 32k sync timer.  Convert the cycles elapsed since last read into
> - * nsecs and adds to a monotonically increasing timespec.
> - */
> -static struct timespec persistent_ts;
> -static cycles_t cycles, last_cycles;
> -void read_persistent_clock(struct timespec *ts)
> -{
> -     unsigned long long nsecs;
> -     cycles_t delta;
> -     struct timespec *tsp = &persistent_ts;
> -
> -     last_cycles = cycles;
> -     cycles = clocksource_32k.read(&clocksource_32k);
> -     delta = cycles - last_cycles;
> -
> -     nsecs = clocksource_cyc2ns(delta,
> -                                clocksource_32k.mult, clocksource_32k.shift);
> -
> -     timespec_add_ns(tsp, nsecs);
> -     *ts = *tsp;
> -}
> -
> -static int __init omap_init_clocksource_32k(void)
> -{
> -     static char err[] __initdata = KERN_ERR
> -                     "%s: can't register clocksource!\n";
> -
> -     if (cpu_is_omap16xx() || cpu_class_is_omap2()) {
> -             struct clk *sync_32k_ick;
> -
> -             if (cpu_is_omap16xx())
> -                     clocksource_32k.read = omap16xx_32k_read;
> -             else if (cpu_is_omap2420())
> -                     clocksource_32k.read = omap2420_32k_read;
> -             else if (cpu_is_omap2430())
> -                     clocksource_32k.read = omap2430_32k_read;
> -             else if (cpu_is_omap34xx())
> -                     clocksource_32k.read = omap34xx_32k_read;
> -             else if (cpu_is_omap44xx())
> -                     clocksource_32k.read = omap44xx_32k_read;
> -             else
> -                     return -ENODEV;
> -
> -             sync_32k_ick = clk_get(NULL, "omap_32ksync_ick");
> -             if (sync_32k_ick)
> -                     clk_enable(sync_32k_ick);
> -
> -             clocksource_32k.mult = clocksource_hz2mult(32768,
> -                                         clocksource_32k.shift);
> -
> -             offset_32k = clocksource_32k.read(&clocksource_32k);
> -
> -             if (clocksource_register(&clocksource_32k))
> -                     printk(err, clocksource_32k.name);
> -     }
> -     return 0;
> -}
> -arch_initcall(omap_init_clocksource_32k);
> -
> -#endif       /* !(defined(CONFIG_ARCH_OMAP730) ||
> defined(CONFIG_ARCH_OMAP15XX)) */
> -
> -/* Global address base setup code */
> -
> -#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
> -
> -static void __init __omap2_set_globals(struct omap_globals
> *omap2_globals)
> -{
> -     omap2_set_globals_tap(omap2_globals);
> -     omap2_set_globals_sdrc(omap2_globals);
> -     omap2_set_globals_control(omap2_globals);
> -     omap2_set_globals_prcm(omap2_globals);
> -     omap2_set_globals_uart(omap2_globals);
> -}
> -
> -#endif
> -
> -#if defined(CONFIG_ARCH_OMAP2420)
> -
> -static struct omap_globals omap242x_globals = {
> -     .class  = OMAP242X_CLASS,
> -     .tap    = OMAP2_L4_IO_ADDRESS(0x48014000),
> -     .sdrc   = OMAP2420_SDRC_BASE,
> -     .sms    = OMAP2420_SMS_BASE,
> -     .ctrl   = OMAP242X_CTRL_BASE,
> -     .prm    = OMAP2420_PRM_BASE,
> -     .cm     = OMAP2420_CM_BASE,
> -     .uart1_phys     = OMAP2_UART1_BASE,
> -     .uart2_phys     = OMAP2_UART2_BASE,
> -     .uart3_phys     = OMAP2_UART3_BASE,
> -};
> -
> -void __init omap2_set_globals_242x(void)
> -{
> -     __omap2_set_globals(&omap242x_globals);
> -}
> -#endif
> -
> -#if defined(CONFIG_ARCH_OMAP2430)
> -
> -static struct omap_globals omap243x_globals = {
> -     .class  = OMAP243X_CLASS,
> -     .tap    = OMAP2_L4_IO_ADDRESS(0x4900a000),
> -     .sdrc   = OMAP243X_SDRC_BASE,
> -     .sms    = OMAP243X_SMS_BASE,
> -     .ctrl   = OMAP243X_CTRL_BASE,
> -     .prm    = OMAP2430_PRM_BASE,
> -     .cm     = OMAP2430_CM_BASE,
> -     .uart1_phys     = OMAP2_UART1_BASE,
> -     .uart2_phys     = OMAP2_UART2_BASE,
> -     .uart3_phys     = OMAP2_UART3_BASE,
> -};
> -
> -void __init omap2_set_globals_243x(void)
> -{
> -     __omap2_set_globals(&omap243x_globals);
> -}
> -#endif
> -
> -#if defined(CONFIG_ARCH_OMAP3)
> -
> -static struct omap_globals omap3_globals = {
> -     .class  = OMAP343X_CLASS,
> -     .tap    = OMAP2_L4_IO_ADDRESS(0x4830A000),
> -     .sdrc   = OMAP343X_SDRC_BASE,
> -     .sms    = OMAP343X_SMS_BASE,
> -     .ctrl   = OMAP343X_CTRL_BASE,
> -     .prm    = OMAP3430_PRM_BASE,
> -     .cm     = OMAP3430_CM_BASE,
> -     .uart1_phys     = OMAP3_UART1_BASE,
> -     .uart2_phys     = OMAP3_UART2_BASE,
> -     .uart3_phys     = OMAP3_UART3_BASE,
> -     .uart4_phys     = OMAP3_UART4_BASE,     /* Only on 3630 */
> -};
> -
> -void __init omap2_set_globals_3xxx(void)
> -{
> -     __omap2_set_globals(&omap3_globals);
> -}
> -
> -void __init omap3_map_io(void)
> -{
> -     omap2_set_globals_3xxx();
> -     omap34xx_map_common_io();
> -}
> -#endif
> -
> -#if defined(CONFIG_ARCH_OMAP4)
> -static struct omap_globals omap4_globals = {
> -     .class  = OMAP443X_CLASS,
> -     .tap    = OMAP2_L4_IO_ADDRESS(OMAP443X_SCM_BASE),
> -     .ctrl   = OMAP443X_SCM_BASE,
> -     .ctrl_pad       = OMAP443X_CTRL_BASE,
> -     .prm    = OMAP4430_PRM_BASE,
> -     .cm     = OMAP4430_CM_BASE,
> -     .cm2    = OMAP4430_CM2_BASE,
> -     .uart1_phys     = OMAP4_UART1_BASE,
> -     .uart2_phys     = OMAP4_UART2_BASE,
> -     .uart3_phys     = OMAP4_UART3_BASE,
> -     .uart4_phys     = OMAP4_UART4_BASE,
> -};
> -
> -void __init omap2_set_globals_443x(void)
> -{
> -     omap2_set_globals_tap(&omap4_globals);
> -     omap2_set_globals_control(&omap4_globals);
> -     omap2_set_globals_prcm(&omap4_globals);
> -     omap2_set_globals_uart(&omap4_globals);
> -}
> -#endif
> -
> diff --git a/arch/arm/plat-omap/devices.c b/arch/arm/plat-omap/devices.c
> index d1920be..78162a0 100644
> --- a/arch/arm/plat-omap/devices.c
> +++ b/arch/arm/plat-omap/devices.c
> @@ -21,7 +21,6 @@
>  #include <asm/mach/map.h>
>
>  #include <plat/tc.h>
> -#include <plat/control.h>
>  #include <plat/board.h>
>  #include <plat/mmc.h>
>  #include <mach/gpio.h>
> diff --git a/arch/arm/plat-omap/sram.c b/arch/arm/plat-omap/sram.c
> index 33ee6b8..d971aeb 100644
> --- a/arch/arm/plat-omap/sram.c
> +++ b/arch/arm/plat-omap/sram.c
> @@ -30,8 +30,6 @@
>  #include <plat/cpu.h>
>  #include <plat/vram.h>
>
> -#include <plat/control.h>
> -
>  #if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
>  # include "../mach-omap2/prm.h"
>  # include "../mach-omap2/cm.h"
> @@ -68,7 +66,6 @@
>  #define OMAP34XX_VA_WRITEPERM0               OMAP2_L3_IO_ADDRESS(0x68012858)
>  #define OMAP34XX_VA_ADDR_MATCH2              OMAP2_L3_IO_ADDRESS(0x68012880)
>  #define OMAP34XX_VA_SMS_RG_ATT0              OMAP2_L3_IO_ADDRESS(0x6C000048)
> -#define OMAP34XX_VA_CONTROL_STAT     OMAP2_L4_IO_ADDRESS(0x480022F0)
>
>  #define GP_DEVICE            0x300
>
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
