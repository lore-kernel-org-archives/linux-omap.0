From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH v2 1/6] ARM: OMAP4: PM: Fix the PRM and CM base addresses
Date: Tue,  8 Dec 2009 23:45:58 +0530
Message-ID: <1260296163-26637-1-git-send-email-rnayak@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:35433 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S937854AbZLHSQP (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 8 Dec 2009 13:16:15 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Rajendra Nayak <rnayak@ti.com>, Paul Walmsley <paul@pwsan.com>, Benoit Cousson <b-cousson@ti.com>

This patch fixes the PRM and CM base addresses and adds
a new CM2 base address for OMAP4

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Benoit Cousson <b-cousson@ti.com>
---
 arch/arm/mach-omap2/Makefile               |    1 +
 arch/arm/mach-omap2/prcm.c                 |    2 ++
 arch/arm/plat-omap/clock.c                 |    5 -----
 arch/arm/plat-omap/common.c                |    2 ++
 arch/arm/plat-omap/include/plat/common.h   |    1 +
 arch/arm/plat-omap/include/plat/omap44xx.h |    6 ++++--
 6 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index b6e011a..2996974 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -11,6 +11,7 @@ clock-common				= clock.o clockdomain.o
 
 obj-$(CONFIG_ARCH_OMAP2) += $(omap-2-3-common) $(prcm-common) $(clock-common)
 obj-$(CONFIG_ARCH_OMAP3) += $(omap-2-3-common) $(prcm-common) $(clock-common)
+obj-$(CONFIG_ARCH_OMAP4) += prcm.o
 
 obj-$(CONFIG_OMAP_MCBSP) += mcbsp.o
 
diff --git a/arch/arm/mach-omap2/prcm.c b/arch/arm/mach-omap2/prcm.c
index 029d376..bfe9a15 100644
--- a/arch/arm/mach-omap2/prcm.c
+++ b/arch/arm/mach-omap2/prcm.c
@@ -34,6 +34,7 @@
 
 static void __iomem *prm_base;
 static void __iomem *cm_base;
+static void __iomem *cm2_base;
 
 #define MAX_MODULE_ENABLE_WAIT		100000
 
@@ -265,6 +266,7 @@ void __init omap2_set_globals_prcm(struct omap_globals *omap2_globals)
 {
 	prm_base = omap2_globals->prm;
 	cm_base = omap2_globals->cm;
+	cm2_base = omap2_globals->cm2;
 }
 
 #ifdef CONFIG_ARCH_OMAP3
diff --git a/arch/arm/plat-omap/clock.c b/arch/arm/plat-omap/clock.c
index 681bfc3..b857d11 100644
--- a/arch/arm/plat-omap/clock.c
+++ b/arch/arm/plat-omap/clock.c
@@ -57,11 +57,6 @@ void omap2_clk_prepare_for_reboot(void)
 {
 }
 EXPORT_SYMBOL(omap2_clk_prepare_for_reboot);
-
-void omap_prcm_arch_reset(char mode)
-{
-}
-EXPORT_SYMBOL(omap_prcm_arch_reset);
 #endif
 int clk_enable(struct clk *clk)
 {
diff --git a/arch/arm/plat-omap/common.c b/arch/arm/plat-omap/common.c
index cc050b3..01ab1e5 100644
--- a/arch/arm/plat-omap/common.c
+++ b/arch/arm/plat-omap/common.c
@@ -284,12 +284,14 @@ static struct omap_globals omap4_globals = {
 	.ctrl	= OMAP2_L4_IO_ADDRESS(OMAP443X_CTRL_BASE),
 	.prm	= OMAP2_L4_IO_ADDRESS(OMAP4430_PRM_BASE),
 	.cm	= OMAP2_L4_IO_ADDRESS(OMAP4430_CM_BASE),
+	.cm2	= OMAP2_L4_IO_ADDRESS(OMAP4430_CM2_BASE),
 };
 
 void __init omap2_set_globals_443x(void)
 {
 	omap2_set_globals_tap(&omap4_globals);
 	omap2_set_globals_control(&omap4_globals);
+	omap2_set_globals_prcm(&omap4_globals);
 }
 #endif
 
diff --git a/arch/arm/plat-omap/include/plat/common.h b/arch/arm/plat-omap/include/plat/common.h
index 754fbc8..5876373 100644
--- a/arch/arm/plat-omap/include/plat/common.h
+++ b/arch/arm/plat-omap/include/plat/common.h
@@ -46,6 +46,7 @@ struct omap_globals {
 	void __iomem	*ctrl;		/* System Control Module */
 	void __iomem	*prm;		/* Power and Reset Management */
 	void __iomem	*cm;		/* Clock Management */
+	void __iomem	*cm2;
 };
 
 void omap2_set_globals_242x(void);
diff --git a/arch/arm/plat-omap/include/plat/omap44xx.h b/arch/arm/plat-omap/include/plat/omap44xx.h
index e52902a..ef870de 100644
--- a/arch/arm/plat-omap/include/plat/omap44xx.h
+++ b/arch/arm/plat-omap/include/plat/omap44xx.h
@@ -26,8 +26,10 @@
 #define OMAP44XX_EMIF2_BASE		0x4d000000
 #define OMAP44XX_DMM_BASE		0x4e000000
 #define OMAP4430_32KSYNCT_BASE		0x4a304000
-#define OMAP4430_CM_BASE		0x4a004000
-#define OMAP4430_PRM_BASE		0x48306000
+#define OMAP4430_CM1_BASE		0x4a004000
+#define OMAP4430_CM_BASE		OMAP4430_CM1_BASE
+#define OMAP4430_CM2_BASE		0x4a008000
+#define OMAP4430_PRM_BASE		0x4a306000
 #define OMAP44XX_GPMC_BASE		0x50000000
 #define OMAP443X_SCM_BASE		0x4a002000
 #define OMAP443X_CTRL_BASE		OMAP443X_SCM_BASE
-- 
1.5.4.7

