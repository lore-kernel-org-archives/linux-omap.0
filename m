From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 06/07] ARM: OMAP2: Misc updates from linux-omap tree, v4
Date: Thu, 9 Oct 2008 18:02:34 +0300
Message-ID: <20081009150233.GH26230@atomide.com>
References: <1223035009-23866-1-git-send-email-tony@atomide.com> <1223035009-23866-2-git-send-email-tony@atomide.com> <1223035009-23866-3-git-send-email-tony@atomide.com> <1223035009-23866-4-git-send-email-tony@atomide.com> <1223035009-23866-5-git-send-email-tony@atomide.com> <1223035009-23866-6-git-send-email-tony@atomide.com> <1223035009-23866-7-git-send-email-tony@atomide.com> <20081008073910.GB30831@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="10jrOL3x2xqLmOsH"
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:55149 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753271AbYJIPCr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Oct 2008 11:02:47 -0400
Content-Disposition: inline
In-Reply-To: <20081008073910.GB30831@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org


--10jrOL3x2xqLmOsH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* Tony Lindgren <tony@atomide.com> [081008 10:37]:
> * Tony Lindgren <tony@atomide.com> [081003 14:56]:
> > Misc updates from linux-omap tree, mostly to update common
> > device initialization and add missing defines from linux-omap
> > tree. Also some changes to make room for adding 34xx in
> > following patches.
> 
> I'left out the CONFIG_VIDEO_OMAP2 changes from this patch to make it
> more readable. Here's an updated version.

And of course I forgot to remove the call to related init function
breaking compile.. One more time below. Also updates in the
omap2-upstream tree for you to pull.

Tony

--10jrOL3x2xqLmOsH
Content-Type: text/x-diff; charset=utf-8
Content-Disposition: inline; filename="omap2-misc.patch"
Content-Transfer-Encoding: 8bit

>From 646e3ed1a349fbccce651fed2d3987f0e7b0f0f4 Mon Sep 17 00:00:00 2001
From: Tony Lindgren <tony@atomide.com>
Date: Mon, 6 Oct 2008 15:49:36 +0300
Subject: [PATCH] ARM: OMAP2: Misc updates from linux-omap tree

Misc updates from linux-omap tree, mostly to update common
device initialization and add missing defines from linux-omap
tree. Also some changes to make room for adding 34xx in
following patches.

Note that the I2C resources are now set up in
arch/arm/plat-omap/i2c.c helper, and can be removed
from devices.c.

Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/mach-omap1/devices.c b/arch/arm/mach-omap1/devices.c
index ab708d4..79cfe01 100644
--- a/arch/arm/mach-omap1/devices.c
+++ b/arch/arm/mach-omap1/devices.c
@@ -101,7 +101,7 @@ static inline void omap_init_mbox(void) { }
 
 #if defined(CONFIG_OMAP_STI)
 
