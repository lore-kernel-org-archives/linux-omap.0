From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH A 07/15] tidspbridge: hDevContext == pDevContext
Date: Wed, 18 Mar 2009 03:23:03 +0200
Message-ID: <1237339391-20543-8-git-send-email-felipe.contreras@gmail.com>
References: <1237339391-20543-1-git-send-email-felipe.contreras@gmail.com>
 <1237339391-20543-2-git-send-email-felipe.contreras@gmail.com>
 <1237339391-20543-3-git-send-email-felipe.contreras@gmail.com>
 <1237339391-20543-4-git-send-email-felipe.contreras@gmail.com>
 <1237339391-20543-5-git-send-email-felipe.contreras@gmail.com>
 <1237339391-20543-6-git-send-email-felipe.contreras@gmail.com>
 <1237339391-20543-7-git-send-email-felipe.contreras@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f169.google.com ([209.85.218.169]:56149 "EHLO
	mail-bw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756277AbZCRBYV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Mar 2009 21:24:21 -0400
Received: by mail-bw0-f169.google.com with SMTP id 17so321490bwz.37
        for <linux-omap@vger.kernel.org>; Tue, 17 Mar 2009 18:24:19 -0700 (PDT)
In-Reply-To: <1237339391-20543-7-git-send-email-felipe.contreras@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Hari Kanigeri <h-kanigeri2@ti.com>, Hiroshi DOYU <hiroshi.doyu@nokia.com>, Ameya Palande <ameya.palande@nokia.com>, Fernando Guzman Lugo <x0095840@ti.com>, Felipe Contreras <felipe.contreras@nokia.com>

From: Felipe Contreras <felipe.contreras@nokia.com>

Signed-off-by: Felipe Contreras <felipe.contreras@nokia.com>
---
 drivers/dsp/bridge/wmd/tiomap_sm.c |   23 ++++++++++-------------
 1 files changed, 10 insertions(+), 13 deletions(-)

diff --git a/drivers/dsp/bridge/wmd/tiomap_sm.c b/drivers/dsp/bridge/wmd/tiomap_sm.c
index d70f51e..0e18613 100644
--- a/drivers/dsp/bridge/wmd/tiomap_sm.c
+++ b/drivers/dsp/bridge/wmd/tiomap_sm.c
@@ -28,10 +28,9 @@
 extern struct platform_device omap_dspbridge_dev;
 #endif
 
-DSP_STATUS CHNLSM_EnableInterrupt(struct WMD_DEV_CONTEXT *hDevContext)
+DSP_STATUS CHNLSM_EnableInterrupt(struct WMD_DEV_CONTEXT *pDevContext)
 {
 	DSP_STATUS status = DSP_SOK;
-	struct WMD_DEV_CONTEXT *pDevContext = hDevContext;
 	u32 numMbxMsg;
 	u32 mbxValue;
 	struct CFG_HOSTRES resources;
@@ -78,11 +77,11 @@ DSP_STATUS CHNLSM_EnableInterrupt(struct WMD_DEV_CONTEXT *hDevContext)
 	return status;
 }
 
-DSP_STATUS CHNLSM_DisableInterrupt(struct WMD_DEV_CONTEXT *hDevContext)
+DSP_STATUS CHNLSM_DisableInterrupt(struct WMD_DEV_CONTEXT *pDevContext)
 {
 	struct CFG_HOSTRES resources;
 
-	DBG_Trace(DBG_ENTER, "CHNLSM_DisableInterrupt(0x%x)\n", hDevContext);
+	DBG_Trace(DBG_ENTER, "CHNLSM_DisableInterrupt(0x%x)\n", pDevContext);
 
 	CFG_GetHostResources((struct CFG_DEVNODE *)DRV_GetFirstDevExtension(),
 			     &resources);
@@ -91,10 +90,8 @@ DSP_STATUS CHNLSM_DisableInterrupt(struct WMD_DEV_CONTEXT *hDevContext)
 	return DSP_SOK;
 }
 
-DSP_STATUS CHNLSM_InterruptDSP(struct WMD_DEV_CONTEXT *hDevContext)
+DSP_STATUS CHNLSM_InterruptDSP(struct WMD_DEV_CONTEXT *pDevContext)
 {
-	struct WMD_DEV_CONTEXT *pDevContext = hDevContext;
-
 #ifdef CONFIG_BRIDGE_DVFS
 	struct dspbridge_platform_data *pdata =
 		omap_dspbridge_dev.dev.platform_data;
@@ -136,7 +133,7 @@ DSP_STATUS CHNLSM_InterruptDSP(struct WMD_DEV_CONTEXT *hDevContext)
 		/* Restart the peripheral clocks that were disabled only
 		 * in DSP initiated Hibernation case.*/
 		if (pDevContext->dwBrdState == BRD_DSP_HIBERNATION)
-			DSP_PeripheralClocks_Enable(hDevContext, NULL);
+			DSP_PeripheralClocks_Enable(pDevContext, NULL);
 
 		pDevContext->dwBrdState = BRD_RUNNING;
 	}
@@ -162,21 +159,21 @@ DSP_STATUS CHNLSM_InterruptDSP(struct WMD_DEV_CONTEXT *hDevContext)
 	return DSP_SOK;
 }
 
-DSP_STATUS CHNLSM_InterruptDSP2(struct WMD_DEV_CONTEXT *hDevContext,
+DSP_STATUS CHNLSM_InterruptDSP2(struct WMD_DEV_CONTEXT *pDevContext,
 				u16 wMbVal)
 {
-	hDevContext->wIntrVal2Dsp = wMbVal;
-	return CHNLSM_InterruptDSP(hDevContext);
+	pDevContext->wIntrVal2Dsp = wMbVal;
+	return CHNLSM_InterruptDSP(pDevContext);
 }
 
-bool CHNLSM_ISR(struct WMD_DEV_CONTEXT *hDevContext, bool *pfSchedDPC,
+bool CHNLSM_ISR(struct WMD_DEV_CONTEXT *pDevContext, bool *pfSchedDPC,
 		u16 *pwIntrVal)
 {
 	struct CFG_HOSTRES resources;
 	u32 numMbxMsg;
 	u32 mbxValue;
 
-	DBG_Trace(DBG_ENTER, "CHNLSM_ISR(0x%x)\n", hDevContext);
+	DBG_Trace(DBG_ENTER, "CHNLSM_ISR(0x%x)\n", pDevContext);
 
 	CFG_GetHostResources((struct CFG_DEVNODE *)DRV_GetFirstDevExtension(), &resources);
 
-- 
1.6.2.1.287.g9a8be

