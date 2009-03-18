From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH A 08/15] tidspbridge: remove UTIL_Wait wrapper
Date: Wed, 18 Mar 2009 03:23:04 +0200
Message-ID: <1237339391-20543-9-git-send-email-felipe.contreras@gmail.com>
References: <1237339391-20543-1-git-send-email-felipe.contreras@gmail.com>
 <1237339391-20543-2-git-send-email-felipe.contreras@gmail.com>
 <1237339391-20543-3-git-send-email-felipe.contreras@gmail.com>
 <1237339391-20543-4-git-send-email-felipe.contreras@gmail.com>
 <1237339391-20543-5-git-send-email-felipe.contreras@gmail.com>
 <1237339391-20543-6-git-send-email-felipe.contreras@gmail.com>
 <1237339391-20543-7-git-send-email-felipe.contreras@gmail.com>
 <1237339391-20543-8-git-send-email-felipe.contreras@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f169.google.com ([209.85.218.169]:56149 "EHLO
	mail-bw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756265AbZCRBYX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Mar 2009 21:24:23 -0400
Received: by mail-bw0-f169.google.com with SMTP id 17so321490bwz.37
        for <linux-omap@vger.kernel.org>; Tue, 17 Mar 2009 18:24:21 -0700 (PDT)
In-Reply-To: <1237339391-20543-8-git-send-email-felipe.contreras@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Hari Kanigeri <h-kanigeri2@ti.com>, Hiroshi DOYU <hiroshi.doyu@nokia.com>, Ameya Palande <ameya.palande@nokia.com>, Fernando Guzman Lugo <x0095840@ti.com>, Felipe Contreras <felipe.contreras@gmail.com>

Wrappers only hurt readability, use native kernel functions instead
(udelay, mdelay).

Also remove useless defines.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 arch/arm/plat-omap/include/dspbridge/util.h |   33 ---------------------------
 drivers/dsp/bridge/wmd/_tiomap_pwr.h        |    4 ---
 drivers/dsp/bridge/wmd/_tiomap_util.h       |    1 -
 drivers/dsp/bridge/wmd/tiomap3430.c         |   10 ++++----
 drivers/dsp/bridge/wmd/tiomap3430_pwr.c     |    4 +-
 drivers/dsp/bridge/wmd/tiomap_sm.c          |    4 +-
 6 files changed, 9 insertions(+), 47 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/util.h b/arch/arm/plat-omap/include/dspbridge/util.h
index 9d8842a..e6815ca 100644
--- a/arch/arm/plat-omap/include/dspbridge/util.h
+++ b/arch/arm/plat-omap/include/dspbridge/util.h
@@ -26,7 +26,6 @@
  *      UTIL_Exit
  *      UTIL_GetSysInfo
  *      UTIL_Init
- *      UTIL_Wait
  */
 
 #ifndef _UTIL_H
@@ -120,36 +119,4 @@
 		return true;
 	}
 
-/*
- *  ======== UTIL_Wait ========
- *  Purpose:
- *      This fucntion busy waits given a certain number of micro seconds
- *      independent of the processor speed. This is acheived by the
- *      OEM functions QueryPerformanceCounter and QueryPerformanceFrequency.
- *  Parameters:
- *      u32   Number of Micro seconds to busy wait
- *  Returns:
- *          Nothing
- *  Requires:
- *          UTIL_Initalized.
- *  Ensures:
- *      Busy waits x Micro seconds or Sleeps X milli seconds; in that
- *      case, it is a blocking call there will be a context switching
- *      hence it may not represent the absolute busy wait time.
- */
-	static inline void UTIL_Wait(IN u32 dwMicroSeconds)
-	{
-		if (dwMicroSeconds / 1000 <= 1) {
-			/* <= 1 millisecond delay */
-			udelay(dwMicroSeconds);
-		} else if (dwMicroSeconds * HZ / 1000000 <= 1) {
-			/* <= 10 millisecond delay */
-			mdelay(dwMicroSeconds / 1000);
-		} else {
-			/* > 10 millisecond delay */
-			set_current_state(TASK_INTERRUPTIBLE);
-			schedule_timeout(dwMicroSeconds * HZ / 1000000);
-		}
-	}
-
 #endif				/* _UTIL_H */
diff --git a/drivers/dsp/bridge/wmd/_tiomap_pwr.h b/drivers/dsp/bridge/wmd/_tiomap_pwr.h
index 15ff2d3..8a7cf1b 100644
--- a/drivers/dsp/bridge/wmd/_tiomap_pwr.h
+++ b/drivers/dsp/bridge/wmd/_tiomap_pwr.h
@@ -28,10 +28,6 @@
 #ifndef _TIOMAP_PWR_
 #define _TIOMAP_PWR_
 
-/* Wait time between MBX and IDLE checks for PWR */
-#define PWR_WAIT_USECS          500
-#define PWR_WAIT_MSECS          50
-
 /*
  * ======== WakeDSP =========
  * Wakes up the DSP from DeepSleep
diff --git a/drivers/dsp/bridge/wmd/_tiomap_util.h b/drivers/dsp/bridge/wmd/_tiomap_util.h
index b655409..47e1e5d 100644
--- a/drivers/dsp/bridge/wmd/_tiomap_util.h
+++ b/drivers/dsp/bridge/wmd/_tiomap_util.h
@@ -30,7 +30,6 @@
 
 /* Time out Values in uSeconds*/
 #define TIHELEN_ACKTIMEOUT  10000
