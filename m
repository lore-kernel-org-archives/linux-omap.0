From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 5/7] DSPBRIDGE: Remove process context list
Date: Wed, 16 Dec 2009 21:45:56 -0600
Message-ID: <1261021558-19036-6-git-send-email-omar.ramirez@ti.com>
References: <1261021558-19036-1-git-send-email-omar.ramirez@ti.com>
 <1261021558-19036-2-git-send-email-omar.ramirez@ti.com>
 <1261021558-19036-3-git-send-email-omar.ramirez@ti.com>
 <1261021558-19036-4-git-send-email-omar.ramirez@ti.com>
 <1261021558-19036-5-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:33142 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933768AbZLQDim (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 16 Dec 2009 22:38:42 -0500
In-Reply-To: <1261021558-19036-5-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Ameya Palande <ameya.palande@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>, Fernando Guzman <x0095840@ti.com>, Ernesto Ramos <ernesto@ti.com>

From: Fernando Guzman Lugo <x0095840@ti.com>

This patch removes the list implementation to store and manage
process contexts as it is not needed anymore.

Signed-off-by: Fernando Guzman Lugo <x0095840@ti.com>
---
 .../plat-omap/include/dspbridge/resourcecleanup.h  |    2 -
 drivers/dsp/bridge/pmgr/wcd.c                      |    1 -
 drivers/dsp/bridge/rmgr/drv.c                      |  382 --------------------
 drivers/dsp/bridge/rmgr/drv_interface.c            |   27 +--
 drivers/dsp/bridge/rmgr/proc.c                     |   43 +---
 5 files changed, 6 insertions(+), 449 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/resourcecleanup.h b/arch/arm/plat-omap/include/dspbridge/resourcecleanup.h
index f32da22..a6f4397 100644
--- a/arch/arm/plat-omap/include/dspbridge/resourcecleanup.h
+++ b/arch/arm/plat-omap/include/dspbridge/resourcecleanup.h
@@ -76,8 +76,6 @@ extern DSP_STATUS DRV_ProcRemoveSTRMResElement(HANDLE STRMRes, HANDLE pCtxt);
 
 extern DSP_STATUS DRV_RemoveAllSTRMResElements(HANDLE pCtxt);
 
-extern DSP_STATUS DRV_ProcDisplayResInfo(u8 *pBuf, u32 *pSize);
-
 extern enum NODE_STATE NODE_GetState(HANDLE hNode);
 
 #endif
diff --git a/drivers/dsp/bridge/pmgr/wcd.c b/drivers/dsp/bridge/pmgr/wcd.c
index 0d027ec..70a56ed 100644
--- a/drivers/dsp/bridge/pmgr/wcd.c
+++ b/drivers/dsp/bridge/pmgr/wcd.c
@@ -639,7 +639,6 @@ u32 MGRWRAP_GetProcessResourcesInfo(union Trapped_Args *args, void *pr_ctxt)
     DSP_STATUS status = DSP_SOK;
     u32 uSize = 0;
     u8 *pBuf = MEM_Alloc(8092, MEM_NONPAGED);
-    status = DRV_ProcDisplayResInfo(pBuf, &uSize);
     GT_1trace(WCD_debugMask, GT_ENTER,
 	     "MGRWRAP_GetProcessResourcesInfo:uSize=%d :\n", uSize);
     cp_to_usr(args->ARGS_PROC_GETTRACE.pBuf, pBuf, status, uSize);
diff --git a/drivers/dsp/bridge/rmgr/drv.c b/drivers/dsp/bridge/rmgr/drv.c
index 92e2a62..7201c95 100644
--- a/drivers/dsp/bridge/rmgr/drv.c
+++ b/drivers/dsp/bridge/rmgr/drv.c
@@ -128,9 +128,6 @@ struct DRV_OBJECT {
 	u32 dwSignature;
 	struct LST_LIST *devList;
 	struct LST_LIST *devNodeString;
-#ifndef RES_CLEANUP_DISABLE
-	struct PROCESS_CONTEXT  *procCtxtList;
-#endif
 };
 
 /*
@@ -156,13 +153,10 @@ static DSP_STATUS RequestBridgeResourcesDSP(u32 dwContext, s32 fRequest);
 #ifndef RES_CLEANUP_DISABLE
 /* GPP PROCESS CLEANUP CODE */
 
-static DSP_STATUS PrintProcessInformation(void);
 static DSP_STATUS DRV_ProcFreeNodeRes(HANDLE hPCtxt);
 static DSP_STATUS  DRV_ProcFreeSTRMRes(HANDLE hPCtxt);
 extern enum NODE_STATE NODE_GetState(HANDLE hNode);
 
-/* Get the process context list from driver object */
-
 /* Set the Process ID */
 DSP_STATUS DRV_ProcSetPID(HANDLE hPCtxt, s32 hProcess)
 {
@@ -175,108 +169,6 @@ DSP_STATUS DRV_ProcSetPID(HANDLE hPCtxt, s32 hProcess)
 	return status;
 }
 
-
-/* Getting the head of the process context list */
-DSP_STATUS DRV_GetProcCtxtList(struct PROCESS_CONTEXT **pPctxt,
-				struct DRV_OBJECT *hDrvObject)
-{
-	DSP_STATUS status = DSP_SOK;
-	struct DRV_OBJECT *pDrvObject = (struct DRV_OBJECT *)hDrvObject;
-
-	DBC_Assert(hDrvObject != NULL);
-	GT_2trace(curTrace, GT_ENTER,
-		"DRV_GetProcCtxtList: 2 *pPctxt:%x, pDrvObject"
-		":%x", *pPctxt, pDrvObject);
-	*pPctxt = pDrvObject->procCtxtList;
-	GT_2trace(curTrace, GT_ENTER,
-		"DRV_GetProcCtxtList: 3 *pPctxt:%x, pDrvObject"
-		":%x", *pPctxt, pDrvObject);
-	return status;
-}
-
-/* Add a new process context to process context list */
-DSP_STATUS DRV_InsertProcContext(struct DRV_OBJECT *hDrVObject, HANDLE hPCtxt)
-{
-	struct PROCESS_CONTEXT **pCtxt = (struct PROCESS_CONTEXT **)hPCtxt;
-	DSP_STATUS status = DSP_SOK;
-	struct PROCESS_CONTEXT *pCtxtList = NULL;
-	struct DRV_OBJECT	     *hDRVObject;
-
-	GT_0trace(curTrace, GT_ENTER, "\n In DRV_InsertProcContext\n");
-
-	status = CFG_GetObject((u32 *)&hDRVObject, REG_DRV_OBJECT);
-	DBC_Assert(hDRVObject != NULL);
-
-	*pCtxt = MEM_Calloc(1 * sizeof(struct PROCESS_CONTEXT), MEM_PAGED);
-	if (!*pCtxt) {
-		pr_err("DSP: MEM_Calloc failed in DRV_InsertProcContext\n");
-		return DSP_EMEMORY;
-	}
-
-	spin_lock_init(&(*pCtxt)->proc_list_lock);
-	INIT_LIST_HEAD(&(*pCtxt)->processor_list);
-
-	GT_0trace(curTrace, GT_ENTER,
-		 "\n In DRV_InsertProcContext Calling "
-		 "DRV_GetProcCtxtList\n");
-	DRV_GetProcCtxtList(&pCtxtList, hDRVObject);
-	GT_0trace(curTrace, GT_ENTER,
-		 "\n In DRV_InsertProcContext After Calling "
-		 "DRV_GetProcCtxtList\n");
-	if (pCtxtList != NULL) {
-		GT_0trace(curTrace, GT_ENTER,
-			 "\n In DRV_InsertProcContext and pCtxt is "
-			 "not Null\n");
-		while (pCtxtList->next != NULL)
-			pCtxtList = pCtxtList->next;
-
-		pCtxtList->next = *pCtxt;
-	} else {
-		GT_0trace(curTrace, GT_ENTER,
-			 "\n In DRV_InsertProcContext and "
-			 "pCtxt is Null\n");
-		hDRVObject->procCtxtList = *pCtxt;
-	}
-	return status;
-}
-
-/* Delete a process context from process resource context list */
-DSP_STATUS DRV_RemoveProcContext(struct DRV_OBJECT *hDRVObject,
-		HANDLE pr_ctxt)
-{
-	DSP_STATUS status = DSP_SOK;
-	struct PROCESS_CONTEXT *pr_ctxt_list = NULL;
-	struct PROCESS_CONTEXT *ptr_prev;
-
-	DBC_Assert(hDRVObject != NULL);
-
-	GT_0trace(curTrace, GT_ENTER, "DRV_RemoveProcContext: 12");
-	DRV_GetProcCtxtList(&pr_ctxt_list, hDRVObject);
-	ptr_prev = pr_ctxt_list;
-
-	GT_0trace(curTrace, GT_ENTER, "DRV_RemoveProcContext: 13");
-	while (pr_ctxt_list && (pr_ctxt_list != pr_ctxt)) {
-		ptr_prev = pr_ctxt_list;
-		pr_ctxt_list = pr_ctxt_list->next;
-		GT_0trace(curTrace, GT_ENTER,
-			 "DRV_RemoveProcContext: 2");
-	}
-
-	GT_0trace(curTrace, GT_ENTER, "DRV_RemoveProcContext: 3");
-
-	if (!pr_ctxt_list)
-		return DSP_ENOTFOUND;
-	else if (hDRVObject->procCtxtList == pr_ctxt_list)
-		hDRVObject->procCtxtList = pr_ctxt_list->next;
-	else
-		ptr_prev->next = pr_ctxt_list->next;
-
-	MEM_Free(pr_ctxt);
-	GT_0trace(curTrace, GT_ENTER, "DRV_RemoveProcContext: 7");
-
-	return status;
-}
-
 /* Update the state of process context */
 DSP_STATUS DRV_ProcUpdatestate(HANDLE hPCtxt, enum GPP_PROC_RES_STATE status)
 {
@@ -439,8 +331,6 @@ DSP_STATUS DRV_InsertDMMResElement(HANDLE hDMMRes, HANDLE hPCtxt)
 	return status;
 }
 
-
-
 /* Release DMM resource element context
 * This is called from Proc_UnMap. after the actual resource is freed */
 DSP_STATUS 	DRV_RemoveDMMResElement(HANDLE hDMMRes, HANDLE hPCtxt)
@@ -517,7 +407,6 @@ DSP_STATUS  DRV_ProcFreeDMMRes(HANDLE hPCtxt)
 	return status;
 }
 