-#define OMAP1_STI_BASE		IO_ADDRESS(0xfffea000)
+#define OMAP1_STI_BASE		0xfffea000
 #define OMAP1_STI_CHANNEL_BASE	(OMAP1_STI_BASE + 0x400)
 
 static struct resource sti_resources[] = {
diff --git a/arch/arm/mach-omap2/clock.h b/arch/arm/mach-omap2/clock.h
index ea55f28..1fb330e 100644
--- a/arch/arm/mach-omap2/clock.h
+++ b/arch/arm/mach-omap2/clock.h
@@ -21,6 +21,7 @@
 /* The maximum error between a target DPLL rate and the rounded rate in Hz */
 #define DEFAULT_DPLL_RATE_TOLERANCE	50000
 
+int omap2_clk_init(void);
 int omap2_clk_enable(struct clk *clk);
 void omap2_clk_disable(struct clk *clk);
 long omap2_clk_round_rate(struct clk *clk, unsigned long rate);
diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index 7a7f025..7cca33e 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -23,50 +23,7 @@
 #include <mach/board.h>
 #include <mach/mux.h>
 #include <mach/gpio.h>
-
-#if	defined(CONFIG_I2C_OMAP) || defined(CONFIG_I2C_OMAP_MODULE)
-
-#define OMAP2_I2C_BASE2		0x48072000
-#define OMAP2_I2C_INT2		57
-
-static struct resource i2c_resources2[] = {
-	{
-		.start		= OMAP2_I2C_BASE2,
-		.end		= OMAP2_I2C_BASE2 + 0x3f,
-		.flags		= IORESOURCE_MEM,
-	},
-	{
-		.start		= OMAP2_I2C_INT2,
-		.flags		= IORESOURCE_IRQ,
-	},
-};
-
-static struct platform_device omap_i2c_device2 = {
-	.name           = "i2c_omap",
-	.id             = 2,
-	.num_resources	= ARRAY_SIZE(i2c_resources2),
-	.resource	= i2c_resources2,
-};
-
-/* See also arch/arm/plat-omap/devices.c for first I2C on 24xx */
-static void omap_init_i2c(void)
-{
-	/* REVISIT: Second I2C not in use on H4? */
-	if (machine_is_omap_h4())
-		return;
-
-	if (!cpu_is_omap2430()) {
-		omap_cfg_reg(J15_24XX_I2C2_SCL);
-		omap_cfg_reg(H19_24XX_I2C2_SDA);
-	}
-	(void) platform_device_register(&omap_i2c_device2);
-}
-
-#else
-
-static void omap_init_i2c(void) {}
-
-#endif
+#include <mach/eac.h>
 
 #if defined(CONFIG_OMAP_DSP) || defined(CONFIG_OMAP_DSP_MODULE)
 #define OMAP2_MBOX_BASE		IO_ADDRESS(OMAP24XX_MAILBOX_BASE)
@@ -104,7 +61,9 @@ static inline void omap_init_mbox(void) { }
 
 #if defined(CONFIG_OMAP_STI)
 
-#define OMAP2_STI_BASE		IO_ADDRESS(0x48068000)
+#if defined(CONFIG_ARCH_OMAP2)
+
+#define OMAP2_STI_BASE		0x48068000
 #define OMAP2_STI_CHANNEL_BASE	0x54000000
 #define OMAP2_STI_IRQ		4
 
@@ -124,6 +83,25 @@ static struct resource sti_resources[] = {
 		.flags		= IORESOURCE_IRQ,
 	}
 };
