From: Ameya Palande <ameya.palande@nokia.com>
Subject: [PATCH 1/2] DSPBRIDGE: Cleanup SleepDSP
Date: Fri, 24 Jul 2009 10:01:20 +0300
Message-ID: <1248418882-28164-1-git-send-email-ameya.palande@nokia.com>
References: <1248272767-29223-1-git-send-email-ameya.palande@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:58569 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751854AbZGXHBq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 24 Jul 2009 03:01:46 -0400
In-Reply-To: <1248272767-29223-1-git-send-email-ameya.palande@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: hiroshi.doyu@nokia.com, omar.ramirez@ti.com, x0095840@ti.com

Signed-off-by: Ameya Palande <ameya.palande@nokia.com>
---
 drivers/dsp/bridge/wmd/tiomap3430_pwr.c |   33 ++++++++++++++++++------------
 1 files changed, 20 insertions(+), 13 deletions(-)

diff --git a/drivers/dsp/bridge/wmd/tiomap3430_pwr.c b/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
index b81df8c..7aa58d1 100644
--- a/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
+++ b/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
@@ -204,20 +204,21 @@ DSP_STATUS SleepDSP(struct WMD_DEV_CONTEXT *pDevContext, IN u32 dwCmd,
 	struct CFG_HOSTRES resources;
 	struct DEH_MGR *hDehMgr;
 	u16 usCount = TIHELEN_ACKTIMEOUT;
-	enum HW_PwrState_t pwrState;
-	enum HW_PwrState_t targetPwrState;
+	enum HW_PwrState_t pwrState, targetPwrState;
 
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
@@ -245,7 +246,6 @@ DSP_STATUS SleepDSP(struct WMD_DEV_CONTEXT *pDevContext, IN u32 dwCmd,
 		break;
 	case BRD_HIBERNATION:
 	case BRD_DSP_HIBERNATION:
-		status = HW_MBOX_saveSettings(resources.dwMboxBase);
 		/* Already in Hibernation, so just return */
 		DBG_Trace(DBG_LEVEL7, "SleepDSP- DSP already in "
 			 "hibernation\n");
@@ -259,17 +259,22 @@ DSP_STATUS SleepDSP(struct WMD_DEV_CONTEXT *pDevContext, IN u32 dwCmd,
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
@@ -278,17 +283,19 @@ DSP_STATUS SleepDSP(struct WMD_DEV_CONTEXT *pDevContext, IN u32 dwCmd,
 	} else {
 		DBG_Trace(DBG_LEVEL7, "SleepDSP: DSP STANDBY Pwr state %x \n",
 			 pwrState);
+
 		/* Update the Bridger Driver state */
 		if (enable_off_mode)
 			pDevContext->dwBrdState = BRD_HIBERNATION;
 		else
 			pDevContext->dwBrdState = BRD_RETENTION;
+
 		/* Turn off DSP Peripheral clocks  */
 		status = DSP_PeripheralClocks_Disable(pDevContext, NULL);
 		if (DSP_FAILED(status))
 			DBG_Trace(DBG_LEVEL7, "SleepDSP- FAILED\n");
 	}
-#endif
+#endif /* CONFIG_PM */
 	return status;
 }
 
-- 
1.6.2.4

