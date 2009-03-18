From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH A 05/15] tidspbridge: whitespace cleanups
Date: Wed, 18 Mar 2009 03:23:01 +0200
Message-ID: <1237339391-20543-6-git-send-email-felipe.contreras@gmail.com>
References: <1237339391-20543-1-git-send-email-felipe.contreras@gmail.com>
 <1237339391-20543-2-git-send-email-felipe.contreras@gmail.com>
 <1237339391-20543-3-git-send-email-felipe.contreras@gmail.com>
 <1237339391-20543-4-git-send-email-felipe.contreras@gmail.com>
 <1237339391-20543-5-git-send-email-felipe.contreras@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f158.google.com ([209.85.220.158]:63018 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756243AbZCRBYS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Mar 2009 21:24:18 -0400
Received: by mail-fx0-f158.google.com with SMTP id 2so304246fxm.37
        for <linux-omap@vger.kernel.org>; Tue, 17 Mar 2009 18:24:16 -0700 (PDT)
In-Reply-To: <1237339391-20543-5-git-send-email-felipe.contreras@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Hari Kanigeri <h-kanigeri2@ti.com>, Hiroshi DOYU <hiroshi.doyu@nokia.com>, Ameya Palande <ameya.palande@nokia.com>, Fernando Guzman Lugo <x0095840@ti.com>, Felipe Contreras <felipe.contreras@nokia.com>

From: Felipe Contreras <felipe.contreras@nokia.com>

Signed-off-by: Felipe Contreras <felipe.contreras@nokia.com>
---
 drivers/dsp/bridge/wmd/tiomap_sm.c |   83 +++++++++++++++++-------------------
 1 files changed, 39 insertions(+), 44 deletions(-)

diff --git a/drivers/dsp/bridge/wmd/tiomap_sm.c b/drivers/dsp/bridge/wmd/tiomap_sm.c
index 5249ea5..fe4acd8 100644
--- a/drivers/dsp/bridge/wmd/tiomap_sm.c
+++ b/drivers/dsp/bridge/wmd/tiomap_sm.c
@@ -43,38 +43,37 @@ DSP_STATUS CHNLSM_EnableInterrupt(struct WMD_DEV_CONTEXT *hDevContext)
 
 	/* Read the messages in the mailbox until the message queue is empty */
 
-	status = CFG_GetHostResources(
-			(struct CFG_DEVNODE *)DRV_GetFirstDevExtension(),
-			&resources);
+	status = CFG_GetHostResources((struct CFG_DEVNODE *)DRV_GetFirstDevExtension(),
+				      &resources);
 	status = DEV_GetDevType(pDevContext->hDevObject, &devType);
 	status = DEV_GetIOMgr(pDevContext->hDevObject, &hIOMgr);
 	if (devType == DSP_UNIT) {
 		hwStatus = HW_MBOX_NumMsgGet(resources.dwMboxBase,
-					       MBOX_DSP2ARM, &numMbxMsg);
+					     MBOX_DSP2ARM, &numMbxMsg);
 		while (numMbxMsg != 0) {
 			hwStatus = HW_MBOX_MsgRead(resources.dwMboxBase,
-						     MBOX_DSP2ARM,
-						     &mbxValue);
+						   MBOX_DSP2ARM,
+						   &mbxValue);
 			numMbxMsg--;
 		}
 		/* clear the DSP mailbox as well...*/
 		hwStatus = HW_MBOX_NumMsgGet(resources.dwMboxBase,
-					       MBOX_ARM2DSP, &numMbxMsg);
+					     MBOX_ARM2DSP, &numMbxMsg);
 		while (numMbxMsg != 0) {
 			hwStatus = HW_MBOX_MsgRead(resources.dwMboxBase,
-						    MBOX_ARM2DSP, &mbxValue);
+						   MBOX_ARM2DSP, &mbxValue);
 			numMbxMsg--;
 			UTIL_Wait(10);
 
 			HW_MBOX_EventAck(resources.dwMboxBase, MBOX_ARM2DSP,
-					  HW_MBOX_U1_DSP1,
-					  HW_MBOX_INT_NEW_MSG);
+					 HW_MBOX_U1_DSP1,
+					 HW_MBOX_INT_NEW_MSG);
 		}
 		/* Enable the new message events on this IRQ line */
 		hwStatus = HW_MBOX_EventEnable(resources.dwMboxBase,
-						 MBOX_DSP2ARM,
-						 MBOX_ARM,
-						 HW_MBOX_INT_NEW_MSG);
+					       MBOX_DSP2ARM,
+					       MBOX_ARM,
+					       HW_MBOX_INT_NEW_MSG);
 	}
 
 	return status;
@@ -88,11 +87,10 @@ DSP_STATUS CHNLSM_DisableInterrupt(struct WMD_DEV_CONTEXT *hDevContext)
 
 	DBG_Trace(DBG_ENTER, "CHNLSM_DisableInterrupt(0x%x)\n", hDevContext);
 
-	status = CFG_GetHostResources(
-			(struct CFG_DEVNODE *)DRV_GetFirstDevExtension(),
-			&resources);
+	status = CFG_GetHostResources((struct CFG_DEVNODE *)DRV_GetFirstDevExtension(),
+				      &resources);
 	hwStatus = HW_MBOX_EventDisable(resources.dwMboxBase, MBOX_DSP2ARM,
-					  MBOX_ARM, HW_MBOX_INT_NEW_MSG);
+					MBOX_ARM, HW_MBOX_INT_NEW_MSG);
 	return status;
 }
 
