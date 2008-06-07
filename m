From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 14/16] ARM: OMAP2: Misc updates from linux-omap tree
Date: Fri,  6 Jun 2008 19:12:40 -0700
Message-ID: <1212804762-18413-13-git-send-email-tony@atomide.com>
References: 1212803277-18007-1-git-send-email-tony@atomide.com
 <1212804762-18413-1-git-send-email-tony@atomide.com>
 <1212804762-18413-2-git-send-email-tony@atomide.com>
 <1212804762-18413-3-git-send-email-tony@atomide.com>
 <1212804762-18413-4-git-send-email-tony@atomide.com>
 <1212804762-18413-5-git-send-email-tony@atomide.com>
 <1212804762-18413-6-git-send-email-tony@atomide.com>
 <1212804762-18413-7-git-send-email-tony@atomide.com>
 <1212804762-18413-8-git-send-email-tony@atomide.com>
 <1212804762-18413-9-git-send-email-tony@atomide.com>
 <1212804762-18413-10-git-send-email-tony@atomide.com>
 <1212804762-18413-11-git-send-email-tony@atomide.com>
 <1212804762-18413-12-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-bos.mailhop.org ([63.208.196.179]:56843 "EHLO
	mho-02-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756091AbYFGCNN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 Jun 2008 22:13:13 -0400
In-Reply-To: <1212804762-18413-12-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>

Misc updates from linux-omap tree

Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/mach-omap1/devices.c b/arch/arm/mach-omap1/device=
s.c
index da8a3ac..15ab43c 100644
--- a/arch/arm/mach-omap1/devices.c
+++ b/arch/arm/mach-omap1/devices.c
@@ -102,7 +102,7 @@ static inline void omap_init_mbox(void) { }
=20
 #if defined(CONFIG_OMAP_STI)
=20
-#define OMAP1_STI_BASE		IO_ADDRESS(0xfffea000)
+#define OMAP1_STI_BASE		0xfffea000
 #define OMAP1_STI_CHANNEL_BASE	(OMAP1_STI_BASE + 0x400)
=20
 static struct resource sti_resources[] =3D {
diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/device=
s.c
index b603bc5..d8fb3f8 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -13,9 +13,9 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/platform_device.h>
+#include <linux/io.h>
=20
 #include <asm/hardware.h>
-#include <asm/io.h>
 #include <asm/mach-types.h>
 #include <asm/mach/map.h>
=20
@@ -23,49 +23,37 @@
 #include <asm/arch/board.h>
 #include <asm/arch/mux.h>
 #include <asm/arch/gpio.h>
+#include <asm/arch/eac.h>
=20
-#if	defined(CONFIG_I2C_OMAP) || defined(CONFIG_I2C_OMAP_MODULE)
+#if defined(CONFIG_VIDEO_OMAP2) || defined(CONFIG_VIDEO_OMAP2_MODULE)
=20
-#define OMAP2_I2C_BASE2		0x48072000
-#define OMAP2_I2C_INT2		57
-
-static struct resource i2c_resources2[] =3D {
+static struct resource cam_resources[] =3D {
 	{
-		.start		=3D OMAP2_I2C_BASE2,
-		.end		=3D OMAP2_I2C_BASE2 + 0x3f,
+		.start		=3D OMAP24XX_CAMERA_BASE,
+		.end		=3D OMAP24XX_CAMERA_BASE + 0xfff,
 		.flags		=3D IORESOURCE_MEM,
 	},
 	{
-		.start		=3D OMAP2_I2C_INT2,
+		.start		=3D INT_24XX_CAM_IRQ,
 		.flags		=3D IORESOURCE_IRQ,
-	},
+	}
 };
=20
-static struct platform_device omap_i2c_device2 =3D {
-	.name           =3D "i2c_omap",
-	.id             =3D 2,
-	.num_resources	=3D ARRAY_SIZE(i2c_resources2),
-	.resource	=3D i2c_resources2,
+static struct platform_device omap_cam_device =3D {
+	.name		=3D "omap24xxcam",
+	.id		=3D -1,
+	.num_resources	=3D ARRAY_SIZE(cam_resources),
+	.resource	=3D cam_resources,
 };
=20
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
=20
 #if defined(CONFIG_OMAP_DSP) || defined(CONFIG_OMAP_DSP_MODULE)
@@ -104,7 +92,9 @@ static inline void omap_init_mbox(void) { }
=20
 #if defined(CONFIG_OMAP_STI)
=20
-#define OMAP2_STI_BASE		IO_ADDRESS(0x48068000)
+#if defined(CONFIG_ARCH_OMAP2)
+
+#define OMAP2_STI_BASE		0x48068000
 #define OMAP2_STI_CHANNEL_BASE	0x54000000
 #define OMAP2_STI_IRQ		4
=20
@@ -124,6 +114,25 @@ static struct resource sti_resources[] =3D {
 		.flags		=3D IORESOURCE_IRQ,
 	}
 };
+#elif defined(CONFIG_ARCH_OMAP3)
+
+#define OMAP3_SDTI_BASE		0x54500000
+#define OMAP3_SDTI_CHANNEL_BASE	0x54600000
+
+static struct resource sti_resources[] =3D {
+	{
+		.start		=3D OMAP3_SDTI_BASE,
+		.end		=3D OMAP3_SDTI_BASE + 0xFFF,
+		.flags		=3D IORESOURCE_MEM,
+	},
+	{
+		.start		=3D OMAP3_SDTI_CHANNEL_BASE,
+		.end		=3D OMAP3_SDTI_CHANNEL_BASE + SZ_1M - 1,
+		.flags		=3D IORESOURCE_MEM,
+	}
+};
+
+#endif
=20
 static struct platform_device sti_device =3D {
 	.name		=3D "sti",
@@ -140,12 +149,14 @@ static inline void omap_init_sti(void)
 static inline void omap_init_sti(void) {}
 #endif
=20
-#if defined(CONFIG_SPI_OMAP24XX)
+#if defined(CONFIG_SPI_OMAP24XX) || defined(CONFIG_SPI_OMAP24XX_MODULE=
)
=20
 #include <asm/arch/mcspi.h>
=20
 #define OMAP2_MCSPI1_BASE		0x48098000
 #define OMAP2_MCSPI2_BASE		0x4809a000
+#define OMAP2_MCSPI3_BASE		0x480b8000
+#define OMAP2_MCSPI4_BASE		0x480ba000
=20
 static struct omap2_mcspi_platform_config omap2_mcspi1_config =3D {
 	.num_cs		=3D 4,
@@ -159,7 +170,7 @@ static struct resource omap2_mcspi1_resources[] =3D=
 {
 	},
 };
=20
-struct platform_device omap2_mcspi1 =3D {
+static struct platform_device omap2_mcspi1 =3D {
 	.name		=3D "omap2_mcspi",
 	.id		=3D 1,
 	.num_resources	=3D ARRAY_SIZE(omap2_mcspi1_resources),
@@ -181,7 +192,7 @@ static struct resource omap2_mcspi2_resources[] =3D=
 {
 	},
 };
=20
-struct platform_device omap2_mcspi2 =3D {
+static struct platform_device omap2_mcspi2 =3D {
 	.name		=3D "omap2_mcspi",
 	.id		=3D 2,
 	.num_resources	=3D ARRAY_SIZE(omap2_mcspi2_resources),
@@ -191,16 +202,162 @@ struct platform_device omap2_mcspi2 =3D {
 	},
 };
=20
+#if defined(CONFIG_ARCH_OMAP2430) || defined(CONFIG_ARCH_OMAP3)
+static struct omap2_mcspi_platform_config omap2_mcspi3_config =3D {
+	.num_cs		=3D 2,
+};
+
+static struct resource omap2_mcspi3_resources[] =3D {
+	{
+	.start		=3D OMAP2_MCSPI3_BASE,
+	.end		=3D OMAP2_MCSPI3_BASE + 0xff,
+	.flags		=3D IORESOURCE_MEM,
+	},
+};
+
+static struct platform_device omap2_mcspi3 =3D {
+	.name		=3D "omap2_mcspi",
+	.id		=3D 3,
+	.num_resources	=3D ARRAY_SIZE(omap2_mcspi3_resources),
+	.resource	=3D omap2_mcspi3_resources,
+	.dev		=3D {
+		.platform_data =3D &omap2_mcspi3_config,
+	},
+};
+#endif
+
+#ifdef CONFIG_ARCH_OMAP3
+static struct omap2_mcspi_platform_config omap2_mcspi4_config =3D {
+	.num_cs		=3D 1,
+};
+
+static struct resource omap2_mcspi4_resources[] =3D {
+	{
+		.start		=3D OMAP2_MCSPI4_BASE,
+		.end		=3D OMAP2_MCSPI4_BASE + 0xff,
+		.flags		=3D IORESOURCE_MEM,
+	},
+};
+
+static struct platform_device omap2_mcspi4 =3D {
+	.name		=3D "omap2_mcspi",
+	.id		=3D 4,
+	.num_resources	=3D ARRAY_SIZE(omap2_mcspi4_resources),
+	.resource	=3D omap2_mcspi4_resources,
+	.dev		=3D {
+		.platform_data =3D &omap2_mcspi4_config,
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
=20
 #else
 static inline void omap_init_mcspi(void) {}
 #endif
=20
+#ifdef CONFIG_SND_OMAP24XX_EAC
+
+#define OMAP2_EAC_BASE			0x48090000
+
+static struct resource omap2_eac_resources[] =3D {
+	{
+		.start		=3D OMAP2_EAC_BASE,
+		.end		=3D OMAP2_EAC_BASE + 0x109,
+		.flags		=3D IORESOURCE_MEM,
+	},
+};
+
+static struct platform_device omap2_eac_device =3D {
+	.name		=3D "omap24xx-eac",
+	.id		=3D -1,
+	.num_resources	=3D ARRAY_SIZE(omap2_eac_resources),
+	.resource	=3D omap2_eac_resources,
+	.dev =3D {
+		.platform_data =3D NULL,
+	},
+};
+
+void omap_init_eac(struct eac_platform_data *pdata)
+{
+	omap2_eac_device.dev.platform_data =3D pdata;
+	platform_device_register(&omap2_eac_device);
+}
+
+#else
+void omap_init_eac(struct eac_platform_data *pdata) {}
+#endif
+
+#ifdef CONFIG_OMAP_SHA1_MD5
+static struct resource sha1_md5_resources[] =3D {
+	{
+		.start	=3D OMAP24XX_SEC_SHA1MD5_BASE,
+		.end	=3D OMAP24XX_SEC_SHA1MD5_BASE + 0x64,
+		.flags	=3D IORESOURCE_MEM,
+	},
+	{
+		.start	=3D INT_24XX_SHA1MD5,
+		.flags	=3D IORESOURCE_IRQ,
+	}
+};
+
+static struct platform_device sha1_md5_device =3D {
+	.name		=3D "OMAP SHA1/MD5",
+	.id		=3D -1,
+	.num_resources	=3D ARRAY_SIZE(sha1_md5_resources),
+	.resource	=3D sha1_md5_resources,
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
+#if defined(CONFIG_HDQ_MASTER_OMAP) || defined(CONFIG_HDQ_MASTER_OMAP_=
MODULE)
+#if defined(CONFIG_ARCH_OMAP2430) || defined(CONFIG_ARCH_OMAP3430)
+#define OMAP_HDQ_BASE	0x480B2000
+#endif
+static struct resource omap_hdq_resources[] =3D {
+	{
+		.start		=3D OMAP_HDQ_BASE,
+		.end		=3D OMAP_HDQ_BASE + 0x1C,
+		.flags		=3D IORESOURCE_MEM,
+	},
+	{
+		.start		=3D INT_24XX_HDQ_IRQ,
+		.flags		=3D IORESOURCE_IRQ,
+	},
+};
+static struct platform_device omap_hdq_dev =3D {
+	.name =3D "omap_hdq",
+	.id =3D 0,
+	.dev =3D {
+		.platform_data =3D NULL,
+	},
+	.num_resources	=3D ARRAY_SIZE(omap_hdq_resources),
+	.resource	=3D omap_hdq_resources,
+};
+static inline void omap_hdq_init(void)
+{
+	(void) platform_device_register(&omap_hdq_dev);
+}
+#else
+static inline void omap_hdq_init(void) {}
+#endif
+
 /*--------------------------------------------------------------------=
-----*/
=20
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
=20
 	return 0;
 }
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index a2d9ec8..d825100 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -4,8 +4,11 @@
  * OMAP2 I/O mapping code
  *
  * Copyright (C) 2005 Nokia Corporation
- * Author: Juha Yrj=F6l=E4 <juha.yrjola@nokia.com>
- * Updated map desc to add 2430 support : <x0khasim@ti.com>
+ * Copyright (C) 2007 Texas Instruments
+ *
+ * Author:
+ *	Juha Yrjola <juha.yrjola@nokia.com>
+ *	Syed Khasim <x0khasim@ti.com>
  *
  * This program is free software; you can redistribute it and/or modif=
y
  * it under the terms of the GNU General Public License version 2 as
@@ -15,14 +18,18 @@
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
+#include <linux/io.h>
=20
 #include <asm/tlb.h>
-#include <asm/io.h>
=20
 #include <asm/mach/map.h>
-
 #include <asm/arch/mux.h>
 #include <asm/arch/omapfb.h>
+#include <asm/arch/sram.h>
+
+#include "memory.h"
+
+#include "clock.h"
=20
 #include <asm/arch/powerdomain.h>
=20
@@ -31,18 +38,13 @@
 #include <asm/arch/clockdomain.h>
 #include "clockdomains.h"
=20
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
-static struct map_desc omap2_io_desc[] __initdata =3D {
+
+#ifdef CONFIG_ARCH_OMAP24XX
+static struct map_desc omap24xx_io_desc[] __initdata =3D {
 	{
 		.virtual	=3D L3_24XX_VIRT,
 		.pfn		=3D __phys_to_pfn(L3_24XX_PHYS),
@@ -50,12 +52,39 @@ static struct map_desc omap2_io_desc[] __initdata =3D=
 {
 		.type		=3D MT_DEVICE
 	},
 	{
-		.virtual        =3D L4_24XX_VIRT,
-		.pfn            =3D __phys_to_pfn(L4_24XX_PHYS),
-		.length         =3D L4_24XX_SIZE,
-		.type           =3D MT_DEVICE
+		.virtual	=3D L4_24XX_VIRT,
+		.pfn		=3D __phys_to_pfn(L4_24XX_PHYS),
+		.length		=3D L4_24XX_SIZE,
+		.type		=3D MT_DEVICE
+	},
+};
+
+#ifdef CONFIG_ARCH_OMAP2420
+static struct map_desc omap242x_io_desc[] __initdata =3D {
+	{
+		.virtual	=3D DSP_MEM_24XX_VIRT,
+		.pfn		=3D __phys_to_pfn(DSP_MEM_24XX_PHYS),
+		.length		=3D DSP_MEM_24XX_SIZE,
+		.type		=3D MT_DEVICE
+	},
+	{
+		.virtual	=3D DSP_IPI_24XX_VIRT,
+		.pfn		=3D __phys_to_pfn(DSP_IPI_24XX_PHYS),
+		.length		=3D DSP_IPI_24XX_SIZE,
+		.type		=3D MT_DEVICE
 	},
+	{
+		.virtual	=3D DSP_MMU_24XX_VIRT,
+		.pfn		=3D __phys_to_pfn(DSP_MMU_24XX_PHYS),
+		.length		=3D DSP_MMU_24XX_SIZE,
+		.type		=3D MT_DEVICE
+	},
+};
+
+#endif
+
 #ifdef CONFIG_ARCH_OMAP2430
+static struct map_desc omap243x_io_desc[] __initdata =3D {
 	{
 		.virtual	=3D L4_WK_243X_VIRT,
 		.pfn		=3D __phys_to_pfn(L4_WK_243X_PHYS),
@@ -68,30 +97,33 @@ static struct map_desc omap2_io_desc[] __initdata =3D=
 {
 		.length		=3D OMAP243X_GPMC_SIZE,
 		.type		=3D MT_DEVICE
 	},
-#endif
 	{
-		.virtual	=3D DSP_MEM_24XX_VIRT,
-		.pfn		=3D __phys_to_pfn(DSP_MEM_24XX_PHYS),
-		.length		=3D DSP_MEM_24XX_SIZE,
+		.virtual	=3D OMAP243X_SDRC_VIRT,
+		.pfn		=3D __phys_to_pfn(OMAP243X_SDRC_PHYS),
+		.length		=3D OMAP243X_SDRC_SIZE,
 		.type		=3D MT_DEVICE
 	},
 	{
-		.virtual	=3D DSP_IPI_24XX_VIRT,
-		.pfn		=3D __phys_to_pfn(DSP_IPI_24XX_PHYS),
-		.length		=3D DSP_IPI_24XX_SIZE,
+		.virtual	=3D OMAP243X_SMS_VIRT,
+		.pfn		=3D __phys_to_pfn(OMAP243X_SMS_PHYS),
+		.length		=3D OMAP243X_SMS_SIZE,
 		.type		=3D MT_DEVICE
 	},
-	{
-		.virtual	=3D DSP_MMU_24XX_VIRT,
-		.pfn		=3D __phys_to_pfn(DSP_MMU_24XX_PHYS),
-		.length		=3D DSP_MMU_24XX_SIZE,
-		.type		=3D MT_DEVICE
-	}
 };
+#endif
+#endif
=20
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
=20
 	/* Normally devicemaps_init() would flush caches and tlb after
 	 * mdesc->map_io(), but we must also do it here because of the CPU
@@ -111,11 +143,6 @@ void __init omap2_init_common_hw(void)
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
diff --git a/arch/arm/mach-omap2/memory.h b/arch/arm/mach-omap2/memory.=
h
index 9a280b5..bb3db80 100644
--- a/arch/arm/mach-omap2/memory.h
+++ b/arch/arm/mach-omap2/memory.h
@@ -14,6 +14,9 @@
  * published by the Free Software Foundation.
  */
=20
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
diff --git a/arch/arm/plat-omap/devices.c b/arch/arm/plat-omap/devices.=
c
index 7001794..b3e0147 100644
--- a/arch/arm/plat-omap/devices.c
+++ b/arch/arm/plat-omap/devices.c
@@ -20,16 +20,17 @@
 #include <asm/mach/map.h>
=20
 #include <asm/arch/tc.h>
+#include <asm/arch/control.h>
 #include <asm/arch/board.h>
+#include <asm/arch/mmc.h>
 #include <asm/arch/mux.h>
 #include <asm/arch/gpio.h>
 #include <asm/arch/menelaus.h>
+#include <asm/arch/dsp_common.h>
 #include <asm/arch/mcbsp.h>
=20
 #if	defined(CONFIG_OMAP_DSP) || defined(CONFIG_OMAP_DSP_MODULE)
=20
-#include "../plat-omap/dsp/dsp_common.h"
-
 static struct dsp_platform_data dsp_pdata =3D {
 	.kdev_list =3D LIST_HEAD_INIT(dsp_pdata.kdev_list),
 };
@@ -75,7 +76,7 @@ int dsp_kfunc_device_register(struct dsp_kfunc_device=
 *kdev)
 {
 	static DEFINE_MUTEX(dsp_pdata_lock);
=20
-	mutex_init(&kdev->lock);
+	spin_lock_init(&kdev->lock);
=20
 	mutex_lock(&dsp_pdata_lock);
 	list_add_tail(&kdev->entry, &dsp_pdata.kdev_list);
@@ -94,6 +95,10 @@ static inline void omap_init_dsp(void) { }
=20
 static void omap_init_kp(void)
 {
+	/* REVISIT: 2430 keypad is on TWL4030 */
+	if (cpu_is_omap2430() || cpu_is_omap34xx())
+		return;
+
 	if (machine_is_omap_h2() || machine_is_omap_h3()) {
 		omap_cfg_reg(F18_1610_KBC0);
 		omap_cfg_reg(D20_1610_KBC1);
@@ -190,25 +195,38 @@ static inline void __init omap_init_mcbsp(void)
=20
 /*--------------------------------------------------------------------=
-----*/
=20
-#if	defined(CONFIG_MMC_OMAP) || defined(CONFIG_MMC_OMAP_MODULE)
+#if	defined(CONFIG_MMC_OMAP) || defined(CONFIG_MMC_OMAP_MODULE) \
+	|| defined(CONFIG_MMC_OMAP_HS) || defined(CONFIG_MMC_OMAP_HS_MODULE)
=20
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
=20
-static struct omap_mmc_conf mmc1_conf;
+#endif
+
+static struct omap_mmc_platform_data mmc1_data;
=20
 static u64 mmc1_dmamask =3D 0xffffffff;
=20
 static struct resource mmc1_resources[] =3D {
 	{
 		.start		=3D OMAP_MMC1_BASE,
-		.end		=3D OMAP_MMC1_BASE + 0x7f,
+		.end		=3D OMAP_MMC1_END,
 		.flags		=3D IORESOURCE_MEM,
 	},
 	{
@@ -222,26 +240,28 @@ static struct platform_device mmc_omap_device1 =3D=
 {
 	.id		=3D 1,
 	.dev =3D {
 		.dma_mask	=3D &mmc1_dmamask,
-		.platform_data	=3D &mmc1_conf,
+		.platform_data	=3D &mmc1_data,
 	},
 	.num_resources	=3D ARRAY_SIZE(mmc1_resources),
 	.resource	=3D mmc1_resources,
 };
=20
-#ifdef	CONFIG_ARCH_OMAP16XX
+#if defined(CONFIG_ARCH_OMAP16XX) || defined(CONFIG_ARCH_OMAP2430) || =
\
+	defined(CONFIG_ARCH_OMAP34XX)
=20
-static struct omap_mmc_conf mmc2_conf;
+static struct omap_mmc_platform_data mmc2_data;
=20
 static u64 mmc2_dmamask =3D 0xffffffff;
=20
+
 static struct resource mmc2_resources[] =3D {
 	{
 		.start		=3D OMAP_MMC2_BASE,
-		.end		=3D OMAP_MMC2_BASE + 0x7f,
+		.end		=3D OMAP_MMC2_END,
 		.flags		=3D IORESOURCE_MEM,
 	},
 	{
-		.start		=3D INT_1610_MMC2,
+		.start		=3D OMAP_MMC2_INT,
 		.flags		=3D IORESOURCE_IRQ,
 	},
 };
@@ -251,7 +271,7 @@ static struct platform_device mmc_omap_device2 =3D =
{
 	.id		=3D 2,
 	.dev =3D {
 		.dma_mask	=3D &mmc2_dmamask,
-		.platform_data	=3D &mmc2_conf,
+		.platform_data	=3D &mmc2_data,
 	},
 	.num_resources	=3D ARRAY_SIZE(mmc2_resources),
 	.resource	=3D mmc2_resources,
@@ -270,6 +290,20 @@ static void __init omap_init_mmc(void)
=20
 	/* block 1 is always available and has just one pinout option */
 	mmc =3D &mmc_conf->mmc[0];
+
+	if (cpu_is_omap2430() || cpu_is_omap34xx()) {
+		if (mmc->enabled)
+			(void) platform_device_register(&mmc_omap_device1);
+
+#if defined(CONFIG_ARCH_OMAP2430) || defined(CONFIG_ARCH_OMAP34XX)
+		mmc =3D &mmc_conf->mmc[1];
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
@@ -304,7 +338,20 @@ static void __init omap_init_mmc(void)
 				omap_cfg_reg(MMC_DAT3);
 			}
 		}
-		mmc1_conf =3D *mmc;
+#if defined(CONFIG_ARCH_OMAP2420)
+		if (mmc->internal_clock) {
+			/*
+			 * Use internal loop-back in MMC/SDIO
+			 * Module Input Clock selection
+			 */
+			if (cpu_is_omap24xx()) {
+				u32 v =3D omap_ctrl_readl(OMAP2_CONTROL_DEVCONF0);
+				v |=3D (1 << 24); /* not used in 243x */
+				omap_ctrl_writel(v, OMAP2_CONTROL_DEVCONF0);
+			}
+		}
+#endif
+		mmc1_data.conf =3D *mmc;
 		(void) platform_device_register(&mmc_omap_device1);
 	}
=20
@@ -333,13 +380,32 @@ static void __init omap_init_mmc(void)
 		if (cpu_is_omap1710())
 			omap_writel(omap_readl(MOD_CONF_CTRL_1) | (1 << 24),
 				     MOD_CONF_CTRL_1);
-		mmc2_conf =3D *mmc;
+		mmc2_data.conf =3D *mmc;
 		(void) platform_device_register(&mmc_omap_device2);
 	}
 #endif
 	return;
 }
+
+void omap_set_mmc_info(int host, const struct omap_mmc_platform_data *=
info)
+{
+	switch (host) {
+	case 1:
+		mmc1_data =3D *info;
+		break;
+#if defined(CONFIG_ARCH_OMAP16XX) || defined(CONFIG_ARCH_OMAP2430) || =
\
+	defined(CONFIG_ARCH_OMAP34XX)
+	case 2:
+		mmc2_data =3D *info;
+		break;
+#endif
+	default:
+		BUG();
+	}
+}
+
 #else
+void omap_set_mmc_info(int host, const struct omap_mmc_platform_data *=
info) {}
 static inline void omap_init_mmc(void) {}
 #endif
=20
@@ -391,8 +457,17 @@ static inline void omap_init_uwire(void) {}
=20
 #if	defined(CONFIG_OMAP_WATCHDOG) || defined(CONFIG_OMAP_WATCHDOG_MODU=
LE)
=20
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
@@ -475,10 +550,6 @@ static inline void omap_init_rng(void) {}
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
@@ -489,7 +560,6 @@ static int __init omap_init_devices(void)
 	omap_init_uwire();
 	omap_init_wdt();
 	omap_init_rng();
-#endif
 	return 0;
 }
 arch_initcall(omap_init_devices);
diff --git a/include/asm-arm/arch-omap/board-2430sdp.h b/include/asm-ar=
m/arch-omap/board-2430sdp.h
index c7db900..fde6915 100644
--- a/include/asm-arm/arch-omap/board-2430sdp.h
+++ b/include/asm-arm/arch-omap/board-2430sdp.h
@@ -30,10 +30,12 @@
 #define __ASM_ARCH_OMAP_2430SDP_H
=20
 /* Placeholder for 2430SDP specific defines */
-#define OMAP24XX_ETHR_START		 0x08000300
+#define OMAP24XX_ETHR_START		0x08000300
 #define OMAP24XX_ETHR_GPIO_IRQ		149
 #define SDP2430_CS0_BASE		0x04000000
=20
-#define TWL4030_IRQNUM			INT_24XX_SYS_NIRQ
+/* Function prototypes */
+extern void sdp2430_flash_init(void);
+extern void sdp2430_usb_init(void);
=20
 #endif /* __ASM_ARCH_OMAP_2430SDP_H */
diff --git a/include/asm-arm/arch-omap/board-apollon.h b/include/asm-ar=
m/arch-omap/board-apollon.h
index 547125a..3c4b785 100644
--- a/include/asm-arm/arch-omap/board-apollon.h
+++ b/include/asm-arm/arch-omap/board-apollon.h
@@ -31,6 +31,12 @@
=20
 extern void apollon_mmc_init(void);
=20
+static inline int apollon_plus(void)
+{
+	/* The apollon plus has IDCODE revision 5 */
+	return system_rev & 0xc0;
+}
+
 /* Placeholder for APOLLON specific defines */
 #define APOLLON_ETHR_GPIO_IRQ		74
=20
diff --git a/include/asm-arm/arch-omap/board-h4.h b/include/asm-arm/arc=
h-omap/board-h4.h
index 7e0efef..9cc2ff7 100644
--- a/include/asm-arm/arch-omap/board-h4.h
+++ b/include/asm-arm/arch-omap/board-h4.h
@@ -1,7 +1,7 @@
 /*
  * linux/include/asm-arm/arch-omap/board-h4.h
  *
- * Hardware definitions for TI OMAP1610 H4 board.
+ * Hardware definitions for TI OMAP2420 H4 board.
  *
  * Initial creation by Dirk Behme <dirk.behme@de.bosch.com>
  *
@@ -29,6 +29,9 @@
 #ifndef __ASM_ARCH_OMAP_H4_H
 #define __ASM_ARCH_OMAP_H4_H
=20
+/* MMC Prototypes */
+extern void h4_mmc_init(void);
+
 /* Placeholder for H4 specific defines */
 #define OMAP24XX_ETHR_GPIO_IRQ		92
 #endif /*  __ASM_ARCH_OMAP_H4_H */
diff --git a/include/asm-arm/arch-omap/control.h b/include/asm-arm/arch=
-omap/control.h
index 987553e..12bc22a 100644
--- a/include/asm-arm/arch-omap/control.h
+++ b/include/asm-arm/arch-omap/control.h
@@ -1,13 +1,10 @@
-#ifndef __ASM_ARCH_CONTROL_H
-#define __ASM_ARCH_CONTROL_H
-
 /*
  * include/asm-arm/arch-omap/control.h
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
=20
+#ifndef __ASM_ARCH_CONTROL_H
+#define __ASM_ARCH_CONTROL_H
+
 #include <asm/arch/io.h>
=20
+#ifndef __ASSEMBLY__
 #define OMAP242X_CTRL_REGADDR(reg)					\
-	(void __iomem *)IO_ADDRESS(OMAP242X_CTRL_BASE + (reg))
+	(__force void __iomem *)IO_ADDRESS(OMAP242X_CTRL_BASE + (reg))
 #define OMAP243X_CTRL_REGADDR(reg)					\
-	(void __iomem *)IO_ADDRESS(OMAP243X_CTRL_BASE + (reg))
+	(__force void __iomem *)IO_ADDRESS(OMAP243X_CTRL_BASE + (reg))
 #define OMAP343X_CTRL_REGADDR(reg)					\
-	(void __iomem *)IO_ADDRESS(OMAP343X_CTRL_BASE + (reg))
+	(__force void __iomem *)IO_ADDRESS(OMAP343X_CTRL_BASE + (reg))
+#else
+#define OMAP242X_CTRL_REGADDR(reg)	IO_ADDRESS(OMAP242X_CTRL_BASE + (re=
g))
+#define OMAP243X_CTRL_REGADDR(reg)	IO_ADDRESS(OMAP243X_CTRL_BASE + (re=
g))
+#define OMAP343X_CTRL_REGADDR(reg)	IO_ADDRESS(OMAP343X_CTRL_BASE + (re=
g))
+#endif /* __ASSEMBLY__ */
=20
 /*
  * As elsewhere, the "OMAP2_" prefix indicates that the macro is valid=
 for
@@ -134,6 +140,7 @@
 #define OMAP343X_CONTROL_TEST_KEY_13	(OMAP2_CONTROL_GENERAL + 0x00fc)
 #define OMAP343X_CONTROL_IVA2_BOOTADDR	(OMAP2_CONTROL_GENERAL + 0x0190=
)
 #define OMAP343X_CONTROL_IVA2_BOOTMOD	(OMAP2_CONTROL_GENERAL + 0x0194)
+#define OMAP343X_CONTROL_TEMP_SENSOR	(OMAP2_CONTROL_GENERAL + 0x02b4)
=20
 /*
  * REVISIT: This list of registers is not comprehensive - there are mo=
re
diff --git a/include/asm-arm/arch-omap/gpio.h b/include/asm-arm/arch-om=
ap/gpio.h
index 5ee6a49..c49d38a 100644
--- a/include/asm-arm/arch-omap/gpio.h
+++ b/include/asm-arm/arch-omap/gpio.h
@@ -76,6 +76,8 @@ extern void omap_free_gpio(int gpio);
 extern void omap_set_gpio_direction(int gpio, int is_input);
 extern void omap_set_gpio_dataout(int gpio, int enable);
 extern int omap_get_gpio_datain(int gpio);
+extern void omap2_gpio_prepare_for_retention(void);
+extern void omap2_gpio_resume_after_retention(void);
 extern void omap_set_gpio_debounce(int gpio, int enable);
 extern void omap_set_gpio_debounce_time(int gpio, int enable);
=20
diff --git a/include/asm-arm/arch-omap/gpmc.h b/include/asm-arm/arch-om=
ap/gpmc.h
index 6a8e07f..53dc246 100644
--- a/include/asm-arm/arch-omap/gpmc.h
+++ b/include/asm-arm/arch-omap/gpmc.h
@@ -11,6 +11,9 @@
 #ifndef __OMAP2_GPMC_H
 #define __OMAP2_GPMC_H
=20
+/* Maximum Number of Chip Selects */
+#define GPMC_CS_NUM		8
+
 #define GPMC_CS_CONFIG1		0x00
 #define GPMC_CS_CONFIG2		0x04
 #define GPMC_CS_CONFIG3		0x08
@@ -22,6 +25,9 @@
 #define GPMC_CS_NAND_ADDRESS	0x20
 #define GPMC_CS_NAND_DATA	0x24
=20
+#define GPMC_CONFIG		0x50
+#define GPMC_STATUS		0x54
+
 #define GPMC_CONFIG1_WRAPBURST_SUPP     (1 << 31)
 #define GPMC_CONFIG1_READMULTIPLE_SUPP  (1 << 30)
 #define GPMC_CONFIG1_READTYPE_ASYNC     (0 << 29)
@@ -81,6 +87,7 @@ struct gpmc_timings {
 };
=20
 extern unsigned int gpmc_ns_to_ticks(unsigned int time_ns);
+extern unsigned int gpmc_ticks_to_ns(unsigned int ticks);
 extern unsigned int gpmc_round_ns_to_ticks(unsigned int time_ns);
 extern unsigned long gpmc_get_fclk_period(void);
=20
diff --git a/include/asm-arm/arch-omap/hardware.h b/include/asm-arm/arc=
h-omap/hardware.h
index 45fdfcc..a315f69 100644
--- a/include/asm-arm/arch-omap/hardware.h
+++ b/include/asm-arm/arch-omap/hardware.h
@@ -282,8 +282,8 @@
=20
 #include "omap730.h"
 #include "omap1510.h"
-#include "omap24xx.h"
 #include "omap16xx.h"
+#include "omap24xx.h"
 #include "omap34xx.h"
=20
 #ifndef __ASSEMBLER__
diff --git a/include/asm-arm/arch-omap/irqs.h b/include/asm-arm/arch-om=
ap/irqs.h
index 7464c69..f901e8b 100644
--- a/include/asm-arm/arch-omap/irqs.h
+++ b/include/asm-arm/arch-omap/irqs.h
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
=20
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
=20
 /* Max. 128 level 2 IRQs (OMAP1610), 192 GPIOs (OMAP730) and
  * 16 MPUIO lines */
@@ -325,6 +369,7 @@
=20
 #ifndef __ASSEMBLY__
 extern void omap_init_irq(void);
+extern int omap_irq_pending(void);
 #endif
=20
 #include <asm/hardware.h>
diff --git a/include/asm-arm/arch-omap/mmc.h b/include/asm-arm/arch-oma=
p/mmc.h
index 7cfc5f2..7ce54e4 100644
--- a/include/asm-arm/arch-omap/mmc.h
+++ b/include/asm-arm/arch-omap/mmc.h
@@ -71,4 +71,8 @@ extern void omap_set_mmc_info(int host, const struct =
omap_mmc_platform_data *inf
 /* called from board-specific card detection service routine */
 extern void omap_mmc_notify_cover_event(struct device *dev, int slot, =
int is_closed);
=20
+#if defined(CONFIG_MMC_OMAP_HS) || defined(CONFIG_MMC_OMAP_HS_MODULE)
+void __init hsmmc_init(void);
+#endif
+
 #endif
diff --git a/include/asm-arm/arch-omap/omap1510.h b/include/asm-arm/arc=
h-omap/omap1510.h
index c575d35..7b5114b 100644
--- a/include/asm-arm/arch-omap/omap1510.h
+++ b/include/asm-arm/arch-omap/omap1510.h
@@ -44,5 +44,7 @@
 #define OMAP1510_DSPREG_SIZE	SZ_128K
 #define OMAP1510_DSPREG_START	0xE1000000
=20
+#define OMAP1510_DSP_MMU_BASE	(0xfffed200)
+
 #endif /*  __ASM_ARCH_OMAP15XX_H */
=20
diff --git a/include/asm-arm/arch-omap/omap16xx.h b/include/asm-arm/arc=
h-omap/omap16xx.h
index f7f5cdf..d576e59 100644
--- a/include/asm-arm/arch-omap/omap16xx.h
+++ b/include/asm-arm/arch-omap/omap16xx.h
@@ -44,6 +44,11 @@
 #define OMAP16XX_DSPREG_SIZE	SZ_128K
 #define OMAP16XX_DSPREG_START	0xE1000000
=20
+#define OMAP16XX_SEC_BASE	0xFFFE4000
+#define OMAP16XX_SEC_DES	(OMAP16XX_SEC_BASE + 0x0000)
+#define OMAP16XX_SEC_SHA1MD5	(OMAP16XX_SEC_BASE + 0x0800)
+#define OMAP16XX_SEC_RNG	(OMAP16XX_SEC_BASE + 0x1000)
+
 /*
  * -------------------------------------------------------------------=
--------
  * Interrupts
@@ -190,7 +195,7 @@
 #define WSPR_DISABLE_0         (0x0000aaaa)
 #define WSPR_DISABLE_1         (0x00005555)
=20
-/* Mailbox */
+#define OMAP16XX_DSP_MMU_BASE	(0xfffed200)
 #define OMAP16XX_MAILBOX_BASE	(0xfffcf000)
=20
 #endif /*  __ASM_ARCH_OMAP16XX_H */
diff --git a/include/asm-arm/arch-omap/omap24xx.h b/include/asm-arm/arc=
h-omap/omap24xx.h
index b9fcaae..affe39b 100644
--- a/include/asm-arm/arch-omap/omap24xx.h
+++ b/include/asm-arm/arch-omap/omap24xx.h
@@ -48,6 +48,7 @@
 #define OMAP2420_PRM_BASE	OMAP2420_CM_BASE
 #define OMAP2420_SDRC_BASE	(L3_24XX_BASE + 0x9000)
 #define OMAP2420_SMS_BASE	0x68008000
+#define OMAP2420_GPMC_BASE	0x6800a000
=20
 #define OMAP2430_32KSYNCT_BASE	(L4_WK_243X_BASE + 0x20000)
 #define OMAP2430_PRCM_BASE	(L4_WK_243X_BASE + 0x6000)
diff --git a/include/asm-arm/arch-omap/omapfb.h b/include/asm-arm/arch-=
omap/omapfb.h
index 46d7a4f..722eeec 100644
--- a/include/asm-arm/arch-omap/omapfb.h
+++ b/include/asm-arm/arch-omap/omapfb.h
@@ -62,6 +62,7 @@
 #define OMAPFB_CAPS_WINDOW_PIXEL_DOUBLE	0x00010000
 #define OMAPFB_CAPS_WINDOW_SCALE	0x00020000
 #define OMAPFB_CAPS_WINDOW_OVERLAY	0x00040000
+#define OMAPFB_CAPS_WINDOW_ROTATE	0x00080000
 #define OMAPFB_CAPS_SET_BACKLIGHT	0x01000000
=20
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
=20
+extern void omapfb_reserve_sdram(void);
 extern void omapfb_register_panel(struct lcd_panel *panel);
 extern void omapfb_write_first_pixel(struct omapfb_device *fbdev, u16 =
pixval);
 extern void omapfb_notify_clients(struct omapfb_device *fbdev,
diff --git a/include/asm-arm/arch-omap/sdrc.h b/include/asm-arm/arch-om=
ap/sdrc.h
index 673b396..660da4d 100644
--- a/include/asm-arm/arch-omap/sdrc.h
+++ b/include/asm-arm/arch-omap/sdrc.h
@@ -25,6 +25,8 @@
 #define SDRC_DLLB_STATUS	0x06C
 #define SDRC_POWER		0x070
 #define SDRC_MR_0		0x084
+#define SDRC_ACTIM_CTRL_A	0x09c
+#define SDRC_ACTIM_CTRL_B	0x0a0
 #define SDRC_RFR_CTRL_0		0x0a4
=20
 /*
diff --git a/include/asm-arm/arch-omap/system.h b/include/asm-arm/arch-=
omap/system.h
index ac2bfa4..4faeb9f 100644
--- a/include/asm-arm/arch-omap/system.h
+++ b/include/asm-arm/arch-omap/system.h
@@ -9,12 +9,12 @@
 #include <asm/mach-types.h>
 #include <asm/hardware.h>
=20
+#include <asm/arch/prcm.h>
+
 #ifndef CONFIG_MACH_VOICEBLUE
 #define voiceblue_reset()		do {} while (0)
 #endif
=20
-extern void omap_prcm_arch_reset(char mode);
-
 static inline void arch_idle(void)
 {
 	cpu_do_idle();
@@ -40,7 +40,7 @@ static inline void omap1_arch_reset(char mode)
=20
 static inline void arch_reset(char mode)
 {
-	if (!cpu_is_omap24xx())
+	if (!cpu_class_is_omap2())
 		omap1_arch_reset(mode);
 	else
 		omap_prcm_arch_reset(mode);
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