-#define TIHELEN_WRITE_DELAY 10
 
 /*  Time delay for HOM->SAM transition. */
 #define  WAIT_SAM   1000000	/* in usec (1000 millisec) */
diff --git a/drivers/dsp/bridge/wmd/tiomap3430.c b/drivers/dsp/bridge/wmd/tiomap3430.c
index a6e695a..2ce7295 100644
--- a/drivers/dsp/bridge/wmd/tiomap3430.c
+++ b/drivers/dsp/bridge/wmd/tiomap3430.c
@@ -460,9 +460,9 @@ static DSP_STATUS WMD_BRD_Start(struct WMD_DEV_CONTEXT *hDevContext,
 		/* Reset and Unreset the RST2, so that BOOTADDR is copied to
 		 * IVA2 SYSC register */
 		HW_RST_Reset(resources.dwPrmBase, HW_RST2_IVA2);
-		UTIL_Wait(100);
+		udelay(100);
 		HW_RST_UnReset(resources.dwPrmBase, HW_RST2_IVA2);
-		UTIL_Wait(100);
+		udelay(100);
 		DBG_Trace(DBG_LEVEL6, "WMD_BRD_Start 0 ****** \n");
 		GetHWRegs(resources.dwPrmBase, resources.dwCmBase);
 		/* Disbale the DSP MMU */
@@ -737,7 +737,7 @@ static DSP_STATUS WMD_BRD_Stop(struct WMD_DEV_CONTEXT *hDevContext)
 
 			IO_InterruptDSP2(pDevContext, MBX_PM_DSPIDLE);
 
-			UTIL_Wait(10000);	/* 10 msec */
+			mdelay(10);
 
 			GetHWRegs(resources.dwPrmBase, resources.dwCmBase);
 
@@ -1053,7 +1053,7 @@ static DSP_STATUS WMD_DEV_Create(OUT struct WMD_DEV_CONTEXT **ppDevContext,
 				 "WMD_DEV_create:Reset mail box and "
 				 "enable the clock Fail\n");
 		}
-		UTIL_Wait(5);
+		udelay(5);
 		/* 24xx-Linux MMU address is obtained from the host
 		 * resources struct */
 		pDevContext->dwDSPMmuBase = resources.dwDmmuBase;
@@ -2174,7 +2174,7 @@ bool WaitForStart(struct WMD_DEV_CONTEXT *pDevContext, u32 dwSyncAddr)
 
 	/*  Wait for response from board */
 	while (*((volatile u16 *)dwSyncAddr) && --usCount)
-		UTIL_Wait(TIHELEN_WRITE_DELAY);
+		udelay(10);
 
 	/*  If timed out: return FALSE */
 	if (!usCount) {
diff --git a/drivers/dsp/bridge/wmd/tiomap3430_pwr.c b/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
index f3e7645..95a89b3 100644
--- a/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
+++ b/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
@@ -122,7 +122,7 @@ DSP_STATUS handle_hibernation_fromDSP(struct WMD_DEV_CONTEXT *pDevContext)
 	/* Wait for DSP to move into Off state,  how much time should
 	 * we wait? */
 	while ((pwrState != HW_PWR_STATE_OFF) && --usCount) {
-		UTIL_Wait(PWR_WAIT_USECS);
+		udelay(500);
 		HW_PWR_IVA2StateGet(resources.dwPrmBase, HW_PWR_DOMAIN_DSP,
 				    &pwrState);
 	}
@@ -243,7 +243,7 @@ DSP_STATUS SleepDSP(struct WMD_DEV_CONTEXT *pDevContext, IN u32 dwCmd,
 	/* Wait for DSP to move into Standby state,  how much time
 	 * should we wait?*/
 	while ((pwrState != targetPwrState) && --usCount) {
-		UTIL_Wait(PWR_WAIT_USECS);
+		udelay(500);
 		HW_PWR_IVA2StateGet(resources.dwPrmBase, HW_PWR_DOMAIN_DSP,
 				    &pwrState);
 	}
diff --git a/drivers/dsp/bridge/wmd/tiomap_sm.c b/drivers/dsp/bridge/wmd/tiomap_sm.c
index 0e18613..574cf28 100644
--- a/drivers/dsp/bridge/wmd/tiomap_sm.c
+++ b/drivers/dsp/bridge/wmd/tiomap_sm.c
@@ -61,7 +61,7 @@ DSP_STATUS CHNLSM_EnableInterrupt(struct WMD_DEV_CONTEXT *pDevContext)
 			HW_MBOX_MsgRead(resources.dwMboxBase,
 					MBOX_ARM2DSP, &mbxValue);
 			numMbxMsg--;
-			UTIL_Wait(10);
+			udelay(10);
 
 			HW_MBOX_EventAck(resources.dwMboxBase, MBOX_ARM2DSP,
 					 HW_MBOX_U1_DSP1,
@@ -141,7 +141,7 @@ DSP_STATUS CHNLSM_InterruptDSP(struct WMD_DEV_CONTEXT *pDevContext)
 		HW_MBOX_IsFull(resources.dwMboxBase,
 			       MBOX_ARM2DSP, &mbxFull);
 		if (mbxFull)
-			UTIL_Wait(1000);	/* wait for 1 ms)      */
+			mdelay(1);
 		else
 			break;
 	}
-- 
1.6.2.1.287.g9a8be

