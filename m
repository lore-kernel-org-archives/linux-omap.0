From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH 01/06][RFC] OMAP4: PM: Fix the PRM and CM base addresses
Date: Fri, 29 May 2009 14:02:54 +0530
Message-ID: <1243585979-10921-1-git-send-email-rnayak@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:46127 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756737AbZE2IdG (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 29 May 2009 04:33:06 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id n4T8X2RU030627
	for <linux-omap@vger.kernel.org>; Fri, 29 May 2009 03:33:07 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Rajendra Nayak <rnayak@ti.com>

This patch fixes the PRM and CM base addresses and adds
a new CM2 base address for OMAP4

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/prcm.c                 |    2 ++
 arch/arm/plat-omap/common.c                |    1 +
 arch/arm/plat-omap/include/mach/common.h   |    1 +
 arch/arm/plat-omap/include/mach/omap44xx.h |    6 ++++--
 4 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/prcm.c b/arch/arm/mach-omap2/prcm.c
index f945156..de307fa 100644
--- a/arch/arm/mach-omap2/prcm.c
+++ b/arch/arm/mach-omap2/prcm.c
@@ -27,6 +27,7 @@
 
 static void __iomem *prm_base;
 static void __iomem *cm_base;
+static void __iomem *cm2_base;
 
 u32 omap_prcm_get_reset_sources(void)
 {
@@ -124,4 +125,5 @@ void __init omap2_set_globals_prcm(struct omap_globals *omap2_globals)
 {
 	prm_base = omap2_globals->prm;
 	cm_base = omap2_globals->cm;
+	cm2_base = omap2_globals->cm2;
 }
diff --git a/arch/arm/plat-omap/common.c b/arch/arm/plat-omap/common.c
index ebcf006..a2d5298 100644
--- a/arch/arm/plat-omap/common.c
+++ b/arch/arm/plat-omap/common.c
@@ -372,6 +372,7 @@ static struct omap_globals omap4_globals = {
 	.ctrl	= OMAP2_IO_ADDRESS(OMAP443X_CTRL_BASE),
 	.prm	= OMAP2_IO_ADDRESS(OMAP4430_PRM_BASE),
 	.cm	= OMAP2_IO_ADDRESS(OMAP4430_CM_BASE),
+	.cm2	= OMAP2_IO_ADDRESS(OMAP4430_CM2_BASE),
 };
 
 void __init omap2_set_globals_443x(void)
diff --git a/arch/arm/plat-omap/include/mach/common.h b/arch/arm/plat-omap/include/mach/common.h
index fdeab42..878c4f9 100644
--- a/arch/arm/plat-omap/include/mach/common.h
+++ b/arch/arm/plat-omap/include/mach/common.h
@@ -55,6 +55,7 @@ struct omap_globals {
 	void __iomem	*ctrl;		/* System Control Module */
 	void __iomem	*prm;		/* Power and Reset Management */
 	void __iomem	*cm;		/* Clock Management */
+	void __iomem	*cm2;
 };
 
 void omap2_set_globals_242x(void);
diff --git a/arch/arm/plat-omap/include/mach/omap44xx.h b/arch/arm/plat-omap/include/mach/omap44xx.h
index 15dec7f..be29d77 100644
--- a/arch/arm/plat-omap/include/mach/omap44xx.h
+++ b/arch/arm/plat-omap/include/mach/omap44xx.h
@@ -23,8 +23,10 @@
 #define L4_EMU_44XX_BASE		0x54000000
 #define L3_44XX_BASE			0x44000000
 #define OMAP4430_32KSYNCT_BASE		0x4a304000
-#define OMAP4430_CM_BASE		0x4a004000
-#define OMAP4430_PRM_BASE		0x48306000
+#define OMAP4430_CM1_BASE		0x4A30A000
+#define OMAP4430_CM_BASE		OMAP4430_CM1_BASE
+#define OMAP4430_CM2_BASE		0x4A008000
+#define OMAP4430_PRM_BASE		0x4A306000
 #define OMAP44XX_GPMC_BASE		0x50000000
 #define OMAP443X_SCM_BASE		0x4a002000
 #define OMAP443X_CTRL_BASE		OMAP443X_SCM_BASE
-- 
1.5.4.7

