From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 1/3 v2] OMAP4: Add L2 Cache support
Date: Fri, 29 Jan 2010 19:00:39 +0530
Message-ID: <1264771839-1121-1-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:56856 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753515Ab0A2NbD (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 29 Jan 2010 08:31:03 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-arm-kernel@lists.infradead.org, rmk@arm.linux.org.uk, catalin.marinas@arm.com, linux-omap@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>

This patch adds L2 Cache support for OMAP4. External L2 cache
is used in OMPA4

v2 version incorporates Catalin's commnet on the register
save/restore list

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
CC: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm/mach-omap2/board-4430sdp.c        |   45 ++++++++++++++++++++++++++++
 arch/arm/mm/Kconfig                        |    2 +-
 arch/arm/plat-omap/include/plat/omap44xx.h |    1 +
 3 files changed, 47 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index 0c6be6b..a828c77 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -28,6 +28,7 @@
 #include <plat/control.h>
 #include <plat/timer-gp.h>
 #include <asm/hardware/gic.h>
+#include <asm/hardware/cache-l2x0.h>
 
 static struct platform_device sdp4430_lcd_device = {
 	.name		= "sdp4430_lcd",
@@ -49,6 +50,50 @@ static struct omap_lcd_config sdp4430_lcd_config __initdata = {
 static struct omap_board_config_kernel sdp4430_config[] __initdata = {
 	{ OMAP_TAG_LCD,		&sdp4430_lcd_config },
 };
+#ifdef CONFIG_CACHE_L2X0
+static noinline void omap_l2x_control(unsigned long val)
+{
+	register unsigned long r0 asm("r0") = val;
+
+	/* This API modifies Pl310 Control Register.
+	 * r0 contains the value to be modified and "r12" contains
+	 * the monitor API number. It uses few CPU registers
+	 * internally and hence they need be backed up including
+	 * link register "lr".
+	 * Explicitly save r11 and r12 since  the compiler generated
+	 * code won't save it.
+	 */
+	__asm__ __volatile__(
+		__asmeq("%0", "r0")
+		"stmfd r13!, {r11,r12}\n"
+		"ldr r12, =0x102\n"
+		"dsb\n"
+		"smc\n"
+		"ldmfd r13!, {r11,r12}\n"
+		: : "r" (r0)
+		: "r4", "r5", "r10", "lr");
+}
+
+static int __init omap_l2_cache_init(void)
+{
+	void __iomem *l2cache_base;
+
+	/* Static mapping, never released */
+	l2cache_base = ioremap(OMAP44XX_L2CACHE_BASE, SZ_4K);
+	BUG_ON(!l2cache_base);
+
+	/* Enable L2 Cache controller */
+	omap_l2x_control(0x1);
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
index baf6384..696e83e 100644
--- a/arch/arm/mm/Kconfig
+++ b/arch/arm/mm/Kconfig
@@ -754,7 +754,7 @@ config CACHE_FEROCEON_L2_WRITETHROUGH
 config CACHE_L2X0
 	bool "Enable the L2x0 outer cache controller"
 	depends on REALVIEW_EB_ARM11MP || MACH_REALVIEW_PB11MP || MACH_REALVIEW_PB1176 || \
-		   REALVIEW_EB_A9MP || ARCH_MX35 || ARCH_MX31 || MACH_REALVIEW_PBX || ARCH_NOMADIK
+		   REALVIEW_EB_A9MP || ARCH_MX35 || ARCH_MX31 || MACH_REALVIEW_PBX || ARCH_NOMADIK || ARCH_OMAP4
 	default y
 	select OUTER_CACHE
 	help
diff --git a/arch/arm/plat-omap/include/plat/omap44xx.h b/arch/arm/plat-omap/include/plat/omap44xx.h
index ef870de..c7d628e 100644
--- a/arch/arm/plat-omap/include/plat/omap44xx.h
+++ b/arch/arm/plat-omap/include/plat/omap44xx.h
@@ -40,6 +40,7 @@
 #define OMAP44XX_GIC_CPU_BASE		0x48240100
 #define OMAP44XX_SCU_BASE		0x48240000
 #define OMAP44XX_LOCAL_TWD_BASE		0x48240600
+#define OMAP44XX_L2CACHE_BASE		0x48242000
 #define OMAP44XX_WKUPGEN_BASE		0x48281000
 
 #define OMAP44XX_MAILBOX_BASE		(L4_44XX_BASE + 0xF4000)
-- 
1.6.0.4

