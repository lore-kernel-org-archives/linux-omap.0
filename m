From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 1/8] DSPBRIDGE: Cleanup SSI handling - remove IO_ADDRESS
Date: Thu,  7 Jan 2010 19:00:26 -0600
Message-ID: <1262912426-29974-1-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:41952 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754463Ab0AHAvS (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 7 Jan 2010 19:51:18 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Ameya Palande <ameya.palande@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>, Fernando Guzman <x0095840@ti.com>, Ernesto Ramos <ernesto@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>

This patch cleans SSI clock preparation and also removes
the dependency on IO_ADDRESS variants for easier maintenance.

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 arch/arm/plat-omap/include/dspbridge/drv.h |    7 ++++++
 drivers/dsp/bridge/services/clk.c          |   30 ++++++++++++++-------------
 2 files changed, 23 insertions(+), 14 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/drv.h b/arch/arm/plat-omap/include/dspbridge/drv.h
index d14613f..59c26fc 100644
--- a/arch/arm/plat-omap/include/dspbridge/drv.h
+++ b/arch/arm/plat-omap/include/dspbridge/drv.h
@@ -115,6 +115,13 @@
 #define OMAP_DMMU_BASE 0x5D000000
 #define OMAP_DMMU_SIZE 0x1000
 
+#define OMAP_SSI_BASE		0x48058000
+#define OMAP_SSI_SIZE		0x1000
+
+#define SSI_AUTOIDLE			(1 << 0)
+#define SSI_SIDLE_SMARTIDLE	(2 << 3)
+#define SSI_MIDLE_NOIDLE		(1 << 12)
+
 #define OMAP_PRCM_VDD1_DOMAIN 1
 #define OMAP_PRCM_VDD2_DOMAIN 2
 
diff --git a/drivers/dsp/bridge/services/clk.c b/drivers/dsp/bridge/services/clk.c
index d1c68fc..dbe3988 100644
--- a/drivers/dsp/bridge/services/clk.c
+++ b/drivers/dsp/bridge/services/clk.c
@@ -39,6 +39,7 @@
 #include <dspbridge/std.h>
 #include <dspbridge/dbdefs.h>
 #include <dspbridge/errbase.h>
+#include <dspbridge/drv.h>
 
 /*  ----------------------------------- Trace & Debug */
 #include <dspbridge/dbc.h>
@@ -54,11 +55,6 @@
 
 typedef volatile unsigned long  REG_UWORD32;
 
-#define SSI_Base        0x48058000
-
-#define SSI_BASE                     IO_ADDRESS(SSI_Base)
-
-
 struct SERVICES_Clk_t {
 	struct clk *clk_handle;
 	const char *clk_name;
@@ -354,19 +350,25 @@ s32 CLK_Get_UseCnt(IN enum SERVICES_ClkId clk_id)
 
 void SSI_Clk_Prepare(bool FLAG)
 {
-	u32 ssi_sysconfig;
-	ssi_sysconfig = __raw_readl((SSI_BASE) + 0x10);
+	void __iomem *ssi_base;
+	unsigned int value;
+
+	ssi_base = ioremap(OMAP_SSI_BASE, OMAP_SSI_SIZE);
 
 	if (FLAG) {
-		/* Set Autoidle, SIDLEMode to smart idle, and MIDLEmode to
-		 * no idle
+		/*
+		 * Set Autoidle, SIDLEMode to smart idle, and MIDLEmode to
+		 * no idle.
 		 */
-		ssi_sysconfig = 0x1011;
+		value = SSI_AUTOIDLE | SSI_SIDLE_SMARTIDLE | SSI_MIDLE_NOIDLE;
 	} else {
-		/* Set Autoidle, SIDLEMode to forced idle, and MIDLEmode to
-		 * forced idle
+		/*
+		 * Set Autoidle, SIDLEMode to forced idle, and MIDLEmode to
+		 * forced idle.
 		 */
-		ssi_sysconfig = 0x1;
+		value = SSI_AUTOIDLE;
 	}
-	__raw_writel((u32)ssi_sysconfig, SSI_BASE + 0x10);
+
+	__raw_writel(value, ssi_base + 0x10);
+	iounmap(ssi_base);
 }
-- 
1.6.2.4

