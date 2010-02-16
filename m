From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 15/18] DSPBRIDGE: change critical error statements to pr_err in wmd
Date: Tue, 16 Feb 2010 02:42:25 -0600
Message-ID: <1266309748-11714-16-git-send-email-omar.ramirez@ti.com>
References: <1266309748-11714-1-git-send-email-omar.ramirez@ti.com>
 <1266309748-11714-2-git-send-email-omar.ramirez@ti.com>
 <1266309748-11714-3-git-send-email-omar.ramirez@ti.com>
 <1266309748-11714-4-git-send-email-omar.ramirez@ti.com>
 <1266309748-11714-5-git-send-email-omar.ramirez@ti.com>
 <1266309748-11714-6-git-send-email-omar.ramirez@ti.com>
 <1266309748-11714-7-git-send-email-omar.ramirez@ti.com>
 <1266309748-11714-8-git-send-email-omar.ramirez@ti.com>
 <1266309748-11714-9-git-send-email-omar.ramirez@ti.com>
 <1266309748-11714-10-git-send-email-omar.ramirez@ti.com>
 <1266309748-11714-11-git-send-email-omar.ramirez@ti.com>
 <1266309748-11714-12-git-send-email-omar.ramirez@ti.com>
 <1266309748-11714-13-git-send-email-omar.ramirez@ti.com>
 <1266309748-11714-14-git-send-email-omar.ramirez@ti.com>
 <1266309748-11714-15-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:57646 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755117Ab0BPIaK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Feb 2010 03:30:10 -0500
In-Reply-To: <1266309748-11714-15-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Ameya Palande <ameya.palande@nokia.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>, Nishanth Menon <nm@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>

Print to console:
    - SHM critical size errors.
    - PM power transition errors.
    - lack of MSG frame issues.

This will help to quick diagnose most common bridge errors.

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 drivers/dsp/bridge/wmd/io_sm.c          |   19 +++++++++----------
 drivers/dsp/bridge/wmd/tiomap3430.c     |    8 ++++----
 drivers/dsp/bridge/wmd/tiomap3430_pwr.c |    6 +++---
 3 files changed, 16 insertions(+), 17 deletions(-)

diff --git a/drivers/dsp/bridge/wmd/io_sm.c b/drivers/dsp/bridge/wmd/io_sm.c
index ab7607f..3471ed5 100644
--- a/drivers/dsp/bridge/wmd/io_sm.c
+++ b/drivers/dsp/bridge/wmd/io_sm.c
@@ -497,9 +497,9 @@ DSP_STATUS WMD_IO_OnLoaded(struct IO_MGR *hIOMgr)
 
 		if ((ulSegSize + ulSeg1Size + ulPadSize) >
 		   hostRes.dwMemLength[1]) {
-			DBG_Trace(DBG_LEVEL7, "Insufficient SHM Reserved 0x%x. "
-				 "Required 0x%x\n", hostRes.dwMemLength[1],
-				 ulSegSize + ulSeg1Size + ulPadSize);
+			pr_err("%s: SHM Error, reserved 0x%x required 0x%x\n",
+					__func__, hostRes.dwMemLength[1],
+					ulSegSize + ulSeg1Size + ulPadSize);
 			status = DSP_EMEMORY;
 		}
 	}
@@ -905,10 +905,9 @@ static void IO_DispatchPM(struct work_struct *work)
 				 "command\n");
 			status = pIOMgr->pIntfFxns->pfnDevCntrl(pIOMgr->
 				 hWmdContext, WMDIOCTL_PWR_HIBERNATE, pArg);
