From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 14/16] ARM: OMAP2: Misc updates from linux-omap tree
Date: Sat, 23 Aug 2008 15:43:03 -0700
Message-ID: <20080823224302.GF4713@atomide.com>
References: <1212804762-18413-6-git-send-email-tony@atomide.com> <1212804762-18413-7-git-send-email-tony@atomide.com> <1212804762-18413-8-git-send-email-tony@atomide.com> <1212804762-18413-9-git-send-email-tony@atomide.com> <1212804762-18413-10-git-send-email-tony@atomide.com> <1212804762-18413-11-git-send-email-tony@atomide.com> <1212804762-18413-12-git-send-email-tony@atomide.com> <1212804762-18413-13-git-send-email-tony@atomide.com> <20080819210807.GE17034@flint.arm.linux.org.uk> <20080820074242.GE28862@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="ILuaRSyQpoVaJ1HG"
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:52475 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753266AbYHWWnL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 23 Aug 2008 18:43:11 -0400
Content-Disposition: inline
In-Reply-To: <20080820074242.GE28862@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org


--ILuaRSyQpoVaJ1HG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* Tony Lindgren <tony@atomide.com> [080820 00:43]:
> * Russell King - ARM Linux <linux@arm.linux.org.uk> [080820 00:08]:
> > On Fri, Jun 06, 2008 at 07:12:40PM -0700, Tony Lindgren wrote:
> > > @@ -208,10 +365,12 @@ static int __init omap2_init_devices(void)
> > >  	/* please keep these calls, and their implementations above,
> > >  	 * in alphabetical order so they're easier to sort through.
> > >  	 */
> > > -	omap_init_i2c();
> > > +	omap_init_camera();
> > >  	omap_init_mbox();
> > >  	omap_init_mcspi();
> > > +	omap_hdq_init();
> > >  	omap_init_sti();
> > > +	omap_init_sha1_md5();
> > >  
> > >  	return 0;
> > >  }
> > 
> > Hmm, looking through this file, looking at:
> > 1. the conditionals on the machine type
> > 2. the CONFIG_ dependencies for CPU driver versions
> > 
> > and then considering... what if a platform only supports one mcspi,
> > should we be registering all mcspi's...
> > 
> > Wouldn't it be better to let the platforms themselves decide which
> > devices should be registered, just like AT91 does and now PXA?
> 
> Yes, the struct omap2_mcspi_device_config is already coming from
> board-*.c files. But the mach-omap2/board-*.c files will be coming
> after the core code has been merged.
> 
> > > +#ifndef __ASM_ARCH_CONTROL_H
> > > +#define __ASM_ARCH_CONTROL_H
> > > +
> > >  #include <asm/arch/io.h>
> > >  
> > > +#ifndef __ASSEMBLY__
> > >  #define OMAP242X_CTRL_REGADDR(reg)					\
> > > -	(void __iomem *)IO_ADDRESS(OMAP242X_CTRL_BASE + (reg))
> > > +	(__force void __iomem *)IO_ADDRESS(OMAP242X_CTRL_BASE + (reg))
> > >  #define OMAP243X_CTRL_REGADDR(reg)					\
> > > -	(void __iomem *)IO_ADDRESS(OMAP243X_CTRL_BASE + (reg))
> > > +	(__force void __iomem *)IO_ADDRESS(OMAP243X_CTRL_BASE + (reg))
> > >  #define OMAP343X_CTRL_REGADDR(reg)					\
> > > -	(void __iomem *)IO_ADDRESS(OMAP343X_CTRL_BASE + (reg))
> > > +	(__force void __iomem *)IO_ADDRESS(OMAP343X_CTRL_BASE + (reg))
> > 
> > There's those big warning casts again.  If you moved that inside
> > IO_ADDRESS() then you wouldn't need all these #ifndef __ASSEMBLY__
> > stuff whereever you use that macro.
> 
> Will remove these. I have some mach/io.h clean up patches coming up for
> the next merge window that should take care of this.

