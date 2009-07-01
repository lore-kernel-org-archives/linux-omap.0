From: Ameya Palande <ameya.palande@nokia.com>
Subject: [PATCH] DSPBRIDGE: Fixes the DSP crash when driver is unloaded.
Date: Wed,  1 Jul 2009 16:32:39 +0300
Message-ID: <1246455159-7420-1-git-send-email-ameya.palande@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:21071 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751988AbZGANcq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 1 Jul 2009 09:32:46 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: h-kanigeri2@ti.com, omar.ramirez@ti.com, x0095840@ti.com

From: Roman Tereshonkov <roman.tereshonkov@nokia.com>

clk_notifier_unregister should be run before data structures are freed,
otherwise it will try to access to NULLed data.

Signed-off-by: Roman Tereshonkov <roman.tereshonkov@nokia.com>
Signed-off-by: Hari Kanigeri <h-kanigeri2@ti.com>
---
 drivers/dsp/bridge/rmgr/drv_interface.c |   29 ++++++++++++++++-------------
 1 files changed, 16 insertions(+), 13 deletions(-)

diff --git a/drivers/dsp/bridge/rmgr/drv_interface.c b/drivers/dsp/bridge/rmgr/drv_interface.c
index f41e153..12b140c 100644
--- a/drivers/dsp/bridge/rmgr/drv_interface.c
+++ b/drivers/dsp/bridge/rmgr/drv_interface.c
@@ -452,6 +452,17 @@ static int __devexit omap34xx_bridge_remove(struct platform_device *pdev)
 	dsp_status = CFG_GetObject((u32 *)&hDrvObject, REG_DRV_OBJECT);
 	if (DSP_FAILED(dsp_status))
 		goto func_cont;
+
+#ifdef CONFIG_BRIDGE_DVFS
+	if (!clk_notifier_unregister(clk_handle, &iva_clk_notifier)) {
+		GT_0trace(driverTrace, GT_7CLASS,
+		"clk_notifier_unregister PASS for iva2_ck \n");
+	} else {
+		GT_0trace(driverTrace, GT_7CLASS,
+		"clk_notifier_unregister FAILED for iva2_ck \n");
+	}
+#endif /* #ifdef CONFIG_BRIDGE_DVFS */
+
 	DRV_GetProcCtxtList(&pCtxtclosed, (struct DRV_OBJECT *)hDrvObject);
 	while (pCtxtclosed != NULL) {
 		GT_1trace(driverTrace, GT_5CLASS, "***Cleanup of "
@@ -463,28 +474,20 @@ static int __devexit omap34xx_bridge_remove(struct platform_device *pdev)
 				     pCtxtclosed, (void *)pCtxtclosed->pid);
 		pCtxtclosed = pTmp;
 	}
-func_cont:
+
 	if (driverContext) {
 		/* Put the DSP in reset state */
 		ret = DSP_Deinit(driverContext);
 		driverContext = 0;
 		DBC_Assert(ret == true);
 	}
-	SERVICES_Exit();
-	GT_exit();
-	/* unregister the clock notifier */
-#ifdef CONFIG_BRIDGE_DVFS
-	if (!clk_notifier_unregister(clk_handle, &iva_clk_notifier)) {
-		GT_0trace(driverTrace, GT_7CLASS,
-		"clk_notifier_unregister PASS for iva2_ck \n");
-	} else {
-		GT_0trace(driverTrace, GT_7CLASS,
-		"clk_notifier_unregister PASS for iva2_ck \n");
-	}
 
 	clk_put(clk_handle);
 	clk_handle = NULL;
-#endif /* #ifdef CONFIG_BRIDGE_DVFS */
+
+func_cont:
+	SERVICES_Exit();
+	GT_exit();
 
 	devno = MKDEV(driver_major, driver_minor);
 	if (bridge_device) {
-- 
1.6.2.4