@@ -103,7 +101,7 @@ DSP_STATUS CHNLSM_InterruptDSP(struct WMD_DEV_CONTEXT *hDevContext)
 
 #ifdef CONFIG_BRIDGE_DVFS
 	struct dspbridge_platform_data *pdata =
-				omap_dspbridge_dev.dev.platform_data;
+		omap_dspbridge_dev.dev.platform_data;
 	u32 opplevel = 0;
 #endif
 	HW_STATUS hwStatus;
@@ -113,37 +111,35 @@ DSP_STATUS CHNLSM_InterruptDSP(struct WMD_DEV_CONTEXT *hDevContext)
 	u32 temp;
 	/* We are waiting indefinitely here. This needs to be fixed in the
 	 * second phase */
-	status = CFG_GetHostResources(
-			(struct CFG_DEVNODE *)DRV_GetFirstDevExtension(),
-			&resources);
+	status = CFG_GetHostResources((struct CFG_DEVNODE *)DRV_GetFirstDevExtension(),
+				      &resources);
 #ifdef CONFIG_BRIDGE_DVFS
-		if (pdata->dsp_get_opp)
-			opplevel = (*pdata->dsp_get_opp)();
-
-		/* If OPP is at minimum level, increase it before waking up
-		* the DSP */
-		if (opplevel == 1) {
-			if (pdata->dsp_set_min_opp) {
-				(*pdata->dsp_set_min_opp)(opplevel+1);
-				DBG_Trace(DBG_LEVEL7, "CHNLSM_InterruptDSP: "
-					"Setting the vdd1 opp level to %d "
-					"before waking DSP \n",
-					(opplevel + 1));
-			}
+	if (pdata->dsp_get_opp)
+		opplevel = (*pdata->dsp_get_opp)();
+
+	/* If OPP is at minimum level, increase it before waking up
+	 * the DSP */
+	if (opplevel == 1) {
+		if (pdata->dsp_set_min_opp) {
+			(*pdata->dsp_set_min_opp)(opplevel+1);
+			DBG_Trace(DBG_LEVEL7, "CHNLSM_InterruptDSP: "
+				  "Setting the vdd1 opp level to %d "
+				  "before waking DSP \n",
+				  (opplevel + 1));
 		}
+	}
 #endif
 
-	if  (pDevContext->dwBrdState == BRD_DSP_HIBERNATION ||
+	if (pDevContext->dwBrdState == BRD_DSP_HIBERNATION ||
 	    pDevContext->dwBrdState == BRD_HIBERNATION) {
 
-		temp = (u32) *((REG_UWORD32 *) ((u32)
-		       (resources.dwDmmuBase) + 0x10));
+		temp = (u32) *((REG_UWORD32 *) ((u32) (resources.dwDmmuBase) + 0x10));
 
 		/* Restore mailbox settings */
 		status = HW_MBOX_restoreSettings(resources.dwMboxBase);
 
-                /* Restart the peripheral clocks that were disabled only
-                 * in DSP initiated Hibernation case.*/
+		/* Restart the peripheral clocks that were disabled only
+		 * in DSP initiated Hibernation case.*/
 		if (pDevContext->dwBrdState == BRD_DSP_HIBERNATION)
 			DSP_PeripheralClocks_Enable(hDevContext, NULL);
 
@@ -151,7 +147,7 @@ DSP_STATUS CHNLSM_InterruptDSP(struct WMD_DEV_CONTEXT *hDevContext)
 	}
 	while (--cnt) {
 		hwStatus = HW_MBOX_IsFull(resources.dwMboxBase,
-					   MBOX_ARM2DSP, &mbxFull);
+					  MBOX_ARM2DSP, &mbxFull);
 		if (mbxFull)
 			UTIL_Wait(1000);	/* wait for 1 ms)      */
 		else
@@ -163,10 +159,10 @@ DSP_STATUS CHNLSM_InterruptDSP(struct WMD_DEV_CONTEXT *hDevContext)
 		return status;
 	}
 	DBG_Trace(DBG_LEVEL3, "writing %x to Mailbox\n",
-		 pDevContext->wIntrVal2Dsp);
+		  pDevContext->wIntrVal2Dsp);
 
 	hwStatus = HW_MBOX_MsgWrite(resources.dwMboxBase, MBOX_ARM2DSP,
-				     pDevContext->wIntrVal2Dsp);
+				    pDevContext->wIntrVal2Dsp);
 	/* set the Mailbox interrupt to default value */
 	pDevContext->wIntrVal2Dsp = MBX_PCPY_CLASS;
 	return status;
@@ -195,8 +191,7 @@ bool CHNLSM_ISR(struct WMD_DEV_CONTEXT *hDevContext, OUT bool *pfSchedDPC,
 
 	DBG_Trace(DBG_ENTER, "CHNLSM_ISR(0x%x)\n", hDevContext);
 
-	CFG_GetHostResources(
-		(struct CFG_DEVNODE *)DRV_GetFirstDevExtension(), &resources);
+	CFG_GetHostResources((struct CFG_DEVNODE *)DRV_GetFirstDevExtension(), &resources);
 
 	HW_MBOX_NumMsgGet(resources.dwMboxBase, MBOX_DSP2ARM, &numMbxMsg);
 
-- 
1.6.2.1.287.g9a8be

