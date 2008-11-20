From: "Ramirez Luna, Omar" <x00omar@ti.com>
Subject: [omapzoom][PATCH 1/4] DSPBRIDGE: Free resources when user fails to
 do so
Date: Thu, 20 Nov 2008 03:11:51 -0600
Message-ID: <27F9C60D11D683428E133F85D2BB4A5303F1A398EC@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:47336 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751944AbYKTJMF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 20 Nov 2008 04:12:05 -0500
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pandita, Vikram" <vikram.pandita@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

From: Fernando Guzman Lugo <x0095840@ti.com>
Date: Mon, 17 Nov 2008 15:49:56 -0600
Subject: [PATCH] DSPBRIDGE: Free resources when user fails to do so

Added error protection in bridge driver to handle
the cases where user applications detach the
processor without releasing DMM resources.

Signed-off-by: Fernando Guzman Lugo <x0095840@ti.com>
---
 arch/arm/plat-omap/include/dspbridge/drv.h |   13 +++++++++++
 drivers/dsp/bridge/rmgr/drv.c              |    3 +-
 drivers/dsp/bridge/rmgr/proc.c             |   31 +++++++++++++++------------
 3 files changed, 31 insertions(+), 16 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/drv.h b/arch/arm/plat-omap/include/dspbridge/drv.h
index 0a8fb7e..4345b56 100644
--- a/arch/arm/plat-omap/include/dspbridge/drv.h
+++ b/arch/arm/plat-omap/include/dspbridge/drv.h
@@ -427,4 +427,17 @@ struct PROCESS_CONTEXT{
 	extern DSP_STATUS DRV_ReleaseResources(IN u32 dwContext,
 					       struct DRV_OBJECT *hDrvObject);
 
+/*
+ *  ======== DRV_ProcFreeDMMRes ========
+ *  Purpose:
+ *       Actual DMM De-Allocation.
+ *  Parameters:
+ *      hPCtxt:      Path to the driver Registry Key.
+ *  Returns:
+ *      DSP_SOK if success;
+ */
+
+
+	extern DSP_STATUS  DRV_ProcFreeDMMRes(HANDLE hPCtxt);
+
 #endif				/* DRV_ */
diff --git a/drivers/dsp/bridge/rmgr/drv.c b/drivers/dsp/bridge/rmgr/drv.c
index 2614103..22faf49 100644
--- a/drivers/dsp/bridge/rmgr/drv.c
+++ b/drivers/dsp/bridge/rmgr/drv.c
@@ -162,7 +162,6 @@ static DSP_STATUS RequestBridgeResourcesDSP(u32 dwContext, s32 fRequest);
 
 static DSP_STATUS PrintProcessInformation(void);
 static DSP_STATUS DRV_ProcFreeNodeRes(HANDLE hPCtxt);
-static DSP_STATUS  DRV_ProcFreeDMMRes(HANDLE hPCtxt);
 static DSP_STATUS  DRV_ProcFreeSTRMRes(HANDLE hPCtxt);
 extern enum NODE_STATE NODE_GetState(HANDLE hNode);
 
@@ -559,7 +558,7 @@ DSP_STATUS DRV_UpdateDMMResElement(HANDLE hDMMRes, u32 pMpuAddr, u32 ulSize,
 }
 
 /* Actual DMM De-Allocation */
-static DSP_STATUS  DRV_ProcFreeDMMRes(HANDLE hPCtxt)
+DSP_STATUS  DRV_ProcFreeDMMRes(HANDLE hPCtxt)
 {
 	struct PROCESS_CONTEXT *pCtxt = (struct PROCESS_CONTEXT *)hPCtxt;
 	DSP_STATUS status = DSP_SOK;
diff --git a/drivers/dsp/bridge/rmgr/proc.c b/drivers/dsp/bridge/rmgr/proc.c
index eb7781d..d7798e7 100644
--- a/drivers/dsp/bridge/rmgr/proc.c
+++ b/drivers/dsp/bridge/rmgr/proc.c
@@ -140,6 +140,7 @@
 #include <dspbridge/dbreg.h>
 #include <dspbridge/msg.h>
 #include <dspbridge/wmdioctl.h>
+#include <dspbridge/drv.h>
 
 /*  ----------------------------------- This */
 #include <dspbridge/proc.h>
@@ -646,25 +647,27 @@ DSP_STATUS PROC_Detach(DSP_HPROCESSOR hProcessor)
 			pProcObject->g_pszLastCoff = NULL;
 		}
 
+#ifndef RES_CLEANUP_DISABLE
+		/* Return PID instead of process handle */
+		hProcess = current->pid;
+
+		res_status = CFG_GetObject((u32 *)&hDRVObject, REG_DRV_OBJECT);
+		if (DSP_SUCCEEDED(res_status)) {
+			DRV_GetProcContext(hProcess,
+				(struct DRV_OBJECT *)hDRVObject, &pPctxt,
+					 NULL, 0);
+			if (pPctxt != NULL) {
+				DRV_ProcFreeDMMRes(pPctxt);
+				pPctxt->hProcessor = NULL;
+			}
+		}
+#endif
+
 		/* Remove the Proc from the DEV List */
 		(void)DEV_RemoveProcObject(pProcObject->hDevObject,
 			(u32)pProcObject);
 		/* Free the Processor Object */
 		MEM_FreeObject(pProcObject);
-#ifndef RES_CLEANUP_DISABLE
-	/* Return PID instead of process handle */
-	hProcess = current->pid;
-
-	res_status = CFG_GetObject((u32 *)&hDRVObject, REG_DRV_OBJECT);
-	/* res_status = CFG_GetObject(REG_DRV_OBJECT, (u32*)&hDRVObject); */
-	if (DSP_SUCCEEDED(res_status)) {
-		DRV_GetProcContext(hProcess,
-				 (struct DRV_OBJECT *)hDRVObject, &pPctxt,
-				 NULL, 0);
-		if (pPctxt != NULL)
-			pPctxt->hProcessor = NULL;
-	}
-#endif
 	} else {
 		status = DSP_EHANDLE;
 		GT_0trace(PROC_DebugMask, GT_7CLASS,
-- 
1.6.0