+#elif defined(CONFIG_ARCH_OMAP3)
+
+#define OMAP3_SDTI_BASE		0x54500000
+#define OMAP3_SDTI_CHANNEL_BASE	0x54600000
+
+static struct resource sti_resources[] = {
+	{
+		.start		= OMAP3_SDTI_BASE,
+		.end		= OMAP3_SDTI_BASE + 0xFFF,
+		.flags		= IORESOURCE_MEM,
+	},
+	{
+		.start		= OMAP3_SDTI_CHANNEL_BASE,
+		.end		= OMAP3_SDTI_CHANNEL_BASE + SZ_1M - 1,
+		.flags		= IORESOURCE_MEM,
+	}
+};
+
+#endif
 
 static struct platform_device sti_device = {
 	.name		= "sti",
@@ -140,12 +118,14 @@ static inline void omap_init_sti(void)
 static inline void omap_init_sti(void) {}
 #endif
 
-#if defined(CONFIG_SPI_OMAP24XX)
+#if defined(CONFIG_SPI_OMAP24XX) || defined(CONFIG_SPI_OMAP24XX_MODULE)
 
 #include <mach/mcspi.h>
 
 #define OMAP2_MCSPI1_BASE		0x48098000
 #define OMAP2_MCSPI2_BASE		0x4809a000
+#define OMAP2_MCSPI3_BASE		0x480b8000
+#define OMAP2_MCSPI4_BASE		0x480ba000
 
 static struct omap2_mcspi_platform_config omap2_mcspi1_config = {
 	.num_cs		= 4,
@@ -159,7 +139,7 @@ static struct resource omap2_mcspi1_resources[] = {
 	},
 };
 
-struct platform_device omap2_mcspi1 = {
+static struct platform_device omap2_mcspi1 = {
 	.name		= "omap2_mcspi",
 	.id		= 1,
 	.num_resources	= ARRAY_SIZE(omap2_mcspi1_resources),
@@ -181,7 +161,7 @@ static struct resource omap2_mcspi2_resources[] = {
 	},
 };
 
-struct platform_device omap2_mcspi2 = {
+static struct platform_device omap2_mcspi2 = {
 	.name		= "omap2_mcspi",
 	.id		= 2,
 	.num_resources	= ARRAY_SIZE(omap2_mcspi2_resources),
@@ -191,16 +171,162 @@ struct platform_device omap2_mcspi2 = {
 	},
 };
 
+#if defined(CONFIG_ARCH_OMAP2430) || defined(CONFIG_ARCH_OMAP3)
+static struct omap2_mcspi_platform_config omap2_mcspi3_config = {
+	.num_cs		= 2,
+};
+
+static struct resource omap2_mcspi3_resources[] = {
+	{
+	.start		= OMAP2_MCSPI3_BASE,
+	.end		= OMAP2_MCSPI3_BASE + 0xff,
+	.flags		= IORESOURCE_MEM,
+	},
+};
+
+static struct platform_device omap2_mcspi3 = {
+	.name		= "omap2_mcspi",
+	.id		= 3,
+	.num_resources	= ARRAY_SIZE(omap2_mcspi3_resources),
+	.resource	= omap2_mcspi3_resources,
+	.dev		= {
+		.platform_data = &omap2_mcspi3_config,
+	},
+};
+#endif
+
+#ifdef CONFIG_ARCH_OMAP3
+static struct omap2_mcspi_platform_config omap2_mcspi4_config = {
+	.num_cs		= 1,
+};
+
+static struct resource omap2_mcspi4_resources[] = {
+	{
+		.start		= OMAP2_MCSPI4_BASE,
+		.end		= OMAP2_MCSPI4_BASE + 0xff,
+		.flags		= IORESOURCE_MEM,
+	},
+};
+
+static struct platform_device omap2_mcspi4 = {
+	.name		= "omap2_mcspi",
+	.id		= 4,
+	.num_resources	= ARRAY_SIZE(omap2_mcspi4_resources),
+	.resource	= omap2_mcspi4_resources,
+	.dev		= {
+		.platform_data = &omap2_mcspi4_config,
+	},
+};
+#endif
+
 static void omap_init_mcspi(void)
 {
 	platform_device_register(&omap2_mcspi1);
 	platform_device_register(&omap2_mcspi2);
+#if defined(CONFIG_ARCH_OMAP2430) || defined(CONFIG_ARCH_OMAP3)
+	platform_device_register(&omap2_mcspi3);
+#endif
+#ifdef CONFIG_ARCH_OMAP3
+	platform_device_register(&omap2_mcspi4);
+#endif
 }
 
 #else
 static inline void omap_init_mcspi(void) {}
 #endif
 
+#ifdef CONFIG_SND_OMAP24XX_EAC
+
+#define OMAP2_EAC_BASE			0x48090000
+
+static struct resource omap2_eac_resources[] = {
+	{
+		.start		= OMAP2_EAC_BASE,
+		.end		= OMAP2_EAC_BASE + 0x109,
+		.flags		= IORESOURCE_MEM,
+	},
+};
+
+static struct platform_device omap2_eac_device = {
+	.name		= "omap24xx-eac",
+	.id		= -1,
+	.num_resources	= ARRAY_SIZE(omap2_eac_resources),
+	.resource	= omap2_eac_resources,
+	.dev = {
+		.platform_data = NULL,
+	},
+};
+
+void omap_init_eac(struct eac_platform_data *pdata)
+{
+	omap2_eac_device.dev.platform_data = pdata;
+	platform_device_register(&omap2_eac_device);
+}
+
+#else
+void omap_init_eac(struct eac_platform_data *pdata) {}
+#endif
+
+#ifdef CONFIG_OMAP_SHA1_MD5
+static struct resource sha1_md5_resources[] = {
+	{
+		.start	= OMAP24XX_SEC_SHA1MD5_BASE,
+		.end	= OMAP24XX_SEC_SHA1MD5_BASE + 0x64,
+		.flags	= IORESOURCE_MEM,
+	},
+	{
+		.start	= INT_24XX_SHA1MD5,
+		.flags	= IORESOURCE_IRQ,
+	}
+};
+
+static struct platform_device sha1_md5_device = {
+	.name		= "OMAP SHA1/MD5",
+	.id		= -1,
+	.num_resources	= ARRAY_SIZE(sha1_md5_resources),
+	.resource	= sha1_md5_resources,
+};
+
+static void omap_init_sha1_md5(void)
+{
+	platform_device_register(&sha1_md5_device);
+}
+#else
+static inline void omap_init_sha1_md5(void) { }
+#endif
+
+#if defined(CONFIG_HDQ_MASTER_OMAP) || defined(CONFIG_HDQ_MASTER_OMAP_MODULE)
+#if defined(CONFIG_ARCH_OMAP2430) || defined(CONFIG_ARCH_OMAP3430)
+#define OMAP_HDQ_BASE	0x480B2000
+#endif
+static struct resource omap_hdq_resources[] = {
+	{
+		.start		= OMAP_HDQ_BASE,
+		.end		= OMAP_HDQ_BASE + 0x1C,
+		.flags		= IORESOURCE_MEM,
+	},
+	{
+		.start		= INT_24XX_HDQ_IRQ,
+		.flags		= IORESOURCE_IRQ,
+	},
+};
+static struct platform_device omap_hdq_dev = {
+	.name = "omap_hdq",
+	.id = 0,
+	.dev = {
+		.platform_data = NULL,
+	},
+	.num_resources	= ARRAY_SIZE(omap_hdq_resources),
+	.resource	= omap_hdq_resources,
+};
+static inline void omap_hdq_init(void)
+{
+	(void) platform_device_register(&omap_hdq_dev);
+}
+#else
+static inline void omap_hdq_init(void) {}
+#endif
+
 /*-------------------------------------------------------------------------*/
 
 static int __init omap2_init_devices(void)
@@ -208,10 +334,11 @@ static int __init omap2_init_devices(void)
 	/* please keep these calls, and their implementations above,
 	 * in alphabetical order so they're easier to sort through.
 	 */
-	omap_init_i2c();
 	omap_init_mbox();
 	omap_init_mcspi();
+	omap_hdq_init();
 	omap_init_sti();
+	omap_init_sha1_md5();
 
 	return 0;
 }
diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index be6a753..149bfba 100644
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -23,7 +23,7 @@
 #include <asm/mach-types.h>
 #include <mach/gpmc.h>
 
-#include "memory.h"
+#include <mach/sdrc.h>
 
 /* GPMC register offsets */
 #define GPMC_REVISION		0x00
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index 371e540..03c6ab1 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -4,8 +4,11 @@
  * OMAP2 I/O mapping code
  *
  * Copyright (C) 2005 Nokia Corporation
- * Author: Juha Yrjölä <juha.yrjola@nokia.com>
- * Updated map desc to add 2430 support : <x0khasim@ti.com>
+ * Copyright (C) 2007 Texas Instruments
+ *
+ * Author:
+ *	Juha Yrjola <juha.yrjola@nokia.com>
+ *	Syed Khasim <x0khasim@ti.com>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -23,6 +26,11 @@
 
 #include <mach/mux.h>
 #include <mach/omapfb.h>
+#include <mach/sram.h>
+
+#include "memory.h"
+
+#include "clock.h"
 
 #include <mach/powerdomain.h>
 
@@ -31,13 +39,6 @@
 #include <mach/clockdomain.h>
 #include "clockdomains.h"
 
-extern void omap_sram_init(void);
-extern int omap2_clk_init(void);
-extern void omap2_check_revision(void);
-extern void omap2_init_memory(void);
-extern void gpmc_init(void);
-extern void omapfb_reserve_sdram(void);
-
 /*
  * The machine specific code may provide the extra mapping besides the
  * default mapping provided here.
diff --git a/arch/arm/mach-omap2/irq.c b/arch/arm/mach-omap2/irq.c
index 742bd00..a5c748a 100644
--- a/arch/arm/mach-omap2/irq.c
+++ b/arch/arm/mach-omap2/irq.c
@@ -37,11 +37,9 @@ static struct omap_irq_bank {
 } __attribute__ ((aligned(4))) irq_banks[] = {
 	{
 		/* MPU INTC */
-		.base_reg	= IO_ADDRESS(OMAP24XX_IC_BASE),
+		.base_reg	= 0,
 		.nr_irqs	= 96,
-	}, {
-		/* XXX: DSP INTC */
-	}
+	},
 };
 
 /* XXX: FIQ and additional INTC support (only MPU at the moment) */
