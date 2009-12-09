From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 1/4] OMAP4: Add L2 Cache support
Date: Thu, 10 Dec 2009 00:13:50 +0530
Message-ID: <1260384233-2278-1-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:33156 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757026AbZLISoO (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 9 Dec 2009 13:44:14 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux@arm.linux.org.uk, Santosh Shilimkar <santosh.shilimkar@ti.com>

This patch adds L2 Cache support for OMAP4. External L2 cache
is used in OMPA4

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/board-4430sdp.c        |   30 ++++++++++++++++++++++++++++
 arch/arm/mm/Kconfig                        |    2 +-
 arch/arm/plat-omap/include/plat/omap44xx.h |    1 +
 3 files changed, 32 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index 0c6be6b..ceb2490 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -28,6 +28,7 @@
 #include <plat/control.h>
 #include <plat/timer-gp.h>
 #include <asm/hardware/gic.h>
+#include <asm/hardware/cache-l2x0.h>
 
 static struct platform_device sdp4430_lcd_device = {
 	.name		= "sdp4430_lcd",
@@ -49,6 +50,35 @@ static struct omap_lcd_config sdp4430_lcd_config __initdata = {
 static struct omap_board_config_kernel sdp4430_config[] __initdata = {
 	{ OMAP_TAG_LCD,		&sdp4430_lcd_config },
 };
+#ifdef CONFIG_CACHE_L2X0
+static int __init omap_l2_cache_init(void)
+{
+	void __iomem *l2cache_base;
+
+	/* Static mapping, never released */
+	l2cache_base = ioremap(OMAP44XX_L2CACHE_BASE, SZ_4K);
+	BUG_ON(!l2cache_base);
+
+	/* Enable L2 Cache using secure api
+	 * Save/Restore relevant registers
+	 */
+	__asm__ __volatile__(
+		"stmfd r13!, {r0-r12, r14}\n"
+		"mov r0, #1\n"
+		"ldr r12, =0x102\n"
+		"dsb\n"
+		"smc\n"
+		"ldmfd r13!, {r0-r12, r14}");
+
+	/* 32KB way size, 16-way associativity,
+	* parity disabled
+	*/
+	l2x0_init(l2cache_base, 0x0e050000, 0xc0000fff);
+
+	return 0;
+}
+early_initcall(omap_l2_cache_init);
+#endif
 
 static void __init gic_init_irq(void)
 {
diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
index dd4698c..b146ae2 100644
--- a/arch/arm/mm/Kconfig
+++ b/arch/arm/mm/Kconfig
@@ -758,7 +758,7 @@ config CACHE_FEROCEON_L2_WRITETHROUGH
 config CACHE_L2X0
 	bool "Enable the L2x0 outer cache controller"
 	depends on REALVIEW_EB_ARM11MP || MACH_REALVIEW_PB11MP || MACH_REALVIEW_PB1176 || \
-		   REALVIEW_EB_A9MP || ARCH_MX35 || ARCH_MX31 || MACH_REALVIEW_PBX || ARCH_NOMADIK
+		   REALVIEW_EB_A9MP || ARCH_MX35 || ARCH_MX31 || MACH_REALVIEW_PBX || ARCH_NOMADIK || ARCH_OMAP4
 	default y
 	select OUTER_CACHE
 	help
diff --git a/arch/arm/plat-omap/include/plat/omap44xx.h b/arch/arm/plat-omap/include/plat/omap44xx.h
index e52902a..9b7870c 100644
--- a/arch/arm/plat-omap/include/plat/omap44xx.h
+++ b/arch/arm/plat-omap/include/plat/omap44xx.h
@@ -38,6 +38,7 @@
 #define OMAP44XX_GIC_CPU_BASE		0x48240100
 #define OMAP44XX_SCU_BASE		0x48240000
 #define OMAP44XX_LOCAL_TWD_BASE		0x48240600
+#define OMAP44XX_L2CACHE_BASE		0x48242000
 #define OMAP44XX_WKUPGEN_BASE		0x48281000
 
 #define OMAP44XX_MAILBOX_BASE		(L4_44XX_BASE + 0xF4000)
-- 
1.6.0.4

