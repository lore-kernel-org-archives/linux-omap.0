From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/7] OMAP4: Create board support for OMAP_4430SDP, v3
Date: Tue, 19 May 2009 14:17:56 -0700
Message-ID: <20090519211756.GH19742@atomide.com>
References: <1242739888-12428-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="EVh9lyqKgK19OcEf"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:51612 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750860AbZESVSG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 May 2009 17:18:06 -0400
Content-Disposition: inline
In-Reply-To: <1242739888-12428-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org


--EVh9lyqKgK19OcEf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

I rebased these patches on top of the for-next branch in linux-omap
tree, some comments and the updated patch below.

* Santosh Shilimkar <santosh.shilimkar@ti.com> [090519 06:32]:
> (patch is rebased on 2.6.30-rc6. The older version was based on 2.6.30-rc2)
> 
> This patch creates the bare minimal board files  to support
> OMAP_4430SDP. Additinaly new omap44xx.h is created which contains
> the base addresses for OMAP4430. File omap34xx.h is adapted to avoid
> multiple definitions of common omap base address definitions.
> 
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> ---
>  arch/arm/mach-omap2/board-4430sdp.c        |   94 ++++++++++++++++++++++++++++
>  arch/arm/plat-omap/include/mach/hardware.h |    1 +
>  arch/arm/plat-omap/include/mach/omap34xx.h |   10 ++--
>  arch/arm/plat-omap/include/mach/omap44xx.h |   61 ++++++++++++++++++
>  4 files changed, 161 insertions(+), 5 deletions(-)
>  create mode 100644 arch/arm/mach-omap2/board-4430sdp.c
>  create mode 100644 arch/arm/plat-omap/include/mach/omap44xx.h

In general, considering this whole series is less than 750 lines of changes,
I suggest collapsing them into following three patches:

1. Add minimal support for omap4

This patch would be everything in your series, except what's in patches
two and three below.

2. Add support for 4430 SDP

This patch would be just the board-4430sdp.c the changes to mach-omap2/Makefile
and mach-omap2/Kconfig.

3. Add defconfig for 4430 SDP

This patch would just contain the defconfig.

To make things easy, I rebased two of your patches on top of the for-next
branch in the linux-omap tree. Some comments and the updated patch below.

Please do any more changes on top of this version so we can get things
queued up nicely for Russell.
 
> diff --git a/arch/arm/plat-omap/include/mach/omap34xx.h b/arch/arm/plat-omap/include/mach/omap34xx.h
> index ab64015..4cf9859 100644
> --- a/arch/arm/plat-omap/include/mach/omap34xx.h
> +++ b/arch/arm/plat-omap/include/mach/omap34xx.h
> @@ -3,7 +3,7 @@
>   *
>   * This file contains the processor specific definitions of the TI OMAP34XX.
>   *
> - * Copyright (C) 2007 Texas Instruments.
> + * Copyright (C) 2007-2009 Texas Instruments.
>   * Copyright (C) 2007 Nokia Corporation.
>   *
>   * This program is free software; you can redistribute it and/or modify
> @@ -31,13 +31,9 @@
>  
>  #define L4_34XX_BASE		0x48000000
>  #define L4_WK_34XX_BASE		0x48300000
> -#define L4_WK_OMAP_BASE		L4_WK_34XX_BASE
>  #define L4_PER_34XX_BASE	0x49000000
> -#define L4_PER_OMAP_BASE	L4_PER_34XX_BASE
>  #define L4_EMU_34XX_BASE	0x54000000
> -#define L4_EMU_BASE		L4_EMU_34XX_BASE
>  #define L3_34XX_BASE		0x68000000
> -#define L3_OMAP_BASE		L3_34XX_BASE
>  
>  #define OMAP3430_32KSYNCT_BASE	0x48320000
>  #define OMAP3430_CM_BASE	0x48004800
> @@ -85,6 +81,10 @@
>  
>  #if defined(CONFIG_ARCH_OMAP3430)
>  
> +#define L4_WK_OMAP_BASE			L4_WK_34XX_BASE
> +#define L4_PER_OMAP_BASE		L4_PER_34XX_BASE
> +#define L4_EMU_BASE			L4_EMU_34XX_BASE
> +#define L3_OMAP_BASE			L3_34XX_BASE
>  #define OMAP2_32KSYNCT_BASE		OMAP3430_32KSYNCT_BASE
>  #define OMAP2_CM_BASE			OMAP3430_CM_BASE
>  #define OMAP2_PRM_BASE			OMAP3430_PRM_BASE

The part above can be left out now when rebased on top of the earlier
header clean-up.


> diff --git a/arch/arm/plat-omap/include/mach/omap44xx.h b/arch/arm/plat-omap/include/mach/omap44xx.h
> new file mode 100644
> index 0000000..fce4126
> --- /dev/null
> +++ b/arch/arm/plat-omap/include/mach/omap44xx.h