@@ -118,10 +116,8 @@ void __init omap_init_irq(void)
 	for (i = 0; i < ARRAY_SIZE(irq_banks); i++) {
 		struct omap_irq_bank *bank = irq_banks + i;
 
-		/* XXX */
-		if (!bank->base_reg)
-			continue;
-
+		if (cpu_is_omap24xx())
+			bank->base_reg = IO_ADDRESS(OMAP24XX_IC_BASE);
 		omap_irq_bank_init_one(bank);
 
 		nr_irqs += bank->nr_irqs;
diff --git a/arch/arm/mach-omap2/memory.h b/arch/arm/mach-omap2/memory.h
index 9a280b5..bb3db80 100644
--- a/arch/arm/mach-omap2/memory.h
+++ b/arch/arm/mach-omap2/memory.h
@@ -14,6 +14,9 @@
  * published by the Free Software Foundation.
  */
 
+#ifndef ARCH_ARM_MACH_OMAP2_MEMORY_H
+#define ARCH_ARM_MACH_OMAP2_MEMORY_H
+
 /* Memory timings */
 #define M_DDR		1
 #define M_LOCK_CTRL	(1 << 2)
@@ -34,3 +37,7 @@ extern u32 omap2_memory_get_fast_dll_ctrl(void);
 extern u32 omap2_memory_get_type(void);
 u32 omap2_dll_force_needed(void);
 u32 omap2_reprogram_sdrc(u32 level, u32 force);
+void __init omap2_init_memory(void);
+void __init gpmc_init(void);
+
+#endif
diff --git a/arch/arm/plat-omap/devices.c b/arch/arm/plat-omap/devices.c
index 187e3d8..1c1d831 100644
--- a/arch/arm/plat-omap/devices.c
+++ b/arch/arm/plat-omap/devices.c
@@ -20,16 +20,16 @@
 #include <asm/mach/map.h>
 
 #include <mach/tc.h>
+#include <mach/control.h>
 #include <mach/board.h>
 #include <mach/mux.h>
 #include <mach/gpio.h>
 #include <mach/menelaus.h>
 #include <mach/mcbsp.h>
+#include <mach/dsp_common.h>
 
 #if	defined(CONFIG_OMAP_DSP) || defined(CONFIG_OMAP_DSP_MODULE)
 
-#include "../plat-omap/dsp/dsp_common.h"
-
 static struct dsp_platform_data dsp_pdata = {
 	.kdev_list = LIST_HEAD_INIT(dsp_pdata.kdev_list),
 };
@@ -75,7 +75,7 @@ int dsp_kfunc_device_register(struct dsp_kfunc_device *kdev)
 {
 	static DEFINE_MUTEX(dsp_pdata_lock);
 
-	mutex_init(&kdev->lock);
+	spin_lock_init(&kdev->lock);
 
 	mutex_lock(&dsp_pdata_lock);
 	list_add_tail(&kdev->entry, &dsp_pdata.kdev_list);
@@ -479,10 +479,6 @@ static inline void omap_init_rng(void) {}
  */
 static int __init omap_init_devices(void)
 {
-/*
- * Need to enable relevant once for 2430 SDP
- */
-#ifndef CONFIG_MACH_OMAP_2430SDP
 	/* please keep these calls, and their implementations above,
 	 * in alphabetical order so they're easier to sort through.
 	 */
@@ -492,7 +488,6 @@ static int __init omap_init_devices(void)
 	omap_init_uwire();
 	omap_init_wdt();
 	omap_init_rng();
-#endif
 	return 0;
 }
 arch_initcall(omap_init_devices);
diff --git a/arch/arm/plat-omap/include/mach/board-2430sdp.h b/arch/arm/plat-omap/include/mach/board-2430sdp.h
index cf1dc02..10d449e 100644
--- a/arch/arm/plat-omap/include/mach/board-2430sdp.h
+++ b/arch/arm/plat-omap/include/mach/board-2430sdp.h
@@ -30,10 +30,12 @@
 #define __ASM_ARCH_OMAP_2430SDP_H
 
 /* Placeholder for 2430SDP specific defines */
-#define OMAP24XX_ETHR_START		 0x08000300
+#define OMAP24XX_ETHR_START		0x08000300
 #define OMAP24XX_ETHR_GPIO_IRQ		149
 #define SDP2430_CS0_BASE		0x04000000
 
-#define TWL4030_IRQNUM			INT_24XX_SYS_NIRQ
+/* Function prototypes */
+extern void sdp2430_flash_init(void);
+extern void sdp2430_usb_init(void);
 
 #endif /* __ASM_ARCH_OMAP_2430SDP_H */
diff --git a/arch/arm/plat-omap/include/mach/board-apollon.h b/arch/arm/plat-omap/include/mach/board-apollon.h
index d6f2a8e..731c858 100644
--- a/arch/arm/plat-omap/include/mach/board-apollon.h
+++ b/arch/arm/plat-omap/include/mach/board-apollon.h
@@ -31,6 +31,12 @@
 
 extern void apollon_mmc_init(void);
 
+static inline int apollon_plus(void)
+{
+	/* The apollon plus has IDCODE revision 5 */
+	return system_rev & 0xc0;
+}
+
 /* Placeholder for APOLLON specific defines */
 #define APOLLON_ETHR_GPIO_IRQ		74
 
diff --git a/arch/arm/plat-omap/include/mach/board-h4.h b/arch/arm/plat-omap/include/mach/board-h4.h
index 1470cd3..7c3fa0f 100644
--- a/arch/arm/plat-omap/include/mach/board-h4.h
+++ b/arch/arm/plat-omap/include/mach/board-h4.h
@@ -1,7 +1,7 @@
 /*
  * arch/arm/plat-omap/include/mach/board-h4.h
  *
- * Hardware definitions for TI OMAP1610 H4 board.
+ * Hardware definitions for TI OMAP2420 H4 board.
  *
  * Initial creation by Dirk Behme <dirk.behme@de.bosch.com>
  *
@@ -29,6 +29,9 @@
 #ifndef __ASM_ARCH_OMAP_H4_H
 #define __ASM_ARCH_OMAP_H4_H
 
+/* MMC Prototypes */
+extern void h4_mmc_init(void);
+
 /* Placeholder for H4 specific defines */
 #define OMAP24XX_ETHR_GPIO_IRQ		92
 #endif /*  __ASM_ARCH_OMAP_H4_H */
diff --git a/arch/arm/plat-omap/include/mach/board.h b/arch/arm/plat-omap/include/mach/board.h
index 5444564..c23c12c 100644
--- a/arch/arm/plat-omap/include/mach/board.h
+++ b/arch/arm/plat-omap/include/mach/board.h
@@ -45,6 +45,8 @@ struct omap_mmc_conf {
 	unsigned cover:1;
 	/* 4 wire signaling is optional, and is only used for SD/SDIO */
 	unsigned wire4:1;
+	/* use the internal clock */
+	unsigned internal_clock:1;
 	s16 power_pin;
 	s16 switch_pin;
 	s16 wp_pin;
diff --git a/arch/arm/plat-omap/include/mach/control.h b/arch/arm/plat-omap/include/mach/control.h
index ee378d2..dc98867 100644
--- a/arch/arm/plat-omap/include/mach/control.h
+++ b/arch/arm/plat-omap/include/mach/control.h
@@ -1,13 +1,10 @@
-#ifndef __ASM_ARCH_CONTROL_H
-#define __ASM_ARCH_CONTROL_H
-
 /*
  * arch/arm/plat-omap/include/mach/control.h
  *
  * OMAP2/3 System Control Module definitions
  *
- * Copyright (C) 2007 Texas Instruments, Inc.
- * Copyright (C) 2007 Nokia Corporation
+ * Copyright (C) 2007-2008 Texas Instruments, Inc.
+ * Copyright (C) 2007-2008 Nokia Corporation
  *
  * Written by Paul Walmsley
  *
@@ -16,14 +13,23 @@
  * the Free Software Foundation.
  */
 
+#ifndef __ASM_ARCH_CONTROL_H
+#define __ASM_ARCH_CONTROL_H
+
 #include <mach/io.h>
 
+#ifndef __ASSEMBLY__
 #define OMAP242X_CTRL_REGADDR(reg)					\
 	IO_ADDRESS(OMAP242X_CTRL_BASE + (reg))
 #define OMAP243X_CTRL_REGADDR(reg)					\
 	IO_ADDRESS(OMAP243X_CTRL_BASE + (reg))
 #define OMAP343X_CTRL_REGADDR(reg)					\
 	IO_ADDRESS(OMAP343X_CTRL_BASE + (reg))
+#else
+#define OMAP242X_CTRL_REGADDR(reg)	IO_ADDRESS(OMAP242X_CTRL_BASE + (reg))
+#define OMAP243X_CTRL_REGADDR(reg)	IO_ADDRESS(OMAP243X_CTRL_BASE + (reg))
+#define OMAP343X_CTRL_REGADDR(reg)	IO_ADDRESS(OMAP343X_CTRL_BASE + (reg))
+#endif /* __ASSEMBLY__ */
 
 /*
  * As elsewhere, the "OMAP2_" prefix indicates that the macro is valid for
@@ -134,6 +140,7 @@
 #define OMAP343X_CONTROL_TEST_KEY_13	(OMAP2_CONTROL_GENERAL + 0x00fc)
 #define OMAP343X_CONTROL_IVA2_BOOTADDR	(OMAP2_CONTROL_GENERAL + 0x0190)
 #define OMAP343X_CONTROL_IVA2_BOOTMOD	(OMAP2_CONTROL_GENERAL + 0x0194)
+#define OMAP343X_CONTROL_TEMP_SENSOR	(OMAP2_CONTROL_GENERAL + 0x02b4)
 
 /*
  * REVISIT: This list of registers is not comprehensive - there are more
diff --git a/arch/arm/plat-omap/include/mach/gpio.h b/arch/arm/plat-omap/include/mach/gpio.h
index 4cb818d..5bb7460 100644
--- a/arch/arm/plat-omap/include/mach/gpio.h
+++ b/arch/arm/plat-omap/include/mach/gpio.h
@@ -76,6 +76,8 @@ extern void omap_free_gpio(int gpio);
 extern void omap_set_gpio_direction(int gpio, int is_input);
 extern void omap_set_gpio_dataout(int gpio, int enable);
 extern int omap_get_gpio_datain(int gpio);
+extern void omap2_gpio_prepare_for_retention(void);
+extern void omap2_gpio_resume_after_retention(void);
 extern void omap_set_gpio_debounce(int gpio, int enable);
 extern void omap_set_gpio_debounce_time(int gpio, int enable);
 
diff --git a/arch/arm/plat-omap/include/mach/gpmc.h b/arch/arm/plat-omap/include/mach/gpmc.h
index 4258e00..3c7b425 100644
--- a/arch/arm/plat-omap/include/mach/gpmc.h
+++ b/arch/arm/plat-omap/include/mach/gpmc.h
@@ -25,6 +25,9 @@
 #define GPMC_CS_NAND_ADDRESS	0x20
 #define GPMC_CS_NAND_DATA	0x24
 
+#define GPMC_CONFIG		0x50
+#define GPMC_STATUS		0x54
+
 #define GPMC_CONFIG1_WRAPBURST_SUPP     (1 << 31)
 #define GPMC_CONFIG1_READMULTIPLE_SUPP  (1 << 30)
 #define GPMC_CONFIG1_READTYPE_ASYNC     (0 << 29)
diff --git a/arch/arm/plat-omap/include/mach/hardware.h b/arch/arm/plat-omap/include/mach/hardware.h
index abb01e4..29c849f 100644
--- a/arch/arm/plat-omap/include/mach/hardware.h
+++ b/arch/arm/plat-omap/include/mach/hardware.h
@@ -282,8 +282,8 @@
 
 #include "omap730.h"
 #include "omap1510.h"
-#include "omap24xx.h"
 #include "omap16xx.h"
+#include "omap24xx.h"
 #include "omap34xx.h"
 
 #ifndef __ASSEMBLER__
diff --git a/arch/arm/plat-omap/include/mach/irqs.h b/arch/arm/plat-omap/include/mach/irqs.h
index 17248bb..e9fd630 100644
--- a/arch/arm/plat-omap/include/mach/irqs.h
+++ b/arch/arm/plat-omap/include/mach/irqs.h
@@ -125,6 +125,7 @@
 #define INT_UART2		(15 + IH2_BASE)
 #define INT_BT_MCSI1TX		(16 + IH2_BASE)
 #define INT_BT_MCSI1RX		(17 + IH2_BASE)
+#define INT_SOSSI_MATCH		(19 + IH2_BASE)
 #define INT_USB_W2FC		(20 + IH2_BASE)
 #define INT_1WIRE		(21 + IH2_BASE)
 #define INT_OS_TIMER		(22 + IH2_BASE)
@@ -176,6 +177,7 @@
 #define INT_1610_DMA_CH14	(61 + IH2_BASE)
 #define INT_1610_DMA_CH15	(62 + IH2_BASE)
 #define INT_1610_NAND		(63 + IH2_BASE)
+#define INT_1610_SHA1MD5	(91 + IH2_BASE)
 
 /*
  * OMAP-730 specific IRQ numbers for interrupt handler 2
@@ -263,12 +265,16 @@
 #define INT_24XX_GPTIMER10	46
 #define INT_24XX_GPTIMER11	47
 #define INT_24XX_GPTIMER12	48
+#define INT_24XX_SHA1MD5	51
 #define INT_24XX_I2C1_IRQ	56
 #define INT_24XX_I2C2_IRQ	57
+#define INT_24XX_HDQ_IRQ	58
 #define INT_24XX_MCBSP1_IRQ_TX	59
 #define INT_24XX_MCBSP1_IRQ_RX	60
 #define INT_24XX_MCBSP2_IRQ_TX	62
 #define INT_24XX_MCBSP2_IRQ_RX	63
+#define INT_24XX_SPI1_IRQ	65
+#define INT_24XX_SPI2_IRQ	66
 #define INT_24XX_UART1_IRQ	72
 #define INT_24XX_UART2_IRQ	73
 #define INT_24XX_UART3_IRQ	74
diff --git a/arch/arm/plat-omap/include/mach/omap1510.h b/arch/arm/plat-omap/include/mach/omap1510.h
index 505a38a..d240046 100644
--- a/arch/arm/plat-omap/include/mach/omap1510.h
+++ b/arch/arm/plat-omap/include/mach/omap1510.h
@@ -44,5 +44,7 @@
 #define OMAP1510_DSPREG_SIZE	SZ_128K
 #define OMAP1510_DSPREG_START	0xE1000000
 
+#define OMAP1510_DSP_MMU_BASE	(0xfffed200)
+
 #endif /*  __ASM_ARCH_OMAP15XX_H */
 
diff --git a/arch/arm/plat-omap/include/mach/omap16xx.h b/arch/arm/plat-omap/include/mach/omap16xx.h
index c6c93af..0e69b50 100644
--- a/arch/arm/plat-omap/include/mach/omap16xx.h
+++ b/arch/arm/plat-omap/include/mach/omap16xx.h
@@ -44,6 +44,11 @@
 #define OMAP16XX_DSPREG_SIZE	SZ_128K
 #define OMAP16XX_DSPREG_START	0xE1000000
 
+#define OMAP16XX_SEC_BASE	0xFFFE4000
+#define OMAP16XX_SEC_DES	(OMAP16XX_SEC_BASE + 0x0000)
+#define OMAP16XX_SEC_SHA1MD5	(OMAP16XX_SEC_BASE + 0x0800)
+#define OMAP16XX_SEC_RNG	(OMAP16XX_SEC_BASE + 0x1000)
+
 /*
  * ---------------------------------------------------------------------------
  * Interrupts
@@ -190,7 +195,7 @@
 #define WSPR_DISABLE_0         (0x0000aaaa)
 #define WSPR_DISABLE_1         (0x00005555)
 
-/* Mailbox */
+#define OMAP16XX_DSP_MMU_BASE	(0xfffed200)
 #define OMAP16XX_MAILBOX_BASE	(0xfffcf000)
 
 #endif /*  __ASM_ARCH_OMAP16XX_H */
diff --git a/arch/arm/plat-omap/include/mach/omapfb.h b/arch/arm/plat-omap/include/mach/omapfb.h
index cae037d..ec67fb4 100644
--- a/arch/arm/plat-omap/include/mach/omapfb.h
+++ b/arch/arm/plat-omap/include/mach/omapfb.h
@@ -62,6 +62,7 @@
 #define OMAPFB_CAPS_WINDOW_PIXEL_DOUBLE	0x00010000
 #define OMAPFB_CAPS_WINDOW_SCALE	0x00020000
 #define OMAPFB_CAPS_WINDOW_OVERLAY	0x00040000
+#define OMAPFB_CAPS_WINDOW_ROTATE	0x00080000
 #define OMAPFB_CAPS_SET_BACKLIGHT	0x01000000
 
 /* Values from DSP must map to lower 16-bits */
@@ -305,6 +306,7 @@ struct lcd_ctrl {
 					   int screen_width,
 					   int pos_x, int pos_y, int width,
 					   int height, int color_mode);
+	int		(*set_rotate)	  (int angle);
 	int		(*setup_mem)	  (int plane, size_t size,
 					   int mem_type, unsigned long *paddr);
 	int		(*mmap)		  (struct fb_info *info,
@@ -374,6 +376,7 @@ extern struct lcd_ctrl omap1_lcd_ctrl;
 extern struct lcd_ctrl omap2_disp_ctrl;
 #endif
 
+extern void omapfb_reserve_sdram(void);
 extern void omapfb_register_panel(struct lcd_panel *panel);
 extern void omapfb_write_first_pixel(struct omapfb_device *fbdev, u16 pixval);
 extern void omapfb_notify_clients(struct omapfb_device *fbdev,
diff --git a/arch/arm/plat-omap/include/mach/sdrc.h b/arch/arm/plat-omap/include/mach/sdrc.h
index d908eb5..25ee381 100644
--- a/arch/arm/plat-omap/include/mach/sdrc.h
+++ b/arch/arm/plat-omap/include/mach/sdrc.h
@@ -25,6 +25,8 @@
 #define SDRC_DLLB_STATUS	0x06C
 #define SDRC_POWER		0x070
 #define SDRC_MR_0		0x084
+#define SDRC_ACTIM_CTRL_A	0x09c
+#define SDRC_ACTIM_CTRL_B	0x0a0
 #define SDRC_RFR_CTRL_0		0x0a4
 
 /*

--10jrOL3x2xqLmOsH--
