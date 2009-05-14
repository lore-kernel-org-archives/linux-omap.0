From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 1/5] ARM: OMAP2/3: Remove OMAP2_32KSYNCT_BASE
Date: Thu, 14 May 2009 16:23:06 -0700
Message-ID: <20090514232306.19331.92192.stgit@localhost>
References: <20090514231820.19331.65419.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:59981 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756084AbZENXXO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 May 2009 19:23:14 -0400
In-Reply-To: <20090514231820.19331.65419.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org

Use processor specific defines instead.

As an extra bonus, this patch fixes the problem of CONFIG_DEBUG_SPINLOCK
calling sched_clock before we have things initialized:

http://patchwork.kernel.org/patch/15810/

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/sram242x.S             |    4 +-
 arch/arm/mach-omap2/sram243x.S             |    4 +-
 arch/arm/plat-omap/common.c                |   69 ++++++++++++++++++++++++----
 arch/arm/plat-omap/include/mach/omap24xx.h |    2 -
 arch/arm/plat-omap/include/mach/omap34xx.h |    1 
 5 files changed, 62 insertions(+), 18 deletions(-)

diff --git a/arch/arm/mach-omap2/sram242x.S b/arch/arm/mach-omap2/sram242x.S
index af4bd34..cbb8930 100644
--- a/arch/arm/mach-omap2/sram242x.S
+++ b/arch/arm/mach-omap2/sram242x.S
@@ -128,7 +128,7 @@ omap242x_sdi_prcm_voltctrl:
 prcm_mask_val:
 	.word 0xFFFF3FFC
 omap242x_sdi_timer_32ksynct_cr:
-	.word IO_ADDRESS(OMAP2_32KSYNCT_BASE + 0x010)
+	.word IO_ADDRESS(OMAP2420_32KSYNCT_BASE + 0x010)
 ENTRY(omap242x_sram_ddr_init_sz)
 	.word	. - omap242x_sram_ddr_init
 
@@ -224,7 +224,7 @@ omap242x_srs_prcm_voltctrl:
 ddr_prcm_mask_val:
 	.word 0xFFFF3FFC
 omap242x_srs_timer_32ksynct:
-	.word IO_ADDRESS(OMAP2_32KSYNCT_BASE + 0x010)
+	.word IO_ADDRESS(OMAP2420_32KSYNCT_BASE + 0x010)
 
 ENTRY(omap242x_sram_reprogram_sdrc_sz)
 	.word	. - omap242x_sram_reprogram_sdrc
diff --git a/arch/arm/mach-omap2/sram243x.S b/arch/arm/mach-omap2/sram243x.S
index 84363e2..054b0f3 100644
--- a/arch/arm/mach-omap2/sram243x.S
+++ b/arch/arm/mach-omap2/sram243x.S
@@ -128,7 +128,7 @@ omap243x_sdi_prcm_voltctrl:
 prcm_mask_val:
 	.word 0xFFFF3FFC
 omap243x_sdi_timer_32ksynct_cr:
-	.word IO_ADDRESS(OMAP2_32KSYNCT_BASE + 0x010)
+	.word IO_ADDRESS(OMAP2430_32KSYNCT_BASE + 0x010)
 ENTRY(omap243x_sram_ddr_init_sz)
 	.word	. - omap243x_sram_ddr_init
 
@@ -224,7 +224,7 @@ omap243x_srs_prcm_voltctrl:
 ddr_prcm_mask_val:
 	.word 0xFFFF3FFC
 omap243x_srs_timer_32ksynct:
-	.word IO_ADDRESS(OMAP2_32KSYNCT_BASE + 0x010)
+	.word IO_ADDRESS(OMAP2430_32KSYNCT_BASE + 0x010)
 
 ENTRY(omap243x_sram_reprogram_sdrc_sz)
 	.word	. - omap243x_sram_reprogram_sdrc
diff --git a/arch/arm/plat-omap/common.c b/arch/arm/plat-omap/common.c
index 433021f..e1add78 100644
--- a/arch/arm/plat-omap/common.c
+++ b/arch/arm/plat-omap/common.c
@@ -175,25 +175,61 @@ console_initcall(omap_add_serial_console);
  * but systems won't necessarily want to spend resources that way.
  */
 
-#if defined(CONFIG_ARCH_OMAP16XX)
-#define TIMER_32K_SYNCHRONIZED		0xfffbc410
-#elif defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
-#define TIMER_32K_SYNCHRONIZED		(OMAP2_32KSYNCT_BASE + 0x10)
-#endif
+#define OMAP16XX_TIMER_32K_SYNCHRONIZED		0xfffbc410
 
-#ifdef	TIMER_32K_SYNCHRONIZED
+#if !(defined(CONFIG_ARCH_OMAP730) || defined(CONFIG_ARCH_OMAP15XX))
 
 #include <linux/clocksource.h>
 
