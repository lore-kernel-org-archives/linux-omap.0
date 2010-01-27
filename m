From: "Gomez Castellanos, Ivan" <ivan.gomez@ti.com>
Subject: [PATCH 1/2] DSPBRIDGE: Check process context in bridge_ioctl
Date: Wed, 27 Jan 2010 12:06:23 -0600
Message-ID: <818EF96F5A7CC84789DD014773DB095484859F55@dlee01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:39477 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755860Ab0A0SHz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 27 Jan 2010 13:07:55 -0500
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Ameya.Palande@nokia.com" <Ameya.Palande@nokia.com>, "Hiroshi.DOYU@nokia.com" <Hiroshi.DOYU@nokia.com>, "felipe.contreras@nokia.com" <felipe.contreras@nokia.com>, "Menon, Nishanth" <nm@ti.com>

>From f9d2f46583399c4addd3c2978c62d1821e0100d7 Mon Sep 17 00:00:00 2001
From: Ivan Gomez <ivan.gomez@ti.com>
Date: Thu, 21 Jan 2010 12:27:33 -0600
Subject: [PATCH] DSPBRIDGE: Check process context in bridge_ioctl

Check pcontext (filp->private_data) in bridge_ioctl function,
so that additional pcontext checks can be removed.

Signed-off-by: Ivan Gomez <ivan.gomez@ti.com>
---
 drivers/dsp/bridge/rmgr/drv.c           |   32 +++---------------------------
 drivers/dsp/bridge/rmgr/drv_interface.c |   19 ++++++++++-------
 drivers/dsp/bridge/rmgr/node.c          |    6 +----
 drivers/dsp/bridge/rmgr/proc.c          |    7 ++---
 4 files changed, 19 insertions(+), 45 deletions(-)

diff --git a/drivers/dsp/bridge/rmgr/drv.c b/drivers/dsp/bridge/rmgr/drv.c
index 96314a2..fd09a83 100644
--- a/drivers/dsp/bridge/rmgr/drv.c
+++ b/drivers/dsp/bridge/rmgr/drv.c
@@ -88,14 +88,7 @@ DSP_STATUS DRV_ProcUpdatestate(HANDLE hPCtxt, enum GPP_PROC_RES_STATE status)
 {
 	struct PROCESS_CONTEXT *pCtxt = (struct PROCESS_CONTEXT *)hPCtxt;
 	DSP_STATUS status1 = DSP_SOK;
-	if (pCtxt != NULL) {
-		pCtxt->resState = status;
-	} else {
-		status1 = DSP_EHANDLE;
-		GT_0trace(curTrace, GT_ENTER,
-			 "DRV_ProcUpdatestate: Failed to update "
-			 "process state");
-	}
+	pCtxt->resState = status;
 	return status1;
 }
 