-			if (DSP_FAILED(status)) {
-				DBG_Trace(DBG_LEVEL7, "IO_DispatchPM : "
-					 "Hibernation command failed\n");
-			}
+			if (DSP_FAILED(status))
+				pr_err("%s: hibernate cmd failed 0x%x\n",
+							__func__, status);
 		} else if (pArg[0] == MBX_PM_OPP_REQ) {
 			pArg[1] = pIOMgr->pSharedMem->oppRequest.rqstOppPt;
 			DBG_Trace(DBG_LEVEL7, "IO_DispatchPM : Value of OPP "
@@ -1355,9 +1354,9 @@ static void InputMsg(struct IO_MGR *pIOMgr, struct MSG_MGR *hMsgMgr)
 						 * No free frame to copy the
 						 * message into.
 						 */
-						DBG_Trace(DBG_LEVEL7, "NO FREE "
-							"MSG FRAMES, DISCARDING"
-							" MESSAGE\n");
+						pr_err("%s: no free msg frames,"
+							" discarding msg\n",
+							__func__);
 					}
 				}
 				break;
diff --git a/drivers/dsp/bridge/wmd/tiomap3430.c b/drivers/dsp/bridge/wmd/tiomap3430.c
index a8dbbfe..4563ca4 100644
--- a/drivers/dsp/bridge/wmd/tiomap3430.c
+++ b/drivers/dsp/bridge/wmd/tiomap3430.c
@@ -458,7 +458,7 @@ static DSP_STATUS WMD_BRD_Start(struct WMD_DEV_CONTEXT *hDevContext,
 	 /* Write a signature into the SHM base + offset; this will
 	 * get cleared when the DSP program starts.  */
 	if ((ulShmBaseVirt == 0) || (ulShmBase == 0)) {
-		DBG_Trace(DBG_LEVEL6, "WMD_BRD_Start: Illegal SM base\n");
+		pr_err("%s: Illegal SM base\n", __func__);
 		status = DSP_EFAIL;
 	} else
 		*((volatile u32 *)dwSyncAddr) = 0xffffffff;
@@ -1338,8 +1338,8 @@ static DSP_STATUS WMD_BRD_MemMap(struct WMD_DEV_CONTEXT *hDevContext,
 		       vma->vm_end, vma->vm_flags);
 	}
 	if (!vma) {
-		DBG_Trace(DBG_LEVEL7, "Failed to get the VMA region for "
-			  "MPU Buffer !!! \n");
+		pr_err("%s: Failed to get VMA region for 0x%x (%d)\n",
+					__func__, ulMpuAddr, ulNumBytes);
 		status = DSP_EINVALIDARG;
 		up_read(&mm->mmap_sem);
 		goto func_cont;
@@ -1923,7 +1923,7 @@ bool WaitForStart(struct WMD_DEV_CONTEXT *pDevContext, u32 dwSyncAddr)
 
 	/*  If timed out: return FALSE */
 	if (!timeout) {
-		DBG_Trace(DBG_LEVEL7, "Timed out Waiting for DSP to Start\n");
+		pr_err("%s: Timed out waiting DSP to Start\n", __func__);
 		return FALSE;
 	}
 	return TRUE;
diff --git a/drivers/dsp/bridge/wmd/tiomap3430_pwr.c b/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
index 270655a..9469c5e 100644
--- a/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
+++ b/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
@@ -117,7 +117,7 @@ DSP_STATUS handle_hibernation_fromDSP(struct WMD_DEV_CONTEXT *pDevContext)
 				    &pwrState);
 	}
 	if (timeout == 0) {
-		DBG_Trace(DBG_LEVEL7, "Timed out Waiting for DSP Off mode \n");
+		pr_err("%s: Timed out waiting for DSP off mode\n", __func__);
 		status = WMD_E_TIMEOUT;
 		return status;
 	} else {
@@ -232,8 +232,8 @@ DSP_STATUS SleepDSP(struct WMD_DEV_CONTEXT *pDevContext, IN u32 dwCmd,
 	}
 
 	if (!timeout) {
-		DBG_Trace(DBG_LEVEL7, "SleepDSP: Timed out Waiting for DSP"
-			 " STANDBY %x \n", pwrState);
+		pr_err("%s: Timed out waiting for DSP off mode, state %x\n",
+							__func__, pwrState);
 #ifdef CONFIG_BRIDGE_NTFY_PWRERR
 		DEV_GetDehMgr(pDevContext->hDevObject, &hDehMgr);
 		WMD_DEH_Notify(hDehMgr, DSP_PWRERROR, 0);
-- 
1.6.2.4

