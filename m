From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 1/1] omap4: Move SOC specific code from board file
Date: Thu, 29 Apr 2010 15:02:24 +0530
Message-ID: <1272533544-30750-1-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:39876 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932554Ab0D3RMh (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 30 Apr 2010 13:12:37 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id o3T9WRE3021684
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 29 Apr 2010 04:32:29 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>

This patch moves OMAP4 soc specific code from 4430sdp board file.
The change is necessary so that newer board support can be added
with minimal changes. This will be also problematic for
multi-board, multi-omap builds.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
Boot tested with regular and multi-omap defconfig on OMAP4430 and
OMAP3430 SDPs. OMAP4430 still needs to fix unused clock and pm to
make it boot with multi-omap build.

 arch/arm/mach-omap2/Makefile                    |    2 +-
 arch/arm/mach-omap2/board-4430sdp.c             |   47 +--------------
 arch/arm/mach-omap2/include/mach/omap4-common.h |   26 ++++++++
 arch/arm/mach-omap2/omap-smp.c                  |    2 +-
 arch/arm/mach-omap2/omap4-common.c              |   73 +++++++++++++++++++++++
 arch/arm/plat-omap/common.c                     |    3 -
 arch/arm/plat-omap/include/plat/common.h        |    3 -
 7 files changed, 102 insertions(+), 54 deletions(-)
 create mode 100644 arch/arm/mach-omap2/include/mach/omap4-common.h
 create mode 100644 arch/arm/mach-omap2/omap4-common.c

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 4b9fc57..ffe600a 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -22,7 +22,7 @@ obj-$(CONFIG_OMAP_MCBSP) += mcbsp.o
 # SMP support ONLY available for OMAP4
 obj-$(CONFIG_SMP)			+= omap-smp.o omap-headsmp.o
 obj-$(CONFIG_LOCAL_TIMERS)		+= timer-mpu.o
-obj-$(CONFIG_ARCH_OMAP4)		+= omap44xx-smc.o
+obj-$(CONFIG_ARCH_OMAP4)		+= omap44xx-smc.o omap4-common.o
 
 AFLAGS_omap44xx-smc.o			:=-Wa,-march=armv7-a
 
diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index b88f28c..0f8cd85 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -20,6 +20,7 @@
 #include <linux/usb/otg.h>
 
 #include <mach/hardware.h>
+#include <mach/omap4-common.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
@@ -29,8 +30,6 @@
 #include <plat/control.h>
 #include <plat/timer-gp.h>
 #include <plat/usb.h>
-#include <asm/hardware/gic.h>
-#include <asm/hardware/cache-l2x0.h>
 
 static struct platform_device sdp4430_lcd_device = {
 	.name		= "sdp4430_lcd",
@@ -49,50 +48,6 @@ static struct omap_board_config_kernel sdp4430_config[] __initdata = {
 	{ OMAP_TAG_LCD,		&sdp4430_lcd_config },
 };
 
-#ifdef CONFIG_CACHE_L2X0
-static int __init omap_l2_cache_init(void)
-{
-	extern void omap_smc1(u32 fn, u32 arg);
-	void __iomem *l2cache_base;
-
-	/* To avoid code running on other OMAPs in
-	 * multi-omap builds
-	 */
-	if (!cpu_is_omap44xx())
-		return -ENODEV;
-
-	/* Static mapping, never released */
-	l2cache_base = ioremap(OMAP44XX_L2CACHE_BASE, SZ_4K);
-	BUG_ON(!l2cache_base);
-
-	/* Enable PL310 L2 Cache controller */
-	omap_smc1(0x102, 0x1);
-
-	/* 32KB way size, 16-way associativity,
-	* parity disabled
-	*/
-	l2x0_init(l2cache_base, 0x0e050000, 0xc0000fff);
-
-	return 0;
-}
-early_initcall(omap_l2_cache_init);
-#endif
-
-static void __init gic_init_irq(void)
-{
-	void __iomem *base;
-
-	/* Static mapping, never released */
-	base = ioremap(OMAP44XX_GIC_DIST_BASE, SZ_4K);
-	BUG_ON(!base);
-	gic_dist_init(0, base, 29);
-
-	/* Static mapping, never released */
-	gic_cpu_base_addr = ioremap(OMAP44XX_GIC_CPU_BASE, SZ_512);
-	BUG_ON(!gic_cpu_base_addr);
-	gic_cpu_init(0, gic_cpu_base_addr);
-}
-
 static void __init omap_4430sdp_init_irq(void)
 {
 	omap_board_config = sdp4430_config;
diff --git a/arch/arm/mach-omap2/include/mach/omap4-common.h b/arch/arm/mach-omap2/include/mach/omap4-common.h
new file mode 100644
index 0000000..423af3a
--- /dev/null
+++ b/arch/arm/mach-omap2/include/mach/omap4-common.h
@@ -0,0 +1,26 @@
+/*
+ * omap4-common.h: OMAP4 specific common header file
+ *
+ * Copyright (C) 2010 Texas Instruments, Inc.
+ *
+ * Author:
+ *	Santosh Shilimkar <santosh.shilimkar@ti.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#ifndef OMAP_ARCH_OMAP4_COMMON_H
+#define OMAP_ARCH_OMAP4_COMMON_H
+
+#ifdef CONFIG_CACHE_L2X0
+extern void __iomem *l2cache_base;
+#endif
+
+extern void __iomem *gic_cpu_base_addr;
+extern void __iomem *gic_dist_base_addr;
+
+extern void __init gic_init_irq(void);
+extern void omap_smc1(u32 fn, u32 arg);
+
+#endif
diff --git a/arch/arm/mach-omap2/omap-smp.c b/arch/arm/mach-omap2/omap-smp.c
index 38153e5..1cf5231 100644
--- a/arch/arm/mach-omap2/omap-smp.c
+++ b/arch/arm/mach-omap2/omap-smp.c
@@ -24,7 +24,7 @@
 #include <asm/localtimer.h>
 #include <asm/smp_scu.h>
 #include <mach/hardware.h>
-#include <plat/common.h>
+#include <mach/omap4-common.h>
 
 /* SCU base address */
 static void __iomem *scu_base;
diff --git a/arch/arm/mach-omap2/omap4-common.c b/arch/arm/mach-omap2/omap4-common.c
new file mode 100644
index 0000000..075aad4
--- /dev/null
+++ b/arch/arm/mach-omap2/omap4-common.c
@@ -0,0 +1,73 @@
+/*
+ * OMAP4 specific common source file.
+ *
+ * Copyright (C) 2010 Texas Instruments, Inc.
+ * Author:
+ *	Santosh Shilimkar <santosh.shilimkar@ti.com>
+ *
+ *
+ * This program is free software,you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/platform_device.h>
+
+#include <asm/hardware/gic.h>
+#include <asm/hardware/cache-l2x0.h>
+
+#include <mach/hardware.h>
+#include <mach/omap4-common.h>
+
+#ifdef CONFIG_CACHE_L2X0
+void __iomem *l2cache_base;
+#endif
+
+void __iomem *gic_cpu_base_addr;
+void __iomem *gic_dist_base_addr;
+
+
+void __init gic_init_irq(void)
+{
+	/* Static mapping, never released */
+	gic_dist_base_addr = ioremap(OMAP44XX_GIC_DIST_BASE, SZ_4K);
+	BUG_ON(!gic_dist_base_addr);
+	gic_dist_init(0, gic_dist_base_addr, 29);
+
+	/* Static mapping, never released */
+	gic_cpu_base_addr = ioremap(OMAP44XX_GIC_CPU_BASE, SZ_512);
+	BUG_ON(!gic_cpu_base_addr);
+	gic_cpu_init(0, gic_cpu_base_addr);
+}
+
+#ifdef CONFIG_CACHE_L2X0
+static int __init omap_l2_cache_init(void)
+{
+	/* To avoid code running on other OMAPs in
+	 * multi-omap builds
+	 */
+	if (!cpu_is_omap44xx())
+		return -ENODEV;
+
+	/* Static mapping, never released */
+	l2cache_base = ioremap(OMAP44XX_L2CACHE_BASE, SZ_4K);
+	BUG_ON(!l2cache_base);
+
+	/* Enable PL310 L2 Cache controller */
+	omap_smc1(0x102, 0x1);
+
+	/*
+	 * 32KB way size, 16-way associativity,
+	 * parity disabled
+	 */
+	l2x0_init(l2cache_base, 0x0e050000, 0xc0000fff);
+
+	return 0;
+}
+early_initcall(omap_l2_cache_init);
+#endif
+
+
diff --git a/arch/arm/plat-omap/common.c b/arch/arm/plat-omap/common.c
index f12f0e3..219c01e 100644
--- a/arch/arm/plat-omap/common.c
+++ b/arch/arm/plat-omap/common.c
@@ -47,9 +47,6 @@
 struct omap_board_config_kernel *omap_board_config;
 int omap_board_config_size;
 
-/* used by omap-smp.c and board-4430sdp.c */
-void __iomem *gic_cpu_base_addr;
-
 static const void *get_config(u16 tag, size_t len, int skip, size_t *len_out)
 {
 	struct omap_board_config_kernel *kinfo = NULL;
diff --git a/arch/arm/plat-omap/include/plat/common.h b/arch/arm/plat-omap/include/plat/common.h
index 7556e27..d265018 100644
--- a/arch/arm/plat-omap/include/plat/common.h
+++ b/arch/arm/plat-omap/include/plat/common.h
@@ -31,9 +31,6 @@
 
 struct sys_timer;
 
-/* used by omap-smp.c and board-4430sdp.c */
-extern void __iomem *gic_cpu_base_addr;
-
 extern void omap_map_common_io(void);
 extern struct sys_timer omap_timer;
 
-- 
1.6.0.4

