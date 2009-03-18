From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH A 06/15] tidspbridge: trivial cleanups
Date: Wed, 18 Mar 2009 03:23:02 +0200
Message-ID: <1237339391-20543-7-git-send-email-felipe.contreras@gmail.com>
References: <1237339391-20543-1-git-send-email-felipe.contreras@gmail.com>
 <1237339391-20543-2-git-send-email-felipe.contreras@gmail.com>
 <1237339391-20543-3-git-send-email-felipe.contreras@gmail.com>
 <1237339391-20543-4-git-send-email-felipe.contreras@gmail.com>
 <1237339391-20543-5-git-send-email-felipe.contreras@gmail.com>
 <1237339391-20543-6-git-send-email-felipe.contreras@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f158.google.com ([209.85.220.158]:63018 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756265AbZCRBYU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Mar 2009 21:24:20 -0400
Received: by mail-fx0-f158.google.com with SMTP id 2so304246fxm.37
        for <linux-omap@vger.kernel.org>; Tue, 17 Mar 2009 18:24:18 -0700 (PDT)
In-Reply-To: <1237339391-20543-6-git-send-email-felipe.contreras@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Hari Kanigeri <h-kanigeri2@ti.com>, Hiroshi DOYU <hiroshi.doyu@nokia.com>, Ameya Palande <ameya.palande@nokia.com>, Fernando Guzman Lugo <x0095840@ti.com>, Felipe Contreras <felipe.contreras@nokia.com>

From: Felipe Contreras <felipe.contreras@nokia.com>

Signed-off-by: Felipe Contreras <felipe.contreras@nokia.com>
---
 drivers/dsp/bridge/wmd/tiomap_sm.c |   81 +++++++++++++++---------------------
 1 files changed, 34 insertions(+), 47 deletions(-)

diff --git a/drivers/dsp/bridge/wmd/tiomap_sm.c b/drivers/dsp/bridge/wmd/tiomap_sm.c
index fe4acd8..d70f51e 100644
--- a/drivers/dsp/bridge/wmd/tiomap_sm.c
+++ b/drivers/dsp/bridge/wmd/tiomap_sm.c
@@ -31,7 +31,6 @@ extern struct platform_device omap_dspbridge_dev;
 DSP_STATUS CHNLSM_EnableInterrupt(struct WMD_DEV_CONTEXT *hDevContext)
 {
 	DSP_STATUS status = DSP_SOK;
-	HW_STATUS hwStatus;
 	struct WMD_DEV_CONTEXT *pDevContext = hDevContext;
 	u32 numMbxMsg;
 	u32 mbxValue;
@@ -43,25 +42,25 @@ DSP_STATUS CHNLSM_EnableInterrupt(struct WMD_DEV_CONTEXT *hDevContext)
 
 	/* Read the messages in the mailbox until the message queue is empty */
 
-	status = CFG_GetHostResources((struct CFG_DEVNODE *)DRV_GetFirstDevExtension(),
-				      &resources);
-	status = DEV_GetDevType(pDevContext->hDevObject, &devType);
+	CFG_GetHostResources((struct CFG_DEVNODE *)DRV_GetFirstDevExtension(),
+			     &resources);
+	DEV_GetDevType(pDevContext->hDevObject, &devType);
 	status = DEV_GetIOMgr(pDevContext->hDevObject, &hIOMgr);
 	if (devType == DSP_UNIT) {
-		hwStatus = HW_MBOX_NumMsgGet(resources.dwMboxBase,
-					     MBOX_DSP2ARM, &numMbxMsg);
+		HW_MBOX_NumMsgGet(resources.dwMboxBase,
+				  MBOX_DSP2ARM, &numMbxMsg);
 		while (numMbxMsg != 0) {
-			hwStatus = HW_MBOX_MsgRead(resources.dwMboxBase,
-						   MBOX_DSP2ARM,
-						   &mbxValue);
+			HW_MBOX_MsgRead(resources.dwMboxBase,
+					MBOX_DSP2ARM,
+					&mbxValue);
 			numMbxMsg--;
 		}
 		/* clear the DSP mailbox as well...*/
-		hwStatus = HW_MBOX_NumMsgGet(resources.dwMboxBase,
-					     MBOX_ARM2DSP, &numMbxMsg);
+		HW_MBOX_NumMsgGet(resources.dwMboxBase,
+				  MBOX_ARM2DSP, &numMbxMsg);
 		while (numMbxMsg != 0) {
-			hwStatus = HW_MBOX_MsgRead(resources.dwMboxBase,
-						   MBOX_ARM2DSP, &mbxValue);
+			HW_MBOX_MsgRead(resources.dwMboxBase,
+					MBOX_ARM2DSP, &mbxValue);
 			numMbxMsg--;
 			UTIL_Wait(10);
 
@@ -70,10 +69,10 @@ DSP_STATUS CHNLSM_EnableInterrupt(struct WMD_DEV_CONTEXT *hDevContext)
 					 HW_MBOX_INT_NEW_MSG);
 		}
 		/* Enable the new message events on this IRQ line */
-		hwStatus = HW_MBOX_EventEnable(resources.dwMboxBase,
-					       MBOX_DSP2ARM,
-					       MBOX_ARM,
-					       HW_MBOX_INT_NEW_MSG);
+		HW_MBOX_EventEnable(resources.dwMboxBase,
+				    MBOX_DSP2ARM,
+				    MBOX_ARM,
+				    HW_MBOX_INT_NEW_MSG);
 	}
 
 	return status;
@@ -81,22 +80,19 @@ DSP_STATUS CHNLSM_EnableInterrupt(struct WMD_DEV_CONTEXT *hDevContext)
 
 DSP_STATUS CHNLSM_DisableInterrupt(struct WMD_DEV_CONTEXT *hDevContext)
 {
-	DSP_STATUS status = DSP_SOK;
-	HW_STATUS hwStatus;
 	struct CFG_HOSTRES resources;
 
 	DBG_Trace(DBG_ENTER, "CHNLSM_DisableInterrupt(0x%x)\n", hDevContext);
 
-	status = CFG_GetHostResources((struct CFG_DEVNODE *)DRV_GetFirstDevExtension(),
-				      &resources);
-	hwStatus = HW_MBOX_EventDisable(resources.dwMboxBase, MBOX_DSP2ARM,
-					MBOX_ARM, HW_MBOX_INT_NEW_MSG);
-	return status;
+	CFG_GetHostResources((struct CFG_DEVNODE *)DRV_GetFirstDevExtension(),
+			     &resources);
+	HW_MBOX_EventDisable(resources.dwMboxBase, MBOX_DSP2ARM,
+			     MBOX_ARM, HW_MBOX_INT_NEW_MSG);
+	return DSP_SOK;
 }
 
 DSP_STATUS CHNLSM_InterruptDSP(struct WMD_DEV_CONTEXT *hDevContext)
 {
-	DSP_STATUS status = DSP_SOK;
 	struct WMD_DEV_CONTEXT *pDevContext = hDevContext;
 
 #ifdef CONFIG_BRIDGE_DVFS
@@ -104,15 +100,14 @@ DSP_STATUS CHNLSM_InterruptDSP(struct WMD_DEV_CONTEXT *hDevContext)
 		omap_dspbridge_dev.dev.platform_data;
 	u32 opplevel = 0;
 #endif
-	HW_STATUS hwStatus;
 	u32 mbxFull;
 	struct CFG_HOSTRES resources;
 	u16 cnt = 10;
 	u32 temp;
 	/* We are waiting indefinitely here. This needs to be fixed in the
 	 * second phase */
-	status = CFG_GetHostResources((struct CFG_DEVNODE *)DRV_GetFirstDevExtension(),
-				      &resources);
+	CFG_GetHostResources((struct CFG_DEVNODE *)DRV_GetFirstDevExtension(),
+			     &resources);
 #ifdef CONFIG_BRIDGE_DVFS
 	if (pdata->dsp_get_opp)
 		opplevel = (*pdata->dsp_get_opp)();
@@ -136,7 +131,7 @@ DSP_STATUS CHNLSM_InterruptDSP(struct WMD_DEV_CONTEXT *hDevContext)
 		temp = (u32) *((REG_UWORD32 *) ((u32) (resources.dwDmmuBase) + 0x10));
 
 		/* Restore mailbox settings */
-		status = HW_MBOX_restoreSettings(resources.dwMboxBase);
+		HW_MBOX_restoreSettings(resources.dwMboxBase);
 
 		/* Restart the peripheral clocks that were disabled only
 		 * in DSP initiated Hibernation case.*/
@@ -146,8 +141,8 @@ DSP_STATUS CHNLSM_InterruptDSP(struct WMD_DEV_CONTEXT *hDevContext)
 		pDevContext->dwBrdState = BRD_RUNNING;
 	}
 	while (--cnt) {
-		hwStatus = HW_MBOX_IsFull(resources.dwMboxBase,
-					  MBOX_ARM2DSP, &mbxFull);
+		HW_MBOX_IsFull(resources.dwMboxBase,
+			       MBOX_ARM2DSP, &mbxFull);
 		if (mbxFull)
 			UTIL_Wait(1000);	/* wait for 1 ms)      */
 		else
@@ -155,36 +150,28 @@ DSP_STATUS CHNLSM_InterruptDSP(struct WMD_DEV_CONTEXT *hDevContext)
 	}
 	if (!cnt) {
 		DBG_Trace(DBG_LEVEL7, "Timed out waiting for DSP mailbox \n");
-		status = WMD_E_TIMEOUT;
-		return status;
+		return WMD_E_TIMEOUT;
 	}
 	DBG_Trace(DBG_LEVEL3, "writing %x to Mailbox\n",
 		  pDevContext->wIntrVal2Dsp);
 
-	hwStatus = HW_MBOX_MsgWrite(resources.dwMboxBase, MBOX_ARM2DSP,
-				    pDevContext->wIntrVal2Dsp);
+	HW_MBOX_MsgWrite(resources.dwMboxBase, MBOX_ARM2DSP,
+			 pDevContext->wIntrVal2Dsp);
 	/* set the Mailbox interrupt to default value */
 	pDevContext->wIntrVal2Dsp = MBX_PCPY_CLASS;
-	return status;
+	return DSP_SOK;
 }
 
 DSP_STATUS CHNLSM_InterruptDSP2(struct WMD_DEV_CONTEXT *hDevContext,
 				u16 wMbVal)
 {
-	struct WMD_DEV_CONTEXT *pDevContext = hDevContext;
-
-	pDevContext->wIntrVal2Dsp = wMbVal;
-
+	hDevContext->wIntrVal2Dsp = wMbVal;
 	return CHNLSM_InterruptDSP(hDevContext);
 }
 
-bool CHNLSM_ISR(struct WMD_DEV_CONTEXT *hDevContext, OUT bool *pfSchedDPC,
-		OUT u16 *pwIntrVal)
+bool CHNLSM_ISR(struct WMD_DEV_CONTEXT *hDevContext, bool *pfSchedDPC,
+		u16 *pwIntrVal)
 {
-	bool fMyInterrupt = true;	/*
-					 * We own the mbx and
-					 * we're not sharing it
-					 */
 	struct CFG_HOSTRES resources;
 	u32 numMbxMsg;
 	u32 mbxValue;
@@ -206,5 +193,5 @@ bool CHNLSM_ISR(struct WMD_DEV_CONTEXT *hDevContext, OUT bool *pfSchedDPC,
 	}
 	/* Set *pfSchedDPC to true; */
 	*pfSchedDPC = true;
-	return fMyInterrupt;
+	return true;
 }
-- 
1.6.2.1.287.g9a8be