@@ -111,8 +104,7 @@ DSP_STATUS DRV_InsertNodeResElement(HANDLE hNode, HANDLE hNodeRes,
 	GT_0trace(curTrace, GT_ENTER, "DRV_InsertNodeResElement: 1");
 	*pNodeRes = (struct NODE_RES_OBJECT *)MEM_Calloc
 		    (1 * sizeof(struct NODE_RES_OBJECT), MEM_PAGED);
-	DBC_Assert(hPCtxt != NULL);
-	if ((*pNodeRes == NULL) || (hPCtxt == NULL)) {
+	if (*pNodeRes == NULL) {
 		GT_0trace(curTrace, GT_ENTER, "DRV_InsertNodeResElement: 12");
 		status = DSP_EHANDLE;
 	}
@@ -144,7 +136,6 @@ DSP_STATUS DRV_RemoveNodeResElement(HANDLE hNodeRes, HANDLE hPCtxt)
 	struct PROCESS_CONTEXT *pCtxt = (struct PROCESS_CONTEXT *)hPCtxt;
 	struct NODE_RES_OBJECT *pTempNode;
 
-	DBC_Assert(hPCtxt != NULL);
 	pTempNode = pCtxt->pNodeList;
 	if (pTempNode == pNodeRes) {
 		pCtxt->pNodeList = pNodeRes->next;
@@ -168,7 +159,6 @@ static DSP_STATUS DRV_ProcFreeNodeRes(HANDLE hPCtxt)
 	struct NODE_RES_OBJECT *pNodeRes = NULL;
 	u32  nState;
 
-	DBC_Assert(hPCtxt != NULL);
 	pNodeList = pCtxt->pNodeList;
 	while (pNodeList != NULL) {
 		GT_0trace(curTrace, GT_ENTER, "DRV_ProcFreeNodeRes: 1");
@@ -216,9 +206,8 @@ DSP_STATUS DRV_InsertDMMResElement(HANDLE hDMMRes, HANDLE hPCtxt)
 
 	*pDMMRes = (struct DMM_RES_OBJECT *)
 		    MEM_Calloc(1 * sizeof(struct DMM_RES_OBJECT), MEM_PAGED);
-	DBC_Assert(hPCtxt != NULL);
 	GT_0trace(curTrace, GT_ENTER, "DRV_InsertDMMResElement: 1");
-	if ((*pDMMRes == NULL) || (hPCtxt == NULL)) {
+	if (*pDMMRes == NULL) {
 		GT_0trace(curTrace, GT_5CLASS, "DRV_InsertDMMResElement: 2");
 		status = DSP_EHANDLE;
 	}
@@ -249,7 +238,6 @@ DSP_STATUS DRV_RemoveDMMResElement(HANDLE hDMMRes, HANDLE hPCtxt)
 	struct DMM_RES_OBJECT *pDMMRes = (struct DMM_RES_OBJECT *)hDMMRes;
 	struct DMM_RES_OBJECT *pTempDMMRes = NULL;
 
-	DBC_Assert(hPCtxt != NULL);
 	pTempDMMRes = pCtxt->pDMMList;
 	if (pCtxt->pDMMList == pDMMRes) {
 		pCtxt->pDMMList = pDMMRes->next;
@@ -291,7 +279,6 @@ DSP_STATUS  DRV_ProcFreeDMMRes(HANDLE hPCtxt)
 	struct DMM_RES_OBJECT *pDMMList = pCtxt->pDMMList;
 	struct DMM_RES_OBJECT *pDMMRes = NULL;
 
-	DBC_Assert(hPCtxt != NULL);
 	GT_0trace(curTrace, GT_ENTER, "\nDRV_ProcFreeDMMRes: 1\n");
 	while (pDMMList != NULL) {
 		pDMMRes = pDMMList;
@@ -322,7 +309,6 @@ DSP_STATUS DRV_RemoveAllDMMResElements(HANDLE hPCtxt)
 	struct DMM_RES_OBJECT *pTempDMMRes2 = NULL;
 	struct DMM_RES_OBJECT *pTempDMMRes = NULL;
 
-	DBC_Assert(pCtxt != NULL);
 	DRV_ProcFreeDMMRes(pCtxt);
 	pTempDMMRes = pCtxt->pDMMList;
 	while (pTempDMMRes != NULL) {
@@ -341,7 +327,6 @@ DSP_STATUS DRV_GetDMMResElement(u32 pMapAddr, HANDLE hDMMRes, HANDLE hPCtxt)
 	DSP_STATUS status = DSP_SOK;
 	struct DMM_RES_OBJECT *pTempDMM = NULL;
 
-	DBC_Assert(hPCtxt != NULL);
 	pTempDMM = pCtxt->pDMMList;
 	while ((pTempDMM != NULL) && (pTempDMM->ulDSPAddr != pMapAddr)) {
 		GT_3trace(curTrace, GT_ENTER,
@@ -385,7 +370,6 @@ DSP_STATUS 	DRV_RemoveAllNodeResElements(HANDLE hPCtxt)
 	struct NODE_RES_OBJECT *pTempNode2 = NULL;
 	struct NODE_RES_OBJECT *pTempNode = NULL;
 
-	DBC_Assert(hPCtxt != NULL);
 	DRV_ProcFreeNodeRes(pCtxt);
 	pTempNode = pCtxt->pNodeList;
 	while (pTempNode != NULL) {
@@ -406,7 +390,6 @@ DSP_STATUS DRV_GetNodeResElement(HANDLE hNode, HANDLE hNodeRes, HANDLE hPCtxt)
 	struct NODE_RES_OBJECT *pTempNode2 = NULL;
 	struct NODE_RES_OBJECT *pTempNode = NULL;
 
-	DBC_Assert(hPCtxt != NULL);
 	pTempNode = pCtxt->pNodeList;
 	GT_0trace(curTrace, GT_ENTER, "DRV_GetNodeResElement: 1");
 	while ((pTempNode != NULL) && (pTempNode->hNode != hNode)) {
@@ -431,11 +414,10 @@ DSP_STATUS DRV_ProcInsertSTRMResElement(HANDLE hStreamHandle, HANDLE hSTRMRes,
 	struct PROCESS_CONTEXT *pCtxt = (struct PROCESS_CONTEXT *)hPCtxt;
 	DSP_STATUS status = DSP_SOK;
 	struct STRM_RES_OBJECT *pTempSTRMRes = NULL;
-	DBC_Assert(hPCtxt != NULL);
 
 	*pSTRMRes = (struct STRM_RES_OBJECT *)
 		    MEM_Calloc(1 * sizeof(struct STRM_RES_OBJECT), MEM_PAGED);
-	if ((*pSTRMRes == NULL) || (hPCtxt == NULL)) {
+	if (*pSTRMRes == NULL) {
 		GT_0trace(curTrace, GT_ENTER, "DRV_InsertSTRMResElement: 2");
 		status = DSP_EHANDLE;
 	}
@@ -467,8 +449,6 @@ DSP_STATUS 	DRV_ProcRemoveSTRMResElement(HANDLE hSTRMRes, HANDLE hPCtxt)
 	struct PROCESS_CONTEXT *pCtxt = (struct PROCESS_CONTEXT *)hPCtxt;
 	struct STRM_RES_OBJECT *pTempSTRMRes;
 
-	DBC_Assert(hPCtxt != NULL);
-
 	pTempSTRMRes = pCtxt->pSTRMList;
 
 	if (pCtxt->pSTRMList == pSTRMRes) {
@@ -499,8 +479,6 @@ static DSP_STATUS  DRV_ProcFreeSTRMRes(HANDLE hPCtxt)
 	u32 dwArg;
 	s32 ulBufSize;
 
-
-	DBC_Assert(hPCtxt != NULL);
 	pSTRMList = pCtxt->pSTRMList;
 	while (pSTRMList != NULL) {
 		pSTRMRes = pSTRMList;
@@ -538,7 +516,6 @@ DSP_STATUS	DRV_RemoveAllSTRMResElements(HANDLE hPCtxt)
 	struct STRM_RES_OBJECT *pTempSTRMRes2 = NULL;
 	struct STRM_RES_OBJECT *pTempSTRMRes = NULL;
 
-	DBC_Assert(hPCtxt != NULL);
 	DRV_ProcFreeSTRMRes(pCtxt);
 	pTempSTRMRes = pCtxt->pSTRMList;
 	while (pTempSTRMRes != NULL) {
@@ -559,7 +536,6 @@ DSP_STATUS DRV_GetSTRMResElement(HANDLE hStrm, HANDLE hSTRMRes, HANDLE hPCtxt)
 	struct STRM_RES_OBJECT *pTempSTRM2 = NULL;
 	struct STRM_RES_OBJECT *pTempSTRM = pCtxt->pSTRMList;
 
-	DBC_Assert(hPCtxt != NULL);
 	while ((pTempSTRM != NULL) && (pTempSTRM->hStream != hStrm)) {
 		GT_0trace(curTrace, GT_ENTER, "DRV_GetSTRMResElement: 2");
 		pTempSTRM2 = pTempSTRM;
diff --git a/drivers/dsp/bridge/rmgr/drv_interface.c b/drivers/dsp/bridge/rmgr/drv_interface.c
index 301aea1..f3a67e2 100644
--- a/drivers/dsp/bridge/rmgr/drv_interface.c
+++ b/drivers/dsp/bridge/rmgr/drv_interface.c
@@ -559,10 +559,15 @@ static long bridge_ioctl(struct file *filp, unsigned int code,
 
 	GT_0trace(driverTrace, GT_ENTER, " -> driver_ioctl\n");
 
+	if (!filp->private_data) {
+		status = -EIO;
+		goto err;
+	}
+
 	status = copy_from_user(&pBufIn, (union Trapped_Args *)args,
 				sizeof(union Trapped_Args));
 
-	if (status >= 0) {
+	if (!status) {
 		status = WCD_CallDevIOCtl(code, &pBufIn, &retval,
 				filp->private_data);
 
@@ -576,8 +581,8 @@ static long bridge_ioctl(struct file *filp, unsigned int code,
 
 	}
 
+err:
 	GT_0trace(driverTrace, GT_ENTER, " <- driver_ioctl\n");
-
 	return status;
 }
 
@@ -614,12 +619,10 @@ DSP_STATUS DRV_RemoveAllResources(HANDLE hPCtxt)
 {
 	DSP_STATUS status = DSP_SOK;
 	struct PROCESS_CONTEXT *pCtxt = (struct PROCESS_CONTEXT *)hPCtxt;
-	if (pCtxt != NULL) {
-		DRV_RemoveAllSTRMResElements(pCtxt);
-		DRV_RemoveAllNodeResElements(pCtxt);
-		DRV_RemoveAllDMMResElements(pCtxt);
-		DRV_ProcUpdatestate(pCtxt, PROC_RES_FREED);
-	}
+	DRV_RemoveAllSTRMResElements(pCtxt);
+	DRV_RemoveAllNodeResElements(pCtxt);
+	DRV_RemoveAllDMMResElements(pCtxt);
+	DRV_ProcUpdatestate(pCtxt, PROC_RES_FREED);
 	return status;
 }
 #endif
diff --git a/drivers/dsp/bridge/rmgr/node.c b/drivers/dsp/bridge/rmgr/node.c
index 336abea..3f0431a 100644
--- a/drivers/dsp/bridge/rmgr/node.c
+++ b/drivers/dsp/bridge/rmgr/node.c
@@ -1641,20 +1641,16 @@ func_cont1:
 	 /*  Free host-side resources allocated by NODE_Create()
 	 *  DeleteNode() fails if SM buffers not freed by client!  */
 #ifndef RES_CLEANUP_DISABLE
-	if (!pr_ctxt)
-		goto func_cont;
 	if (DRV_GetNodeResElement(hNode, &nodeRes, pr_ctxt) != DSP_ENOTFOUND) {
 		GT_0trace(NODE_debugMask, GT_5CLASS, "\nNODE_Delete12:\n");
 		DRV_ProcNodeUpdateStatus(nodeRes, false);
 	}
 #endif
-func_cont:
 	GT_0trace(NODE_debugMask, GT_ENTER, "\nNODE_Delete13:\n ");
 	DeleteNode(hNode, pr_ctxt);
 #ifndef RES_CLEANUP_DISABLE
 	GT_0trace(NODE_debugMask, GT_5CLASS, "\nNODE_Delete2:\n ");
-	if (pr_ctxt)
-		DRV_RemoveNodeResElement(nodeRes, pr_ctxt);
+	DRV_RemoveNodeResElement(nodeRes, pr_ctxt);
 #endif
 	GT_0trace(NODE_debugMask, GT_ENTER, "\nNODE_Delete3:\n ");
 	/* Exit critical section */
diff --git a/drivers/dsp/bridge/rmgr/proc.c b/drivers/dsp/bridge/rmgr/proc.c
index cd32561..ebf7337 100644
--- a/drivers/dsp/bridge/rmgr/proc.c
+++ b/drivers/dsp/bridge/rmgr/proc.c
@@ -135,7 +135,7 @@ PROC_Attach(u32 uProcessor, OPTIONAL CONST struct DSP_PROCESSORATTRIN *pAttrIn,
 		 "uProcessor:  0x%x\n\tpAttrIn:  0x%x\n\tphProcessor:"
 		 "0x%x\n", uProcessor, pAttrIn, phProcessor);
 
-	if (pr_ctxt && pr_ctxt->hProcessor) {
+	if (pr_ctxt->hProcessor) {
 		*phProcessor = pr_ctxt->hProcessor;
 		return status;
 	}
@@ -496,8 +496,7 @@ DSP_STATUS PROC_Detach(struct PROCESS_CONTEXT *pr_ctxt)
 	DBC_Require(cRefs > 0);
 	GT_0trace(PROC_DebugMask, GT_ENTER, "Entered PROC_Detach\n");
 
-	if (pr_ctxt)
-		pProcObject = (struct PROC_OBJECT *)pr_ctxt->hProcessor;
+	pProcObject = (struct PROC_OBJECT *)pr_ctxt->hProcessor;
 
 	if (MEM_IsValidHandle(pProcObject, PROC_SIGNATURE)) {
 		/* Notify the Client */
@@ -1662,7 +1661,7 @@ DSP_STATUS PROC_UnMap(DSP_HPROCESSOR hProcessor, void *pMapAddr,
 	if (DSP_FAILED(status))
 		goto func_end;
 
-	if (pr_ctxt && DRV_GetDMMResElement((u32)pMapAddr, &dmmRes, pr_ctxt)
+	if (DRV_GetDMMResElement((u32)pMapAddr, &dmmRes, pr_ctxt)
 							!= DSP_ENOTFOUND)
 		DRV_RemoveDMMResElement(dmmRes, pr_ctxt);
 #endif
-- 
1.5.4.3
