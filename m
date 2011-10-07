From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 5/7] ARM: OMAP: Map SRAM later on with ioremap_exec()
Date: Fri, 07 Oct 2011 12:45:53 -0700
Message-ID: <20111007194553.18205.69634.stgit@kaulin.local>
References: <20111007194242.18205.64009.stgit@kaulin.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:43003 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753853Ab1JGTpz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Oct 2011 15:45:55 -0400
In-Reply-To: <20111007194242.18205.64009.stgit@kaulin.local>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>, linux-omap@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>

This allows us to remove omap hacks for map_io.

Acked-by: Nicolas Pitre <nicolas.pitre@linaro.org>
Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Tested-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap1/devices.c            |    3 +
 arch/arm/mach-omap1/io.c                 |    2 -
 arch/arm/mach-omap2/io.c                 |   21 +--------
 arch/arm/mach-omap2/io.h                 |    7 ---
 arch/arm/plat-omap/include/plat/common.h |    2 +
 arch/arm/plat-omap/sram.c                |   69 +++++++++---------------------
 6 files changed, 28 insertions(+), 76 deletions(-)

diff --git a/arch/arm/mach-omap1/devices.c b/arch/arm/mach-omap1/devices.c
index 36f26c3..38e1142 100644
--- a/arch/arm/mach-omap1/devices.c
+++ b/arch/arm/mach-omap1/devices.c
@@ -21,6 +21,7 @@
 #include <mach/hardware.h>
 #include <asm/mach/map.h>
 
+#include <plat/common.h>
 #include <plat/tc.h>
 #include <plat/board.h>
 #include <plat/mux.h>
@@ -291,6 +292,8 @@ static int __init omap1_init_devices(void)
 	if (!cpu_class_is_omap1())
 		return -ENODEV;
 
+	omap_sram_init();
+
 	/* please keep these calls, and their implementations above,
 	 * in alphabetical order so they're easier to sort through.
 	 */
diff --git a/arch/arm/mach-omap1/io.c b/arch/arm/mach-omap1/io.c
index a16aab7..8140a4e 100644
--- a/arch/arm/mach-omap1/io.c
+++ b/arch/arm/mach-omap1/io.c
@@ -21,7 +21,6 @@
 #include "clock.h"
 
 extern void omap_check_revision(void);
-extern void omap_sram_init(void);
 
 /*
  * The machine specific code may provide the extra mapping besides the
@@ -133,7 +132,6 @@ void omap1_init_early(void)
 	 */
 	omap1_clk_init();
 	omap1_mux_init();
-	omap_sram_init();
 }
 
 /*
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index e8123d0..b42bbb8 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -35,8 +35,8 @@
 #include "clock2xxx.h"
 #include "clock3xxx.h"
 #include "clock44xx.h"
-#include "io.h"
 
+#include <plat/common.h>
 #include <plat/omap-pm.h>
 #include "voltage.h"
 #include "powerdomain.h"
@@ -240,22 +240,11 @@ static struct map_desc omap44xx_io_desc[] __initdata = {
 };
 #endif
 
-static void __init _omap2_map_common_io(void)
-{
-	/* Normally devicemaps_init() would flush caches and tlb after
-	 * mdesc->map_io(), but we must also do it here because of the CPU
-	 * revision check below.
-	 */
-	local_flush_tlb_all();
-	flush_cache_all();
-}
-
 #ifdef CONFIG_SOC_OMAP2420
 void __init omap242x_map_common_io(void)
 {
 	iotable_init(omap24xx_io_desc, ARRAY_SIZE(omap24xx_io_desc));
 	iotable_init(omap242x_io_desc, ARRAY_SIZE(omap242x_io_desc));
-	_omap2_map_common_io();
 }
 #endif
 
@@ -264,7 +253,6 @@ void __init omap243x_map_common_io(void)
 {
 	iotable_init(omap24xx_io_desc, ARRAY_SIZE(omap24xx_io_desc));
 	iotable_init(omap243x_io_desc, ARRAY_SIZE(omap243x_io_desc));
-	_omap2_map_common_io();
 }
 #endif
 
@@ -272,7 +260,6 @@ void __init omap243x_map_common_io(void)
 void __init omap34xx_map_common_io(void)
 {
 	iotable_init(omap34xx_io_desc, ARRAY_SIZE(omap34xx_io_desc));
-	_omap2_map_common_io();
 }
 #endif
 
@@ -280,7 +267,6 @@ void __init omap34xx_map_common_io(void)
 void __init omapti816x_map_common_io(void)
 {
 	iotable_init(omapti816x_io_desc, ARRAY_SIZE(omapti816x_io_desc));
-	_omap2_map_common_io();
 }
 #endif
 