> +
> +/* Common macros between OMAPs */
> +
> +#if defined(CONFIG_ARCH_OMAP4)
> +
> +#define L4_WK_OMAP_BASE			L4_WK_44XX_BASE
> +#define L4_PER_OMAP_BASE		L4_PER_44XX_BASE
> +#define L4_EMU_BASE			L4_EMU_44XX_BASE
> +#define L3_OMAP_BASE			L3_44XX_BASE
> +#define OMAP2_32KSYNCT_BASE		OMAP4430_32KSYNCT_BASE
> +#define OMAP2_CM_BASE			OMAP4430_CM_BASE
> +#define OMAP2_PRM_BASE			OMAP4430_PRM_BASE
> +#define OMAP2_VA_IC_BASE		IO_ADDRESS(OMAP44XX_IC_BASE)
> +
> +#endif
> +

And this part too can now be left out. See the related changes to plat-omap/common.c
for the timer, I've only compile tested it :)

Regards,

Tony

--EVh9lyqKgK19OcEf
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: inline; filename="board-support.patch"

>From b053e3239892fa088339db2eb0f33dbaa803f61d Mon Sep 17 00:00:00 2001
From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Date: Tue, 19 May 2009 13:51:45 -0700
Subject: [PATCH] ARM: OMAP4: Create board support for OMAP_4430SDP, v3

This patch creates the bare minimal board files  to support
OMAP_4430SDP. Additinaly new omap44xx.h is created which contains
the base addresses for OMAP4430. File omap34xx.h is adapted to avoid
multiple definitions of common omap base address definitions.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
new file mode 100644
index 0000000..57e477b
--- /dev/null
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -0,0 +1,94 @@
+/*
+ * Board support file for OMAP4430 SDP.
+ *
+ * Copyright (C) 2009 Texas Instruments
+ *
+ * Author: Santosh Shilimkar <santosh.shilimkar@ti.com>
+ *
+ * Based on mach-omap2/board-3430sdp.c
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <linux/io.h>
+#include <linux/gpio.h>
+
+#include <mach/hardware.h>
+#include <asm/mach-types.h>
+#include <asm/mach/arch.h>
+#include <asm/mach/map.h>
+
+#include <mach/board.h>
+#include <mach/common.h>
+#include <mach/control.h>
+#include <mach/timer-gp.h>
+#include <asm/hardware/gic.h>
+
+static struct platform_device sdp4430_lcd_device = {
+	.name		= "sdp4430_lcd",
+	.id		= -1,
+};
+
+static struct platform_device *sdp4430_devices[] __initdata = {
+	&sdp4430_lcd_device,
+};
+
+static struct omap_uart_config sdp4430_uart_config __initdata = {
+	.enabled_uarts	= (1 << 0) | (1 << 1) | (1 << 2),
+};
+
+static struct omap_lcd_config sdp4430_lcd_config __initdata = {
+	.ctrl_name	= "internal",
+};
+
+static struct omap_board_config_kernel sdp4430_config[] __initdata = {
+	{ OMAP_TAG_UART,	&sdp4430_uart_config },
+	{ OMAP_TAG_LCD,		&sdp4430_lcd_config },
+};
+
+static void __init gic_init_irq(void)
+{
+	gic_dist_init(0, IO_ADDRESS(OMAP44XX_GIC_DIST_BASE), 29);
+	gic_cpu_init(0, IO_ADDRESS(OMAP44XX_GIC_CPU_BASE));
+}
+
+static void __init omap_4430sdp_init_irq(void)
+{
+	omap2_init_common_hw(NULL);
+#ifdef CONFIG_OMAP_32K_TIMER
+	omap2_gp_clockevent_set_gptimer(1);
+#endif
+	gic_init_irq();
+	omap_gpio_init();
+}
+
+
+static void __init omap_4430sdp_init(void)
+{
+	platform_add_devices(sdp4430_devices, ARRAY_SIZE(sdp4430_devices));
+	omap_board_config = sdp4430_config;
+	omap_board_config_size = ARRAY_SIZE(sdp4430_config);
+	omap_serial_init();
+}
+
+static void __init omap_4430sdp_map_io(void)
+{
+	omap2_set_globals_443x();
+	omap2_map_common_io();
+}
+
+MACHINE_START(OMAP_4430SDP, "OMAP4430 4430SDP board")
+	/* Maintainer: Santosh Shilimkar - Texas Instruments Inc */
+	.phys_io	= 0x48000000,
+	.io_pg_offst	= ((0xd8000000) >> 18) & 0xfffc,
+	.boot_params	= 0x80000100,
+	.map_io		= omap_4430sdp_map_io,
+	.init_irq	= omap_4430sdp_init_irq,
+	.init_machine	= omap_4430sdp_init,
+	.timer		= &omap_timer,
+MACHINE_END
diff --git a/arch/arm/plat-omap/common.c b/arch/arm/plat-omap/common.c
index 70b68ef..febcacf 100644
--- a/arch/arm/plat-omap/common.c
+++ b/arch/arm/plat-omap/common.c
@@ -217,6 +217,15 @@ static cycle_t omap34xx_32k_read(struct clocksource *cs)
 #define omap34xx_32k_read	NULL
 #endif
 
