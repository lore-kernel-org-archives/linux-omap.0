From: Ameya Palande <ameya.palande@nokia.com>
Subject: [PATCH][RFC] DSPBRIDGE: SleepDSP switch to VDD1 OPP1 while hibernation
Date: Wed, 22 Jul 2009 17:26:07 +0300
Message-ID: <1248272767-29223-1-git-send-email-ameya.palande@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:34416 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755319AbZGVO1B (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 22 Jul 2009 10:27:01 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: hiroshi.doyu@nokia.com, omar.ramirez@ti.com, x0095840@ti.com

This patch adds code to switch to VDD1 OPP1 when DSP is hibernated.
Also some code cleanup.

Signed-off-by: Ameya Palande <ameya.palande@nokia.com>
---
 drivers/dsp/bridge/wmd/tiomap3430_pwr.c |   51 +++++++++++++++++++++----------
 1 files changed, 35 insertions(+), 16 deletions(-)

diff --git a/drivers/dsp/bridge/wmd/tiomap3430_pwr.c b/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
index b81df8c..20d3e23 100644
--- a/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
+++ b/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
@@ -207,17 +207,19 @@ DSP_STATUS SleepDSP(struct WMD_DEV_CONTEXT *pDevContext, IN u32 dwCmd,
 	enum HW_PwrState_t pwrState;
 	enum HW_PwrState_t targetPwrState;
 
-	status = CFG_GetHostResources(
-		 (struct CFG_DEVNODE *)DRV_GetFirstDevExtension(), &resources);
-	if (DSP_FAILED(status))
-		return status;
 	DBG_Trace(DBG_LEVEL7, "SleepDSP- Enter function \n");
 
-		/* next, check if sleep code is valid... */
+	/* Check if sleep code is valid */
 	if ((dwCmd != PWR_DEEPSLEEP) && (dwCmd != PWR_EMERGENCYDEEPSLEEP)) {
 		DBG_Trace(DBG_LEVEL7, "SleepDSP- Illegal sleep command\n");
 		return DSP_EINVALIDARG;
 	}
+
+	status = CFG_GetHostResources(
+		 (struct CFG_DEVNODE *)DRV_GetFirstDevExtension(), &resources);
+	if (DSP_FAILED(status))
+		return status;
+
 	switch (pDevContext->dwBrdState) {
 	case BRD_RUNNING:
 		status = HW_MBOX_saveSettings(resources.dwMboxBase);
@@ -245,7 +247,6 @@ DSP_STATUS SleepDSP(struct WMD_DEV_CONTEXT *pDevContext, IN u32 dwCmd,
 		break;
 	case BRD_HIBERNATION:
 	case BRD_DSP_HIBERNATION:
-		status = HW_MBOX_saveSettings(resources.dwMboxBase);
 		/* Already in Hibernation, so just return */
 		DBG_Trace(DBG_LEVEL7, "SleepDSP- DSP already in "
 			 "hibernation\n");
@@ -259,17 +260,22 @@ DSP_STATUS SleepDSP(struct WMD_DEV_CONTEXT *pDevContext, IN u32 dwCmd,
 			 "SleepDSP- Bridge in Illegal state\n");
 			return DSP_EFAIL;
 	}
+
 	/* Get the PRCM DSP power domain status */
 	HW_PWR_IVA2StateGet(resources.dwPrmBase, HW_PWR_DOMAIN_DSP,
-			    &pwrState);
-	/* Wait for DSP to move into Standby state,  how much time
-	 * should we wait?*/
+			&pwrState);
+
+	/*
+	 * Wait for DSP to move into Standby state,  how much time
+	 * should we wait?
+	 */
 	while ((pwrState != targetPwrState) && --usCount) {
 		udelay(500);
 		HW_PWR_IVA2StateGet(resources.dwPrmBase, HW_PWR_DOMAIN_DSP,
 				    &pwrState);
 	}
-	if (usCount == 0) {
+
+	if (!usCount) {
 		DBG_Trace(DBG_LEVEL7, "SleepDSP: Timed out Waiting for DSP"
 			 " STANDBY %x \n", pwrState);
 		DEV_GetDehMgr(pDevContext->hDevObject, &hDehMgr);
@@ -278,17 +284,30 @@ DSP_STATUS SleepDSP(struct WMD_DEV_CONTEXT *pDevContext, IN u32 dwCmd,
 	} else {
 		DBG_Trace(DBG_LEVEL7, "SleepDSP: DSP STANDBY Pwr state %x \n",
 			 pwrState);
+
 		/* Update the Bridger Driver state */
-		if (enable_off_mode)
-			pDevContext->dwBrdState = BRD_HIBERNATION;
-		else
-			pDevContext->dwBrdState = BRD_RETENTION;
+		pDevContext->dwBrdState = enable_off_mode ? BRD_HIBERNATION
+							: BRD_RETENTION;
+
 		/* Turn off DSP Peripheral clocks  */
 		status = DSP_PeripheralClocks_Disable(pDevContext, NULL);
-		if (DSP_FAILED(status))
+		if (DSP_FAILED(status)) {
 			DBG_Trace(DBG_LEVEL7, "SleepDSP- FAILED\n");
+			return status;
+		}
+#ifdef CONFIG_BRIDGE_DVFS
+		else if (targetPwrState == HW_PWR_STATE_OFF) {
+			struct dspbridge_platform_data *pdata =
+				omap_dspbridge_dev->dev.platform_data;
+			/*
+			 * Set the OPP to low level before moving to OFF mode
+			 */
+			if (pdata->dsp_set_min_opp)
+				(*pdata->dsp_set_min_opp)(VDD1_OPP1);
+		}
+#endif /* CONFIG_BRIDGE_DVFS */
 	}
-#endif
+#endif /* CONFIG_PM */
 	return status;
 }
 
-- 
1.6.2.4

