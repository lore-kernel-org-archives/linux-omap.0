From: Omar Ramirez Luna <x00omar@ti.com>
Subject: [PATCH 03/14] DSPBRIDGE: Fixed Double notification when a sys_error happens
Date: Wed, 20 May 2009 00:02:09 -0500
Message-ID: <1242795740-21535-3-git-send-email-x00omar@ti.com>
References: <1242795740-21535-1-git-send-email-x00omar@ti.com>
 <1242795740-21535-2-git-send-email-x00omar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:39054 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751544AbZETE6c (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 20 May 2009 00:58:32 -0400
In-Reply-To: <1242795740-21535-2-git-send-email-x00omar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Hiroshi.DOYU@nokia.com, ameya.palande@nokia.com, Omar Ramirez Luna <x00omar@ti.com>

There is no need to keep sending notifications once an mmu fault
or sys error was sent, one notification should be enough to
signal the reload of baseimage for recovery.

Signed-off-by: Omar Ramirez Luna <x00omar@ti.com>
Acked-by: Hari Kanigeri <h-kanigeri2@ti.com>
---
 drivers/dsp/bridge/wmd/ue_deh.c |   13 +++++++++++--
 1 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/dsp/bridge/wmd/ue_deh.c b/drivers/dsp/bridge/wmd/ue_deh.c
index d5551cb..278dae2 100644
--- a/drivers/dsp/bridge/wmd/ue_deh.c
+++ b/drivers/dsp/bridge/wmd/ue_deh.c
@@ -197,6 +197,7 @@ void WMD_DEH_Notify(struct DEH_MGR *hDehMgr, u32 ulEventMask,
 	struct DEH_MGR *pDehMgr = (struct DEH_MGR *)hDehMgr;
 	struct WMD_DEV_CONTEXT *pDevContext;
 	DSP_STATUS status = DSP_SOK;
+	DSP_STATUS status1 = DSP_EFAIL;
 	u32 memPhysical = 0;
 	u32 HW_MMU_MAX_TLB_COUNT = 31;
 	u32 extern faultAddr;
@@ -285,6 +286,11 @@ void WMD_DEH_Notify(struct DEH_MGR *hDehMgr, u32 ulEventMask,
 				 "0x%x\n", dwErrInfo);
 			break;
 		}
+
+		/* Filter subsequent notifications when an error occurs */
+		if (pDevContext->dwBrdState != BRD_ERROR)
+			status1 = DSP_SOK;
+
 		/* Set the Board state as ERROR */
 		pDevContext->dwBrdState = BRD_ERROR;
 		/* Disable all the clocks that were enabled by DSP */
@@ -292,8 +298,11 @@ void WMD_DEH_Notify(struct DEH_MGR *hDehMgr, u32 ulEventMask,
 		/* Call DSP Trace Buffer */
 		PrintDspTraceBuffer(hDehMgr->hWmdContext);
 
-		/* Signal DSP error/exception event. */
-		NTFY_Notify(pDehMgr->hNtfy, ulEventMask);
+		if (DSP_SUCCEEDED(status1)) {
+			/* Signal DSP error/exception event. */
+			NTFY_Notify(pDehMgr->hNtfy, ulEventMask);
+		}
+
 	}
 	DBG_Trace(DBG_LEVEL1, "Exiting WMD_DEH_Notify\n");
 
-- 
1.6.2.4