@@ -288,7 +274,6 @@ void __init omapti816x_map_common_io(void)
 void __init omap44xx_map_common_io(void)
 {
 	iotable_init(omap44xx_io_desc, ARRAY_SIZE(omap44xx_io_desc));
-	_omap2_map_common_io();
 }
 #endif
 
@@ -337,7 +322,6 @@ void __iomem *omap_irq_base;
 static void __init omap_common_init_early(void)
 {
 	omap2_check_revision();
-	omap_sram_init();
 }
 
 static void __init omap_hwmod_init_postsetup(void)
@@ -449,11 +433,12 @@ void __init omap4430_init_early(void)
 void __init omap_sdrc_init(struct omap_sdrc_params *sdrc_cs0,
 				      struct omap_sdrc_params *sdrc_cs1)
 {
+	omap_sram_init();
+
 	if (cpu_is_omap24xx() || omap3_has_sdrc()) {
 		omap2_sdrc_init(sdrc_cs0, sdrc_cs1);
 		_omap2_init_reprogram_sdrc();
 	}
-
 }
 
 /*
diff --git a/arch/arm/mach-omap2/io.h b/arch/arm/mach-omap2/io.h
index fd230c6..e69de29 100644
--- a/arch/arm/mach-omap2/io.h
+++ b/arch/arm/mach-omap2/io.h
@@ -1,7 +0,0 @@
-
-#ifndef __MACH_OMAP2_IO_H__
-#define __MACH_OMAP2_IO_H__
-
-extern int __init omap_sram_init(void);
-
-#endif /*  __MACH_OMAP2_IO_H__ */
diff --git a/arch/arm/plat-omap/include/plat/common.h b/arch/arm/plat-omap/include/plat/common.h
index 5eac355..ed85720 100644
--- a/arch/arm/plat-omap/include/plat/common.h
+++ b/arch/arm/plat-omap/include/plat/common.h
@@ -55,6 +55,8 @@ void am35xx_init_early(void);
 void ti816x_init_early(void);
 void omap4430_init_early(void);
 
+void omap_sram_init(void);
+
 /*
  * IO bases for various OMAP processors
  * Except the tap base, rest all the io bases
diff --git a/arch/arm/plat-omap/sram.c b/arch/arm/plat-omap/sram.c
index 3c8aa44..8b28664 100644
--- a/arch/arm/plat-omap/sram.c
+++ b/arch/arm/plat-omap/sram.c
@@ -38,16 +38,9 @@
 #endif
 
 #define OMAP1_SRAM_PA		0x20000000
-#define OMAP1_SRAM_VA		VMALLOC_END
 #define OMAP2_SRAM_PUB_PA	(OMAP2_SRAM_PA + 0xf800)
-#define OMAP2_SRAM_VA		0xfe400000
-#define OMAP2_SRAM_PUB_VA	(OMAP2_SRAM_VA + 0x800)
-#define OMAP3_SRAM_VA           0xfe400000
 #define OMAP3_SRAM_PUB_PA       (OMAP3_SRAM_PA + 0x8000)
-#define OMAP3_SRAM_PUB_VA       (OMAP3_SRAM_VA + 0x8000)
-#define OMAP4_SRAM_VA		0xfe400000
 #define OMAP4_SRAM_PUB_PA	(OMAP4_SRAM_PA + 0x4000)
-#define OMAP4_SRAM_PUB_VA	(OMAP4_SRAM_VA + 0x4000)
 
 #if defined(CONFIG_ARCH_OMAP2PLUS)
 #define SRAM_BOOTLOADER_SZ	0x00
@@ -70,9 +63,9 @@
 #define ROUND_DOWN(value,boundary)	((value) & (~((boundary)-1)))
 
 static unsigned long omap_sram_start;
-static unsigned long omap_sram_base;
+static void __iomem *omap_sram_base;
 static unsigned long omap_sram_size;
-static unsigned long omap_sram_ceil;
+static void __iomem *omap_sram_ceil;
 
 /*
  * Depending on the target RAMFS firewall setup, the public usable amount of
@@ -112,7 +105,6 @@ static void __init omap_detect_sram(void)
 	if (cpu_class_is_omap2()) {
 		if (is_sram_locked()) {
 			if (cpu_is_omap34xx()) {
-				omap_sram_base = OMAP3_SRAM_PUB_VA;
 				omap_sram_start = OMAP3_SRAM_PUB_PA;
 				if ((omap_type() == OMAP2_DEVICE_TYPE_EMU) ||
 				    (omap_type() == OMAP2_DEVICE_TYPE_SEC)) {
@@ -121,25 +113,20 @@ static void __init omap_detect_sram(void)
 					omap_sram_size = 0x8000; /* 32K */
 				}
 			} else if (cpu_is_omap44xx()) {
-				omap_sram_base = OMAP4_SRAM_PUB_VA;
 				omap_sram_start = OMAP4_SRAM_PUB_PA;
 				omap_sram_size = 0xa000; /* 40K */
 			} else {
-				omap_sram_base = OMAP2_SRAM_PUB_VA;
 				omap_sram_start = OMAP2_SRAM_PUB_PA;
 				omap_sram_size = 0x800; /* 2K */
 			}
 		} else {
 			if (cpu_is_omap34xx()) {
-				omap_sram_base = OMAP3_SRAM_VA;
 				omap_sram_start = OMAP3_SRAM_PA;
 				omap_sram_size = 0x10000; /* 64K */
 			} else if (cpu_is_omap44xx()) {
-				omap_sram_base = OMAP4_SRAM_VA;
 				omap_sram_start = OMAP4_SRAM_PA;
 				omap_sram_size = 0xe000; /* 56K */
 			} else {
-				omap_sram_base = OMAP2_SRAM_VA;
 				omap_sram_start = OMAP2_SRAM_PA;
 				if (cpu_is_omap242x())
 					omap_sram_size = 0xa0000; /* 640K */
@@ -148,7 +135,6 @@ static void __init omap_detect_sram(void)
 			}
 		}
 	} else {
-		omap_sram_base = OMAP1_SRAM_VA;
 		omap_sram_start = OMAP1_SRAM_PA;
 
 		if (cpu_is_omap7xx())
@@ -165,24 +151,14 @@ static void __init omap_detect_sram(void)
 			omap_sram_size = 0x4000;
 		}
 	}
