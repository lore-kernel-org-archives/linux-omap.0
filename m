From: Ameya Palande <ameya.palande@nokia.com>
Subject: [PATCH 04/13] DSPBRIDGE: Use pr_ctxt in PROC_UnMap and NODE_Delete
Date: Tue, 11 Aug 2009 04:21:45 +0300
Message-ID: <1249953714-20972-5-git-send-email-ameya.palande@nokia.com>
References: <1249953714-20972-1-git-send-email-ameya.palande@nokia.com>
 <1249953714-20972-2-git-send-email-ameya.palande@nokia.com>
 <1249953714-20972-3-git-send-email-ameya.palande@nokia.com>
 <1249953714-20972-4-git-send-email-ameya.palande@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:28866 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753076AbZHKBWO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 Aug 2009 21:22:14 -0400
In-Reply-To: <1249953714-20972-4-git-send-email-ameya.palande@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: hiroshi.doyu@nokia.com, omar.ramirez@ti.com, x0095840@ti.com, suyog@ti.com, roman.tereshonkov@nokia.com, ernesto@ti.com

Signed-off-by: Ameya Palande <ameya.palande@nokia.com>
---
 arch/arm/plat-omap/include/dspbridge/node.h |    3 +-
 arch/arm/plat-omap/include/dspbridge/proc.h |    3 +-
 drivers/dsp/bridge/pmgr/wcd.c               |    4 +-
 drivers/dsp/bridge/rmgr/drv.c               |    8 +++--
 drivers/dsp/bridge/rmgr/node.c              |   37 +++++++++++----------------
 drivers/dsp/bridge/rmgr/proc.c              |   29 ++++++---------------
 6 files changed, 34 insertions(+), 50 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/node.h b/arch/arm/plat-omap/include/dspbridge/node.h
index db3be05..e8952f5 100644
--- a/arch/arm/plat-omap/include/dspbridge/node.h
+++ b/arch/arm/plat-omap/include/dspbridge/node.h
@@ -309,7 +309,8 @@
  *  Ensures:
  *      DSP_SOK:            hNode is invalid.
  */
-	extern DSP_STATUS NODE_Delete(struct NODE_OBJECT *hNode);
+	extern DSP_STATUS NODE_Delete(struct NODE_OBJECT *hNode,
+			struct PROCESS_CONTEXT *pr_ctxt);
 
 /*
  *  ======== NODE_DeleteMgr ========
diff --git a/arch/arm/plat-omap/include/dspbridge/proc.h b/arch/arm/plat-omap/include/dspbridge/proc.h
index ff1573f..832b518 100644
--- a/arch/arm/plat-omap/include/dspbridge/proc.h
+++ b/arch/arm/plat-omap/include/dspbridge/proc.h
@@ -623,7 +623,8 @@
  *  Ensures:
  *  Details:
  */