-
 /* Release all DMM resources and its context
 * This is called from .bridge_release. */
 DSP_STATUS DRV_RemoveAllDMMResElements(HANDLE hPCtxt)
@@ -605,7 +494,6 @@ DSP_STATUS 	DRV_RemoveAllNodeResElements(HANDLE hPCtxt)
 }
 
 /* Getting the node resource element */
-
 DSP_STATUS DRV_GetNodeResElement(HANDLE hNode, HANDLE hNodeRes, HANDLE hPCtxt)
 {
 	struct NODE_RES_OBJECT **nodeRes = (struct NODE_RES_OBJECT **)hNodeRes;
@@ -629,8 +517,6 @@ DSP_STATUS DRV_GetNodeResElement(HANDLE hNode, HANDLE hNodeRes, HANDLE hPCtxt)
 	return status;
 }
 
-
-
 /* Allocate the STRM resource element
 * This is called after the actual resource is allocated
 */
@@ -668,8 +554,6 @@ DSP_STATUS DRV_ProcInsertSTRMResElement(HANDLE hStreamHandle, HANDLE hSTRMRes,
 	return status;
 }
 
-
-
 /* Release Stream resource element context
 * This function called after the actual resource is freed
 */
@@ -698,7 +582,6 @@ DSP_STATUS 	DRV_ProcRemoveSTRMResElement(HANDLE hSTRMRes, HANDLE hPCtxt)
 	return status;
 }
 