-
-	omap_sram_ceil = omap_sram_base + omap_sram_size;
 }
 
-static struct map_desc omap_sram_io_desc[] __initdata = {
-	{	/* .length gets filled in at runtime */
-		.virtual	= OMAP1_SRAM_VA,
-		.pfn		= __phys_to_pfn(OMAP1_SRAM_PA),
-		.type		= MT_MEMORY
-	}
-};
-
 /*
  * Note that we cannot use ioremap for SRAM, as clock init needs SRAM early.
  */
 static void __init omap_map_sram(void)
 {
-	unsigned long base;
+	int cached = 1;
 
 	if (omap_sram_size == 0)
 		return;
@@ -195,28 +171,18 @@ static void __init omap_map_sram(void)
 		 * the ARM may attempt to write cache lines back to SDRAM
 		 * which will cause the system to hang.
 		 */
-		omap_sram_io_desc[0].type = MT_MEMORY_NONCACHED;
+		cached = 0;
 	}
 
-	omap_sram_io_desc[0].virtual = omap_sram_base;
-	base = omap_sram_start;
-	base = ROUND_DOWN(base, PAGE_SIZE);
-	omap_sram_io_desc[0].pfn = __phys_to_pfn(base);
-	omap_sram_io_desc[0].length = ROUND_DOWN(omap_sram_size, PAGE_SIZE);
-	iotable_init(omap_sram_io_desc, ARRAY_SIZE(omap_sram_io_desc));
-
-	pr_info("SRAM: Mapped pa 0x%08llx to va 0x%08lx size: 0x%lx\n",
-		(long long) __pfn_to_phys(omap_sram_io_desc[0].pfn),
-		omap_sram_io_desc[0].virtual,
-		omap_sram_io_desc[0].length);
+	omap_sram_start = ROUND_DOWN(omap_sram_start, PAGE_SIZE);
+	omap_sram_base = __arm_ioremap_exec(omap_sram_start, omap_sram_size,
+						cached);
+	if (!omap_sram_base) {
+		pr_err("SRAM: Could not map\n");
+		return;
+	}
 
-	/*
-	 * Normally devicemaps_init() would flush caches and tlb after
-	 * mdesc->map_io(), but since we're called from map_io(), we
-	 * must do it here.
-	 */
-	local_flush_tlb_all();
-	flush_cache_all();
+	omap_sram_ceil = omap_sram_base + omap_sram_size;
 
 	/*
 	 * Looks like we need to preserve some bootloader code at the
@@ -235,13 +201,18 @@ static void __init omap_map_sram(void)
  */
 void *omap_sram_push_address(unsigned long size)
 {
-	if (size > (omap_sram_ceil - (omap_sram_base + SRAM_BOOTLOADER_SZ))) {
+	unsigned long available, new_ceil = (unsigned long)omap_sram_ceil;
+
+	available = omap_sram_ceil - (omap_sram_base + SRAM_BOOTLOADER_SZ);
+
+	if (size > available) {
 		pr_err("Not enough space in SRAM\n");
 		return NULL;
 	}
 
-	omap_sram_ceil -= size;
-	omap_sram_ceil = ROUND_DOWN(omap_sram_ceil, FNCPY_ALIGN);
+	new_ceil -= size;
+	new_ceil = ROUND_DOWN(new_ceil, FNCPY_ALIGN);
+	omap_sram_ceil = IOMEM(new_ceil);
 
 	return (void *)omap_sram_ceil;
 }

