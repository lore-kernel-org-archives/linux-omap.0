From: Ameya Palande <ameya.palande@nokia.com>
Subject: [PATCH] DSPBRIDGE: Maintain VDD1 at OPP3 while DSP is active
Date: Fri, 17 Jul 2009 02:35:52 +0300
Message-ID: <1247787352-22732-1-git-send-email-ameya.palande@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:63179 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933604AbZGPXf4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 16 Jul 2009 19:35:56 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: omar.ramirez@ti.com, x0095840@ti.com, hiroshi.doyu@nokia.com, nm@ti.com

With Smartreflex ON, OPP2 is not sufficient for reliable DSP operation and
we can see following problems:

1. DSP mailbox timeout
2. DSP MMU Faults
3. DSP SYSERRORS

To avoid these issues, this patch maintains OPP3 for DSP active operation by
introducing a new new module parameter "min_active_opp". This can be used
for tuning OPP active value depending on the hardware configuration.

Signed-off-by: Ameya Palande <ameya.palande@nokia.com>
---
 drivers/dsp/bridge/rmgr/drv_interface.c |    6 ++++++
 drivers/dsp/bridge/wmd/tiomap3430.c     |   15 ++++++++-------
 drivers/dsp/bridge/wmd/tiomap3430_pwr.c |   12 +++++++-----
 drivers/dsp/bridge/wmd/tiomap_sm.c      |    9 +++++++--
 4 files changed, 28 insertions(+), 14 deletions(-)

diff --git a/drivers/dsp/bridge/rmgr/drv_interface.c b/drivers/dsp/bridge/rmgr/drv_interface.c
index 12b140c..24f6336 100644
--- a/drivers/dsp/bridge/rmgr/drv_interface.c
+++ b/drivers/dsp/bridge/rmgr/drv_interface.c
@@ -134,6 +134,9 @@ static u32 phys_mempool_base;
 static u32 phys_mempool_size;
 static int tc_wordswapon;	/* Default value is always false */
 
+/* Minimum ACTIVE VDD1 OPP level for reliable DSP operation */
+unsigned short min_active_opp = 3;
+
 #ifdef CONFIG_PM
 struct omap34xx_bridge_suspend_data {
 	int suspended;
@@ -185,6 +188,9 @@ MODULE_PARM_DESC(phys_mempool_size,
 module_param(tc_wordswapon, int, 0);
 MODULE_PARM_DESC(tc_wordswapon, "TC Word Swap Option. default = 0");
 
+module_param(min_active_opp, ushort, S_IRUSR | S_IWUSR);
+MODULE_PARM_DESC(min_active_opp, "Minimum ACTIVE VDD1 OPP Level, default = 3");
+
 MODULE_AUTHOR("Texas Instruments");
 MODULE_LICENSE("GPL");
 
diff --git a/drivers/dsp/bridge/wmd/tiomap3430.c b/drivers/dsp/bridge/wmd/tiomap3430.c
index 54c53b6..f1d5b15 100644
--- a/drivers/dsp/bridge/wmd/tiomap3430.c
+++ b/drivers/dsp/bridge/wmd/tiomap3430.c
@@ -99,6 +99,8 @@
 
 #define MMU_GFLUSH 0x60
 
+extern unsigned short min_active_opp;
+
 /* Forward Declarations: */
 static DSP_STATUS WMD_BRD_Monitor(struct WMD_DEV_CONTEXT *pDevContext);
 static DSP_STATUS WMD_BRD_Read(struct WMD_DEV_CONTEXT *pDevContext,
@@ -295,13 +297,12 @@ static inline void flush_all(struct WMD_DEV_CONTEXT *pDevContext)
 #ifdef CONFIG_BRIDGE_DVFS
 		struct dspbridge_platform_data *pdata =
 			omap_dspbridge_dev->dev.platform_data;
-		u32 opplevel = 0;
-		if (pdata->dsp_get_opp)
-			opplevel = (*pdata->dsp_get_opp)();
-		if (opplevel == VDD1_OPP1) {
-			if (pdata->dsp_set_min_opp)
-				(*pdata->dsp_set_min_opp)(VDD1_OPP2);
-		}
+		/*
+		 * When Smartreflex is ON, DSP requires at least OPP level 3
+		 * to operate reliably. So boost lower OPP levels to OPP3.
+		 */
+		if (pdata->dsp_set_min_opp)
+			(*pdata->dsp_set_min_opp)(min_active_opp);
 #endif
 		tlb_flush_all(pDevContext->dwDSPMmuBase);
 	}
diff --git a/drivers/dsp/bridge/wmd/tiomap3430_pwr.c b/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
index bec696b..4d841db 100644
--- a/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
+++ b/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
@@ -72,6 +72,7 @@
 #endif
 extern struct MAILBOX_CONTEXT mboxsetting;
 extern unsigned short enable_off_mode;
+extern unsigned short min_active_opp;
 /*
  *  ======== handle_constraints_set ========
  *  	Sets new DSP constraint
@@ -97,12 +98,13 @@ DSP_STATUS handle_constraints_set(struct WMD_DEV_CONTEXT *pDevContext,
 	/* Set the new opp value */
 	if (pdata->dsp_set_min_opp) {
 		/*
-		 * Accessing IVA-Memories at OPP1 has been removed from
-		 * operating specification so elevate OPP to 2.
+		 * When Smartreflex is ON, DSP requires at least OPP level 3
+		 * to operate reliably. So boost lower OPP levels to OPP3.
 		 */
-		if (pConstraintVal == VDD1_OPP1) {
-			pr_debug("DSPBRIDGE: VDD1 OPP1 elevated to OPP2\n");
-			(*pdata->dsp_set_min_opp)(VDD1_OPP2);
+		if (pConstraintVal < min_active_opp) {
+			pr_debug("DSPBRIDGE: VDD1 OPP%x elevated to OPP%x\n",
+					pConstraintVal, min_active_opp);
+			(*pdata->dsp_set_min_opp)(min_active_opp);
 		} else
 			(*pdata->dsp_set_min_opp)(pConstraintVal);
 	}
diff --git a/drivers/dsp/bridge/wmd/tiomap_sm.c b/drivers/dsp/bridge/wmd/tiomap_sm.c
index 69f6fb3..36c645c 100644
--- a/drivers/dsp/bridge/wmd/tiomap_sm.c
+++ b/drivers/dsp/bridge/wmd/tiomap_sm.c
@@ -28,6 +28,8 @@
 
 #define MAILBOX_FIFOSTATUS(m) (0x80 + 4 * (m))
 
+extern unsigned short min_active_opp;
+
 static inline unsigned int fifo_full(void __iomem *mbox_base, int mbox_id)
 {
 	return __raw_readl(mbox_base + MAILBOX_FIFOSTATUS(mbox_id)) & 0x1;
@@ -113,9 +115,12 @@ DSP_STATUS CHNLSM_InterruptDSP2(struct WMD_DEV_CONTEXT *pDevContext,
 #ifdef CONFIG_BRIDGE_DVFS
 		struct dspbridge_platform_data *pdata =
 			omap_dspbridge_dev->dev.platform_data;
-
+		/*
+		 * When Smartreflex is ON, DSP requires at least OPP level 3
+		 * to operate reliably. So boost lower OPP levels to OPP3.
+		 */
 		if (pdata->dsp_set_min_opp)
-			(*pdata->dsp_set_min_opp)(VDD1_OPP2);
+			(*pdata->dsp_set_min_opp)(min_active_opp);
 #endif
 		/* Restart the peripheral clocks */
 		DSP_PeripheralClocks_Enable(pDevContext, NULL);
-- 
1.6.2.4