-static cycle_t omap_32k_read(struct clocksource *cs)
+#ifdef CONFIG_ARCH_OMAP16XX
+static cycle_t omap16xx_32k_read(struct clocksource *cs)
+{
+	return omap_readl(OMAP16XX_TIMER_32K_SYNCHRONIZED);
+}
+#else
+#define omap16xx_32k_read	NULL
+#endif
+
+#ifdef CONFIG_ARCH_OMAP2420
+static cycle_t omap2420_32k_read(struct clocksource *cs)
+{
+	return omap_readl(OMAP2420_32KSYNCT_BASE + 0x10);
+}
+#else
+#define omap2420_32k_read	NULL
+#endif
+
+#ifdef CONFIG_ARCH_OMAP2430
+static cycle_t omap2430_32k_read(struct clocksource *cs)
+{
+	return omap_readl(OMAP2430_32KSYNCT_BASE + 0x10);
+}
+#else
+#define omap2430_32k_read	NULL
+#endif
+
+#ifdef CONFIG_ARCH_OMAP34XX
+static cycle_t omap34xx_32k_read(struct clocksource *cs)
 {
-	return omap_readl(TIMER_32K_SYNCHRONIZED);
+	return omap_readl(OMAP3430_32KSYNCT_BASE + 0x10);
+}
+#else
+#define omap34xx_32k_read	NULL
+#endif
+
+/*
+ * Kernel assumes that sched_clock can be called early but may not have
+ * things ready yet.
+ */
+static cycle_t omap_32k_read_dummy(struct clocksource *cs)
+{
+	return 0;
 }
 
 static struct clocksource clocksource_32k = {
 	.name		= "32k_counter",
 	.rating		= 250,
-	.read		= omap_32k_read,
+	.read		= omap_32k_read_dummy,
 	.mask		= CLOCKSOURCE_MASK(32),
 	.shift		= 10,
 	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
@@ -207,7 +243,7 @@ unsigned long long sched_clock(void)
 {
 	unsigned long long ret;
 
-	ret = (unsigned long long)omap_32k_read(&clocksource_32k);
+	ret = (unsigned long long)clocksource_32k.read(&clocksource_32k);
 	ret = (ret * clocksource_32k.mult_orig) >> clocksource_32k.shift;
 	return ret;
 }
@@ -220,6 +256,17 @@ static int __init omap_init_clocksource_32k(void)
 	if (cpu_is_omap16xx() || cpu_class_is_omap2()) {
 		struct clk *sync_32k_ick;
 
+		if (cpu_is_omap16xx())
+			clocksource_32k.read = omap16xx_32k_read;
+		else if (cpu_is_omap2420())
+			clocksource_32k.read = omap2420_32k_read;
+		else if (cpu_is_omap2430())
+			clocksource_32k.read = omap2430_32k_read;
+		else if (cpu_is_omap34xx())
+			clocksource_32k.read = omap34xx_32k_read;
+		else
+			return -ENODEV;
+
 		sync_32k_ick = clk_get(NULL, "omap_32ksync_ick");
 		if (sync_32k_ick)
 			clk_enable(sync_32k_ick);
@@ -234,7 +281,7 @@ static int __init omap_init_clocksource_32k(void)
 }
 arch_initcall(omap_init_clocksource_32k);
 
-#endif	/* TIMER_32K_SYNCHRONIZED */
+#endif	/* !(defined(CONFIG_ARCH_OMAP730) || defined(CONFIG_ARCH_OMAP15XX)) */
 
 /* Global address base setup code */
 
diff --git a/arch/arm/plat-omap/include/mach/omap24xx.h b/arch/arm/plat-omap/include/mach/omap24xx.h
index 24335d4..4202cf4 100644
--- a/arch/arm/plat-omap/include/mach/omap24xx.h
+++ b/arch/arm/plat-omap/include/mach/omap24xx.h
@@ -87,7 +87,6 @@
 
 #if defined(CONFIG_ARCH_OMAP2420)
 
-#define OMAP2_32KSYNCT_BASE	OMAP2420_32KSYNCT_BASE
 #define OMAP2_PRCM_BASE		OMAP2420_PRCM_BASE
 #define OMAP2_CM_BASE		OMAP2420_CM_BASE
 #define OMAP2_PRM_BASE		OMAP2420_PRM_BASE
@@ -95,7 +94,6 @@
 
 #elif defined(CONFIG_ARCH_OMAP2430)
 
-#define OMAP2_32KSYNCT_BASE	OMAP2430_32KSYNCT_BASE
 #define OMAP2_PRCM_BASE		OMAP2430_PRCM_BASE
 #define OMAP2_CM_BASE		OMAP2430_CM_BASE
 #define OMAP2_PRM_BASE		OMAP2430_PRM_BASE
diff --git a/arch/arm/plat-omap/include/mach/omap34xx.h b/arch/arm/plat-omap/include/mach/omap34xx.h
index ab64015..581d910 100644
--- a/arch/arm/plat-omap/include/mach/omap34xx.h
+++ b/arch/arm/plat-omap/include/mach/omap34xx.h
@@ -85,7 +85,6 @@
 
 #if defined(CONFIG_ARCH_OMAP3430)
 
-#define OMAP2_32KSYNCT_BASE		OMAP3430_32KSYNCT_BASE
 #define OMAP2_CM_BASE			OMAP3430_CM_BASE
 #define OMAP2_PRM_BASE			OMAP3430_PRM_BASE
 #define OMAP2_VA_IC_BASE		IO_ADDRESS(OMAP34XX_IC_BASE)

