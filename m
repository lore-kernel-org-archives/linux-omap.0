From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 2/5] OMAP4: Add L2 Cache support
Date: Thu,  4 Feb 2010 19:55:44 +0530
Message-ID: <1265293547-18960-2-git-send-email-santosh.shilimkar@ti.com>
References: <1265293547-18960-1-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:40261 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752219Ab0BDO0R (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 4 Feb 2010 09:26:17 -0500
In-Reply-To: <1265293547-18960-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-arm-kernel@lists.infradead.org, rmk@arm.linux.org.uk, catalin.marinas@arm.com, linux-omap@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, Russell King <rmk+kernel@arm.linux.org.uk>

This patch adds L2 Cache support for OMAP4. External L2 cache
is used in OMPA4

v2 version incorporates Catalin's commnet on the register
save/restore list

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
CC: Catalin Marinas <catalin.marinas@arm.com>
CC: Tony Lindgren <tony@atomide.com>
CC: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-omap2/board-4430sdp.c        |   53 ++++++++++++++++++++++++++++
 arch/arm/mm/Kconfig                        |    2 +-
 arch/arm/plat-omap/include/plat/omap44xx.h |    1 +
 3 files changed, 55 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index 0c6be6b..6571cde 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -28,6 +28,7 @@
 #include <plat/control.h>
 #include <plat/timer-gp.h>
 #include <asm/hardware/gic.h>
+#include <asm/hardware/cache-l2x0.h>
 
 static struct platform_device sdp4430_lcd_device = {
 	.name		= "sdp4430_lcd",
@@ -49,6 +50,58 @@ static struct omap_lcd_config sdp4430_lcd_config __initdata = {
 static struct omap_board_config_kernel sdp4430_config[] __initdata = {
 	{ OMAP_TAG_LCD,		&sdp4430_lcd_config },
 };
+#ifdef CONFIG_CACHE_L2X0
+void noinline omap_smc1(u32 fn, u32 arg)
+{
+	register u32 r12 asm("r12") = fn;
+	register u32 r0 asm("r0") = arg;
+
+	/* This is common routine cache secure monitor API used to
+	 * modify the PL310 secure registers.
+	 * r0 contains the value to be modified and "r12" contains
+	 * the monitor API number. It uses few CPU registers
+	 * internally and hence they need be backed up including
+	 * link register "lr".
+	 * Explicitly save r11 and r12 the compiler generated code
+	 * won't save it.
+	 */
+	asm volatile(
+		"stmfd r13!, {r11,r12}\n"
+		"dsb\n"
+		"smc\n"
+		"ldmfd r13!, {r11,r12}\n"
+		: "+r" (r0), "+r" (r12)
+		:
+		: "r4", "r5", "r10", "lr", "cc");
+}
+EXPORT_SYMBOL(omap_smc1);
+
+static int __init omap_l2_cache_init(void)
+{
+	void __iomem *l2cache_base;
+
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