Here's this patch updated.

Tony

--ILuaRSyQpoVaJ1HG
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline; filename=0014-misc-updates
Content-Transfer-Encoding: 8bit

>From 87c3c0621703f0f9ce5d614930d3be97cda4f8e2 Mon Sep 17 00:00:00 2001
From: Tony Lindgren <tony@atomide.com>
Date: Sat, 23 Aug 2008 15:42:22 -0700
Subject: [PATCH] ARM: OMAP2: Misc updates from linux-omap tree

Misc updates from linux-omap tree

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
diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index 7a7f025..cc5c294 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -13,9 +13,9 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/platform_device.h>
+#include <linux/io.h>
 
 #include <mach/hardware.h>
-#include <asm/io.h>
 #include <asm/mach-types.h>
 #include <asm/mach/map.h>
 
@@ -23,49 +23,37 @@
 #include <mach/board.h>
 #include <mach/mux.h>
 #include <mach/gpio.h>
+#include <mach/eac.h>
 
-#if	defined(CONFIG_I2C_OMAP) || defined(CONFIG_I2C_OMAP_MODULE)
+#if defined(CONFIG_VIDEO_OMAP2) || defined(CONFIG_VIDEO_OMAP2_MODULE)
 
-#define OMAP2_I2C_BASE2		0x48072000
-#define OMAP2_I2C_INT2		57
-
-static struct resource i2c_resources2[] = {
+static struct resource cam_resources[] = {
 	{
-		.start		= OMAP2_I2C_BASE2,
-		.end		= OMAP2_I2C_BASE2 + 0x3f,
+		.start		= OMAP24XX_CAMERA_BASE,
+		.end		= OMAP24XX_CAMERA_BASE + 0xfff,
 		.flags		= IORESOURCE_MEM,
 	},
 	{
-		.start		= OMAP2_I2C_INT2,
+		.start		= INT_24XX_CAM_IRQ,
 		.flags		= IORESOURCE_IRQ,
-	},
+	}
 };
 
