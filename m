From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH A 12/15] tidspbridge: remove IO_InterruptDSP2
Date: Wed, 18 Mar 2009 03:23:08 +0200
Message-ID: <1237339391-20543-13-git-send-email-felipe.contreras@gmail.com>
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
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f158.google.com ([209.85.220.158]:63018 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756301AbZCRBYb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Mar 2009 21:24:31 -0400
Received: by mail-fx0-f158.google.com with SMTP id 2so304246fxm.37
        for <linux-omap@vger.kernel.org>; Tue, 17 Mar 2009 18:24:28 -0700 (PDT)
In-Reply-To: <1237339391-20543-12-git-send-email-felipe.contreras@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Hari Kanigeri <h-kanigeri2@ti.com>, Hiroshi DOYU <hiroshi.doyu@nokia.com>, Ameya Palande <ameya.palande@nokia.com>, Fernando Guzman Lugo <x0095840@ti.com>, Felipe Contreras <felipe.contreras@nokia.com>

From: Felipe Contreras <felipe.contreras@nokia.com>

It's just wrapping CHNLSM_InterruptDSP2.

Signed-off-by: Felipe Contreras <felipe.contreras@nokia.com>
---
 arch/arm/plat-omap/include/dspbridge/io_sm.h |    1 -
 drivers/dsp/bridge/wmd/io_sm.c               |   12 ++++++------
 drivers/dsp/bridge/wmd/tiomap3430.c          |    6 +++---
 drivers/dsp/bridge/wmd/tiomap3430_pwr.c      |   18 +++++++++---------
 4 files changed, 18 insertions(+), 19 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/io_sm.h b/arch/arm/plat-omap/include/dspbridge/io_sm.h
index 02010d0..3dcbf74 100644
--- a/arch/arm/plat-omap/include/dspbridge/io_sm.h
+++ b/arch/arm/plat-omap/include/dspbridge/io_sm.h
@@ -77,7 +77,6 @@
 
 #define IO_DisableInterrupt(h)  CHNLSM_DisableInterrupt(h)
 #define IO_EnableInterrupt(h)   CHNLSM_EnableInterrupt(h)
-#define IO_InterruptDSP2(h, v)  CHNLSM_InterruptDSP2(h, v)
 #define IO_CALLISR(h, pFlag, pwMBRegVal)   CHNLSM_ISR(h, pFlag, pwMBRegVal)
 
 /*
diff --git a/drivers/dsp/bridge/wmd/io_sm.c b/drivers/dsp/bridge/wmd/io_sm.c
index e4d8528..40062cb 100644
--- a/drivers/dsp/bridge/wmd/io_sm.c
+++ b/drivers/dsp/bridge/wmd/io_sm.c
@@ -831,7 +831,7 @@ void IO_CancelChnl(struct IO_MGR *hIOMgr, u32 ulChnl)
 	IO_AndValue(pIOMgr->hWmdContext, struct SHM, sm, hostFreeMask,
 		   (~(1 << ulChnl)));
 
-	IO_InterruptDSP2(pIOMgr->hWmdContext, MBX_PCPY_CLASS);
+	CHNLSM_InterruptDSP2(pIOMgr->hWmdContext, MBX_PCPY_CLASS);
 }
 
 /*
@@ -1201,7 +1201,7 @@ static void InputChnl(struct IO_MGR *pIOMgr, struct CHNL_OBJECT *pChnl,
 	if (fClearChnl) {
 		/* Indicate to the DSP we have read the input: */
 		IO_SetValue(pIOMgr->hWmdContext, struct SHM, sm, inputFull, 0);
-		IO_InterruptDSP2(pIOMgr->hWmdContext, MBX_PCPY_CLASS);
+		CHNLSM_InterruptDSP2(pIOMgr->hWmdContext, MBX_PCPY_CLASS);
 	}
 	if (fNotifyClient) {
 		/* Notify client with IO completion record:  */
@@ -1303,7 +1303,7 @@ static void InputMsg(struct IO_MGR *pIOMgr, struct MSG_MGR *hMsgMgr)
 			   true);
 		IO_SetValue(pIOMgr->hWmdContext, struct MSG, pCtrl, postSWI,
 			   true);
