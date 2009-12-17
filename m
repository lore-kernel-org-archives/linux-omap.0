From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 3/7] DSPBRIDGE: Remove old resource cleanup implementation
Date: Wed, 16 Dec 2009 21:45:54 -0600
Message-ID: <1261021558-19036-4-git-send-email-omar.ramirez@ti.com>
References: <1261021558-19036-1-git-send-email-omar.ramirez@ti.com>
 <1261021558-19036-2-git-send-email-omar.ramirez@ti.com>
 <1261021558-19036-3-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:48163 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934705AbZLQDim (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 16 Dec 2009 22:38:42 -0500
In-Reply-To: <1261021558-19036-3-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Ameya Palande <ameya.palande@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>, Fernando Guzman <x0095840@ti.com>, Ernesto Ramos <ernesto@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>

From: Ameya Palande <ameya.palande@nokia.com>

Remove old resource cleanup implementation, and use the process
context pointer stored in filp->private.

Signed-off-by: Ameya Palande <ameya.palande@nokia.com>
[ orl: split into logical patch set, patch description ]
Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
Acked-by: Fernando Guzman Lugo <x0095840@ti.com>
---
 arch/arm/plat-omap/include/dspbridge/drv.h         |    5 +-
 arch/arm/plat-omap/include/dspbridge/proc.h        |   24 +++
 .../plat-omap/include/dspbridge/resourcecleanup.h  |    7 +-
 drivers/dsp/bridge/rmgr/drv.c                      |  126 ++++------------
 drivers/dsp/bridge/rmgr/drv_interface.c            |   18 ++-
 drivers/dsp/bridge/rmgr/node.c                     |   65 +-------
 drivers/dsp/bridge/rmgr/proc.c                     |  158 ++++---------------
 drivers/dsp/bridge/rmgr/strm.c                     |  104 +++-----------
 8 files changed, 134 insertions(+), 373 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/drv.h b/arch/arm/plat-omap/include/dspbridge/drv.h
index c468461..efc3a92 100644
--- a/arch/arm/plat-omap/include/dspbridge/drv.h
+++ b/arch/arm/plat-omap/include/dspbridge/drv.h
@@ -180,8 +180,9 @@ struct PROCESS_CONTEXT{
 	* (To maintain a linked list of process contexts) */
 	struct PROCESS_CONTEXT *next;
 
-	/* Processor info to which the process is related */
-	DSP_HPROCESSOR hProcessor;
+	/* List of Processors */
+	struct list_head processor_list;
+	spinlock_t proc_list_lock;
 
 	/* DSP Node resources */
 	struct NODE_RES_OBJECT *pNodeList;
diff --git a/arch/arm/plat-omap/include/dspbridge/proc.h b/arch/arm/plat-omap/include/dspbridge/proc.h
index f5b0c50..d4896d5 100644
--- a/arch/arm/plat-omap/include/dspbridge/proc.h
+++ b/arch/arm/plat-omap/include/dspbridge/proc.h
@@ -66,6 +66,30 @@
 #include <dspbridge/devdefs.h>
 #include <dspbridge/drv.h>
 
+/* The PROC_OBJECT structure.   */
+struct PROC_OBJECT {
+	struct LST_ELEM link;		/* Link to next PROC_OBJECT */
+	u32 dwSignature;		/* Used for object validation */
+	struct DEV_OBJECT *hDevObject;	/* Device this PROC represents */
+	u32 hProcess;			/* Process owning this Processor */
+	struct MGR_OBJECT *hMgrObject;	/* Manager Object Handle */
+	u32 uAttachCount;		/* Processor attach count */
+	u32 uProcessor;			/* Processor number */
+	u32 uTimeout;			/* Time out count */
+	enum DSP_PROCSTATE sState;	/* Processor state */
+	u32 ulUnit;			/* DDSP unit number */
+	bool bIsAlreadyAttached;	/*
+					 * True if the Device below has
+					 * GPP Client attached
+					 */
+	struct NTFY_OBJECT *hNtfy;	/* Manages  notifications */
+	struct WMD_DEV_CONTEXT *hWmdContext;	/* WMD Context Handle */
+	struct WMD_DRV_INTERFACE *pIntfFxns;	/* Function interface to WMD */
+	char *g_pszLastCoff;
+	struct list_head proc_object;
+};
+
+
 /*
  *  ======== PROC_Attach ========
  *  Purpose:
diff --git a/arch/arm/plat-omap/include/dspbridge/resourcecleanup.h b/arch/arm/plat-omap/include/dspbridge/resourcecleanup.h
index b43fa16..f32da22 100644
--- a/arch/arm/plat-omap/include/dspbridge/resourcecleanup.h
+++ b/arch/arm/plat-omap/include/dspbridge/resourcecleanup.h
@@ -35,15 +35,10 @@ extern DSP_STATUS DRV_ProcUpdatestate(HANDLE pCtxt,
 
 extern DSP_STATUS DRV_ProcSetPID(HANDLE pCtxt, s32 hProcess);
 
-extern DSP_STATUS DRV_GetProcContext(u32 phProcess,
-				struct DRV_OBJECT *hDrvObject,
-				HANDLE hPCtxt, DSP_HNODE hNode,
-				u32 pMapAddr);
-
 extern DSP_STATUS DRV_RemoveAllResources(HANDLE pPctxt);
 
 extern DSP_STATUS DRV_RemoveProcContext(struct DRV_OBJECT *hDRVObject,
-				     HANDLE hPCtxt, HANDLE hProcess);
+				     HANDLE pr_ctxt);
 
 extern DSP_STATUS DRV_GetNodeResElement(HANDLE hNode, HANDLE nodeRes,
 					HANDLE pCtxt);
diff --git a/drivers/dsp/bridge/rmgr/drv.c b/drivers/dsp/bridge/rmgr/drv.c
index a00598b..92e2a62 100644
--- a/drivers/dsp/bridge/rmgr/drv.c
+++ b/drivers/dsp/bridge/rmgr/drv.c
@@ -194,77 +194,6 @@ DSP_STATUS DRV_GetProcCtxtList(struct PROCESS_CONTEXT **pPctxt,
 	return status;
 }
 
-
-
-/* Get a particular process context based on process handle (phProcess) */
-DSP_STATUS DRV_GetProcContext(u32 phProcess,
-				struct DRV_OBJECT *hDrvObject,
-				HANDLE hPCtxt, DSP_HNODE hNode,
-				u32 pMapAddr)
-{
-	struct PROCESS_CONTEXT **pCtxt = (struct PROCESS_CONTEXT **)hPCtxt;
-	DSP_STATUS status = DSP_SOK;
-	struct PROCESS_CONTEXT *pCtxtList = NULL;
-	struct DRV_OBJECT *pDrvObject = (struct DRV_OBJECT *)hDrvObject;
-	struct NODE_RES_OBJECT *pTempNode2 = NULL;
-	struct NODE_RES_OBJECT *pTempNode = NULL;
-	struct DMM_RES_OBJECT *pTempDMM2 = NULL;
-	struct DMM_RES_OBJECT *pTempDMM = NULL;
-	s32 pCtxtFound = 0;
-
-	DBC_Assert(pDrvObject != NULL);
-	pCtxtList = pDrvObject->procCtxtList;
-	GT_0trace(curTrace, GT_ENTER, "2DRV_GetProcContext: 2");
-	while ((pCtxtList != NULL) && (pCtxtList->pid != phProcess)) {
-		pCtxtList = pCtxtList->next;
-		GT_0trace(curTrace, GT_ENTER, "2DRV_GetProcContext: 3");
-	}
-	if (pCtxtList == NULL) {
-		if (hNode != NULL) {
-			pCtxtList = pDrvObject->procCtxtList;
-			while ((pCtxtList != NULL) && (pCtxtFound == 0)) {
-				pTempNode = pCtxtList->pNodeList;
-				while ((pTempNode != NULL) &&
-				      (pTempNode->hNode != hNode)) {
-					pTempNode2 = pTempNode;
-					pTempNode = pTempNode->next;
-				}
-				if (pTempNode != NULL) {
-					pCtxtFound = 1;
-					status = DSP_SOK;
-				} else {
-					pCtxtList = pCtxtList->next;
-				}
-			}
-		} else if ((pMapAddr != 0) && (pCtxtFound == 0)) {
-			pCtxtList = pDrvObject->procCtxtList;
-			while ((pCtxtList != NULL) && (pCtxtFound == 0)) {
-				pTempDMM = pCtxtList->pDMMList;
-				while ((pTempDMM != NULL) &&
-				     (pTempDMM->ulDSPAddr != pMapAddr)) {
-					pTempDMM2 = pTempDMM;
-					pTempDMM = pTempDMM->next;
-				}
-				if (pTempDMM != NULL) {
-					pCtxtFound = 1;
-					status = DSP_SOK;
-				} else {
-					pCtxtList = pCtxtList->next;
-				}
-			}
-			if (pCtxtList == NULL)
-				status = DSP_ENOTFOUND;
-
-		}
-	} else{
-		status = DSP_SOK;
-	}
-	GT_0trace(curTrace, GT_ENTER, "2DRV_GetProcContext: 4");
-	*pCtxt = pCtxtList;
-	return status;
-}
-
-
 /* Add a new process context to process context list */
 DSP_STATUS DRV_InsertProcContext(struct DRV_OBJECT *hDrVObject, HANDLE hPCtxt)
 {
@@ -274,9 +203,19 @@ DSP_STATUS DRV_InsertProcContext(struct DRV_OBJECT *hDrVObject, HANDLE hPCtxt)
 	struct DRV_OBJECT	     *hDRVObject;
 
 	GT_0trace(curTrace, GT_ENTER, "\n In DRV_InsertProcContext\n");
+
 	status = CFG_GetObject((u32 *)&hDRVObject, REG_DRV_OBJECT);
 	DBC_Assert(hDRVObject != NULL);
+
 	*pCtxt = MEM_Calloc(1 * sizeof(struct PROCESS_CONTEXT), MEM_PAGED);
+	if (!*pCtxt) {
+		pr_err("DSP: MEM_Calloc failed in DRV_InsertProcContext\n");
+		return DSP_EMEMORY;
+	}
+
+	spin_lock_init(&(*pCtxt)->proc_list_lock);
+	INIT_LIST_HEAD(&(*pCtxt)->processor_list);
+
 	GT_0trace(curTrace, GT_ENTER,
 		 "\n In DRV_InsertProcContext Calling "
 		 "DRV_GetProcCtxtList\n");
@@ -303,36 +242,36 @@ DSP_STATUS DRV_InsertProcContext(struct DRV_OBJECT *hDrVObject, HANDLE hPCtxt)
 
 /* Delete a process context from process resource context list */
 DSP_STATUS DRV_RemoveProcContext(struct DRV_OBJECT *hDRVObject,
-				     HANDLE hPCtxt, HANDLE hProcess)
+		HANDLE pr_ctxt)
 {
 	DSP_STATUS status = DSP_SOK;
-	struct PROCESS_CONTEXT    *pCtxt2 = NULL;
-	struct PROCESS_CONTEXT    *pTmp = NULL;
-	struct PROCESS_CONTEXT    *pCtxtList = NULL;
+	struct PROCESS_CONTEXT *pr_ctxt_list = NULL;
+	struct PROCESS_CONTEXT *ptr_prev;
 
 	DBC_Assert(hDRVObject != NULL);
-	DRV_GetProcContext((u32)hProcess, hDRVObject, &pCtxt2, NULL, 0);
 
 	GT_0trace(curTrace, GT_ENTER, "DRV_RemoveProcContext: 12");
-	DRV_GetProcCtxtList(&pCtxtList, hDRVObject);
+	DRV_GetProcCtxtList(&pr_ctxt_list, hDRVObject);
+	ptr_prev = pr_ctxt_list;
+
 	GT_0trace(curTrace, GT_ENTER, "DRV_RemoveProcContext: 13");
-	pTmp = pCtxtList;
-	while ((pCtxtList != NULL) && (pCtxtList != pCtxt2)) {
-		pTmp = pCtxtList;
-		pCtxtList = pCtxtList->next;
+	while (pr_ctxt_list && (pr_ctxt_list != pr_ctxt)) {
+		ptr_prev = pr_ctxt_list;
+		pr_ctxt_list = pr_ctxt_list->next;
 		GT_0trace(curTrace, GT_ENTER,
 			 "DRV_RemoveProcContext: 2");
 	}
+
 	GT_0trace(curTrace, GT_ENTER, "DRV_RemoveProcContext: 3");
-	if (hDRVObject->procCtxtList == pCtxt2)
-		hDRVObject->procCtxtList = pCtxt2->next;
 
-	if (pCtxtList == NULL)
+	if (!pr_ctxt_list)
 		return DSP_ENOTFOUND;
-	else if (pTmp->next != NULL)
-		pTmp->next = pTmp->next->next;
+	else if (hDRVObject->procCtxtList == pr_ctxt_list)
+		hDRVObject->procCtxtList = pr_ctxt_list->next;
+	else
+		ptr_prev->next = pr_ctxt_list->next;
 
-	MEM_Free(pCtxt2);
+	MEM_Free(pr_ctxt);
 	GT_0trace(curTrace, GT_ENTER, "DRV_RemoveProcContext: 7");
 
 	return status;
@@ -1000,6 +939,7 @@ static DSP_STATUS PrintProcessInformation(void)
 	struct PROCESS_CONTEXT *pCtxtList = NULL;
 	struct NODE_RES_OBJECT *pNodeRes = NULL;
 	struct DMM_RES_OBJECT *pDMMRes = NULL;
+	struct PROC_OBJECT *proc_obj_ptr;
 	struct STRM_RES_OBJECT *pSTRMRes = NULL;
 	struct DSPHEAP_RES_OBJECT *pDSPHEAPRes = NULL;
 	DSP_STATUS status = DSP_SOK;
@@ -1028,11 +968,11 @@ static DSP_STATUS PrintProcessInformation(void)
 			GT_0trace(curTrace, GT_4CLASS, "\nThe Process"
 					" is in DeAllocated state\n");
 		}
-		GT_1trace(curTrace, GT_4CLASS, "\nThe  hProcessor"
-				" handle is: 0X%x\n",
-				(u32)pCtxtList->hProcessor);
-		if (pCtxtList->hProcessor != NULL) {
-			PROC_GetProcessorId(pCtxtList->hProcessor, &procID);
+
+		spin_lock(&pCtxtList->proc_list_lock);
+		list_for_each_entry(proc_obj_ptr, &pCtxtList->processor_list,
+				proc_object) {
+			PROC_GetProcessorId(proc_obj_ptr, &procID);
 			if (procID == DSP_UNIT) {
 				GT_0trace(curTrace, GT_4CLASS,
 					"\nProcess connected to"
@@ -1046,6 +986,8 @@ static DSP_STATUS PrintProcessInformation(void)
 					"\n***ERROR:Invalid Processor Id***\n");
 			}
 		}
+		spin_unlock(&pCtxtList->proc_list_lock);
+
 		pNodeRes = pCtxtList->pNodeList;
 		tempCount = 1;
 		while (pNodeRes != NULL) {
diff --git a/drivers/dsp/bridge/rmgr/drv_interface.c b/drivers/dsp/bridge/rmgr/drv_interface.c
index a8ddf7c..22e81bd 100644
--- a/drivers/dsp/bridge/rmgr/drv_interface.c
+++ b/drivers/dsp/bridge/rmgr/drv_interface.c
@@ -423,6 +423,7 @@ static int __devexit omap34xx_bridge_remove(struct platform_device *pdev)
 	HANDLE	     hDrvObject = NULL;
 	struct PROCESS_CONTEXT	*pTmp = NULL;
 	struct PROCESS_CONTEXT    *pCtxtclosed = NULL;
+	struct PROC_OBJECT *proc_obj_ptr, *temp;
 
 	GT_0trace(driverTrace, GT_ENTER, "-> driver_exit\n");
 
@@ -445,10 +446,13 @@ static int __devexit omap34xx_bridge_remove(struct platform_device *pdev)
 		GT_1trace(driverTrace, GT_5CLASS, "***Cleanup of "
 			 "process***%d\n", pCtxtclosed->pid);
 		DRV_RemoveAllResources(pCtxtclosed);
-		PROC_Detach(pCtxtclosed->hProcessor, pCtxtclosed);
+		list_for_each_entry_safe(proc_obj_ptr, temp,
+				&pCtxtclosed->processor_list, proc_object) {
+			PROC_Detach(proc_obj_ptr, pCtxtclosed);
+		}
 		pTmp = pCtxtclosed->next;
 		DRV_RemoveProcContext((struct DRV_OBJECT *)hDrvObject,
-				     pCtxtclosed, (void *)pCtxtclosed->pid);
+				     pCtxtclosed);
 		pCtxtclosed = pTmp;
 	}
 
@@ -581,6 +585,7 @@ static int bridge_release(struct inode *ip, struct file *filp)
 	DSP_STATUS dsp_status;
 	HANDLE hDrvObject;
 	struct PROCESS_CONTEXT *pr_ctxt;
+	struct PROC_OBJECT *proc_obj_ptr, *temp;
 
 	GT_0trace(driverTrace, GT_ENTER, "-> bridge_release\n");
 
@@ -592,10 +597,13 @@ static int bridge_release(struct inode *ip, struct file *filp)
 		if (DSP_SUCCEEDED(dsp_status)) {
 			flush_signals(current);
 			DRV_RemoveAllResources(pr_ctxt);
-			if (pr_ctxt->hProcessor)
-				PROC_Detach(pr_ctxt->hProcessor, pr_ctxt);
+			list_for_each_entry_safe(proc_obj_ptr, temp,
+					&pr_ctxt->processor_list,
+					proc_object) {
+				PROC_Detach(proc_obj_ptr, pr_ctxt);
+			}
 			DRV_RemoveProcContext((struct DRV_OBJECT *)hDrvObject,
-					pr_ctxt, (void *)pr_ctxt->pid);
+					pr_ctxt);
 		} else {
 			status = -EIO;
 		}
diff --git a/drivers/dsp/bridge/rmgr/node.c b/drivers/dsp/bridge/rmgr/node.c
index d36dccc..9127751 100644
--- a/drivers/dsp/bridge/rmgr/node.c
+++ b/drivers/dsp/bridge/rmgr/node.c
@@ -417,11 +417,7 @@ DSP_STATUS NODE_Allocate(struct PROC_OBJECT *hProcessor,
 #endif
 
 #ifndef RES_CLEANUP_DISABLE
-	HANDLE	     hDrvObject;
 	HANDLE	     nodeRes;
-       u32                  hProcess;
-	struct PROCESS_CONTEXT   *pPctxt = NULL;
-	DSP_STATUS res_status = DSP_SOK;
 #endif
 
 	DBC_Require(cRefs > 0);
@@ -782,45 +778,9 @@ func_cont2:
 
 #ifndef RES_CLEANUP_DISABLE
 	if (DSP_SUCCEEDED(status)) {
-               /* Return TGID instead of process handle */
-               hProcess = current->tgid;
-
-		res_status = CFG_GetObject((u32 *)&hDrvObject,
-					  REG_DRV_OBJECT);
-		if (DSP_SUCCEEDED(res_status)) {
-                       DRV_GetProcContext(hProcess,
-					 (struct DRV_OBJECT *)hDrvObject,
-					 &pPctxt, *phNode, 0);
-			if (pPctxt == NULL) {
-				DRV_InsertProcContext(
-					(struct DRV_OBJECT *)hDrvObject,
-					&pPctxt);
-				if (pPctxt != NULL) {
-					DRV_ProcUpdatestate(pPctxt,
-							PROC_RES_ALLOCATED);
-                                       DRV_ProcSetPID(pPctxt, hProcess);
-					pPctxt->hProcessor =
-						 (DSP_HPROCESSOR)hProcessor;
-				}
-			}
-		}
-	}
-	if (DSP_SUCCEEDED(status)) {
-               /* Return TGID instead of process handle */
-               hProcess = current->tgid;
-		res_status = CFG_GetObject((u32 *)&hDrvObject,
-					REG_DRV_OBJECT);
-		if (DSP_SUCCEEDED(res_status)) {
-                       DRV_GetProcContext(hProcess,
-					 (struct DRV_OBJECT *)hDrvObject,
-					 &pPctxt, *phNode, 0);
-			if (pPctxt != NULL) {
-				DRV_InsertNodeResElement(*phNode, &nodeRes,
-							 pPctxt);
-				DRV_ProcNodeUpdateHeapStatus(nodeRes, true);
-				DRV_ProcNodeUpdateStatus(nodeRes, true);
-			}
-		}
+		DRV_InsertNodeResElement(*phNode, &nodeRes, pr_ctxt);
+		DRV_ProcNodeUpdateHeapStatus(nodeRes, true);
+		DRV_ProcNodeUpdateStatus(nodeRes, true);
 	}
 #endif
 	DBC_Ensure((DSP_FAILED(status) && (*phNode == NULL)) ||
@@ -1640,11 +1600,7 @@ DSP_STATUS NODE_Delete(struct NODE_OBJECT *hNode,
 	struct WMD_DRV_INTERFACE *pIntfFxns;
 
 #ifndef RES_CLEANUP_DISABLE
-       u32                     hProcess;
 	HANDLE		nodeRes;
-	HANDLE		hDrvObject;
-	struct PROCESS_CONTEXT *pCtxt = NULL;
-	DSP_STATUS res_status = DSP_SOK;
 #endif
 	struct DSP_PROCESSORSTATE procStatus;
 	DBC_Require(cRefs > 0);
@@ -1770,16 +1726,9 @@ func_cont1:
 	 /*  Free host-side resources allocated by NODE_Create()
 	 *  DeleteNode() fails if SM buffers not freed by client!  */
 #ifndef RES_CLEANUP_DISABLE
-       /* Return TGID instead of process handle */
-       hProcess = current->tgid;
-	res_status = CFG_GetObject((u32 *)&hDrvObject, REG_DRV_OBJECT);
-	if (DSP_FAILED(res_status))
-		goto func_cont;
-	DRV_GetProcContext(0, (struct DRV_OBJECT *)hDrvObject,
-						&pCtxt, hNode, 0);
-	if (pCtxt == NULL)
+	if (!pr_ctxt)
 		goto func_cont;
-	if (DRV_GetNodeResElement(hNode, &nodeRes, pCtxt) != DSP_ENOTFOUND) {
+	if (DRV_GetNodeResElement(hNode, &nodeRes, pr_ctxt) != DSP_ENOTFOUND) {
 		GT_0trace(NODE_debugMask, GT_5CLASS, "\nNODE_Delete12:\n");
 		DRV_ProcNodeUpdateStatus(nodeRes, false);
 	}
@@ -1789,8 +1738,8 @@ func_cont:
 	DeleteNode(hNode, pr_ctxt);
 #ifndef RES_CLEANUP_DISABLE
 	GT_0trace(NODE_debugMask, GT_5CLASS, "\nNODE_Delete2:\n ");
-	if (pCtxt != NULL)
-		DRV_RemoveNodeResElement(nodeRes, (HANDLE)pCtxt);
+	if (pr_ctxt)
+		DRV_RemoveNodeResElement(nodeRes, pr_ctxt);
 #endif
 	GT_0trace(NODE_debugMask, GT_ENTER, "\nNODE_Delete3:\n ");
 	/* Exit critical section */
diff --git a/drivers/dsp/bridge/rmgr/proc.c b/drivers/dsp/bridge/rmgr/proc.c
index 270d022..6f46a36 100644
--- a/drivers/dsp/bridge/rmgr/proc.c
+++ b/drivers/dsp/bridge/rmgr/proc.c
@@ -160,27 +160,6 @@
 #define EXTEND	      "_EXT_END"	/* Extmem end addr in DSP binary */
 
 extern char *iva_img;
-/* The PROC_OBJECT structure.   */
-struct PROC_OBJECT {
-	struct LST_ELEM link;		/* Link to next PROC_OBJECT */
-	u32 dwSignature;	/* Used for object validation */
-	struct DEV_OBJECT *hDevObject;	/* Device this PROC represents */
-	u32 hProcess;   /* Process owning this Processor */
-	struct MGR_OBJECT *hMgrObject;	/* Manager Object Handle */
-	u32 uAttachCount;	/* Processor attach count */
-	u32 uProcessor;	/* Processor number */
-	u32 uTimeout;		/* Time out count */
-	enum DSP_PROCSTATE sState;	/* Processor state */
-	u32 ulUnit;		/* DDSP unit number */
-	bool bIsAlreadyAttached;	/*
-					 * True if the Device below has
-					 * GPP Client attached
-					 */
-	struct NTFY_OBJECT *hNtfy;	/* Manages  notifications */
-	struct WMD_DEV_CONTEXT *hWmdContext;	/* WMD Context Handle */
-	struct WMD_DRV_INTERFACE *pIntfFxns;	/* Function interface to WMD */
-	char *g_pszLastCoff;
-} ;
 
 /*  ----------------------------------- Globals */
 #if GT_TRACE
@@ -207,24 +186,32 @@ static char **PrependEnvp(char **newEnvp, char **envp, s32 cEnvp, s32 cNewEnvp,
 DSP_STATUS PROC_CleanupAllResources(void)
 {
 	DSP_STATUS dsp_status = DSP_SOK;
-	HANDLE	     hDrvObject = NULL;
-	struct PROCESS_CONTEXT    *pCtxtclosed = NULL;
+	HANDLE hDrvObject = NULL;
+	struct PROCESS_CONTEXT *pCtxtclosed = NULL;
+	struct PROC_OBJECT *proc_obj_ptr, *temp;
+
 	GT_0trace(PROC_DebugMask, GT_ENTER, "PROC_CleanupAllResources\n");
+
 	dsp_status = CFG_GetObject((u32 *)&hDrvObject, REG_DRV_OBJECT);
 	if (DSP_FAILED(dsp_status))
 		goto func_end;
+
 	DRV_GetProcCtxtList(&pCtxtclosed, (struct DRV_OBJECT *)hDrvObject);
+
 	while (pCtxtclosed != NULL) {
 		if (current->tgid != pCtxtclosed->pid) {
 			GT_1trace(PROC_DebugMask, GT_5CLASS,
 				 "***Cleanup of "
 				 "process***%d\n", pCtxtclosed->pid);
-			if (pCtxtclosed->hProcessor)
-				PROC_Detach(pCtxtclosed->hProcessor,
-						pCtxtclosed);
+			list_for_each_entry_safe(proc_obj_ptr, temp,
+					&pCtxtclosed->processor_list,
+					proc_object) {
+				PROC_Detach(proc_obj_ptr, pCtxtclosed);
+			}
 		}
 		pCtxtclosed = pCtxtclosed->next;
 	}
+
 	WMD_DEH_ReleaseDummyMem();
 func_end:
 	return dsp_status;
@@ -247,19 +234,13 @@ PROC_Attach(u32 uProcessor, OPTIONAL CONST struct DSP_PROCESSORATTRIN *pAttrIn,
 	struct DRV_OBJECT *hDrvObject = NULL;
 	u32 devType;
 
-#ifndef RES_CLEANUP_DISABLE
-	HANDLE	     hDRVObject;
-       u32                  hProcess;
-	DSP_STATUS res_status = DSP_SOK;
-	struct PROCESS_CONTEXT   *pPctxt = NULL;
-#endif
-
 	DBC_Require(cRefs > 0);
 	DBC_Require(phProcessor != NULL);
 
 	GT_3trace(PROC_DebugMask, GT_ENTER, "Entered PROC_Attach, args:\n\t"
 		 "uProcessor:  0x%x\n\tpAttrIn:  0x%x\n\tphProcessor:"
 		 "0x%x\n", uProcessor, pAttrIn, phProcessor);
+
 	/* Get the Driver and Manager Object Handles */
 	status = CFG_GetObject((u32 *)&hDrvObject, REG_DRV_OBJECT);
 	if (DSP_SUCCEEDED(status)) {
@@ -308,9 +289,10 @@ PROC_Attach(u32 uProcessor, OPTIONAL CONST struct DSP_PROCESSORATTRIN *pAttrIn,
 	pProcObject->hDevObject = hDevObject;
 	pProcObject->hMgrObject = hMgrObject;
 	pProcObject->uProcessor = devType;
-	/* Get Caller Process and store it */
-       /* Return TGID instead of process handle */
-       pProcObject->hProcess = current->tgid;
+	/* Store TGID instead of process handle */
+	pProcObject->hProcess = current->tgid;
+
+	INIT_LIST_HEAD(&pProcObject->proc_object);
 
 	if (pAttrIn)
 		pProcObject->uTimeout = pAttrIn->uTimeout;
@@ -381,41 +363,12 @@ PROC_Attach(u32 uProcessor, OPTIONAL CONST struct DSP_PROCESSORATTRIN *pAttrIn,
 			 "storage for notification \n");
 		MEM_FreeObject(pProcObject);
 	}
-func_end:
 #ifndef RES_CLEANUP_DISABLE
-	if (DSP_FAILED(status))
-		goto func_cont;
-
-       /* Return TGID instead of process handle */
-       hProcess = current->tgid;
-
-	res_status = CFG_GetObject((u32 *)&hDRVObject, REG_DRV_OBJECT);
-	if (DSP_FAILED(res_status))
-		goto func_cont;
-
-       DRV_GetProcContext(hProcess, (struct DRV_OBJECT *)hDRVObject,
-			 &pPctxt, NULL, 0);
-	if (pPctxt == NULL) {
-		DRV_InsertProcContext((struct DRV_OBJECT *)hDRVObject, &pPctxt);
-		if (pPctxt != NULL) {
-			DRV_ProcUpdatestate(pPctxt, PROC_RES_ALLOCATED);
-                       DRV_ProcSetPID(pPctxt, hProcess);
-		}
-	}
-func_cont:
-       /* Return TGID instead of process handle */
-       hProcess = current->tgid;
-
-	res_status = CFG_GetObject((u32 *)&hDRVObject, REG_DRV_OBJECT);
-	if (DSP_SUCCEEDED(res_status)) {
-                       DRV_GetProcContext(hProcess,
-				 (struct DRV_OBJECT *)hDRVObject, &pPctxt,
-				 NULL, 0);
-		if (pPctxt != NULL)
-			pPctxt->hProcessor = (DSP_HPROCESSOR)*phProcessor;
-
-	}
+	spin_lock(&pr_ctxt->proc_list_lock);
+	list_add(&pProcObject->proc_object, &pr_ctxt->processor_list);
+	spin_unlock(&pr_ctxt->proc_list_lock);
 #endif
+func_end:
 	DBC_Ensure((status == DSP_EFAIL && *phProcessor == NULL) ||
 		  (DSP_SUCCEEDED(status) &&
 		  MEM_IsValidHandle(pProcObject, PROC_SIGNATURE)) ||
@@ -641,27 +594,17 @@ DSP_STATUS PROC_Detach(DSP_HPROCESSOR hProcessor,
 {
 	DSP_STATUS status = DSP_SOK;
 	struct PROC_OBJECT *pProcObject = (struct PROC_OBJECT *)hProcessor;
-#ifndef RES_CLEANUP_DISABLE
-	HANDLE hDRVObject;
-       u32 hProcess;
-	DSP_STATUS res_status = DSP_SOK;
-	struct PROCESS_CONTEXT   *pPctxt = NULL;
-#endif
+
 	DBC_Require(cRefs > 0);
 	GT_1trace(PROC_DebugMask, GT_ENTER, "Entered PROC_Detach, args:\n\t"
 		 "hProcessor:  0x%x\n", hProcessor);
 
 	if (MEM_IsValidHandle(pProcObject, PROC_SIGNATURE)) {
 #ifndef RES_CLEANUP_DISABLE
-		/* Return TGID instead of process handle */
-		hProcess = pProcObject->hProcess;
-		res_status = CFG_GetObject((u32 *)&hDRVObject, REG_DRV_OBJECT);
-		if (DSP_SUCCEEDED(res_status)) {
-			DRV_GetProcContext(hProcess,
-				(struct DRV_OBJECT *)hDRVObject, &pPctxt,
-					 NULL, 0);
-			if (pPctxt != NULL)
-				pPctxt->hProcessor = NULL;
+		if (pr_ctxt) {
+			spin_lock(&pr_ctxt->proc_list_lock);
+			list_del(&pProcObject->proc_object);
+			spin_unlock(&pr_ctxt->proc_list_lock);
 		}
 #endif
 		/* Notify the Client */
@@ -1429,11 +1372,7 @@ DSP_STATUS PROC_Map(DSP_HPROCESSOR hProcessor, void *pMpuAddr, u32 ulSize,
 	struct PROC_OBJECT *pProcObject = (struct PROC_OBJECT *)hProcessor;
 
 #ifndef RES_CLEANUP_DISABLE
-       u32               hProcess;
-       HANDLE        pCtxt = NULL;
-       HANDLE        hDrvObject;
        HANDLE        dmmRes;
-       DSP_STATUS res_status = DSP_SOK;
 #endif
 
 	GT_6trace(PROC_DebugMask, GT_ENTER, "Entered PROC_Map, args:\n\t"
@@ -1483,22 +1422,9 @@ DSP_STATUS PROC_Map(DSP_HPROCESSOR hProcessor, void *pMpuAddr, u32 ulSize,
 
 #ifndef RES_CLEANUP_DISABLE
 	if (DSP_SUCCEEDED(status)) {
-		/* Update the node and stream resource status */
-               /* Return TGID instead of process handle */
-               hProcess = current->tgid;
-
-		res_status = CFG_GetObject((u32 *)&hDrvObject,
-					  REG_DRV_OBJECT);
-		if (DSP_SUCCEEDED(res_status)) {
-                       if (DRV_GetProcContext(hProcess,
-                               (struct DRV_OBJECT *)hDrvObject, &pCtxt, NULL,
-                                       (u32)pMpuAddr) != DSP_ENOTFOUND) {
-				DRV_InsertDMMResElement(&dmmRes, pCtxt);
-				DRV_UpdateDMMResElement(dmmRes, (u32)pMpuAddr,
-						ulSize, (u32)pReqAddr,
-						(u32)*ppMapAddr, hProcessor);
-			}
-		}
+		DRV_InsertDMMResElement(&dmmRes, pr_ctxt);
+		DRV_UpdateDMMResElement(dmmRes, (u32)pMpuAddr, ulSize,
+				(u32)pReqAddr, (u32)*ppMapAddr, hProcessor);
 	}
 #endif
 func_end:
@@ -1821,11 +1747,7 @@ DSP_STATUS PROC_UnMap(DSP_HPROCESSOR hProcessor, void *pMapAddr,
 	u32 vaAlign;
 	u32 sizeAlign;
 #ifndef RES_CLEANUP_DISABLE
-       u32                   hProcess;
-	HANDLE	      pCtxt = NULL;
-	HANDLE	      hDrvObject;
 	HANDLE	      dmmRes;
-	DSP_STATUS res_status = DSP_SOK;
 #endif
 	GT_2trace(PROC_DebugMask, GT_ENTER,
 		 "Entered PROC_UnMap, args:\n\thProcessor:"
@@ -1866,23 +1788,11 @@ DSP_STATUS PROC_UnMap(DSP_HPROCESSOR hProcessor, void *pMapAddr,
 	if (DSP_FAILED(status))
 		goto func_end;
 
-	/* Update the node and stream resource status */
-       /* Return TGID instead of process handle */
-       hProcess = current->tgid;
-
-	res_status = CFG_GetObject((u32 *)&hDrvObject, REG_DRV_OBJECT);
-	if (DSP_FAILED(res_status))
-		goto func_end;
-
-       DRV_GetProcContext(hProcess, (struct DRV_OBJECT *)hDrvObject,
-			 &pCtxt, NULL, (u32)pMapAddr);
-	if (pCtxt != NULL) {
-		if (DRV_GetDMMResElement((u32)pMapAddr, &dmmRes, pCtxt) !=
-		   DSP_ENOTFOUND)
-			DRV_RemoveDMMResElement(dmmRes, pCtxt);
-	}
-func_end:
+	if (pr_ctxt && DRV_GetDMMResElement((u32)pMapAddr, &dmmRes, pr_ctxt)
+							!= DSP_ENOTFOUND)
+		DRV_RemoveDMMResElement(dmmRes, pr_ctxt);
 #endif
+func_end:
 	GT_1trace(PROC_DebugMask, GT_ENTER,
 		 "Leaving PROC_UnMap [0x%x]", status);
 	return status;
diff --git a/drivers/dsp/bridge/rmgr/strm.c b/drivers/dsp/bridge/rmgr/strm.c
index d0bbf6a..7413dc6 100644
--- a/drivers/dsp/bridge/rmgr/strm.c
+++ b/drivers/dsp/bridge/rmgr/strm.c
@@ -159,13 +159,9 @@ DSP_STATUS STRM_AllocateBuffer(struct STRM_OBJECT *hStrm, u32 uSize,
 	DSP_STATUS status = DSP_SOK;
 	u32 uAllocated = 0;
 	u32 i;
-	#ifndef RES_CLEANUP_DISABLE
-	DSP_STATUS res_status = DSP_SOK;
-       u32                  hProcess;
-	HANDLE	     pCtxt = NULL;
-	HANDLE	     hDrvObject;
+#ifndef RES_CLEANUP_DISABLE
 	HANDLE hSTRMRes;
-	#endif
+#endif
 	DBC_Require(cRefs > 0);
 	DBC_Require(apBuffer != NULL);
 
@@ -203,21 +199,9 @@ DSP_STATUS STRM_AllocateBuffer(struct STRM_OBJECT *hStrm, u32 uSize,
 	if (DSP_FAILED(status))
 		goto func_end;
 
-       /* Return TGID instead of process handle */
-       hProcess = current->tgid;
-
-	res_status = CFG_GetObject((u32 *)&hDrvObject, REG_DRV_OBJECT);
-	if (DSP_FAILED(res_status))
-		goto func_end;
-
-       DRV_GetProcContext(hProcess, (struct DRV_OBJECT *)hDrvObject,
-			 &pCtxt, NULL, 0);
-	if (pCtxt != NULL) {
-		if (DRV_GetSTRMResElement(hStrm, &hSTRMRes, pCtxt) !=
-		   DSP_ENOTFOUND) {
-			DRV_ProcUpdateSTRMRes(uNumBufs, hSTRMRes, pCtxt);
-		}
-	}
+	if (DRV_GetSTRMResElement(hStrm, &hSTRMRes, pr_ctxt) !=
+			DSP_ENOTFOUND)
+		DRV_ProcUpdateSTRMRes(uNumBufs, hSTRMRes, pr_ctxt);
 #endif
 func_end:
 	return status;
@@ -235,16 +219,10 @@ DSP_STATUS STRM_Close(struct STRM_OBJECT *hStrm,
 	struct CHNL_INFO chnlInfo;
 	DSP_STATUS status = DSP_SOK;
 
-
 #ifndef RES_CLEANUP_DISABLE
-    u32                      hProcess;
-    HANDLE	      pCtxt = NULL;
-    HANDLE	      hDrvObject;
     HANDLE	      hSTRMRes;
-    DSP_STATUS	  res_status = DSP_SOK;
 #endif
 
-
 	DBC_Require(cRefs > 0);
 
 	GT_1trace(STRM_debugMask, GT_ENTER, "STRM_Close: hStrm: 0x%x\n", hStrm);
@@ -277,22 +255,9 @@ DSP_STATUS STRM_Close(struct STRM_OBJECT *hStrm,
 	if (DSP_FAILED(status))
 		goto func_end;
 
-	/* Update the node and stream resource status */
-       /* Return TGID instead of process handle */
-       hProcess = current->tgid;
-
-	res_status = CFG_GetObject((u32 *)&hDrvObject, REG_DRV_OBJECT);
-	if (DSP_FAILED(res_status))
-		goto func_end;
-
-       DRV_GetProcContext(hProcess, (struct DRV_OBJECT *)hDrvObject,
-			 &pCtxt, NULL, 0);
-	if (pCtxt != NULL) {
-		if (DRV_GetSTRMResElement(hStrm, &hSTRMRes, pCtxt) !=
-		   DSP_ENOTFOUND) {
-			DRV_ProcRemoveSTRMResElement(hSTRMRes, pCtxt);
-		}
-	}
+	if (DRV_GetSTRMResElement(hStrm, &hSTRMRes, pr_ctxt) !=
+			DSP_ENOTFOUND)
+		DRV_ProcRemoveSTRMResElement(hSTRMRes, pr_ctxt);
 func_end:
 #endif
 	DBC_Ensure(status == DSP_SOK || status == DSP_EHANDLE ||
@@ -400,13 +365,9 @@ DSP_STATUS STRM_FreeBuffer(struct STRM_OBJECT *hStrm, u8 **apBuffer,
 	DSP_STATUS status = DSP_SOK;
 	u32 i = 0;
 
-	#ifndef RES_CLEANUP_DISABLE
-	DSP_STATUS res_status = DSP_SOK;
-       u32                  hProcess;
-	HANDLE	     pCtxt = NULL;
-	HANDLE	     hDrvObject;
-	HANDLE 		    hSTRMRes = NULL;
-	#endif
+#ifndef RES_CLEANUP_DISABLE
+	HANDLE hSTRMRes = NULL;
+#endif
 	DBC_Require(cRefs > 0);
 	DBC_Require(apBuffer != NULL);
 
@@ -430,23 +391,9 @@ DSP_STATUS STRM_FreeBuffer(struct STRM_OBJECT *hStrm, u8 **apBuffer,
 		}
 	}
 #ifndef RES_CLEANUP_DISABLE
-	/* Update the node and stream resource status */
-       /* Return TGID instead of process handle */
-       hProcess = current->tgid;
-
-	res_status = CFG_GetObject((u32 *)&hDrvObject, REG_DRV_OBJECT);
-	if (DSP_SUCCEEDED(res_status)) {
-               DRV_GetProcContext(hProcess,
-				 (struct DRV_OBJECT *)hDrvObject, &pCtxt,
-				 NULL, 0);
-		if (pCtxt != NULL) {
-			if (DRV_GetSTRMResElement(hStrm, hSTRMRes, pCtxt) !=
-			   DSP_ENOTFOUND) {
-				DRV_ProcUpdateSTRMRes(uNumBufs-i, hSTRMRes,
-						     pCtxt);
-			}
-		}
-	}
+	if (DRV_GetSTRMResElement(hStrm, hSTRMRes, pr_ctxt) !=
+			DSP_ENOTFOUND)
+		DRV_ProcUpdateSTRMRes(uNumBufs-i, hSTRMRes, pr_ctxt);
 #endif
 	return status;
 }
@@ -640,13 +587,9 @@ DSP_STATUS STRM_Open(struct NODE_OBJECT *hNode, u32 uDir, u32 uIndex,
 	DSP_STATUS status = DSP_SOK;
 	struct CMM_OBJECT *hCmmMgr = NULL;	/* Shared memory manager hndl */
 
-	#ifndef RES_CLEANUP_DISABLE
-	DSP_STATUS res_status = DSP_SOK;
-       u32                  hProcess;
-	HANDLE	     pCtxt = NULL;
-	HANDLE	     hDrvObject;
-	HANDLE 		    hSTRMRes;
-	#endif
+#ifndef RES_CLEANUP_DISABLE
+	HANDLE hSTRMRes;
+#endif
 	DBC_Require(cRefs > 0);
 	DBC_Require(phStrm != NULL);
 	DBC_Require(pAttr != NULL);
@@ -782,18 +725,7 @@ func_cont:
 		(void)DeleteStrm(pStrm);
 
 #ifndef RES_CLEANUP_DISABLE
-       /* Return TGID instead of process handle */
-       hProcess = current->tgid;
-
-	res_status = CFG_GetObject((u32 *)&hDrvObject, REG_DRV_OBJECT);
-	if (DSP_SUCCEEDED(res_status)) {
-               DRV_GetProcContext(hProcess,
-				 (struct DRV_OBJECT *)hDrvObject, &pCtxt,
-				 hNode, 0);
-		if (pCtxt != NULL)
-			DRV_ProcInsertSTRMResElement(*phStrm, &hSTRMRes, pCtxt);
-
-	}
+	DRV_ProcInsertSTRMResElement(*phStrm, &hSTRMRes, pr_ctxt);
 #endif
 
 	 /* ensure we return a documented error code */
-- 
1.6.2.4

