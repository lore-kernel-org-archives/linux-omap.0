From: "Gupta, Ramesh" <grgupta@ti.com>
Subject: [PATCH 2/3] DSPBRIDGE DVFS and OFF mode support with OPP2
Date: Thu, 12 Feb 2009 14:47:27 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02A40C100F@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:33559 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758219AbZBLJSE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Feb 2009 04:18:04 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id n1C9HvxC003223
	for <linux-omap@vger.kernel.org>; Thu, 12 Feb 2009 03:18:03 -0600
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id n1C9Hu9S001803
	for <linux-omap@vger.kernel.org>; Thu, 12 Feb 2009 14:47:57 +0530 (IST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

>From 6a3c7c79eb2a67b9079b9094c0fb0af4d76c06ef Mon Sep 17 00:00:00 2001
From: Ramesh Gupta G <grgupta@ti.com>
Date: Thu, 12 Feb 2009 05:45:10 +0530
Subject: [PATCH 2/3] DSPBRIDGE DVFS and OFF mode support with OPP2

There are some issues with the OPP1 for DSP
This patch keeps VDD1 in OPP2 through out DSP is alive

Signed-off-by: Ramesh Gupta G <grgupta@ti.com>
---
 drivers/dsp/bridge/rmgr/proc.c          |    8 ++++++++
 drivers/dsp/bridge/wmd/tiomap3430_pwr.c |   10 +++++++---
 drivers/dsp/bridge/wmd/tiomap_sm.c      |    4 +---
 3 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/dsp/bridge/rmgr/proc.c b/drivers/dsp/bridge/rmgr/proc.c
index 93d3ec4..89893ed 100644
--- a/drivers/dsp/bridge/rmgr/proc.c
+++ b/drivers/dsp/bridge/rmgr/proc.c
@@ -1548,6 +1548,11 @@ DSP_STATUS PROC_Start(DSP_HPROCESSOR hProcessor)
 #ifdef DEBUG
 	BRD_STATUS uBrdState;
 #endif
+
+#if defined(CONFIG_BRIDGE_DVFS)
+	struct dspbridge_platform_data *pdata =
+				omap_dspbridge_dev.dev.platform_data;
+#endif
 	DBC_Require(cRefs > 0);
 	GT_1trace(PROC_DebugMask, GT_ENTER, "Entered PROC_Start, args:\n\t"
 		 "hProcessor:  0x%x\n", hProcessor);
@@ -1557,6 +1562,9 @@ DSP_STATUS PROC_Start(DSP_HPROCESSOR hProcessor)
 			 "PROC_Start :InValid Handle \n");
 		goto func_end;
 	}
+	if(pdata->dsp_set_min_opp)
+		(*pdata->dsp_set_min_opp)(VDD1_OPP2);
+
 	/* Call the WMD_BRD_Start */
 	if (pProcObject->sState != PROC_LOADED) {
 		GT_0trace(PROC_DebugMask, GT_7CLASS,
diff --git a/drivers/dsp/bridge/wmd/tiomap3430_pwr.c b/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
index 287c2fd..6bbd311 100644
--- a/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
+++ b/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
@@ -96,8 +96,12 @@ DSP_STATUS handle_constraints_set(struct WMD_DEV_CONTEXT *pDevContext,
 	status = HW_MBOX_saveSettings(resources.dwMboxBase);
 
 	/* Set the new opp value */
-	if (pdata->dsp_set_min_opp)
+	if (pdata->dsp_set_min_opp){
+		if ((u32)*(pConstraintVal+1) == 1)
+			(*pdata->dsp_set_min_opp)((u32)*(pConstraintVal+1)+1);
+		else
 			(*pdata->dsp_set_min_opp)((u32)*(pConstraintVal+1));
+	}
 	return DSP_SOK;
 #endif /* #ifdef CONFIG_BRIDGE_DVFS */
 	return DSP_SOK;
@@ -166,9 +170,9 @@ DSP_STATUS handle_hibernation_fromDSP(struct WMD_DEV_CONTEXT *pDevContext)
 					"Tiomap_pwr.c - DSP requested"
 					" OPP = %d, MPU requesting low"
 					" OPP %d instead\n", opplevel,
-					VDD1_OPP1);
+					VDD1_OPP2);
 				if (pdata->dsp_set_min_opp)
-					(*pdata->dsp_set_min_opp)(VDD1_OPP1);
+					(*pdata->dsp_set_min_opp)(VDD1_OPP2);
 				status = DSP_SOK;
 			}
 #endif /* CONFIG_BRIDGE_DVFS */
diff --git a/drivers/dsp/bridge/wmd/tiomap_sm.c b/drivers/dsp/bridge/wmd/tiomap_sm.c
index fc65be9..a365ca8 100644
--- a/drivers/dsp/bridge/wmd/tiomap_sm.c
+++ b/drivers/dsp/bridge/wmd/tiomap_sm.c
@@ -183,15 +183,13 @@ DSP_STATUS CHNLSM_InterruptDSP(struct WMD_DEV_CONTEXT *hDevContext)
 	if (DSP_FAILED(status))
 		return DSP_EFAIL;
 #ifdef CONFIG_BRIDGE_DVFS
-	if (pDevContext->dwBrdState == BRD_DSP_HIBERNATION ||
-	    pDevContext->dwBrdState == BRD_HIBERNATION) {
+	/*FIX ME: By default setting to OPP2 need to fix this */
 		if (pdata->dsp_get_opp)
 			opplevel = (*pdata->dsp_get_opp)();
 		if (opplevel == 1) {
 			if (pdata->dsp_set_min_opp)
 				(*pdata->dsp_set_min_opp)(opplevel+1);
 		}
-	}
 #endif
 
 	if (pDevContext->dwBrdState == BRD_DSP_HIBERNATION ||
-- 
1.5.3.2