-	extern DSP_STATUS PROC_UnMap(DSP_HPROCESSOR hProcessor, void *pMapAddr);
+	extern DSP_STATUS PROC_UnMap(DSP_HPROCESSOR hProcessor, void *pMapAddr,
+			struct PROCESS_CONTEXT *pr_ctxt);
 
 /*
  *  ======== PROC_UnReserveMemory ========
diff --git a/drivers/dsp/bridge/pmgr/wcd.c b/drivers/dsp/bridge/pmgr/wcd.c
index bf8f672..a574278 100644
--- a/drivers/dsp/bridge/pmgr/wcd.c
+++ b/drivers/dsp/bridge/pmgr/wcd.c
@@ -1094,7 +1094,7 @@ u32 PROCWRAP_UnMap(union Trapped_Args *args, void *pr_ctxt)
 
 	GT_0trace(WCD_debugMask, GT_ENTER, "PROCWRAP_UnMap: entered\n");
 	status = PROC_UnMap(args->ARGS_PROC_UNMAPMEM.hProcessor,
-			   args->ARGS_PROC_UNMAPMEM.pMapAddr);
+			   args->ARGS_PROC_UNMAPMEM.pMapAddr, pr_ctxt);
 	return status;
 }
 
@@ -1296,7 +1296,7 @@ u32 NODEWRAP_Delete(union Trapped_Args *args, void *pr_ctxt)
 	u32 retVal;
 
 	GT_0trace(WCD_debugMask, GT_ENTER, "NODEWRAP_Delete: entered\n");
-	retVal = NODE_Delete(args->ARGS_NODE_DELETE.hNode);
+	retVal = NODE_Delete(args->ARGS_NODE_DELETE.hNode, pr_ctxt);
 
 	return retVal;
 }
diff --git a/drivers/dsp/bridge/rmgr/drv.c b/drivers/dsp/bridge/rmgr/drv.c
index 66e4a4d..4a4ebfa 100644
--- a/drivers/dsp/bridge/rmgr/drv.c
+++ b/drivers/dsp/bridge/rmgr/drv.c
@@ -453,13 +453,15 @@ static DSP_STATUS DRV_ProcFreeNodeRes(HANDLE hPCtxt)
 					GT_1trace(curTrace, GT_5CLASS,
 						 "Calling Node_Delete for Node:"
 						 " 0x%x\n", pNodeRes->hNode);
-					status = NODE_Delete(pNodeRes->hNode);
+					status = NODE_Delete(pNodeRes->hNode,
+							pCtxt);
 					GT_1trace(curTrace, GT_5CLASS,
 					"the status after the NodeDelete %x\n",
 					status);
 				} else if ((nState == NODE_ALLOCATED)
 					|| (nState == NODE_CREATED))
-					status = NODE_Delete(pNodeRes->hNode);
+					status = NODE_Delete(pNodeRes->hNode,
+							pCtxt);
 			}
 		}
 	}
@@ -571,7 +573,7 @@ DSP_STATUS  DRV_ProcFreeDMMRes(HANDLE hPCtxt)
 		pDMMList = pDMMList->next;
 		if (pDMMRes->dmmAllocated) {
 			status = PROC_UnMap(pDMMRes->hProcessor,
-				 (void *)pDMMRes->ulDSPResAddr);
+				 (void *)pDMMRes->ulDSPResAddr, pCtxt);
 			status = PROC_UnReserveMemory(pDMMRes->hProcessor,
 				 (void *)pDMMRes->ulDSPResAddr);
 			pDMMRes->dmmAllocated = 0;
diff --git a/drivers/dsp/bridge/rmgr/node.c b/drivers/dsp/bridge/rmgr/node.c
index a6d4d25..d3f0e34 100644
--- a/drivers/dsp/bridge/rmgr/node.c
+++ b/drivers/dsp/bridge/rmgr/node.c
@@ -322,7 +322,8 @@ static struct DSP_BUFFERATTR NODE_DFLTBUFATTRS = {
 	0, 			/* uAlignment */
 };
 
-static void DeleteNode(struct NODE_OBJECT *hNode);
+static void DeleteNode(struct NODE_OBJECT *hNode,
+		struct PROCESS_CONTEXT *pr_ctxt);
 static void DeleteNodeMgr(struct NODE_MGR *hNodeMgr);
 static void FillStreamConnect(struct NODE_OBJECT *hNode1,
 			     struct NODE_OBJECT *hNode2, u32 uStream1,
@@ -780,7 +781,7 @@ func_cont2:
 	} else {
 		/* Cleanup */
 		if (pNode)
-			DeleteNode(pNode);
+			DeleteNode(pNode, pr_ctxt);
 
 	}
 