-		IO_InterruptDSP2(pIOMgr->hWmdContext, MBX_PCPY_CLASS);
+		CHNLSM_InterruptDSP2(pIOMgr->hWmdContext, MBX_PCPY_CLASS);
 	}
 }
 
@@ -1406,7 +1406,7 @@ static void OutputChnl(struct IO_MGR *pIOMgr, struct CHNL_OBJECT *pChnl,
 #endif
 	IO_SetValue(pIOMgr->hWmdContext, struct SHM, sm, outputFull, 1);
 	/* Indicate to the DSP we have written the output: */
-	IO_InterruptDSP2(pIOMgr->hWmdContext, MBX_PCPY_CLASS);
+	CHNLSM_InterruptDSP2(pIOMgr->hWmdContext, MBX_PCPY_CLASS);
 	/* Notify client with IO completion record (keep EOS) */
 	pChirp->status &= CHNL_IOCSTATEOS;
 	NotifyChnlComplete(pChnl, pChirp);
@@ -1493,7 +1493,7 @@ static void OutputMsg(struct IO_MGR *pIOMgr, struct MSG_MGR *hMsgMgr)
 			IO_SetValue(pIOMgr->hWmdContext, struct MSG, pCtrl,
 				   postSWI, true);
 			/* Tell the DSP we have written the output. */
-			IO_InterruptDSP2(pIOMgr->hWmdContext, MBX_PCPY_CLASS);
+			CHNLSM_InterruptDSP2(pIOMgr->hWmdContext, MBX_PCPY_CLASS);
 		}
 	}
 }
