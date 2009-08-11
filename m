From: Ameya Palande <ameya.palande@nokia.com>
Subject: [PATCH 06/13] DSPBRIDGE: Use pr_ctxt in PROC_Detach
Date: Tue, 11 Aug 2009 04:21:47 +0300
Message-ID: <1249953714-20972-7-git-send-email-ameya.palande@nokia.com>
References: <1249953714-20972-1-git-send-email-ameya.palande@nokia.com>
 <1249953714-20972-2-git-send-email-ameya.palande@nokia.com>
 <1249953714-20972-3-git-send-email-ameya.palande@nokia.com>
 <1249953714-20972-4-git-send-email-ameya.palande@nokia.com>
 <1249953714-20972-5-git-send-email-ameya.palande@nokia.com>
 <1249953714-20972-6-git-send-email-ameya.palande@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:37634 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753417AbZHKBWW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 Aug 2009 21:22:22 -0400
In-Reply-To: <1249953714-20972-6-git-send-email-ameya.palande@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: hiroshi.doyu@nokia.com, omar.ramirez@ti.com, x0095840@ti.com, suyog@ti.com, roman.tereshonkov@nokia.com, ernesto@ti.com

Signed-off-by: Ameya Palande <ameya.palande@nokia.com>
---
 arch/arm/plat-omap/include/dspbridge/proc.h |    3 ++-
 drivers/dsp/bridge/pmgr/wcd.c               |    2 +-
 drivers/dsp/bridge/rmgr/drv_interface.c     |    4 ++--
 drivers/dsp/bridge/rmgr/proc.c              |   24 ++++++------------------
 4 files changed, 11 insertions(+), 22 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/proc.h b/arch/arm/plat-omap/include/dspbridge/proc.h
index 1737761..f5b0c50 100644
--- a/arch/arm/plat-omap/include/dspbridge/proc.h
+++ b/arch/arm/plat-omap/include/dspbridge/proc.h
@@ -163,7 +163,8 @@
  *  Ensures:
  *      PROC Object is destroyed.
  */
-	extern DSP_STATUS PROC_Detach(DSP_HPROCESSOR hProcessor);
+	extern DSP_STATUS PROC_Detach(DSP_HPROCESSOR hProcessor,
+			struct PROCESS_CONTEXT *pr_ctxt);
 
 /*
  *  ======== PROC_EnumNodes ========
diff --git a/drivers/dsp/bridge/pmgr/wcd.c b/drivers/dsp/bridge/pmgr/wcd.c
index ddb2aea..4f902a3 100644
--- a/drivers/dsp/bridge/pmgr/wcd.c
+++ b/drivers/dsp/bridge/pmgr/wcd.c
@@ -744,7 +744,7 @@ u32 PROCWRAP_Detach(union Trapped_Args *args, void *pr_ctxt)
 	GT_1trace(WCD_debugMask, GT_ENTER,
 		 "PROCWRAP_Detach: entered args\n0x%x "
 		 "hProceesor \n", args->ARGS_PROC_DETACH.hProcessor);
-	retVal = PROC_Detach(args->ARGS_PROC_DETACH.hProcessor);
+	retVal = PROC_Detach(args->ARGS_PROC_DETACH.hProcessor, pr_ctxt);
 
 	return retVal;
 }
diff --git a/drivers/dsp/bridge/rmgr/drv_interface.c b/drivers/dsp/bridge/rmgr/drv_interface.c
index 9ac7f19..7d4a6ea 100644
--- a/drivers/dsp/bridge/rmgr/drv_interface.c
+++ b/drivers/dsp/bridge/rmgr/drv_interface.c
@@ -474,7 +474,7 @@ static int __devexit omap34xx_bridge_remove(struct platform_device *pdev)
 		GT_1trace(driverTrace, GT_5CLASS, "***Cleanup of "
 			 "process***%d\n", pCtxtclosed->pid);
 		DRV_RemoveAllResources(pCtxtclosed);
-		PROC_Detach(pCtxtclosed->hProcessor);
+		PROC_Detach(pCtxtclosed->hProcessor, pCtxtclosed);
 		pTmp = pCtxtclosed->next;
 		DRV_RemoveProcContext((struct DRV_OBJECT *)hDrvObject,
 				     pCtxtclosed, (void *)pCtxtclosed->pid);
@@ -619,7 +619,7 @@ static int bridge_release(struct inode *ip, struct file *filp)
 		if (DSP_SUCCEEDED(dsp_status)) {
 			flush_signals(current);
 			DRV_RemoveAllResources(pr_ctxt);
-			PROC_Detach(pr_ctxt->hProcessor);
+			PROC_Detach(pr_ctxt->hProcessor, pr_ctxt);
 			DRV_RemoveProcContext((struct DRV_OBJECT *)hDrvObject,
 					pr_ctxt, (void *)pr_ctxt->pid);
 		} else {
diff --git a/drivers/dsp/bridge/rmgr/proc.c b/drivers/dsp/bridge/rmgr/proc.c
index c475436..323054f 100644
--- a/drivers/dsp/bridge/rmgr/proc.c
+++ b/drivers/dsp/bridge/rmgr/proc.c
@@ -220,7 +220,8 @@ DSP_STATUS PROC_CleanupAllResources(void)
 				 "***Cleanup of "
 				 "process***%d\n", pCtxtclosed->pid);
 			if (pCtxtclosed->hProcessor)
-				PROC_Detach(pCtxtclosed->hProcessor);
+				PROC_Detach(pCtxtclosed->hProcessor,
+						pCtxtclosed);
 		}
 		pCtxtclosed = pCtxtclosed->next;
 	}
@@ -604,32 +605,19 @@ DSP_STATUS PROC_Ctrl(DSP_HPROCESSOR hProcessor, u32 dwCmd,
  *      Destroys the  Processor Object. Removes the notification from the Dev
  *      List.
  */
-DSP_STATUS PROC_Detach(DSP_HPROCESSOR hProcessor)
+DSP_STATUS PROC_Detach(DSP_HPROCESSOR hProcessor,
+		struct PROCESS_CONTEXT *pr_ctxt)
 {
 	DSP_STATUS status = DSP_SOK;
 	struct PROC_OBJECT *pProcObject = (struct PROC_OBJECT *)hProcessor;
-#ifndef RES_CLEANUP_DISABLE
-	HANDLE hDRVObject;
-       u32 hProcess;
-	DSP_STATUS res_status = DSP_SOK;
-	struct PROCESS_CONTEXT   *pPctxt = NULL;
-#endif
 	DBC_Require(cRefs > 0);
 	GT_1trace(PROC_DebugMask, GT_ENTER, "Entered PROC_Detach, args:\n\t"
 		 "hProcessor:  0x%x\n", hProcessor);
 
 	if (MEM_IsValidHandle(pProcObject, PROC_SIGNATURE)) {
 #ifndef RES_CLEANUP_DISABLE
-		/* Return PID instead of process handle */
-		hProcess = pProcObject->hProcess;
-		res_status = CFG_GetObject((u32 *)&hDRVObject, REG_DRV_OBJECT);
-		if (DSP_SUCCEEDED(res_status)) {
-			DRV_GetProcContext(hProcess,
-				(struct DRV_OBJECT *)hDRVObject, &pPctxt,
-					 NULL, 0);
-			if (pPctxt != NULL)
-				pPctxt->hProcessor = NULL;
-		}
+		if (pr_ctxt != NULL)
+			pr_ctxt->hProcessor = NULL;
 #endif
 		/* Notify the Client */
 		NTFY_Notify(pProcObject->hNtfy, DSP_PROCESSORDETACH);
-- 
1.6.2.4