@@ -1608,7 +1609,8 @@ DSP_STATUS NODE_CreateMgr(OUT struct NODE_MGR **phNodeMgr,
  *      Loads the node's delete function if necessary. Free GPP side resources
  *      after node's delete function returns.
  */
-DSP_STATUS NODE_Delete(struct NODE_OBJECT *hNode)
+DSP_STATUS NODE_Delete(struct NODE_OBJECT *hNode,
+		struct PROCESS_CONTEXT *pr_ctxt)
 {
 	struct NODE_OBJECT *pNode = (struct NODE_OBJECT *)hNode;
 	struct NODE_MGR *hNodeMgr;
@@ -1624,11 +1626,7 @@ DSP_STATUS NODE_Delete(struct NODE_OBJECT *hNode)
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
@@ -1754,27 +1752,20 @@ func_cont1:
 	 /*  Free host-side resources allocated by NODE_Create()
 	 *  DeleteNode() fails if SM buffers not freed by client!  */
 #ifndef RES_CLEANUP_DISABLE
-	/* Return TGID instead of process handle */
-	hProcess = current->tgid;
-	res_status = CFG_GetObject((u32 *)&hDrvObject, REG_DRV_OBJECT);
-	if (DSP_FAILED(res_status))
+	if (!pr_ctxt)
 		goto func_cont;
-	DRV_GetProcContext(0, (struct DRV_OBJECT *)hDrvObject,
-						&pCtxt, hNode, 0);
-	if (pCtxt == NULL)
-		goto func_cont;
-	if (DRV_GetNodeResElement(hNode, &nodeRes, pCtxt) != DSP_ENOTFOUND) {
+	if (DRV_GetNodeResElement(hNode, &nodeRes, pr_ctxt) != DSP_ENOTFOUND) {
 		GT_0trace(NODE_debugMask, GT_5CLASS, "\nNODE_Delete12:\n");
 		DRV_ProcNodeUpdateStatus(nodeRes, false);
 	}
 #endif
 func_cont:
 	GT_0trace(NODE_debugMask, GT_ENTER, "\nNODE_Delete13:\n ");
-	DeleteNode(hNode);
+	DeleteNode(hNode, pr_ctxt);
 #ifndef RES_CLEANUP_DISABLE
 	GT_0trace(NODE_debugMask, GT_5CLASS, "\nNODE_Delete2:\n ");
-	if (pCtxt != NULL)
-		DRV_RemoveNodeResElement(nodeRes, (HANDLE)pCtxt);
+	if (pr_ctxt)
+		DRV_RemoveNodeResElement(nodeRes, pr_ctxt);
 #endif
 	GT_0trace(NODE_debugMask, GT_ENTER, "\nNODE_Delete3:\n ");
 	/* Exit critical section */
@@ -2770,7 +2761,8 @@ func_end:
  *  Purpose:
  *      Free GPP resources allocated in NODE_Allocate() or NODE_Connect().
  */
-static void DeleteNode(struct NODE_OBJECT *hNode)
+static void DeleteNode(struct NODE_OBJECT *hNode,
+		struct PROCESS_CONTEXT *pr_ctxt)
 {
 	struct NODE_MGR *hNodeMgr;
 	struct CMM_XLATOROBJECT *hXlator;
@@ -2849,7 +2841,8 @@ static void DeleteNode(struct NODE_OBJECT *hNode)
 		}
 		if (taskArgs.uDSPHeapResAddr) {
 			status = PROC_UnMap(hNode->hProcessor,
-					   (void *)taskArgs.uDSPHeapAddr);
+					(void *)taskArgs.uDSPHeapAddr,
+					pr_ctxt);
 			if (DSP_SUCCEEDED(status)) {
 				GT_0trace(NODE_debugMask, GT_5CLASS,
 					 "DSPProcessor_UnMap succeeded.\n");
@@ -2948,7 +2941,7 @@ static void DeleteNodeMgr(struct NODE_MGR *hNodeMgr)
 			while ((hNode =
 				(struct NODE_OBJECT *)LST_GetHead(hNodeMgr->
 				nodeList)))
-					DeleteNode(hNode);
+					DeleteNode(hNode, NULL);
 
 			DBC_Assert(LST_IsEmpty(hNodeMgr->nodeList));
 			LST_Delete(hNodeMgr->nodeList);
diff --git a/drivers/dsp/bridge/rmgr/proc.c b/drivers/dsp/bridge/rmgr/proc.c
index 0ee0656..4ab4a88 100644
--- a/drivers/dsp/bridge/rmgr/proc.c
+++ b/drivers/dsp/bridge/rmgr/proc.c
@@ -1789,7 +1789,8 @@ func_end:
  *  Purpose:
  *      Removes a MPU buffer mapping from the DSP address space.
  */
-DSP_STATUS PROC_UnMap(DSP_HPROCESSOR hProcessor, void *pMapAddr)
+DSP_STATUS PROC_UnMap(DSP_HPROCESSOR hProcessor, void *pMapAddr,
+		struct PROCESS_CONTEXT *pr_ctxt)
 {
 	DSP_STATUS status = DSP_SOK;
 	struct PROC_OBJECT *pProcObject = (struct PROC_OBJECT *)hProcessor;
@@ -1797,11 +1798,7 @@ DSP_STATUS PROC_UnMap(DSP_HPROCESSOR hProcessor, void *pMapAddr)
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
@@ -1816,6 +1813,8 @@ DSP_STATUS PROC_UnMap(DSP_HPROCESSOR hProcessor, void *pMapAddr)
 	}
 
 	status = DMM_GetHandle(hProcessor, &hDmmMgr);
+	if (DSP_FAILED(status))
+		goto func_end;
 	/* Critical section */
 	(void)SYNC_EnterCS(hProcLock);
 	if (DSP_FAILED(status)) {
@@ -1839,23 +1838,11 @@ DSP_STATUS PROC_UnMap(DSP_HPROCESSOR hProcessor, void *pMapAddr)
 	if (DSP_FAILED(status))
 		goto func_end;
 
-	/* Update the node and stream resource status */
-	/* Return TGID instead of process handle */
-	hProcess = current->tgid;
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
-- 
1.6.2.4