@@ -1624,7 +1624,7 @@ static u32 WriteData(struct WMD_DEV_CONTEXT *hDevContext, void *pDest,
 /* ZCPY IO routines. */
 void IO_IntrDSP2(IN struct IO_MGR *pIOMgr, IN u16 wMbVal)
 {
-	IO_InterruptDSP2(pIOMgr->hWmdContext, wMbVal);
+	CHNLSM_InterruptDSP2(pIOMgr->hWmdContext, wMbVal);
 }
 
 /*
diff --git a/drivers/dsp/bridge/wmd/tiomap3430.c b/drivers/dsp/bridge/wmd/tiomap3430.c
index 2ce7295..e2b590f 100644
--- a/drivers/dsp/bridge/wmd/tiomap3430.c
+++ b/drivers/dsp/bridge/wmd/tiomap3430.c
@@ -735,7 +735,7 @@ static DSP_STATUS WMD_BRD_Stop(struct WMD_DEV_CONTEXT *hDevContext)
 	HW_PWRST_IVA2RegGet(resources.dwPrmBase, &dspPwrState);
 	if (dspPwrState != HW_PWR_STATE_OFF) {
 
-			IO_InterruptDSP2(pDevContext, MBX_PM_DSPIDLE);
+			CHNLSM_InterruptDSP2(pDevContext, MBX_PM_DSPIDLE);
 
 			mdelay(10);
 
@@ -1573,7 +1573,7 @@ static DSP_STATUS WMD_BRD_MemUnMap(struct WMD_DEV_CONTEXT *hDevContext,
 	 /* It is better to flush the TLB here, so that any stale old entries
 	 * get flushed */
 EXIT_LOOP:
-	IO_InterruptDSP2(pDevContext, MBX_PM_DSPWAKEUP);
+	CHNLSM_InterruptDSP2(pDevContext, MBX_PM_DSPWAKEUP);
 	HW_MMU_TLBFlushAll(pDevContext->dwDSPMmuBase);
 	DBG_Trace(DBG_LEVEL1, "WMD_BRD_MemUnMap vaCurr %x, pteAddrL1 %x "
 		  "pteAddrL2 %x\n", vaCurr, pteAddrL1, pteAddrL2);
@@ -2058,7 +2058,7 @@ func_cont:
 	 * repetition while mapping non-contiguous physical regions of a virtual
 	 * region */
 	/* Waking up DSP before calling TLB Flush */
-	IO_InterruptDSP2(pDevContext, MBX_PM_DSPWAKEUP);
+	CHNLSM_InterruptDSP2(pDevContext, MBX_PM_DSPWAKEUP);
 	HW_MMU_TLBFlushAll(pDevContext->dwDSPMmuBase);
 	DBG_Trace(DBG_LEVEL7, "< WMD_BRD_MemMap  at end status %x\n", status);
 	return status;
diff --git a/drivers/dsp/bridge/wmd/tiomap3430_pwr.c b/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
index 95a89b3..5fac79e 100644
--- a/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
+++ b/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
@@ -201,23 +201,23 @@ DSP_STATUS SleepDSP(struct WMD_DEV_CONTEXT *pDevContext, IN u32 dwCmd,
 	case BRD_RUNNING:
 		status = HW_MBOX_saveSettings(resources.dwMboxBase);
 		if (dsp_test_sleepstate == HW_PWR_STATE_OFF) {
-			IO_InterruptDSP2(pDevContext,
-					 MBX_PM_DSPHIBERNATE);
+			CHNLSM_InterruptDSP2(pDevContext,
+					     MBX_PM_DSPHIBERNATE);
 			DBG_Trace(DBG_LEVEL7,
 				 "SleepDSP - Sent hibernate "
 				 "command to DSP\n");
 			targetPwrState = HW_PWR_STATE_OFF;
 		} else {
-			IO_InterruptDSP2(pDevContext,
-					 MBX_PM_DSPRETENTION);
+			CHNLSM_InterruptDSP2(pDevContext,
+					     MBX_PM_DSPRETENTION);
 			targetPwrState = HW_PWR_STATE_RET;
 		}
 		break;
 	case BRD_RETENTION:
 		status = HW_MBOX_saveSettings(resources.dwMboxBase);
 		if (dsp_test_sleepstate == HW_PWR_STATE_OFF) {
-			IO_InterruptDSP2(pDevContext,
-					 MBX_PM_DSPHIBERNATE);
+			CHNLSM_InterruptDSP2(pDevContext,
+					     MBX_PM_DSPHIBERNATE);
 			targetPwrState = HW_PWR_STATE_OFF;
 		} else
 			return DSP_SOK;
@@ -301,7 +301,7 @@ DSP_STATUS WakeDSP(struct WMD_DEV_CONTEXT *pDevContext, IN void *pArgs)
 	udelay(10);
 	if (DSP_SUCCEEDED(status)) {
 		/* Send a message to DSP to wake up */
-		IO_InterruptDSP2(pDevContext, MBX_PM_DSPWAKEUP);
+		CHNLSM_InterruptDSP2(pDevContext, MBX_PM_DSPWAKEUP);
 		HW_PWR_IVA2StateGet(resources.dwPrmBase, HW_PWR_DOMAIN_DSP,
 				    &pwrState);
 		DBG_Trace(DBG_LEVEL7,
@@ -425,7 +425,7 @@ DSP_STATUS PreScale_DSP(struct WMD_DEV_CONTEXT *pDevContext, IN void *pArgs)
 		/* Send a prenotificatio to DSP */
 		DBG_Trace(DBG_LEVEL7,
 			 "PreScale_DSP: Sent notification to DSP\n");
-		IO_InterruptDSP2(pDevContext, MBX_PM_SETPOINT_PRENOTIFY);
+		CHNLSM_InterruptDSP2(pDevContext, MBX_PM_SETPOINT_PRENOTIFY);
 		return DSP_SOK;
 	} else {
 		DBG_Trace(DBG_LEVEL7, "PreScale_DSP: Failed - DSP BRD"
@@ -469,7 +469,7 @@ DSP_STATUS PostScale_DSP(struct WMD_DEV_CONTEXT *pDevContext, IN void *pArgs)
 		/* Update the OPP value in shared memory */
 		IO_SHMsetting(hIOMgr, SHM_CURROPP, &level);
 		/* Send a post notification to DSP */
-		IO_InterruptDSP2(pDevContext, MBX_PM_SETPOINT_POSTNOTIFY);
+		CHNLSM_InterruptDSP2(pDevContext, MBX_PM_SETPOINT_POSTNOTIFY);
 		DBG_Trace(DBG_LEVEL7,
 			 "PostScale_DSP: Wrote to shared memory Sent post"
 			 " notification to DSP\n");
-- 
1.6.2.1.287.g9a8be