-
 /* Actual Stream De-Allocation */
 static DSP_STATUS  DRV_ProcFreeSTRMRes(HANDLE hPCtxt)
 {
@@ -764,7 +647,6 @@ DSP_STATUS	DRV_RemoveAllSTRMResElements(HANDLE hPCtxt)
 	return status;
 }
 
-
 /* Getting the stream resource element */
 DSP_STATUS DRV_GetSTRMResElement(HANDLE hStrm, HANDLE hSTRMRes, HANDLE hPCtxt)
 {
@@ -802,270 +684,6 @@ DSP_STATUS DRV_ProcUpdateSTRMRes(u32 uNumBufs, HANDLE hSTRMRes, HANDLE hPCtxt)
 	return status;
 }
 
-/* Displaying the resources allocated by a process */
-DSP_STATUS DRV_ProcDisplayResInfo(u8 *pBuf1, u32 *pSize)
-{
-	struct PROCESS_CONTEXT *pCtxt = NULL;
-	struct NODE_RES_OBJECT *pNodeRes = NULL;
-	struct DMM_RES_OBJECT *pDMMRes = NULL;
-	struct STRM_RES_OBJECT *pSTRMRes = NULL;
-	struct DSPHEAP_RES_OBJECT *pDSPHEAPRes = NULL;
-	u32 tempCount = 1;
-	HANDLE hDrvObject = NULL;
-	void *pBuf = pBuf1;
-	u8 pTempBuf[250];
-	u32 tempStrLen = 0, tempStrLen2 = 0;
-	DSP_STATUS status = DSP_SOK;
-
-	CFG_GetObject((u32 *)&hDrvObject, REG_DRV_OBJECT);
-	DRV_GetProcCtxtList(&pCtxt, (struct DRV_OBJECT *)hDrvObject);
-	GT_0trace(curTrace, GT_ENTER, "*********************"
-		 "DRV_ProcDisplayResourceInfo:*\n");
-	while (pCtxt != NULL) {
-		tempStrLen2 = sprintf((char *)pTempBuf,
-				     "-------------------------------------"
-				     "-----------------------------------\n");
-		tempStrLen2 += 2;
-		memmove(pBuf+tempStrLen, pTempBuf, tempStrLen2);
-		tempStrLen += tempStrLen2;
-		if (pCtxt->resState == PROC_RES_ALLOCATED) {
-			tempStrLen2 = sprintf((char *)pTempBuf,
-					"GPP Process Resource State: "
-					"pCtxt->resState = PROC_RES_ALLOCATED, "
-					" Process ID: %d\n", pCtxt->pid);
-			tempStrLen2 += 2;
-			memmove(pBuf+tempStrLen, pTempBuf, tempStrLen2);
-			tempStrLen += tempStrLen2;
-		} else {
-			tempStrLen2 = sprintf((char *)pTempBuf,
-				"GPP Resource State: pCtxt->resState"
-				" = PROC_RES_DEALLOCATED, Process ID:%d\n",
-				pCtxt->pid);
-			tempStrLen2 += 2;
-			memmove(pBuf+tempStrLen, pTempBuf, tempStrLen2);
-			tempStrLen += tempStrLen2;
-		}
-		pNodeRes = pCtxt->pNodeList;
-		tempCount = 1;
-		while (pNodeRes != NULL) {
-			GT_2trace(curTrace, GT_ENTER,
-				 "DRV_ProcDisplayResourceInfo: #:%d "
-				 "pCtxt->pNodeList->hNode:%x\n",
-				 tempCount, pNodeRes->hNode);
-			tempStrLen2 = sprintf((char *)pTempBuf,
-					"Node Resource Information: Node #"
-					" %d Node Handle hNode:0X%x\n",
-					tempCount, (u32)pNodeRes->hNode);
-			pNodeRes = pNodeRes->next;
-			tempStrLen2 += 2;
-			memmove(pBuf+tempStrLen, pTempBuf, tempStrLen2);
-			tempStrLen += tempStrLen2;
-			tempCount++;
-		}
-		tempCount = 1;
-		pDSPHEAPRes = pCtxt->pDSPHEAPList;
-		while (pDSPHEAPRes != NULL) {
-			GT_2trace(curTrace, GT_ENTER,
-				 "DRV_ProcDisplayResourceInfo: #:%d "
-				 "pCtxt->pDSPHEAPRList->ulMpuAddr:%x\n",
-				 tempCount, pDSPHEAPRes->ulMpuAddr);
-			tempStrLen2 = sprintf((char *)pTempBuf,
-				 "DSP Heap Resource Info: HEAP # %d"
-				 " Mapped GPP Address: 0x%x, size: 0x%x\n",
-				 tempCount, (u32)pDSPHEAPRes->ulMpuAddr,
-				 (u32)pDSPHEAPRes->heapSize);
-			pDSPHEAPRes = pDSPHEAPRes->next;
-			tempStrLen2 += 2;
-			memmove(pBuf+tempStrLen, pTempBuf, tempStrLen2);
-			tempStrLen += tempStrLen2;
-			tempCount++;
-		}
-		tempCount = 1;
-		pDMMRes = pCtxt->pDMMList;
-		while (pDMMRes != NULL) {
-			GT_2trace(curTrace, GT_ENTER,
-					"DRV_ProcDisplayResourceInfo: #:%d "
-					" pCtxt->pDMMList->ulMpuAddr:%x\n",
-					tempCount,
-					pDMMRes->ulMpuAddr);
-			tempStrLen2 = sprintf((char *)pTempBuf,
-					 "DMM Resource Info: DMM # %d Mapped"
-					 " GPP Address: 0x%x, size: 0x%x\n",
-					 tempCount, (u32)pDMMRes->ulMpuAddr,
-					 (u32)pDMMRes->dmmSize);
-			pDMMRes = pDMMRes->next;
-			tempStrLen2 += 2;
-			memmove(pBuf+tempStrLen, pTempBuf, tempStrLen2);
-			tempStrLen += tempStrLen2;
-			tempCount++;
-		}
-		tempCount = 1;
-		pSTRMRes = pCtxt->pSTRMList;
-		while (pSTRMRes != NULL) {
-			GT_2trace(curTrace, GT_ENTER,
-				 "DRV_ProcDisplayResourceInfo: #:%d "
-				 "pCtxt->pSTRMList->hStream:%x\n", tempCount,
-				 pSTRMRes->hStream);
-			tempStrLen2 = sprintf((char *)pTempBuf,
-					     "Stream Resource info: STRM # %d "
-					     "Stream Handle: 0x%x \n",
-					     tempCount, (u32)pSTRMRes->hStream);
-			pSTRMRes = pSTRMRes->next;
-			tempStrLen2 += 2;
-			memmove(pBuf+tempStrLen, pTempBuf, tempStrLen2);
-			tempStrLen += tempStrLen2;
-			tempCount++;
-		}
-		pCtxt = pCtxt->next;
-	}
-	*pSize = tempStrLen;
-	status = PrintProcessInformation();
-	GT_0trace(curTrace, GT_ENTER, "*********************"
-		"DRV_ProcDisplayResourceInfo:**\n");
-	return status;
-}
-
-/*
- *  ======== PrintProcessInformation ========
- *  Purpose:
- *      This function prints the Process's information stored in
- *      the process context list. Some of the information that
- *      it displays is Process's state, Node, Stream, DMM, and
- *      Heap information.
- */
-static DSP_STATUS PrintProcessInformation(void)
-{
-	struct DRV_OBJECT *hDrvObject = NULL;
-	struct PROCESS_CONTEXT *pCtxtList = NULL;
-	struct NODE_RES_OBJECT *pNodeRes = NULL;
-	struct DMM_RES_OBJECT *pDMMRes = NULL;
-	struct PROC_OBJECT *proc_obj_ptr;
-	struct STRM_RES_OBJECT *pSTRMRes = NULL;
-	struct DSPHEAP_RES_OBJECT *pDSPHEAPRes = NULL;
-	DSP_STATUS status = DSP_SOK;
-	u32 tempCount;
-	u32  procID;
-
-	/* Get the Process context list */
-	CFG_GetObject((u32 *)&hDrvObject, REG_DRV_OBJECT);
-	DRV_GetProcCtxtList(&pCtxtList, hDrvObject);
-	GT_0trace(curTrace, GT_4CLASS, "\n### Debug information"
-			" for DSP bridge ##\n");
-	GT_0trace(curTrace, GT_4CLASS, " \n ###The  processes"
-			" information is as follows ### \n") ;
-	GT_0trace(curTrace, GT_4CLASS, "  ====================="
-			"============ \n");
-	/* Go through the entries in the Process context list */
-	while (pCtxtList  != NULL) {
-		GT_1trace(curTrace, GT_4CLASS, "\nThe process"
-				" id is %d\n", pCtxtList->pid);
-		GT_0trace(curTrace, GT_4CLASS, " -------------------"
-				"---------\n");
-		if (pCtxtList->resState == PROC_RES_ALLOCATED) {
-			GT_0trace(curTrace, GT_4CLASS, " \nThe Process"
-					" is in Allocated state\n");
-		} else {
-			GT_0trace(curTrace, GT_4CLASS, "\nThe Process"
-					" is in DeAllocated state\n");
-		}
-
-		spin_lock(&pCtxtList->proc_list_lock);
-		list_for_each_entry(proc_obj_ptr, &pCtxtList->processor_list,
-				proc_object) {
-			PROC_GetProcessorId(proc_obj_ptr, &procID);
-			if (procID == DSP_UNIT) {
-				GT_0trace(curTrace, GT_4CLASS,
-					"\nProcess connected to"
-					" DSP Processor\n");
-			} else if (procID == IVA_UNIT) {
-				GT_0trace(curTrace, GT_4CLASS,
-					"\nProcess connected to"
-					" IVA Processor\n");
-			} else {
-				GT_0trace(curTrace, GT_7CLASS,
-					"\n***ERROR:Invalid Processor Id***\n");
-			}
-		}
-		spin_unlock(&pCtxtList->proc_list_lock);
-
-		pNodeRes = pCtxtList->pNodeList;
-		tempCount = 1;
-		while (pNodeRes != NULL) {
-			if (tempCount == 1)
-				GT_0trace(curTrace, GT_4CLASS,
-					"\n***The Nodes allocated by"
-					" this Process are***\n");
-			GT_2trace(curTrace, GT_4CLASS,
-					"Node # %d Node Handle hNode:0x%x\n",
-					tempCount, (u32)pNodeRes->hNode);
-			pNodeRes = pNodeRes->next;
-			tempCount++;
-		}
-		if (tempCount == 1)
-			GT_0trace(curTrace, GT_4CLASS,
-					"\n ***There are no Nodes"
-					" allocated by this Process***\n");
-		tempCount = 1;
-		pDSPHEAPRes = pCtxtList->pDSPHEAPList;
-		while (pDSPHEAPRes != NULL) {
-			if (tempCount == 1)
-				GT_0trace(curTrace, GT_4CLASS,
-						"\n***The Heaps allocated by"
-						" this Process are***\n");
-			GT_3trace(curTrace, GT_4CLASS,
-				"DSP Heap Resource Info: HEAP # %d "
-				"Mapped GPP Address:0x%x, Size: 0x%lx\n",
-				tempCount, (u32)pDSPHEAPRes->ulMpuAddr,
-				pDSPHEAPRes->heapSize);
-			pDSPHEAPRes = pDSPHEAPRes->next;
-			tempCount++;
-		}
-		if (tempCount == 1)
-			GT_0trace(curTrace, GT_4CLASS,
-				"\n ***There are no Heaps allocated"
-				" by this Process***\n");
-		tempCount = 1;
-		pDMMRes = pCtxtList->pDMMList;
-		while (pDMMRes != NULL) {
-			if (tempCount == 1)
-				GT_0trace(curTrace, GT_4CLASS,
-					"\n ***The DMM resources allocated by"
-					" this Process are***\n");
-			GT_3trace(curTrace, GT_4CLASS,
-				"DMM Resource Info: DMM # %d "
-				"Mapped GPP Address:0X%lx, Size: 0X%lx\n",
-				tempCount, pDMMRes->ulMpuAddr,
-				pDMMRes->dmmSize);
-			pDMMRes = pDMMRes->next;
-			tempCount++;
-		}
-		if (tempCount == 1)
-			GT_0trace(curTrace, GT_4CLASS,
-				"\n ***There are no DMM resources"
-				" allocated by this Process***\n");
-		tempCount = 1;
-		pSTRMRes = pCtxtList->pSTRMList;
-		while (pSTRMRes != NULL) {
-			if (tempCount == 1)
-				GT_0trace(curTrace, GT_4CLASS,
-					"\n***The Stream resources allocated by"
-					" this Process are***\n");
-			GT_2trace(curTrace, GT_4CLASS,
-				"Stream Resource info: STRM # %d"
-				"Stream Handle:0X%x\n",	tempCount,
-				(u32)pSTRMRes->hStream);
-			pSTRMRes = pSTRMRes->next;
-			tempCount++;
-		}
-		if (tempCount == 1)
-			GT_0trace(curTrace, GT_4CLASS,
-				"\n ***There are no Stream resources"
-				"allocated by this Process***\n");
-		pCtxtList = pCtxtList->next;
-	}
-	return status;
-}
-
 /* GPP PROCESS CLEANUP CODE END */
 #endif
 
