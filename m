From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 6/7] DSPBRIDGE: Delete list implementation for resource cleanup
Date: Wed, 16 Dec 2009 21:45:57 -0600
Message-ID: <1261021558-19036-7-git-send-email-omar.ramirez@ti.com>
References: <1261021558-19036-1-git-send-email-omar.ramirez@ti.com>
 <1261021558-19036-2-git-send-email-omar.ramirez@ti.com>
 <1261021558-19036-3-git-send-email-omar.ramirez@ti.com>
 <1261021558-19036-4-git-send-email-omar.ramirez@ti.com>
 <1261021558-19036-5-git-send-email-omar.ramirez@ti.com>
 <1261021558-19036-6-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:45482 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932293AbZLQDik (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 16 Dec 2009 22:38:40 -0500
In-Reply-To: <1261021558-19036-6-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Ameya Palande <ameya.palande@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>, Fernando Guzman <x0095840@ti.com>, Ernesto Ramos <ernesto@ti.com>

From: Ernesto Ramos Falcon <ernesto@ti.com>

This patch moves processor detach implementation to bridge_release,
when a process is exiting it will be doing the detach from there
instead of relying on the user to explicitly call detach function.

This will allow a fine control on the resources that will be cleaned
once the application exits.

Signed-off-by: Ernesto Ramos Falcon <ernesto@ti.com>
---
 arch/arm/plat-omap/include/dspbridge/drv.h  |   12 +--------
 arch/arm/plat-omap/include/dspbridge/proc.h |    5 +--
 drivers/dsp/bridge/pmgr/wcd.c               |    7 ++---
 drivers/dsp/bridge/rmgr/drv.c               |   12 ----------
 drivers/dsp/bridge/rmgr/drv_interface.c     |   16 +++----------
 drivers/dsp/bridge/rmgr/proc.c              |   31 +++++++++++---------------
 6 files changed, 24 insertions(+), 59 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/drv.h b/arch/arm/plat-omap/include/dspbridge/drv.h
index efc3a92..d14613f 100644
--- a/arch/arm/plat-omap/include/dspbridge/drv.h
+++ b/arch/arm/plat-omap/include/dspbridge/drv.h
@@ -173,16 +173,8 @@ struct PROCESS_CONTEXT{
 	/* Process State */
 	enum GPP_PROC_RES_STATE resState;
 
-	/* Process ID (Same as UNIX process ID) */
-	u32 pid;
-
-	/* Pointer to next process context
-	* (To maintain a linked list of process contexts) */
-	struct PROCESS_CONTEXT *next;
-
-	/* List of Processors */
-	struct list_head processor_list;
-	spinlock_t proc_list_lock;
+	/* Handle to Processor */
+	DSP_HPROCESSOR hProcessor;
 
 	/* DSP Node resources */
 	struct NODE_RES_OBJECT *pNodeList;
diff --git a/arch/arm/plat-omap/include/dspbridge/proc.h b/arch/arm/plat-omap/include/dspbridge/proc.h
index d4896d5..935afd0 100644
--- a/arch/arm/plat-omap/include/dspbridge/proc.h
+++ b/arch/arm/plat-omap/include/dspbridge/proc.h
@@ -177,7 +177,7 @@ struct PROC_OBJECT {
  *      Close a DSP processor and de-allocate all (GPP) resources reserved
  *      for it. The Processor Object is deleted.
  *  Parameters:
- *      hProcessor  :   The processor handle.
+ *      pr_ctxt     :   The processor handle.
  *  Returns:
  *      DSP_SOK     :   Success.
  *      DSP_EHANDLE :   InValid Handle.
@@ -187,8 +187,7 @@ struct PROC_OBJECT {
  *  Ensures:
  *      PROC Object is destroyed.
  */
-	extern DSP_STATUS PROC_Detach(DSP_HPROCESSOR hProcessor,
-			struct PROCESS_CONTEXT *pr_ctxt);
+	extern DSP_STATUS PROC_Detach(struct PROCESS_CONTEXT *pr_ctxt);
 
 /*
  *  ======== PROC_EnumNodes ========
diff --git a/drivers/dsp/bridge/pmgr/wcd.c b/drivers/dsp/bridge/pmgr/wcd.c
index 70a56ed..7226b5a 100644
--- a/drivers/dsp/bridge/pmgr/wcd.c
+++ b/drivers/dsp/bridge/pmgr/wcd.c
@@ -734,14 +734,13 @@ func_end:
  */
 u32 PROCWRAP_Detach(union Trapped_Args *args, void *pr_ctxt)
 {
-	u32 retVal;
-
 	GT_1trace(WCD_debugMask, GT_ENTER,
 		 "PROCWRAP_Detach: entered args\n0x%x "
 		 "hProceesor \n", args->ARGS_PROC_DETACH.hProcessor);
-	retVal = PROC_Detach(args->ARGS_PROC_DETACH.hProcessor, pr_ctxt);
 
-	return retVal;
+	/* PROC_Detach called at bridge_release only */
+
+	return DSP_SOK;
 }
 
 /*
diff --git a/drivers/dsp/bridge/rmgr/drv.c b/drivers/dsp/bridge/rmgr/drv.c
index 7201c95..ad49c7f 100644
--- a/drivers/dsp/bridge/rmgr/drv.c
+++ b/drivers/dsp/bridge/rmgr/drv.c
@@ -157,18 +157,6 @@ static DSP_STATUS DRV_ProcFreeNodeRes(HANDLE hPCtxt);
 static DSP_STATUS  DRV_ProcFreeSTRMRes(HANDLE hPCtxt);
 extern enum NODE_STATE NODE_GetState(HANDLE hNode);
 
-/* Set the Process ID */
-DSP_STATUS DRV_ProcSetPID(HANDLE hPCtxt, s32 hProcess)
-{
-	struct PROCESS_CONTEXT *pCtxt = (struct PROCESS_CONTEXT *)hPCtxt;
-	DSP_STATUS status = DSP_SOK;
-
-	DBC_Assert(hPCtxt != NULL);
-
-	pCtxt->pid = hProcess;
-	return status;
-}
-
 /* Update the state of process context */
 DSP_STATUS DRV_ProcUpdatestate(HANDLE hPCtxt, enum GPP_PROC_RES_STATE status)
 {
diff --git a/drivers/dsp/bridge/rmgr/drv_interface.c b/drivers/dsp/bridge/rmgr/drv_interface.c
index f0c5e35..42fb7cb 100644
--- a/drivers/dsp/bridge/rmgr/drv_interface.c
+++ b/drivers/dsp/bridge/rmgr/drv_interface.c
@@ -545,14 +545,11 @@ static int bridge_open(struct inode *ip, struct file *filp)
 	 * process context list.
 	 */
 	pr_ctxt = MEM_Calloc(sizeof(struct PROCESS_CONTEXT), MEM_PAGED);
-	if (pr_ctxt) {
-		spin_lock_init(&(pr_ctxt->proc_list_lock));
-		INIT_LIST_HEAD(&(pr_ctxt->processor_list));
+	if (pr_ctxt)
 		DRV_ProcUpdatestate(pr_ctxt, PROC_RES_ALLOCATED);
-		DRV_ProcSetPID(pr_ctxt, current->tgid);
-	} else {
+	else
 		status = -ENOMEM;
-	}
+
 	filp->private_data = pr_ctxt;
 
 err:
@@ -570,7 +567,6 @@ static int bridge_release(struct inode *ip, struct file *filp)
 	DSP_STATUS dsp_status;
 	HANDLE hDrvObject;
 	struct PROCESS_CONTEXT *pr_ctxt;
-	struct PROC_OBJECT *proc_obj_ptr, *temp;
 
 	GT_0trace(driverTrace, GT_ENTER, "-> bridge_release\n");
 
@@ -584,11 +580,7 @@ static int bridge_release(struct inode *ip, struct file *filp)
 	if (DSP_SUCCEEDED(dsp_status)) {
 		flush_signals(current);
 		DRV_RemoveAllResources(pr_ctxt);
-		list_for_each_entry_safe(proc_obj_ptr, temp,
-				&pr_ctxt->processor_list,
-				proc_object) {
-			PROC_Detach(proc_obj_ptr, pr_ctxt);
-		}
+		PROC_Detach(pr_ctxt);
 		MEM_Free(pr_ctxt);
 	} else {
 		status = -EIO;
diff --git a/drivers/dsp/bridge/rmgr/proc.c b/drivers/dsp/bridge/rmgr/proc.c
index 9bb9082..8501b06 100644
--- a/drivers/dsp/bridge/rmgr/proc.c
+++ b/drivers/dsp/bridge/rmgr/proc.c
@@ -200,6 +200,11 @@ PROC_Attach(u32 uProcessor, OPTIONAL CONST struct DSP_PROCESSORATTRIN *pAttrIn,
 		 "uProcessor:  0x%x\n\tpAttrIn:  0x%x\n\tphProcessor:"
 		 "0x%x\n", uProcessor, pAttrIn, phProcessor);
 
+	if (pr_ctxt && pr_ctxt->hProcessor) {
+		*phProcessor = pr_ctxt->hProcessor;
+		return status;
+	}
+
 	/* Get the Driver and Manager Object Handles */
 	status = CFG_GetObject((u32 *)&hDrvObject, REG_DRV_OBJECT);
 	if (DSP_SUCCEEDED(status)) {
@@ -309,6 +314,7 @@ PROC_Attach(u32 uProcessor, OPTIONAL CONST struct DSP_PROCESSORATTRIN *pAttrIn,
 		}
 		if (DSP_SUCCEEDED(status)) {
 			*phProcessor = (DSP_HPROCESSOR)pProcObject;
+			pr_ctxt->hProcessor = *phProcessor;
 			(void)PROC_NotifyClients(pProcObject,
 						 DSP_PROCESSORATTACH);
 			GT_0trace(PROC_DebugMask, GT_1CLASS,
@@ -322,11 +328,6 @@ PROC_Attach(u32 uProcessor, OPTIONAL CONST struct DSP_PROCESSORATTRIN *pAttrIn,
 			 "storage for notification \n");
 		MEM_FreeObject(pProcObject);
 	}
-#ifndef RES_CLEANUP_DISABLE
-	spin_lock(&pr_ctxt->proc_list_lock);
-	list_add(&pProcObject->proc_object, &pr_ctxt->processor_list);
-	spin_unlock(&pr_ctxt->proc_list_lock);
-#endif
 func_end:
 	DBC_Ensure((status == DSP_EFAIL && *phProcessor == NULL) ||
 		  (DSP_SUCCEEDED(status) &&
@@ -548,24 +549,19 @@ DSP_STATUS PROC_Ctrl(DSP_HPROCESSOR hProcessor, u32 dwCmd,
  *      Destroys the  Processor Object. Removes the notification from the Dev
  *      List.
  */
-DSP_STATUS PROC_Detach(DSP_HPROCESSOR hProcessor,
-		struct PROCESS_CONTEXT *pr_ctxt)
+DSP_STATUS PROC_Detach(struct PROCESS_CONTEXT *pr_ctxt)
 {
 	DSP_STATUS status = DSP_SOK;
-	struct PROC_OBJECT *pProcObject = (struct PROC_OBJECT *)hProcessor;
+	struct PROC_OBJECT *pProcObject = NULL;
+
+	if (pr_ctxt && pr_ctxt->hProcessor)
+		pProcObject = (struct PROC_OBJECT *)pr_ctxt->hProcessor;
 
 	DBC_Require(cRefs > 0);
 	GT_1trace(PROC_DebugMask, GT_ENTER, "Entered PROC_Detach, args:\n\t"
-		 "hProcessor:  0x%x\n", hProcessor);
+		"pr_ctxt->phProcessor:  0x%x\n", *pProcObject);
 
 	if (MEM_IsValidHandle(pProcObject, PROC_SIGNATURE)) {
-#ifndef RES_CLEANUP_DISABLE
-		if (pr_ctxt) {
-			spin_lock(&pr_ctxt->proc_list_lock);
-			list_del(&pProcObject->proc_object);
-			spin_unlock(&pr_ctxt->proc_list_lock);
-		}
-#endif
 		/* Notify the Client */
 		NTFY_Notify(pProcObject->hNtfy, DSP_PROCESSORDETACH);
 		/* Remove the notification memory */
@@ -581,6 +577,7 @@ DSP_STATUS PROC_Detach(DSP_HPROCESSOR hProcessor,
 			(u32)pProcObject);
 		/* Free the Processor Object */
 		MEM_FreeObject(pProcObject);
+		pr_ctxt->hProcessor = NULL;
 	} else {
 		status = DSP_EHANDLE;
 		GT_0trace(PROC_DebugMask, GT_7CLASS,
@@ -1634,8 +1631,6 @@ DSP_STATUS PROC_Stop(DSP_HPROCESSOR hProcessor)
 	}
 	if (DSP_SUCCEEDED((*pProcObject->pIntfFxns->pfnBrdStatus)
 	   (pProcObject->hWmdContext, &uBrdState))) {
-		/* Clean up all the resources except the current running
-		 * process resources */
 		if (uBrdState == BRD_ERROR)
 			WMD_DEH_ReleaseDummyMem();
 	}
-- 
1.6.2.4