+#ifdef CONFIG_ARCH_OMAP4
+static cycle_t omap44xx_32k_read(struct clocksource *cs)
+{
+	return omap_readl(OMAP4430_32KSYNCT_BASE + 0x10);
+}
+#else
+#define omap44xx_32k_read	NULL
+#endif
+
 /*
  * Kernel assumes that sched_clock can be called early but may not have
  * things ready yet.
@@ -264,6 +273,8 @@ static int __init omap_init_clocksource_32k(void)
 			clocksource_32k.read = omap2430_32k_read;
 		else if (cpu_is_omap34xx())
 			clocksource_32k.read = omap34xx_32k_read;
+		else if (cpu_is_omap44xx())
+			clocksource_32k.read = omap44xx_32k_read;
 		else
 			return -ENODEV;
 
diff --git a/arch/arm/plat-omap/include/mach/hardware.h b/arch/arm/plat-omap/include/mach/hardware.h
index 3dc423e..26c1fbf 100644
--- a/arch/arm/plat-omap/include/mach/hardware.h
+++ b/arch/arm/plat-omap/include/mach/hardware.h
@@ -285,5 +285,6 @@
 #include "omap16xx.h"
 #include "omap24xx.h"
 #include "omap34xx.h"
+#include "omap44xx.h"
 
 #endif	/* __ASM_ARCH_OMAP_HARDWARE_H */
diff --git a/arch/arm/plat-omap/include/mach/omap34xx.h b/arch/arm/plat-omap/include/mach/omap34xx.h
index f8d186a..9bab0a8 100644
--- a/arch/arm/plat-omap/include/mach/omap34xx.h
+++ b/arch/arm/plat-omap/include/mach/omap34xx.h
@@ -3,7 +3,7 @@
  *
  * This file contains the processor specific definitions of the TI OMAP34XX.
  *
- * Copyright (C) 2007 Texas Instruments.
+ * Copyright (C) 2007-2009 Texas Instruments.
  * Copyright (C) 2007 Nokia Corporation.
  *
  * This program is free software; you can redistribute it and/or modify
diff --git a/arch/arm/plat-omap/include/mach/omap44xx.h b/arch/arm/plat-omap/include/mach/omap44xx.h
new file mode 100644
index 0000000..15dec7f
--- /dev/null
+++ b/arch/arm/plat-omap/include/mach/omap44xx.h
@@ -0,0 +1,46 @@
+/*:
+ * Address mappings and base address for OMAP4 interconnects
+ * and peripherals.
+ *
+ * Copyright (C) 2009 Texas Instruments
+ *
+ * Author: Santosh Shilimkar <santosh.shilimkar@ti.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#ifndef __ASM_ARCH_OMAP44XX_H
+#define __ASM_ARCH_OMAP44XX_H
+
+/*
+ * Please place only base defines here and put the rest in device
+ * specific headers.
+ */
+#define L4_44XX_BASE			0x4a000000
+#define L4_WK_44XX_BASE			0x4a300000
+#define L4_PER_44XX_BASE		0x48000000
+#define L4_EMU_44XX_BASE		0x54000000
+#define L3_44XX_BASE			0x44000000
+#define OMAP4430_32KSYNCT_BASE		0x4a304000
+#define OMAP4430_CM_BASE		0x4a004000
+#define OMAP4430_PRM_BASE		0x48306000
+#define OMAP44XX_GPMC_BASE		0x50000000
+#define OMAP443X_SCM_BASE		0x4a002000
+#define OMAP443X_CTRL_BASE		OMAP443X_SCM_BASE
+#define OMAP44XX_IC_BASE		0x48200000
+#define OMAP44XX_IVA_INTC_BASE		0x40000000
+#define IRQ_SIR_IRQ			0x0040
+#define OMAP44XX_GIC_DIST_BASE		0x48241000
+#define OMAP44XX_GIC_CPU_BASE		0x48240100
+#define OMAP44XX_VA_GIC_CPU_BASE	IO_ADDRESS(OMAP44XX_GIC_CPU_BASE)
+#define OMAP44XX_SCU_BASE		0x48240000
+#define OMAP44XX_VA_SCU_BASE		IO_ADDRESS(OMAP44XX_SCU_BASE)
+#define OMAP44XX_LOCAL_TWD_BASE		0x48240600
+#define OMAP44XX_VA_LOCAL_TWD_BASE	IO_ADDRESS(OMAP44XX_LOCAL_TWD_BASE)
+#define OMAP44XX_LOCAL_TWD_SIZE		0x00000100
+#define OMAP44XX_WKUPGEN_BASE		0x48281000
+#define OMAP44XX_VA_WKUPGEN_BASE	IO_ADDRESS(OMAP44XX_WKUPGEN_BASE)
+
+#endif /* __ASM_ARCH_OMAP44XX_H */
+

--EVh9lyqKgK19OcEf--