diff --git a/drivers/dsp/bridge/rmgr/drv_interface.c b/drivers/dsp/bridge/rmgr/drv_interface.c
index 0452029..f0c5e35 100644
--- a/drivers/dsp/bridge/rmgr/drv_interface.c
+++ b/drivers/dsp/bridge/rmgr/drv_interface.c
@@ -420,10 +420,7 @@ static int __devexit omap34xx_bridge_remove(struct platform_device *pdev)
 	dev_t devno;
 	bool ret;
 	DSP_STATUS dsp_status = DSP_SOK;
-	HANDLE	     hDrvObject = NULL;
-	struct PROCESS_CONTEXT	*pTmp = NULL;
-	struct PROCESS_CONTEXT    *pCtxtclosed = NULL;
-	struct PROC_OBJECT *proc_obj_ptr, *temp;
+	HANDLE hDrvObject = NULL;
 
 	GT_0trace(driverTrace, GT_ENTER, "-> driver_exit\n");
 
@@ -441,21 +438,6 @@ static int __devexit omap34xx_bridge_remove(struct platform_device *pdev)
 	}
 #endif /* #ifdef CONFIG_BRIDGE_DVFS */
 
-	DRV_GetProcCtxtList(&pCtxtclosed, (struct DRV_OBJECT *)hDrvObject);
-	while (pCtxtclosed != NULL) {
-		GT_1trace(driverTrace, GT_5CLASS, "***Cleanup of "
-			 "process***%d\n", pCtxtclosed->pid);
-		DRV_RemoveAllResources(pCtxtclosed);
-		list_for_each_entry_safe(proc_obj_ptr, temp,
-				&pCtxtclosed->processor_list, proc_object) {
-			PROC_Detach(proc_obj_ptr, pCtxtclosed);
-		}
-		pTmp = pCtxtclosed->next;
-		DRV_RemoveProcContext((struct DRV_OBJECT *)hDrvObject,
-				     pCtxtclosed);
-		pCtxtclosed = pTmp;
-	}
-
 	if (driverContext) {
 		/* Put the DSP in reset state */
 		ret = DSP_Deinit(driverContext);
@@ -562,8 +544,10 @@ static int bridge_open(struct inode *ip, struct file *filp)
 	 * Allocate a new process context and insert it into global
 	 * process context list.
 	 */
-	DRV_InsertProcContext(hDrvObject, &pr_ctxt);
+	pr_ctxt = MEM_Calloc(sizeof(struct PROCESS_CONTEXT), MEM_PAGED);
 	if (pr_ctxt) {
+		spin_lock_init(&(pr_ctxt->proc_list_lock));
+		INIT_LIST_HEAD(&(pr_ctxt->processor_list));
 		DRV_ProcUpdatestate(pr_ctxt, PROC_RES_ALLOCATED);
 		DRV_ProcSetPID(pr_ctxt, current->tgid);
 	} else {
@@ -605,8 +589,7 @@ static int bridge_release(struct inode *ip, struct file *filp)
 				proc_object) {
 			PROC_Detach(proc_obj_ptr, pr_ctxt);
 		}
-		DRV_RemoveProcContext((struct DRV_OBJECT *)hDrvObject,
-				pr_ctxt);
+		MEM_Free(pr_ctxt);
 	} else {
 		status = -EIO;
 	}
