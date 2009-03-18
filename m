From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH A 04/15] tidspbridge: remove IO_CALLDPC
Date: Wed, 18 Mar 2009 03:23:00 +0200
Message-ID: <1237339391-20543-5-git-send-email-felipe.contreras@gmail.com>
References: <1237339391-20543-1-git-send-email-felipe.contreras@gmail.com>
 <1237339391-20543-2-git-send-email-felipe.contreras@gmail.com>
 <1237339391-20543-3-git-send-email-felipe.contreras@gmail.com>
 <1237339391-20543-4-git-send-email-felipe.contreras@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f158.google.com ([209.85.220.158]:63018 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753575AbZCRBYO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Mar 2009 21:24:14 -0400
Received: by fxm2 with SMTP id 2so304246fxm.37
        for <linux-omap@vger.kernel.org>; Tue, 17 Mar 2009 18:24:11 -0700 (PDT)
In-Reply-To: <1237339391-20543-4-git-send-email-felipe.contreras@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Hari Kanigeri <h-kanigeri2@ti.com>, Hiroshi DOYU <hiroshi.doyu@nokia.com>, Ameya Palande <ameya.palande@nokia.com>, Fernando Guzman Lugo <x0095840@ti.com>, Felipe Contreras <felipe.contreras@nokia.com>

From: Felipe Contreras <felipe.contreras@nokia.com>

Doesn't do anything

Signed-off-by: Felipe Contreras <felipe.contreras@nokia.com>
---
 arch/arm/plat-omap/include/dspbridge/chnl_sm.h |   17 -----------------
 arch/arm/plat-omap/include/dspbridge/io_sm.h   |    1 -
 drivers/dsp/bridge/wmd/io_sm.c                 |    2 --
 drivers/dsp/bridge/wmd/tiomap_sm.c             |    5 -----
 4 files changed, 0 insertions(+), 25 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/chnl_sm.h b/arch/arm/plat-omap/include/dspbridge/chnl_sm.h
index 8a9553b..546754b 100644
--- a/arch/arm/plat-omap/include/dspbridge/chnl_sm.h
+++ b/arch/arm/plat-omap/include/dspbridge/chnl_sm.h
@@ -23,7 +23,6 @@
  *
  *  Public Functions:
  *      CHNLSM_DisableInterrupt;
- *      CHNLSM_DPC;
  *      CHNLSM_EnableInterrupt;
  *      CHNLSM_InterruptDSP;
  *      CHNLSM_ISR;
@@ -57,22 +56,6 @@
 							hDevContext);
 
 /*
- *  ======== CHNLSM_DPC ========
- *  Purpose:
- *      This mini-driver's deferred processing routine.  Finishes processing
- *      deferred by the WMD's ISR.
- *  Parameters:
- *      hDevContext:    Handle to mini-driver defined device info.
- *  Returns:
- *  Requires:
- *      Must not block.
- *      Must not acquire resources.
- *      All data objects touched must be locked in memory.
- *  Ensures:
- */
-       extern void CHNLSM_DPC(struct WMD_DEV_CONTEXT *hDevContext);
-
-/*
  *  ======== CHNLSM_EnableInterrupt ========
  *  Purpose:
  *      Enable interrupts from the DSP board to the PC.
diff --git a/arch/arm/plat-omap/include/dspbridge/io_sm.h b/arch/arm/plat-omap/include/dspbridge/io_sm.h
index 69b321c..81f7d93 100644
--- a/arch/arm/plat-omap/include/dspbridge/io_sm.h
+++ b/arch/arm/plat-omap/include/dspbridge/io_sm.h
@@ -79,7 +79,6 @@
 #define IO_EnableInterrupt(h)   CHNLSM_EnableInterrupt(h)
 #define IO_InterruptDSP(h)      CHNLSM_InterruptDSP(h)
 #define IO_InterruptDSP2(h, v)  CHNLSM_InterruptDSP2(h, v)
-#define IO_CALLDPC(h)           CHNLSM_DPC(h)
 #define IO_CALLISR(h, pFlag, pwMBRegVal)   CHNLSM_ISR(h, pFlag, pwMBRegVal)
 
 /*
diff --git a/drivers/dsp/bridge/wmd/io_sm.c b/drivers/dsp/bridge/wmd/io_sm.c
index 7fc4304..9050862 100644
--- a/drivers/dsp/bridge/wmd/io_sm.c
+++ b/drivers/dsp/bridge/wmd/io_sm.c
@@ -955,8 +955,6 @@ void IO_DPC(IN OUT void *pRefData)
 			WMD_DEH_Notify(hDehMgr, DSP_SYSERROR, pIOMgr->wIntrVal);
 
 	}
-	/* Call WMD's DPC: */
-	IO_CALLDPC(pIOMgr->hWmdContext);
 	IO_DispatchChnl(pIOMgr, NULL, IO_SERVICE);
 #ifdef CHNL_MESSAGES
 	if (pMsgMgr) {
diff --git a/drivers/dsp/bridge/wmd/tiomap_sm.c b/drivers/dsp/bridge/wmd/tiomap_sm.c
index 58234d2..5249ea5 100644
--- a/drivers/dsp/bridge/wmd/tiomap_sm.c
+++ b/drivers/dsp/bridge/wmd/tiomap_sm.c
@@ -182,11 +182,6 @@ DSP_STATUS CHNLSM_InterruptDSP2(struct WMD_DEV_CONTEXT *hDevContext,
 	return CHNLSM_InterruptDSP(hDevContext);
 }
 
-void CHNLSM_DPC(struct WMD_DEV_CONTEXT *hDevContext)
-{
-	DBG_Trace(DBG_ENTER, "CHNLSM_DPC(0x%x)\n", hDevContext);
-}
-
 bool CHNLSM_ISR(struct WMD_DEV_CONTEXT *hDevContext, OUT bool *pfSchedDPC,
 		OUT u16 *pwIntrVal)
 {
-- 
1.6.2.1.287.g9a8be

