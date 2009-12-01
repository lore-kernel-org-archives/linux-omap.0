From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH 1/6] ARM: OMAP4: PM: Fix the PRM and CM base addresses
Date: Tue,  1 Dec 2009 17:47:35 +0530
Message-ID: <1259669860-18941-1-git-send-email-rnayak@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:49883 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753085AbZLAMRv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Dec 2009 07:17:51 -0500
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
 arch/arm/mach-omap2/prcm.c                 |    2 ++
 arch/arm/plat-omap/common.c                |    2 ++
 arch/arm/plat-omap/include/mach/common.h   |    1 +
 arch/arm/plat-omap/include/mach/omap44xx.h |    6 ++++--
 4 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/prcm.c b/arch/arm/mach-omap2/prcm.c
index ced555a..256f9fa 100644
--- a/arch/arm/mach-omap2/prcm.c
+++ b/arch/arm/mach-omap2/prcm.c
@@ -28,6 +28,7 @@
 
 static void __iomem *prm_base;
 static void __iomem *cm_base;
+static void __iomem *cm2_base;
 
 #define MAX_MODULE_ENABLE_WAIT		100000
 
@@ -167,4 +168,5 @@ void __init omap2_set_globals_prcm(struct omap_globals *omap2_globals)
 {
 	prm_base = omap2_globals->prm;
 	cm_base = omap2_globals->cm;
+	cm2_base = omap2_globals->cm2;
 }
diff --git a/arch/arm/plat-omap/common.c b/arch/arm/plat-omap/common.c
index 3a4768d..bf00f3f 100644
--- a/arch/arm/plat-omap/common.c
+++ b/arch/arm/plat-omap/common.c
@@ -281,12 +281,14 @@ static struct omap_globals omap4_globals = {
 	.ctrl	= OMAP2_IO_ADDRESS(OMAP443X_CTRL_BASE),
 	.prm	= OMAP2_IO_ADDRESS(OMAP4430_PRM_BASE),
 	.cm	= OMAP2_IO_ADDRESS(OMAP4430_CM_BASE),
+	.cm2	= OMAP2_IO_ADDRESS(OMAP4430_CM2_BASE),
 };
 
 void __init omap2_set_globals_443x(void)
 {
 	omap2_set_globals_tap(&omap4_globals);
 	omap2_set_globals_control(&omap4_globals);
+	omap2_set_globals_prcm(&omap4_globals);
 }
 #endif
 
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
index b3ba5ac..d7b4c28 100644
--- a/arch/arm/plat-omap/include/mach/omap44xx.h
+++ b/arch/arm/plat-omap/include/mach/omap44xx.h
@@ -23,8 +23,10 @@
 #define L4_EMU_44XX_BASE		0x54000000
 #define L3_44XX_BASE			0x44000000
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