diff --git a/drivers/dsp/bridge/rmgr/proc.c b/drivers/dsp/bridge/rmgr/proc.c
index 6f46a36..9bb9082 100644
--- a/drivers/dsp/bridge/rmgr/proc.c
+++ b/drivers/dsp/bridge/rmgr/proc.c
@@ -177,47 +177,6 @@ static char **PrependEnvp(char **newEnvp, char **envp, s32 cEnvp, s32 cNewEnvp,
 			 char *szVar);
 
 /*
- *  ======== PROC_CleanupAllResources =====
- *  Purpose:
- *      Funtion to clean the process resources.
- *      This function is intended to be called when the
- *       processor is in error state
- */
-DSP_STATUS PROC_CleanupAllResources(void)
-{
-	DSP_STATUS dsp_status = DSP_SOK;
-	HANDLE hDrvObject = NULL;
-	struct PROCESS_CONTEXT *pCtxtclosed = NULL;
-	struct PROC_OBJECT *proc_obj_ptr, *temp;
-
-	GT_0trace(PROC_DebugMask, GT_ENTER, "PROC_CleanupAllResources\n");
-
-	dsp_status = CFG_GetObject((u32 *)&hDrvObject, REG_DRV_OBJECT);
-	if (DSP_FAILED(dsp_status))
-		goto func_end;
-
-	DRV_GetProcCtxtList(&pCtxtclosed, (struct DRV_OBJECT *)hDrvObject);
-
-	while (pCtxtclosed != NULL) {
-		if (current->tgid != pCtxtclosed->pid) {
-			GT_1trace(PROC_DebugMask, GT_5CLASS,
-				 "***Cleanup of "
-				 "process***%d\n", pCtxtclosed->pid);
-			list_for_each_entry_safe(proc_obj_ptr, temp,
-					&pCtxtclosed->processor_list,
-					proc_object) {
-				PROC_Detach(proc_obj_ptr, pCtxtclosed);
-			}
-		}
-		pCtxtclosed = pCtxtclosed->next;
-	}
-
-	WMD_DEH_ReleaseDummyMem();
-func_end:
-	return dsp_status;
-}
-
-/*
  *  ======== PROC_Attach ========
  *  Purpose:
  *      Prepare for communication with a particular DSP processor, and return
@@ -1678,7 +1637,7 @@ DSP_STATUS PROC_Stop(DSP_HPROCESSOR hProcessor)
 		/* Clean up all the resources except the current running
 		 * process resources */
 		if (uBrdState == BRD_ERROR)
-			PROC_CleanupAllResources();
+			WMD_DEH_ReleaseDummyMem();
 	}
 	/* check if there are any running nodes */
 	status = DEV_GetNodeManager(pProcObject->hDevObject, &hNodeMgr);
-- 
1.6.2.4

