From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH A 13/15] tidspbridge: remove CHNLSM_InterruptDSP
Date: Wed, 18 Mar 2009 03:23:09 +0200
Message-ID: <1237339391-20543-14-git-send-email-felipe.contreras@gmail.com>
References: <1237339391-20543-1-git-send-email-felipe.contreras@gmail.com>
 <1237339391-20543-2-git-send-email-felipe.contreras@gmail.com>
 <1237339391-20543-3-git-send-email-felipe.contreras@gmail.com>
 <1237339391-20543-4-git-send-email-felipe.contreras@gmail.com>
 <1237339391-20543-5-git-send-email-felipe.contreras@gmail.com>
 <1237339391-20543-6-git-send-email-felipe.contreras@gmail.com>
 <1237339391-20543-7-git-send-email-felipe.contreras@gmail.com>
 <1237339391-20543-8-git-send-email-felipe.contreras@gmail.com>
 <1237339391-20543-9-git-send-email-felipe.contreras@gmail.com>
 <1237339391-20543-10-git-send-email-felipe.contreras@gmail.com>
 <1237339391-20543-11-git-send-email-felipe.contreras@gmail.com>
 <1237339391-20543-12-git-send-email-felipe.contreras@gmail.com>
 <1237339391-20543-13-git-send-email-felipe.contreras@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f169.google.com ([209.85.218.169]:49404 "EHLO
	mail-bw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756571AbZCRBYc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Mar 2009 21:24:32 -0400
Received: by mail-bw0-f169.google.com with SMTP id 17so321651bwz.37
        for <linux-omap@vger.kernel.org>; Tue, 17 Mar 2009 18:24:30 -0700 (PDT)
In-Reply-To: <1237339391-20543-13-git-send-email-felipe.contreras@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Hari Kanigeri <h-kanigeri2@ti.com>, Hiroshi DOYU <hiroshi.doyu@nokia.com>, Ameya Palande <ameya.palande@nokia.com>, Fernando Guzman Lugo <x0095840@ti.com>, Felipe Contreras <felipe.contreras@nokia.com>

From: Felipe Contreras <felipe.contreras@nokia.com>

Not used anymore, move to CHNLSM_InterruptDSP2.

Signed-off-by: Felipe Contreras <felipe.contreras@nokia.com>
---
 arch/arm/plat-omap/include/dspbridge/chnl_sm.h |   16 ----------------
 drivers/dsp/bridge/wmd/tiomap_sm.c             |   10 ++--------
 2 files changed, 2 insertions(+), 24 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/chnl_sm.h b/arch/arm/plat-omap/include/dspbridge/chnl_sm.h
index 546754b..789b9bd 100644
--- a/arch/arm/plat-omap/include/dspbridge/chnl_sm.h
+++ b/arch/arm/plat-omap/include/dspbridge/chnl_sm.h
@@ -24,7 +24,6 @@
  *  Public Functions:
  *      CHNLSM_DisableInterrupt;
  *      CHNLSM_EnableInterrupt;
- *      CHNLSM_InterruptDSP;
  *      CHNLSM_ISR;
  *      CHNLSM_Read;
  *      CHNLSM_UpdateSHMLength;
@@ -69,21 +68,6 @@
 						       hDevContext);
 
 /*
- *  ======== CHNLSM_InterruptDSP ========
- *  Purpose:
- *      Send an interrupt to the DSP processor(s).
- *  Parameters:
- *      hDevContext:    Handle to mini-driver defined device info.
- *  Returns:
- *      DSP_SOK:        Interrupt sent;
- *      else:           Unable to send interrupt.
- *  Requires:
- *  Ensures:
- */
-       extern DSP_STATUS CHNLSM_InterruptDSP(struct WMD_DEV_CONTEXT*
-						    hDevContext);
-
-/*
  *  ======== CHNLSM_InterruptDSP2 ========
  *  Purpose:
  *      Set interrupt value & send an interrupt to the DSP processor(s).
diff --git a/drivers/dsp/bridge/wmd/tiomap_sm.c b/drivers/dsp/bridge/wmd/tiomap_sm.c
index 735f8e9..5ae94ea 100644
--- a/drivers/dsp/bridge/wmd/tiomap_sm.c
+++ b/drivers/dsp/bridge/wmd/tiomap_sm.c
@@ -97,7 +97,8 @@ DSP_STATUS CHNLSM_DisableInterrupt(struct WMD_DEV_CONTEXT *pDevContext)
 	return DSP_SOK;
 }
 
-DSP_STATUS CHNLSM_InterruptDSP(struct WMD_DEV_CONTEXT *pDevContext)
+DSP_STATUS CHNLSM_InterruptDSP2(struct WMD_DEV_CONTEXT *pDevContext,
+				u16 wMbVal)
 {
 #ifdef CONFIG_BRIDGE_DVFS
 	struct dspbridge_platform_data *pdata =
@@ -160,13 +161,6 @@ DSP_STATUS CHNLSM_InterruptDSP(struct WMD_DEV_CONTEXT *pDevContext)
 	return DSP_SOK;
 }
 
-DSP_STATUS CHNLSM_InterruptDSP2(struct WMD_DEV_CONTEXT *pDevContext,
-				u16 wMbVal)
-{
-	pDevContext->wIntrVal2Dsp = wMbVal;
-	return CHNLSM_InterruptDSP(pDevContext);
-}
-
 bool CHNLSM_ISR(struct WMD_DEV_CONTEXT *pDevContext, bool *pfSchedDPC,
 		u16 *pwIntrVal)
 {
-- 
1.6.2.1.287.g9a8be