-static struct platform_device omap_i2c_device2 = {
-	.name           = "i2c_omap",
-	.id             = 2,
-	.num_resources	= ARRAY_SIZE(i2c_resources2),
-	.resource	= i2c_resources2,
+static struct platform_device omap_cam_device = {
+	.name		= "omap24xxcam",
+	.id		= -1,
+	.num_resources	= ARRAY_SIZE(cam_resources),
+	.resource	= cam_resources,
 };
 
-/* See also arch/arm/plat-omap/devices.c for first I2C on 24xx */
-static void omap_init_i2c(void)
+static inline void omap_init_camera(void)
 {
-	/* REVISIT: Second I2C not in use on H4? */
-	if (machine_is_omap_h4())
-		return;
-
-	if (!cpu_is_omap2430()) {
-		omap_cfg_reg(J15_24XX_I2C2_SCL);
-		omap_cfg_reg(H19_24XX_I2C2_SDA);
-	}
-	(void) platform_device_register(&omap_i2c_device2);
+	platform_device_register(&omap_cam_device);
 }
-
 #else
-
-static void omap_init_i2c(void) {}
-
+static inline void omap_init_camera(void)
+{
+}
 #endif
 
 #if defined(CONFIG_OMAP_DSP) || defined(CONFIG_OMAP_DSP_MODULE)
@@ -104,7 +92,9 @@ static inline void omap_init_mbox(void) { }
 
 #if defined(CONFIG_OMAP_STI)
 
-#define OMAP2_STI_BASE		IO_ADDRESS(0x48068000)
+#if defined(CONFIG_ARCH_OMAP2)
+
+#define OMAP2_STI_BASE		0x48068000
 #define OMAP2_STI_CHANNEL_BASE	0x54000000
 #define OMAP2_STI_IRQ		4
 
@@ -124,6 +114,25 @@ static struct resource sti_resources[] = {
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
@@ -140,12 +149,14 @@ static inline void omap_init_sti(void)
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
@@ -159,7 +170,7 @@ static struct resource omap2_mcspi1_resources[] = {
 	},
 };
 
-struct platform_device omap2_mcspi1 = {
+static struct platform_device omap2_mcspi1 = {
 	.name		= "omap2_mcspi",
 	.id		= 1,
 	.num_resources	= ARRAY_SIZE(omap2_mcspi1_resources),
@@ -181,7 +192,7 @@ static struct resource omap2_mcspi2_resources[] = {
 	},
 };
 
-struct platform_device omap2_mcspi2 = {
+static struct platform_device omap2_mcspi2 = {
 	.name		= "omap2_mcspi",
 	.id		= 2,
 	.num_resources	= ARRAY_SIZE(omap2_mcspi2_resources),
@@ -191,16 +202,162 @@ struct platform_device omap2_mcspi2 = {
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
@@ -208,10 +365,12 @@ static int __init omap2_init_devices(void)
 	/* please keep these calls, and their implementations above,
 	 * in alphabetical order so they're easier to sort through.
 	 */
-	omap_init_i2c();
+	omap_init_camera();
 	omap_init_mbox();
 	omap_init_mcspi();
+	omap_hdq_init();
 	omap_init_sti();
+	omap_init_sha1_md5();
 
 	return 0;
 }
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index 371e540..81a751b 100644
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
@@ -15,14 +18,19 @@
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
+#include <linux/io.h>
 
 #include <asm/tlb.h>
-#include <asm/io.h>
 
 #include <asm/mach/map.h>
 
 #include <mach/mux.h>
 #include <mach/omapfb.h>
+#include <mach/sram.h>
+
+#include "memory.h"
+
+#include "clock.h"
 
 #include <mach/powerdomain.h>
 
@@ -31,18 +39,13 @@
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
  */
-static struct map_desc omap2_io_desc[] __initdata = {
+
+#ifdef CONFIG_ARCH_OMAP24XX
+static struct map_desc omap24xx_io_desc[] __initdata = {
 	{
 		.virtual	= L3_24XX_VIRT,
 		.pfn		= __phys_to_pfn(L3_24XX_PHYS),
@@ -50,12 +53,39 @@ static struct map_desc omap2_io_desc[] __initdata = {
 		.type		= MT_DEVICE
 	},
 	{
-		.virtual        = L4_24XX_VIRT,
-		.pfn            = __phys_to_pfn(L4_24XX_PHYS),
-		.length         = L4_24XX_SIZE,
-		.type           = MT_DEVICE
+		.virtual	= L4_24XX_VIRT,
+		.pfn		= __phys_to_pfn(L4_24XX_PHYS),
+		.length		= L4_24XX_SIZE,
+		.type		= MT_DEVICE
+	},
+};
+
+#ifdef CONFIG_ARCH_OMAP2420
+static struct map_desc omap242x_io_desc[] __initdata = {
+	{
+		.virtual	= DSP_MEM_24XX_VIRT,
+		.pfn		= __phys_to_pfn(DSP_MEM_24XX_PHYS),
+		.length		= DSP_MEM_24XX_SIZE,
+		.type		= MT_DEVICE
+	},
+	{
+		.virtual	= DSP_IPI_24XX_VIRT,
+		.pfn		= __phys_to_pfn(DSP_IPI_24XX_PHYS),
+		.length		= DSP_IPI_24XX_SIZE,
+		.type		= MT_DEVICE
+	},
+	{
+		.virtual	= DSP_MMU_24XX_VIRT,
+		.pfn		= __phys_to_pfn(DSP_MMU_24XX_PHYS),
+		.length		= DSP_MMU_24XX_SIZE,
+		.type		= MT_DEVICE
 	},
+};
+
+#endif
+
 #ifdef CONFIG_ARCH_OMAP2430
+static struct map_desc omap243x_io_desc[] __initdata = {
 	{
 		.virtual	= L4_WK_243X_VIRT,
 		.pfn		= __phys_to_pfn(L4_WK_243X_PHYS),
@@ -68,30 +98,33 @@ static struct map_desc omap2_io_desc[] __initdata = {
 		.length		= OMAP243X_GPMC_SIZE,
 		.type		= MT_DEVICE
 	},
-#endif
 	{
-		.virtual	= DSP_MEM_24XX_VIRT,
-		.pfn		= __phys_to_pfn(DSP_MEM_24XX_PHYS),
-		.length		= DSP_MEM_24XX_SIZE,
+		.virtual	= OMAP243X_SDRC_VIRT,
+		.pfn		= __phys_to_pfn(OMAP243X_SDRC_PHYS),
+		.length		= OMAP243X_SDRC_SIZE,
 		.type		= MT_DEVICE
 	},
 	{
-		.virtual	= DSP_IPI_24XX_VIRT,
-		.pfn		= __phys_to_pfn(DSP_IPI_24XX_PHYS),
-		.length		= DSP_IPI_24XX_SIZE,
+		.virtual	= OMAP243X_SMS_VIRT,
+		.pfn		= __phys_to_pfn(OMAP243X_SMS_PHYS),
+		.length		= OMAP243X_SMS_SIZE,
 		.type		= MT_DEVICE
 	},
-	{
-		.virtual	= DSP_MMU_24XX_VIRT,
-		.pfn		= __phys_to_pfn(DSP_MMU_24XX_PHYS),
-		.length		= DSP_MMU_24XX_SIZE,
-		.type		= MT_DEVICE
-	}
 };
+#endif
+#endif
 
 void __init omap2_map_common_io(void)
 {
-	iotable_init(omap2_io_desc, ARRAY_SIZE(omap2_io_desc));
+#if defined(CONFIG_ARCH_OMAP2420)
+	iotable_init(omap24xx_io_desc, ARRAY_SIZE(omap24xx_io_desc));
+	iotable_init(omap242x_io_desc, ARRAY_SIZE(omap242x_io_desc));
+#endif
+
+#if defined(CONFIG_ARCH_OMAP2430)
+	iotable_init(omap24xx_io_desc, ARRAY_SIZE(omap24xx_io_desc));
+	iotable_init(omap243x_io_desc, ARRAY_SIZE(omap243x_io_desc));
+#endif
 
 	/* Normally devicemaps_init() would flush caches and tlb after
 	 * mdesc->map_io(), but we must also do it here because of the CPU
@@ -111,11 +144,6 @@ void __init omap2_init_common_hw(void)
 	pwrdm_init(powerdomains_omap);
 	clkdm_init(clockdomains_omap, clkdm_pwrdm_autodeps);
 	omap2_clk_init();
-/*
- * Need to Fix this for 2430
- */
-#ifndef CONFIG_ARCH_OMAP2430
 	omap2_init_memory();
-#endif
 	gpmc_init();
 }
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
index 187e3d8..09625e6 100644
--- a/arch/arm/plat-omap/devices.c
+++ b/arch/arm/plat-omap/devices.c
@@ -20,16 +20,17 @@
 #include <asm/mach/map.h>
 
 #include <mach/tc.h>
+#include <mach/control.h>
 #include <mach/board.h>
+#include <mach/mmc.h>
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
@@ -75,7 +76,7 @@ int dsp_kfunc_device_register(struct dsp_kfunc_device *kdev)
 {
 	static DEFINE_MUTEX(dsp_pdata_lock);
 
-	mutex_init(&kdev->lock);
+	spin_lock_init(&kdev->lock);
 
 	mutex_lock(&dsp_pdata_lock);
 	list_add_tail(&kdev->entry, &dsp_pdata.kdev_list);
@@ -94,6 +95,10 @@ static inline void omap_init_dsp(void) { }
 
 static void omap_init_kp(void)
 {
+	/* REVISIT: 2430 keypad is on TWL4030 */
+	if (cpu_is_omap2430() || cpu_is_omap34xx())
+		return;
+
 	if (machine_is_omap_h2() || machine_is_omap_h3()) {
 		omap_cfg_reg(F18_1610_KBC0);
 		omap_cfg_reg(D20_1610_KBC1);
@@ -194,25 +199,38 @@ void omap_mcbsp_register_board_cfg(struct omap_mcbsp_platform_data *config,
 
 /*-------------------------------------------------------------------------*/
 
-#if	defined(CONFIG_MMC_OMAP) || defined(CONFIG_MMC_OMAP_MODULE)
+#if	defined(CONFIG_MMC_OMAP) || defined(CONFIG_MMC_OMAP_MODULE) \
+	|| defined(CONFIG_MMC_OMAP_HS) || defined(CONFIG_MMC_OMAP_HS_MODULE)
 
-#ifdef CONFIG_ARCH_OMAP24XX
+#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
 #define	OMAP_MMC1_BASE		0x4809c000
-#define OMAP_MMC1_INT		INT_24XX_MMC_IRQ
+#define	OMAP_MMC1_END		OMAP_MMC1_BASE + 0x1fc
+#define	OMAP_MMC1_INT		INT_24XX_MMC_IRQ
+
+#define	OMAP_MMC2_BASE		0x480b4000
+#define	OMAP_MMC2_END		OMAP_MMC2_BASE + 0x1fc
+#define	OMAP_MMC2_INT		INT_24XX_MMC2_IRQ
+
 #else
+
 #define	OMAP_MMC1_BASE		0xfffb7800
+#define	OMAP_MMC1_END		OMAP_MMC1_BASE + 0x7f
 #define OMAP_MMC1_INT		INT_MMC
-#endif
+
 #define	OMAP_MMC2_BASE		0xfffb7c00	/* omap16xx only */
+#define	OMAP_MMC2_END		OMAP_MMC2_BASE + 0x7f
+#define	OMAP_MMC2_INT		INT_1610_MMC2
 
-static struct omap_mmc_conf mmc1_conf;
+#endif
+
+static struct omap_mmc_platform_data mmc1_data;
 
 static u64 mmc1_dmamask = 0xffffffff;
 
 static struct resource mmc1_resources[] = {
 	{
 		.start		= OMAP_MMC1_BASE,
-		.end		= OMAP_MMC1_BASE + 0x7f,
+		.end		= OMAP_MMC1_END,
 		.flags		= IORESOURCE_MEM,
 	},
 	{
@@ -226,26 +244,28 @@ static struct platform_device mmc_omap_device1 = {
 	.id		= 1,
 	.dev = {
 		.dma_mask	= &mmc1_dmamask,
-		.platform_data	= &mmc1_conf,
+		.platform_data	= &mmc1_data,
 	},
 	.num_resources	= ARRAY_SIZE(mmc1_resources),
 	.resource	= mmc1_resources,
 };
 
-#ifdef	CONFIG_ARCH_OMAP16XX
+#if defined(CONFIG_ARCH_OMAP16XX) || defined(CONFIG_ARCH_OMAP2430) || \
+	defined(CONFIG_ARCH_OMAP34XX)
 
-static struct omap_mmc_conf mmc2_conf;
+static struct omap_mmc_platform_data mmc2_data;
 
 static u64 mmc2_dmamask = 0xffffffff;
 
+
 static struct resource mmc2_resources[] = {
 	{
 		.start		= OMAP_MMC2_BASE,
-		.end		= OMAP_MMC2_BASE + 0x7f,
+		.end		= OMAP_MMC2_END,
 		.flags		= IORESOURCE_MEM,
 	},
 	{
-		.start		= INT_1610_MMC2,
+		.start		= OMAP_MMC2_INT,
 		.flags		= IORESOURCE_IRQ,
 	},
 };
@@ -255,7 +275,7 @@ static struct platform_device mmc_omap_device2 = {
 	.id		= 2,
 	.dev = {
 		.dma_mask	= &mmc2_dmamask,
-		.platform_data	= &mmc2_conf,
+		.platform_data	= &mmc2_data,
 	},
 	.num_resources	= ARRAY_SIZE(mmc2_resources),
 	.resource	= mmc2_resources,
@@ -274,6 +294,20 @@ static void __init omap_init_mmc(void)
 
 	/* block 1 is always available and has just one pinout option */
 	mmc = &mmc_conf->mmc[0];
+
+	if (cpu_is_omap2430() || cpu_is_omap34xx()) {
+		if (mmc->enabled)
+			(void) platform_device_register(&mmc_omap_device1);
+
+#if defined(CONFIG_ARCH_OMAP2430) || defined(CONFIG_ARCH_OMAP34XX)
+		mmc = &mmc_conf->mmc[1];
+		if (mmc->enabled)
+			(void) platform_device_register(&mmc_omap_device2);
+#endif
+
+		return;
+	}
+
 	if (mmc->enabled) {
 		if (cpu_is_omap24xx()) {
 			omap_cfg_reg(H18_24XX_MMC_CMD);
@@ -308,7 +342,20 @@ static void __init omap_init_mmc(void)
 				omap_cfg_reg(MMC_DAT3);
 			}
 		}
-		mmc1_conf = *mmc;
+#if defined(CONFIG_ARCH_OMAP2420)
+		if (mmc->internal_clock) {
+			/*
+			 * Use internal loop-back in MMC/SDIO
+			 * Module Input Clock selection
+			 */
+			if (cpu_is_omap24xx()) {
+				u32 v = omap_ctrl_readl(OMAP2_CONTROL_DEVCONF0);
+				v |= (1 << 24); /* not used in 243x */
+				omap_ctrl_writel(v, OMAP2_CONTROL_DEVCONF0);
+			}
+		}
+#endif
+		mmc1_data.conf = *mmc;
 		(void) platform_device_register(&mmc_omap_device1);
 	}
 
@@ -337,13 +384,32 @@ static void __init omap_init_mmc(void)
 		if (cpu_is_omap1710())
 			omap_writel(omap_readl(MOD_CONF_CTRL_1) | (1 << 24),
 				     MOD_CONF_CTRL_1);
-		mmc2_conf = *mmc;
+		mmc2_data.conf = *mmc;
 		(void) platform_device_register(&mmc_omap_device2);
 	}
 #endif
 	return;
 }
+
+void omap_set_mmc_info(int host, const struct omap_mmc_platform_data *info)
+{
+	switch (host) {
+	case 1:
+		mmc1_data = *info;
+		break;
+#if defined(CONFIG_ARCH_OMAP16XX) || defined(CONFIG_ARCH_OMAP2430) || \
+	defined(CONFIG_ARCH_OMAP34XX)
+	case 2:
+		mmc2_data = *info;
+		break;
+#endif
+	default:
+		BUG();
+	}
+}
+
 #else
+void omap_set_mmc_info(int host, const struct omap_mmc_platform_data *info) {}
 static inline void omap_init_mmc(void) {}
 #endif
 
@@ -395,8 +461,17 @@ static inline void omap_init_uwire(void) {}
 
 #if	defined(CONFIG_OMAP_WATCHDOG) || defined(CONFIG_OMAP_WATCHDOG_MODULE)
 
-#ifdef CONFIG_ARCH_OMAP24XX
+#if defined(CONFIG_ARCH_OMAP34XX)
+#define	OMAP_WDT_BASE		0x48314000
+#elif defined(CONFIG_ARCH_OMAP24XX)
+
+#ifdef CONFIG_ARCH_OMAP2430
+/* WDT2 */
+#define	OMAP_WDT_BASE		0x49016000
+#else
 #define	OMAP_WDT_BASE		0x48022000
+#endif
+
 #else
 #define	OMAP_WDT_BASE		0xfffeb000
 #endif
@@ -479,10 +554,6 @@ static inline void omap_init_rng(void) {}
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
@@ -492,7 +563,6 @@ static int __init omap_init_devices(void)
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
diff --git a/arch/arm/plat-omap/include/mach/control.h b/arch/arm/plat-omap/include/mach/control.h
index e3fd62d..37f9cbe 100644
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
 	(void __iomem *)IO_ADDRESS(OMAP242X_CTRL_BASE + (reg))
 #define OMAP243X_CTRL_REGADDR(reg)					\
 	(void __iomem *)IO_ADDRESS(OMAP243X_CTRL_BASE + (reg))
 #define OMAP343X_CTRL_REGADDR(reg)					\
 	(void __iomem *)IO_ADDRESS(OMAP343X_CTRL_BASE + (reg))
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
index 94ce278..416fdf3 100644
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
index 6a8e07f..53dc246 100644
--- a/arch/arm/plat-omap/include/mach/gpmc.h
+++ b/arch/arm/plat-omap/include/mach/gpmc.h
@@ -11,6 +11,9 @@
 #ifndef __OMAP2_GPMC_H
 #define __OMAP2_GPMC_H
 
+/* Maximum Number of Chip Selects */
+#define GPMC_CS_NUM		8
+
 #define GPMC_CS_CONFIG1		0x00
 #define GPMC_CS_CONFIG2		0x04
 #define GPMC_CS_CONFIG3		0x08
@@ -22,6 +25,9 @@
 #define GPMC_CS_NAND_ADDRESS	0x20
 #define GPMC_CS_NAND_DATA	0x24
 
+#define GPMC_CONFIG		0x50
+#define GPMC_STATUS		0x54
+
 #define GPMC_CONFIG1_WRAPBURST_SUPP     (1 << 31)
 #define GPMC_CONFIG1_READMULTIPLE_SUPP  (1 << 30)
 #define GPMC_CONFIG1_READTYPE_ASYNC     (0 << 29)
@@ -81,6 +87,7 @@ struct gpmc_timings {
 };
 
 extern unsigned int gpmc_ns_to_ticks(unsigned int time_ns);
+extern unsigned int gpmc_ticks_to_ns(unsigned int ticks);
 extern unsigned int gpmc_round_ns_to_ticks(unsigned int time_ns);
 extern unsigned long gpmc_get_fclk_period(void);
 
diff --git a/arch/arm/plat-omap/include/mach/hardware.h b/arch/arm/plat-omap/include/mach/hardware.h
index 07f5d7f..7ff9a5b 100644
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
index 62aa7df..c66a3e3 100644
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
@@ -279,6 +285,44 @@
 #define INT_24XX_USB_IRQ_HSOF	79
 #define INT_24XX_USB_IRQ_OTG	80
 #define INT_24XX_MMC_IRQ	83
+#define INT_24XX_MMC2_IRQ	86
+#define INT_24XX_SPI3_IRQ	91
+
+#define INT_243X_MCBSP2_IRQ	16
+#define INT_243X_MCBSP3_IRQ	17
+#define INT_243X_MCBSP4_IRQ	18
+#define INT_243X_MCBSP5_IRQ	19
+#define INT_243X_MCBSP1_IRQ	64
+#define INT_243X_HS_USB_MC	92
+#define INT_243X_HS_USB_DMA	93
+#define INT_243X_CARKIT_IRQ	94
+
+#define INT_34XX_ST_MCBSP2_IRQ	4
+#define INT_34XX_ST_MCBSP3_IRQ	5
+#define INT_34XX_SYS_NIRQ	7
+#define INT_34XX_PRCM_MPU_IRQ	11
+#define INT_34XX_MCBSP1_IRQ	16
+#define INT_34XX_MCBSP2_IRQ	17
+#define INT_34XX_MCBSP3_IRQ	22
+#define INT_34XX_MCBSP4_IRQ	23
+#define INT_34XX_CAM_IRQ	24
+#define INT_34XX_MCBSP5_IRQ	27
+#define INT_34XX_GPIO_BANK1	29
+#define INT_34XX_GPIO_BANK2	30
+#define INT_34XX_GPIO_BANK3	31
+#define INT_34XX_GPIO_BANK4	32
+#define INT_34XX_GPIO_BANK5	33
+#define INT_34XX_GPIO_BANK6	34
+#define INT_34XX_USIM_IRQ	35
+#define INT_34XX_WDT3_IRQ	36
+#define INT_34XX_SPI4_IRQ	48
+#define INT_34XX_I2C3_IRQ	61
+#define INT_34XX_PBIAS_IRQ	75
+#define INT_34XX_OHCI_IRQ	76
+#define INT_34XX_EHCI_IRQ	77
+#define INT_34XX_TLL_IRQ	78
+#define INT_34XX_MMC3_IRQ	94
+#define INT_34XX_GPT12_IRQ	95
 
 #define	INT_34XX_BENCH_MPU_EMUL	3
 
@@ -327,6 +371,7 @@
 
 #ifndef __ASSEMBLY__
 extern void omap_init_irq(void);
+extern int omap_irq_pending(void);
 #endif
 
 #include <mach/hardware.h>
diff --git a/arch/arm/plat-omap/include/mach/mmc.h b/arch/arm/plat-omap/include/mach/mmc.h
index fc15d13..c483015 100644
--- a/arch/arm/plat-omap/include/mach/mmc.h
+++ b/arch/arm/plat-omap/include/mach/mmc.h
@@ -71,4 +71,8 @@ extern void omap_set_mmc_info(int host, const struct omap_mmc_platform_data *inf
 /* called from board-specific card detection service routine */
 extern void omap_mmc_notify_cover_event(struct device *dev, int slot, int is_closed);
 
+#if defined(CONFIG_MMC_OMAP_HS) || defined(CONFIG_MMC_OMAP_HS_MODULE)
+void __init hsmmc_init(void);
+#endif
+
 #endif
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
diff --git a/arch/arm/plat-omap/include/mach/omap24xx.h b/arch/arm/plat-omap/include/mach/omap24xx.h
index bb8319d..556f0eb 100644
--- a/arch/arm/plat-omap/include/mach/omap24xx.h
+++ b/arch/arm/plat-omap/include/mach/omap24xx.h
@@ -48,6 +48,7 @@
 #define OMAP2420_PRM_BASE	OMAP2420_CM_BASE
 #define OMAP2420_SDRC_BASE	(L3_24XX_BASE + 0x9000)
 #define OMAP2420_SMS_BASE	0x68008000
+#define OMAP2420_GPMC_BASE	0x6800a000
 
 #define OMAP2430_32KSYNCT_BASE	(L4_WK_243X_BASE + 0x20000)
 #define OMAP2430_PRCM_BASE	(L4_WK_243X_BASE + 0x6000)
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
index 787b7ac..0911e03 100644
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
diff --git a/arch/arm/plat-omap/include/mach/system.h b/arch/arm/plat-omap/include/mach/system.h
index 06a28c7..e9b9563 100644
--- a/arch/arm/plat-omap/include/mach/system.h
+++ b/arch/arm/plat-omap/include/mach/system.h
@@ -9,12 +9,12 @@
 #include <asm/mach-types.h>
 #include <mach/hardware.h>
 
+#include <mach/prcm.h>
+
 #ifndef CONFIG_MACH_VOICEBLUE
 #define voiceblue_reset()		do {} while (0)
 #endif
 
-extern void omap_prcm_arch_reset(char mode);
-
 static inline void arch_idle(void)
 {
 	cpu_do_idle();
@@ -40,7 +40,7 @@ static inline void omap1_arch_reset(char mode)
 
 static inline void arch_reset(char mode)
 {
-	if (!cpu_is_omap24xx())
+	if (!cpu_class_is_omap2())
 		omap1_arch_reset(mode);
 	else
 		omap_prcm_arch_reset(mode);

--ILuaRSyQpoVaJ1HG--
