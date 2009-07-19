From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 3/3] DSPBRIDGE: NULL and safety checks
Date: Sun, 19 Jul 2009 02:15:44 -0500
Message-ID: <1247987744-18373-3-git-send-email-omar.ramirez@ti.com>
References: <1247987744-18373-1-git-send-email-omar.ramirez@ti.com>
 <1247987744-18373-2-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:47985 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751310AbZGSHJD (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 19 Jul 2009 03:09:03 -0400
In-Reply-To: <1247987744-18373-2-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ameya Palande <ameya.palande@nokia.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Omar Ramirez Luna <omar.ramirez@ti.com>

NULL and safety checks

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 drivers/dsp/bridge/pmgr/dev.c      |   35 +++++--
 drivers/dsp/bridge/pmgr/msg.c      |    4 +-
 drivers/dsp/bridge/rmgr/node.c     |   33 +++++--
 drivers/dsp/bridge/rmgr/proc.c     |   10 ++-
 drivers/dsp/bridge/script.sh       |   10 ++
 drivers/dsp/bridge/services/list.c |   34 +++----
 drivers/dsp/bridge/services/mem.c  |    3 +-
 drivers/dsp/bridge/wmd/io_sm.c     |  188 ++++++++++++++++++++++++------------
 drivers/dsp/bridge/wmd/msg_sm.c    |   81 ++++++++++-----
 9 files changed, 268 insertions(+), 130 deletions(-)
 create mode 100644 drivers/dsp/bridge/script.sh

diff --git a/drivers/dsp/bridge/pmgr/dev.c b/drivers/dsp/bridge/pmgr/dev.c
index 5e4e30b..59eee7d 100644
--- a/drivers/dsp/bridge/pmgr/dev.c
+++ b/drivers/dsp/bridge/pmgr/dev.c
@@ -496,11 +496,15 @@ DSP_STATUS DEV_DestroyDevice(struct DEV_OBJECT *hDevObject)
 	GT_1trace(debugMask, GT_ENTER, "Entered DEV_DestroyDevice, hDevObject: "
 		 "0x%x\n", hDevObject);
 	if (IsValidHandle(hDevObject)) {
-		if (pDevObject->hCodMgr)
+		if (pDevObject->hCodMgr) {
 			COD_Delete(pDevObject->hCodMgr);
+			pDevObject->hCodMgr = NULL;
+		}
 
-		if (pDevObject->hNodeMgr)
+		if (pDevObject->hNodeMgr) {
 			NODE_DeleteMgr(pDevObject->hNodeMgr);
+			pDevObject->hNodeMgr = NULL;
+		}
 
 		/* Free the io, channel, and message managers for this board: */
 		if (pDevObject->hIOMgr) {
@@ -511,28 +515,40 @@ DSP_STATUS DEV_DestroyDevice(struct DEV_OBJECT *hDevObject)
 			CHNL_Destroy(pDevObject->hChnlMgr);
 			pDevObject->hChnlMgr = NULL;
 		}
-		if (pDevObject->hMsgMgr)
+		if (pDevObject->hMsgMgr) {
 			MSG_Delete(pDevObject->hMsgMgr);
+			pDevObject->hMsgMgr = NULL;
+		}
 
 		if (pDevObject->hDehMgr) {
 			/* Uninitialize DEH module. */
 			(*pDevObject->intfFxns.pfnDehDestroy)
 			(pDevObject->hDehMgr);
+			pDevObject->hDehMgr = NULL;
 		}
-		if (pDevObject->hCmmMgr)
+		if (pDevObject->hCmmMgr) {
 			CMM_Destroy(pDevObject->hCmmMgr, true);
+			pDevObject->hCmmMgr = NULL;
+		}
 
-		if (pDevObject->hDmmMgr)
+		if (pDevObject->hDmmMgr) {
 			DMM_Destroy(pDevObject->hDmmMgr);
+			pDevObject->hDmmMgr = NULL;
+		}
 
 		/* Call the driver's WMD_DEV_Destroy() function: */
 		/* Require of DevDestroy */
-		DBC_Assert(pDevObject->hWmdContext != NULL);
-		status = (*pDevObject->intfFxns.pfnDevDestroy)
-			 (pDevObject->hWmdContext);
+		if (pDevObject->hWmdContext) {
+			status = (*pDevObject->intfFxns.pfnDevDestroy)
+				(pDevObject->hWmdContext);
+			pDevObject->hWmdContext = NULL;
+		} else
+			status = DSP_EFAIL;
 		if (DSP_SUCCEEDED(status)) {
-			if (pDevObject->procList)
+			if (pDevObject->procList) {
 				LST_Delete(pDevObject->procList);
+				pDevObject->procList = NULL;
+			}
 
 			/* Remove this DEV_Object from the global list: */
 			DRV_RemoveDevObject(pDevObject->hDrvObject, pDevObject);
@@ -540,6 +556,7 @@ DSP_STATUS DEV_DestroyDevice(struct DEV_OBJECT *hDevObject)
 			 * (pDevObject->hModule);*/
 			/* Free this dev object: */
 			MEM_FreeObject(pDevObject);
+			pDevObject = NULL;
 		}
 	} else {
 		GT_0trace(debugMask, GT_7CLASS, "DEV_Destroy: Invlaid handle");
diff --git a/drivers/dsp/bridge/pmgr/msg.c b/drivers/dsp/bridge/pmgr/msg.c
index be4acdb..d9e4fc6 100644
--- a/drivers/dsp/bridge/pmgr/msg.c
+++ b/drivers/dsp/bridge/pmgr/msg.c
@@ -134,7 +134,9 @@ void MSG_Delete(struct MSG_MGR *hMsgMgr)
 	/* Let WMD message module destroy the MSG_MGR: */
 	(*pIntfFxns->pfnMsgDelete)(hMsgMgr);
 
-	DBC_Ensure(!MEM_IsValidHandle(pMsgMgr, MSGMGR_SIGNATURE));
+	if (MEM_IsValidHandle(pMsgMgr, MSGMGR_SIGNATURE))
+		GT_1trace(MSG_debugMask, GT_7CLASS, "MSG_Delete: Error hMsgMgr "
+					"Valid Handle: 0x%x\n", hMsgMgr);
 }
 
 /*
diff --git a/drivers/dsp/bridge/rmgr/node.c b/drivers/dsp/bridge/rmgr/node.c
index 53a42bf..8ed9046 100644
--- a/drivers/dsp/bridge/rmgr/node.c
+++ b/drivers/dsp/bridge/rmgr/node.c
@@ -1833,11 +1833,13 @@ DSP_STATUS NODE_DeleteMgr(struct NODE_MGR *hNodeMgr)
 	DSP_STATUS status = DSP_SOK;
 
 	DBC_Require(cRefs > 0);
-	DBC_Require(MEM_IsValidHandle(hNodeMgr, NODEMGR_SIGNATURE));
 
 	GT_1trace(NODE_debugMask, GT_ENTER, "NODE_DeleteMgr: hNodeMgr: 0x%x\n",
 		 hNodeMgr);
-	DeleteNodeMgr(hNodeMgr);
+	if (MEM_IsValidHandle(hNodeMgr, NODEMGR_SIGNATURE))
+		DeleteNodeMgr(hNodeMgr);
+	else
+		status = DSP_EHANDLE;
 
 	return status;
 }
@@ -1855,7 +1857,6 @@ DSP_STATUS NODE_EnumNodes(struct NODE_MGR *hNodeMgr, IN DSP_HNODE *aNodeTab,
 	u32 i;
 	DSP_STATUS status = DSP_SOK;
 	DBC_Require(cRefs > 0);
-	DBC_Require(MEM_IsValidHandle(hNodeMgr, NODEMGR_SIGNATURE));
 	DBC_Require(aNodeTab != NULL || uNodeTabSize == 0);
 	DBC_Require(puNumNodes != NULL);
 	DBC_Require(puAllocated != NULL);
@@ -1863,6 +1864,10 @@ DSP_STATUS NODE_EnumNodes(struct NODE_MGR *hNodeMgr, IN DSP_HNODE *aNodeTab,
 		 "aNodeTab: %d\tuNodeTabSize: 0x%x\tpuNumNodes: 0x%x\t"
 		 "puAllocated\n", hNodeMgr, aNodeTab, uNodeTabSize, puNumNodes,
 		 puAllocated);
+	if (!MEM_IsValidHandle(hNodeMgr, NODEMGR_SIGNATURE)) {
+		status = DSP_EHANDLE;
+		goto func_end;
+	}
 	/* Enter critical section */
 	status = SYNC_EnterCS(hNodeMgr->hSync);
 	if (DSP_SUCCEEDED(status)) {
@@ -1887,6 +1892,7 @@ DSP_STATUS NODE_EnumNodes(struct NODE_MGR *hNodeMgr, IN DSP_HNODE *aNodeTab,
 	/* end of SYNC_EnterCS */
 	/* Exit critical section */
 	(void)SYNC_LeaveCS(hNodeMgr->hSync);
+func_end:
 	return status;
 }
 
@@ -2262,7 +2268,9 @@ bool NODE_Init(void)
  */
 void NODE_OnExit(struct NODE_OBJECT *hNode, s32 nStatus)
 {
-	DBC_Assert(MEM_IsValidHandle(hNode, NODE_SIGNATURE));
+	if (!MEM_IsValidHandle(hNode, NODE_SIGNATURE))
+		return;
+
 	/* Set node state to done */
 	NODE_SetState(hNode, NODE_DONE);
 	hNode->nExitStatus = nStatus;
@@ -2576,6 +2584,10 @@ DSP_STATUS NODE_Run(struct NODE_OBJECT *hNode)
 		goto func_end;
 
 	hNodeMgr = hNode->hNodeMgr;
+	if (!MEM_IsValidHandle(hNodeMgr, NODEMGR_SIGNATURE)) {
+		status = DSP_EHANDLE;
+		goto func_end;
+	}
 	pIntfFxns = hNodeMgr->pIntfFxns;
 	/* Enter critical section */
 	status = SYNC_EnterCS(hNodeMgr->hSync);
@@ -2825,10 +2837,11 @@ static void DeleteNode(struct NODE_OBJECT *hNode)
 			(struct PROC_OBJECT *)hNode->hProcessor;
 #endif
 	DSP_STATUS status;
-	DBC_Require(MEM_IsValidHandle(hNode, NODE_SIGNATURE));
+	if (!MEM_IsValidHandle(hNode, NODE_SIGNATURE))
+		goto func_end;
 	hNodeMgr = hNode->hNodeMgr;
-       if (!MEM_IsValidHandle(hNodeMgr, NODEMGR_SIGNATURE))
-               return;
+	if (!MEM_IsValidHandle(hNodeMgr, NODEMGR_SIGNATURE))
+		goto func_end;
 	hXlator = hNode->hXlator;
 	nodeType = NODE_GetType(hNode);
 	if (nodeType != NODE_DEVICE) {
@@ -2963,9 +2976,11 @@ static void DeleteNode(struct NODE_OBJECT *hNode)
 		hNodeMgr->nldrFxns.pfnFree(hNode->hNldrNode);
                hNode->hNldrNode = NULL;
        }
-
+	hNode->hNodeMgr = NULL;
 	MEM_FreeObject(hNode);
-       hNode = NULL;
+	hNode = NULL;
+func_end:
+	return;
 }
 
 /*
diff --git a/drivers/dsp/bridge/rmgr/proc.c b/drivers/dsp/bridge/rmgr/proc.c
index f6045bb..8cfbc46 100644
--- a/drivers/dsp/bridge/rmgr/proc.c
+++ b/drivers/dsp/bridge/rmgr/proc.c
@@ -2032,15 +2032,21 @@ DSP_STATUS PROC_NotifyAllClients(DSP_HPROCESSOR hProc, u32 uEvents)
 	DSP_STATUS status = DSP_SOK;
 	struct PROC_OBJECT *pProcObject = (struct PROC_OBJECT *)hProc;
 
-	DBC_Require(MEM_IsValidHandle(pProcObject, PROC_SIGNATURE));
 	DBC_Require(IsValidProcEvent(uEvents));
 	DBC_Require(cRefs > 0);
 
+	if (!MEM_IsValidHandle(pProcObject, PROC_SIGNATURE)) {
+		status = DSP_EHANDLE;
+		GT_0trace(PROC_DebugMask, GT_7CLASS, "PROC_NotifyAllClients: "
+			 "InValid Processor Handle \n");
+		goto func_end;
+	}
+
 	DEV_NotifyClients(pProcObject->hDevObject, uEvents);
 
 	GT_0trace(PROC_DebugMask, GT_1CLASS,
 		 "PROC_NotifyAllClients :Signaled. \n");
-
+func_end:
 	return status;
 }
 
diff --git a/drivers/dsp/bridge/script.sh b/drivers/dsp/bridge/script.sh
new file mode 100644
index 0000000..9ca4f87
--- /dev/null
+++ b/drivers/dsp/bridge/script.sh
@@ -0,0 +1,10 @@
+#!/bin/sh
+grep -rl "	" $1 |
+while read filename
+do
+(
+echo $filename
+sed "s/	/	/g;" $filename> $filename.xx
+mv $filename.xx $filename
+)
+done
diff --git a/drivers/dsp/bridge/services/list.c b/drivers/dsp/bridge/services/list.c
index 7fa3e76..7ac7772 100644
--- a/drivers/dsp/bridge/services/list.c
+++ b/drivers/dsp/bridge/services/list.c
@@ -95,11 +95,10 @@ struct LST_LIST *LST_Create(void)
  */
 void LST_Delete(struct LST_LIST *pList)
 {
-	DBC_Require(pList != NULL);
-
 	GT_1trace(LST_debugMask, GT_ENTER, "LST_Delete: pList 0x%x\n", pList);
 
-	MEM_Free(pList);
+	if (pList != NULL)
+		MEM_Free(pList);
 }
 
 /*
@@ -122,11 +121,9 @@ struct LST_ELEM *LST_First(struct LST_LIST *pList)
 {
 	struct LST_ELEM *pElem = NULL;
 
-	DBC_Require(pList != NULL);
-
 	GT_1trace(LST_debugMask, GT_ENTER, "LST_First: pList 0x%x\n", pList);
 
-	if (!LST_IsEmpty(pList))
+	if (pList && !LST_IsEmpty(pList))
 		pElem = pList->head.next;
 
 	return pElem;
@@ -141,11 +138,9 @@ struct LST_ELEM *LST_GetHead(struct LST_LIST *pList)
 {
 	struct LST_ELEM *pElem;
 
-	DBC_Require(pList != NULL);
-
 	GT_1trace(LST_debugMask, GT_ENTER, "LST_GetHead: pList 0x%x\n", pList);
 
-	if (LST_IsEmpty(pList))
+	if (!pList || LST_IsEmpty(pList))
 		return NULL;
 
 	/* pElem is always valid because the list cannot be empty
@@ -197,14 +192,13 @@ void LST_InitElem(struct LST_ELEM *pElem)
 void LST_InsertBefore(struct LST_LIST *pList, struct LST_ELEM *pElem,
 		      struct LST_ELEM *pElemExisting)
 {
-	DBC_Require(pList != NULL);
-	DBC_Require(pElem != NULL);
-	DBC_Require(pElemExisting != NULL);
-
 	GT_3trace(LST_debugMask, GT_ENTER, "LST_InsertBefore: pList 0x%x, "
 		  "pElem 0x%x pElemExisting 0x%x\n", pList, pElem,
 		  pElemExisting);
 
+	if (!pList || !pElem || !pElemExisting)
+		return;
+
 	pElemExisting->prev->next = pElem;
 	pElem->prev = pElemExisting->prev;
 	pElem->next = pElemExisting;
@@ -221,8 +215,8 @@ struct LST_ELEM *LST_Next(struct LST_LIST *pList, struct LST_ELEM *pCurElem)
 {
 	struct LST_ELEM *pNextElem = NULL;
 
-	DBC_Require(pList != NULL);
-	DBC_Require(pCurElem != NULL);
+	if (!pList || !pCurElem)
+		return NULL;
 
 	GT_2trace(LST_debugMask, GT_ENTER,
 		  "LST_Next: pList 0x%x, pCurElem 0x%x\n",
@@ -243,13 +237,13 @@ struct LST_ELEM *LST_Next(struct LST_LIST *pList, struct LST_ELEM *pCurElem)
  */
 void LST_PutTail(struct LST_LIST *pList, struct LST_ELEM *pElem)
 {
-	DBC_Require(pList != NULL);
-	DBC_Require(pElem != NULL);
-
 	GT_2trace(LST_debugMask, GT_ENTER,
 		  "LST_PutTail: pList 0x%x, pElem 0x%x\n",
 		  pList, pElem);
 
+	if (!pList || !pElem)
+		return;
+
 	pElem->prev = pList->head.prev;
 	pElem->next = &pList->head;
 	pList->head.prev = pElem;
@@ -266,8 +260,8 @@ void LST_PutTail(struct LST_LIST *pList, struct LST_ELEM *pElem)
  */
 void LST_RemoveElem(struct LST_LIST *pList, struct LST_ELEM *pCurElem)
 {
-	DBC_Require(pList != NULL);
-	DBC_Require(pCurElem != NULL);
+	if (!pList || !pCurElem)
+		return;
 
 	GT_2trace(LST_debugMask, GT_ENTER,
 		  "LST_RemoveElem: pList 0x%x, pCurElem "
diff --git a/drivers/dsp/bridge/services/mem.c b/drivers/dsp/bridge/services/mem.c
index 47ec09b..a3f86f7 100644
--- a/drivers/dsp/bridge/services/mem.c
+++ b/drivers/dsp/bridge/services/mem.c
@@ -480,7 +480,8 @@ void MEM_Exit(void)
  */
 void MEM_FlushCache(void *pMemBuf, u32 cBytes, s32 FlushType)
 {
-	DBC_Require(cRefs > 0);
+	if (cRefs <= 0 || !pMemBuf)
+		return;
 
 	switch (FlushType) {
 	/* invalidate only */
diff --git a/drivers/dsp/bridge/wmd/io_sm.c b/drivers/dsp/bridge/wmd/io_sm.c
index 6f7e338..f7e8b42 100644
--- a/drivers/dsp/bridge/wmd/io_sm.c
+++ b/drivers/dsp/bridge/wmd/io_sm.c
@@ -206,20 +206,24 @@ DSP_STATUS WMD_IO_Create(OUT struct IO_MGR **phIOMgr,
 	struct CHNL_MGR *hChnlMgr;
        static int ref_count;
 	u32 devType;
-	/* Check DBC requirements:  */
-	DBC_Require(phIOMgr != NULL);
-	DBC_Require(pMgrAttrs != NULL);
-	DBC_Require(pMgrAttrs->uWordSize != 0);
-	/* This for the purposes of DBC_Require: */
+	/* Check requirements:  */
+	if (!phIOMgr || !pMgrAttrs || pMgrAttrs->uWordSize == 0) {
+		status = DSP_EHANDLE;
+		goto func_end;
+	}
 	status = DEV_GetChnlMgr(hDevObject, &hChnlMgr);
-	DBC_Require(status != DSP_EHANDLE);
-	DBC_Require(hChnlMgr != NULL);
-	DBC_Require(hChnlMgr->hIOMgr == NULL);
+	if (status == DSP_EHANDLE || !hChnlMgr || hChnlMgr->hIOMgr) {
+		status = DSP_EHANDLE;
+		goto func_end;
+	}
 	 /*  Message manager will be created when a file is loaded, since
 	 *  size of message buffer in shared memory is configurable in
 	 *  the base image.  */
 	DEV_GetWMDContext(hDevObject, &hWmdContext);
-	DBC_Assert(hWmdContext);
+	if (!hWmdContext) {
+		status = DSP_EHANDLE;
+		goto func_end;
+	}
 	DEV_GetDevType(hDevObject, &devType);
 	/*  DSP shared memory area will get set properly when
 	 *  a program is loaded. They are unknown until a COFF file is
@@ -306,6 +310,7 @@ func_cont:
 		hChnlMgr->hIOMgr = pIOMgr;
 		*phIOMgr = pIOMgr;
 	}
+func_end:
 	return status;
 }
 
@@ -321,14 +326,15 @@ DSP_STATUS WMD_IO_Destroy(struct IO_MGR *hIOMgr)
 	if (MEM_IsValidHandle(hIOMgr, IO_MGRSIGNATURE)) {
 		/* Unplug IRQ:    */
                /* Disable interrupts from the board:  */
-               if (DSP_SUCCEEDED(DEV_GetWMDContext(hIOMgr->hDevObject,
-                      &hWmdContext)))
-                               DBC_Assert(hWmdContext);
-               (void)CHNLSM_DisableInterrupt(hWmdContext);
-               destroy_workqueue(bridge_workqueue);
-               /* Linux function to uninstall ISR */
-               free_irq(INT_MAIL_MPU_IRQ, (void *)hIOMgr);
-               (void)DPC_Destroy(hIOMgr->hDPC);
+		status = DEV_GetWMDContext(hIOMgr->hDevObject, &hWmdContext);
+		if (DSP_SUCCEEDED(status))
+			(void)CHNLSM_DisableInterrupt(hWmdContext);
+
+		destroy_workqueue(bridge_workqueue);
+		/* Linux function to uninstall ISR */
+		free_irq(INT_MAIL_MPU_IRQ, (void *)hIOMgr);
+		if (hIOMgr->hDPC)
+			(void)DPC_Destroy(hIOMgr->hDPC);
 #ifndef DSP_TRACEBUF_DISABLED
 		if (hIOMgr->pMsg)
 			MEM_Free(hIOMgr->pMsg);
@@ -388,13 +394,17 @@ DSP_STATUS WMD_IO_OnLoaded(struct IO_MGR *hIOMgr)
 			   HW_PAGE_SIZE_64KB, HW_PAGE_SIZE_4KB };
 
 	status = DEV_GetCodMgr(hIOMgr->hDevObject, &hCodMan);
-	DBC_Assert(DSP_SUCCEEDED(status));
+	if (DSP_FAILED(status))
+		goto func_end;
 	hChnlMgr = hIOMgr->hChnlMgr;
 	 /*  The message manager is destroyed when the board is stopped.  */
 	DEV_GetMsgMgr(hIOMgr->hDevObject, &hIOMgr->hMsgMgr);
 	hMsgMgr = hIOMgr->hMsgMgr;
-	DBC_Assert(MEM_IsValidHandle(hChnlMgr, CHNL_MGRSIGNATURE));
-	DBC_Assert(MEM_IsValidHandle(hMsgMgr, MSGMGR_SIGNATURE));
+	if (!MEM_IsValidHandle(hChnlMgr, CHNL_MGRSIGNATURE) ||
+	   !MEM_IsValidHandle(hMsgMgr, MSGMGR_SIGNATURE)) {
+		status = DSP_EMEMORY;
+		goto func_end;
+	}
 	if (hIOMgr->pSharedMem)
 		hIOMgr->pSharedMem = NULL;
 
@@ -547,7 +557,8 @@ func_cont1:
 				status = hIOMgr->pIntfFxns->pfnBrdMemMap
 					(hIOMgr->hWmdContext, paCurr, vaCurr,
 					pgSize[i], mapAttrs);
-				DBC_Assert(DSP_SUCCEEDED(status));
+				if (DSP_FAILED(status))
+					goto func_end;
 				paCurr += pgSize[i];
 				vaCurr += pgSize[i];
 				gppVaCurr += pgSize[i];
@@ -608,7 +619,8 @@ func_cont1:
 					 aEProc[ndx].ulGppVa,
 					 aEProc[ndx].ulDspVa *
 					 hIOMgr->uWordSize, pgSize[i]);
-				DBC_Assert(DSP_SUCCEEDED(status));
+				if (DSP_FAILED(status))
+					goto func_end;
 			}
 			paCurr += pgSize[i];
 			vaCurr += pgSize[i];
@@ -705,9 +717,12 @@ func_cont:
 		if ((hIOMgr->extProcInfo.tyTlb[0].ulGppPhys == 0) ||
 		   (uNumProcs != 1)) {
 			status = CHNL_E_NOMEMMAP;
-			DBC_Assert(false);
+			goto func_end;
 		} else {
-			DBC_Assert(aEProc[0].ulDspVa <= ulShmBase);
+			if (aEProc[0].ulDspVa > ulShmBase) {
+				status = DSP_EFAIL;
+				goto func_end;
+			}
 			/* ulShmBase may not be at ulDspVa address */
 			ulShmBaseOffset = (ulShmBase - aEProc[0].ulDspVa) *
 			    hIOMgr->uWordSize;
@@ -715,8 +730,10 @@ func_cont:
 			 *   _BRD_Start() the MMU will be re-programed with MMU
 			 *   DSPVa-GPPPa pair info while DSP is in a known
 			 *   (reset) state.  */
-			DBC_Assert(hIOMgr->pIntfFxns != NULL);
-			DBC_Assert(hIOMgr->hWmdContext != NULL);
+			if (!hIOMgr->pIntfFxns || !hIOMgr->hWmdContext)	{
+				status = DSP_EHANDLE;
+				goto func_end;
+			}
 			status = hIOMgr->pIntfFxns->pfnDevCntrl(hIOMgr->
 				 hWmdContext, WMDIOCTL_SETMMUCONFIG, aEProc);
 			ulShmBase = hIOMgr->extProcInfo.tyTlb[0].ulGppPhys;
@@ -726,6 +743,10 @@ func_cont:
 			ulShmBase += ulShmBaseOffset;
 			ulShmBase = (u32)MEM_LinearAddress((void *)ulShmBase,
 				    ulMemLength);
+			if (ulShmBase == 0) {
+				status = DSP_EFAIL;
+				goto func_end;
+			}
 			DBC_Assert(ulShmBase != 0);
 			if (DSP_SUCCEEDED(status)) {
 				status = registerSHMSegs(hIOMgr, hCodMan,
@@ -824,6 +845,7 @@ func_cont:
     }
 #endif
 	IO_EnableInterrupt(hIOMgr->hWmdContext);
+func_end:
 	return status;
 }
 
@@ -833,9 +855,10 @@ func_cont:
  */
 u32 IO_BufSize(struct IO_MGR *hIOMgr)
 {
-	DBC_Require(MEM_IsValidHandle(hIOMgr, IO_MGRSIGNATURE));
-
-	return hIOMgr->uSMBufSize;
+	if (MEM_IsValidHandle(hIOMgr, IO_MGRSIGNATURE))
+		return hIOMgr->uSMBufSize;
+	else
+		return 0;
 }
 
 /*
@@ -847,7 +870,8 @@ void IO_CancelChnl(struct IO_MGR *hIOMgr, u32 ulChnl)
 	struct IO_MGR *pIOMgr = (struct IO_MGR *)hIOMgr;
 	struct SHM *sm;
 
-	DBC_Require(MEM_IsValidHandle(hIOMgr, IO_MGRSIGNATURE));
+	if (!MEM_IsValidHandle(hIOMgr, IO_MGRSIGNATURE))
+		goto func_end;
 	sm = hIOMgr->pSharedMem;
 
 	/* Inform DSP that we have no more buffers on this channel:  */
@@ -855,6 +879,8 @@ void IO_CancelChnl(struct IO_MGR *hIOMgr, u32 ulChnl)
 		   (~(1 << ulChnl)));
 
 	CHNLSM_InterruptDSP2(pIOMgr->hWmdContext, MBX_PCPY_CLASS);
+func_end:
+	return;
 }
 
 /*
@@ -864,16 +890,20 @@ void IO_CancelChnl(struct IO_MGR *hIOMgr, u32 ulChnl)
 static void IO_DispatchChnl(IN struct IO_MGR *pIOMgr,
 			   IN OUT struct CHNL_OBJECT *pChnl, u32 iMode)
 {
-	DBC_Require(MEM_IsValidHandle(pIOMgr, IO_MGRSIGNATURE));
+	if (!MEM_IsValidHandle(pIOMgr, IO_MGRSIGNATURE))
+		goto func_end;
 
 	DBG_Trace(DBG_LEVEL3, "Entering IO_DispatchChnl \n");
 
 	/* See if there is any data available for transfer: */
-	DBC_Assert(iMode == IO_SERVICE);
+	if (iMode != IO_SERVICE)
+		goto func_end;
 
 	/* Any channel will do for this mode: */
 	InputChnl(pIOMgr, pChnl, iMode);
 	OutputChnl(pIOMgr, pChnl, iMode);
+func_end:
+	return;
 }
 
 /*
@@ -882,13 +912,16 @@ static void IO_DispatchChnl(IN struct IO_MGR *pIOMgr,
  */
 static void IO_DispatchMsg(IN struct IO_MGR *pIOMgr, struct MSG_MGR *hMsgMgr)
 {
-	DBC_Require(MEM_IsValidHandle(pIOMgr, IO_MGRSIGNATURE));
+	if (!MEM_IsValidHandle(pIOMgr, IO_MGRSIGNATURE))
+		goto func_end;
 
 	DBG_Trace(DBG_LEVEL3, "Entering IO_DispatchMsg \n");
 
 	/*  We are performing both input and output processing. */
 	InputMsg(pIOMgr, hMsgMgr);
 	OutputMsg(pIOMgr, hMsgMgr);
+func_end:
+	return;
 }
 
 /*
@@ -902,8 +935,6 @@ static void IO_DispatchPM(struct work_struct *work)
 	DSP_STATUS status;
 	u32 pArg[2];
 
-       /*DBC_Require(MEM_IsValidHandle(pIOMgr, IO_MGRSIGNATURE));*/
-
 	DBG_Trace(DBG_LEVEL7, "IO_DispatchPM: Entering IO_DispatchPM : \n");
 
 	/*  Perform Power message processing here  */
@@ -968,11 +999,13 @@ void IO_DPC(IN OUT void *pRefData)
 	struct MSG_MGR *pMsgMgr;
 	struct DEH_MGR *hDehMgr;
 
-	DBC_Require(MEM_IsValidHandle(pIOMgr, IO_MGRSIGNATURE));
+	if (!MEM_IsValidHandle(pIOMgr, IO_MGRSIGNATURE))
+		goto func_end;
 	pChnlMgr = pIOMgr->hChnlMgr;
 	DEV_GetMsgMgr(pIOMgr->hDevObject, &pMsgMgr);
 	DEV_GetDehMgr(pIOMgr->hDevObject, &hDehMgr);
-	DBC_Require(MEM_IsValidHandle(pChnlMgr, CHNL_MGRSIGNATURE));
+	if (!MEM_IsValidHandle(pChnlMgr, CHNL_MGRSIGNATURE))
+		goto func_end;
 	DBG_Trace(DBG_LEVEL7, "Entering IO_DPC(0x%x)\n", pRefData);
 	/* Check value of interrupt register to ensure it is a valid error */
 	if ((pIOMgr->wIntrVal > DEH_BASE) && (pIOMgr->wIntrVal < DEH_LIMIT)) {
@@ -983,10 +1016,8 @@ void IO_DPC(IN OUT void *pRefData)
 	}
 	IO_DispatchChnl(pIOMgr, NULL, IO_SERVICE);
 #ifdef CHNL_MESSAGES
-	if (pMsgMgr) {
-		DBC_Require(MEM_IsValidHandle(pMsgMgr, MSGMGR_SIGNATURE));
+	if (MEM_IsValidHandle(pMsgMgr, MSGMGR_SIGNATURE))
 		IO_DispatchMsg(pIOMgr, pMsgMgr);
-	}
 #endif
 #ifndef DSP_TRACEBUF_DISABLED
 	if (pIOMgr->wIntrVal & MBX_DBG_CLASS) {
@@ -999,6 +1030,8 @@ void IO_DPC(IN OUT void *pRefData)
 #ifndef DSP_TRACEBUF_DISABLED
 	PrintDSPDebugTrace(pIOMgr);
 #endif
+func_end:
+	return;
 }
 
 
@@ -1012,8 +1045,9 @@ irqreturn_t IO_ISR(int irq, IN void *pRefData)
 {
 	struct IO_MGR *hIOMgr = (struct IO_MGR *)pRefData;
 	bool fSchedDPC;
-       DBC_Require(irq == INT_MAIL_MPU_IRQ);
-	DBC_Require(MEM_IsValidHandle(hIOMgr, IO_MGRSIGNATURE));
+	if (irq != INT_MAIL_MPU_IRQ ||
+	   !MEM_IsValidHandle(hIOMgr, IO_MGRSIGNATURE))
+		return IRQ_NONE;
 	DBG_Trace(DBG_LEVEL3, "Entering IO_ISR(0x%x)\n", pRefData);
 
 	/* Call WMD's CHNLSM_ISR() to see if interrupt is ours, and process. */
@@ -1054,8 +1088,9 @@ void IO_RequestChnl(struct IO_MGR *pIOMgr, struct CHNL_OBJECT *pChnl,
 {
 	struct CHNL_MGR *pChnlMgr;
 	struct SHM *sm;
-	DBC_Require(pChnl != NULL);
-	DBC_Require(pwMbVal != NULL);
+
+	if (!pChnl || !pwMbVal)
+		goto func_end;
 	pChnlMgr = pIOMgr->hChnlMgr;
 	sm = pIOMgr->pSharedMem;
 	if (iMode == IO_INPUT) {
@@ -1078,6 +1113,8 @@ void IO_RequestChnl(struct IO_MGR *pIOMgr, struct CHNL_OBJECT *pChnl,
 	} else {
 		DBC_Assert(iMode); 	/* Shouldn't get here. */
 	}
+func_end:
+	return;
 }
 
 /*
@@ -1086,7 +1123,8 @@ void IO_RequestChnl(struct IO_MGR *pIOMgr, struct CHNL_OBJECT *pChnl,
  */
 void IO_Schedule(struct IO_MGR *pIOMgr)
 {
-	DBC_Require(MEM_IsValidHandle(pIOMgr, IO_MGRSIGNATURE));
+	if (!MEM_IsValidHandle(pIOMgr, IO_MGRSIGNATURE))
+		return;
 
 	DPC_Schedule(pIOMgr->hDPC);
 }
@@ -1107,7 +1145,8 @@ static u32 FindReadyOutput(struct CHNL_MGR *pChnlMgr,
 
 	id = (pChnl != NULL ? pChnl->uId : (pChnlMgr->dwLastOutput + 1));
 	id = ((id == CHNL_MAXCHANNELS) ? 0 : id);
-	DBC_Assert(id < CHNL_MAXCHANNELS);
+	if (id >= CHNL_MAXCHANNELS)
+		goto func_end;
 	if (dwMask) {
 		shift = (1 << id);
 		startId = id;
@@ -1124,7 +1163,7 @@ static u32 FindReadyOutput(struct CHNL_MGR *pChnlMgr,
 			shift = (1 << id);
 		} while (id != startId);
 	}
-	DBC_Ensure((uRetval == OUTPUTNOTREADY) || (uRetval < CHNL_MAXCHANNELS));
+func_end:
 	return uRetval;
 }
 
@@ -1172,7 +1211,8 @@ static void InputChnl(struct IO_MGR *pIOMgr, struct CHNL_OBJECT *pChnl,
 				 pIORequests);
 			if (pChirp) {
 				pChnl->cIOReqs--;
-				DBC_Assert(pChnl->cIOReqs >= 0);
+				if (pChnl->cIOReqs < 0)
+					goto func_end;
 				/* Ensure we don't overflow the client's
 				 * buffer: */
 				uBytes = min(uBytes, pChirp->cBytes);
@@ -1191,8 +1231,8 @@ static void InputChnl(struct IO_MGR *pIOMgr, struct CHNL_OBJECT *pChnl,
 					/* This assertion fails if the DSP
 					 * sends EOS more than once on this
 					 * channel: */
-					DBC_Assert(!(pChnl->dwState &
-						  CHNL_STATEEOS));
+					if (pChnl->dwState & CHNL_STATEEOS)
+						goto func_end;
 					 /* Zero bytes indicates EOS. Update
 					  * IOC status for this chirp, and also
 					  * the channel state: */
@@ -1265,7 +1305,7 @@ static void InputMsg(struct IO_MGR *pIOMgr, struct MSG_MGR *hMsgMgr)
 				 bufEmpty);
 	uMsgs = IO_GetValue(pIOMgr->hWmdContext, struct MSG, pCtrl, size);
 	if (fInputEmpty || uMsgs >= hMsgMgr->uMaxMsgs)
-		return;
+		goto func_end;
 
 	pMsgInput = pIOMgr->pMsgInput;
 	for (i = 0; i < uMsgs; i++) {
@@ -1360,8 +1400,10 @@ static void NotifyChnlComplete(struct CHNL_OBJECT *pChnl,
 {
 	bool fSignalEvent;
 
-	DBC_Require(MEM_IsValidHandle(pChnl, CHNL_SIGNATURE));
-	DBC_Require(pChnl->hSyncEvent != NULL);
+	if (!MEM_IsValidHandle(pChnl, CHNL_SIGNATURE) || !pChnl->hSyncEvent ||
+	   !pChnl->pIOCompletions || !pChirp)
+		goto func_end;
+
 	 /*  Note: we signal the channel event only if the queue of IO
 	  *  completions is empty.  If it is not empty, the event is sure to be
 	  *  signalled by the only IO completion list consumer:
@@ -1370,13 +1412,17 @@ static void NotifyChnlComplete(struct CHNL_OBJECT *pChnl,
 	/* Enqueue the IO completion info for the client: */
 	LST_PutTail(pChnl->pIOCompletions, (struct LST_ELEM *) pChirp);
 	pChnl->cIOCs++;
-	DBC_Assert(pChnl->cIOCs <= pChnl->cChirps);
+
+	if (pChnl->cIOCs > pChnl->cChirps)
+		goto func_end;
 	/* Signal the channel event (if not already set) that IO is complete: */
 	if (fSignalEvent)
 		SYNC_SetEvent(pChnl->hSyncEvent);
 
 	/* Notify that IO is complete */
 	NTFY_Notify(pChnl->hNtfy, DSP_STREAMIOCOMPLETION);
+func_end:
+	return;
 }
 
 /*
@@ -1573,13 +1619,19 @@ static DSP_STATUS registerSHMSegs(struct IO_MGR *hIOMgr,
 	/* Read address and size info for first SM region.*/
 	/* Get start of 1st SM Heap region */
 	status = COD_GetSymValue(hCodMan, SHM0_SHARED_BASE_SYM, &ulShm0_Base);
-	DBC_Assert(ulShm0_Base != 0);
+	if (ulShm0_Base == 0) {
+		status = DSP_EFAIL;
+		goto func_end;
+	}
 	/* Get end of 1st SM Heap region */
 	if (DSP_SUCCEEDED(status)) {
 		/* Get start and length of message part of shared memory */
 		status = COD_GetSymValue(hCodMan, SHM0_SHARED_END_SYM,
 					 &ulShm0_End);
-		DBC_Assert(ulShm0_End != 0);
+		if (ulShm0_End == 0) {
+			status = DSP_EFAIL;
+			goto func_end;
+		}
 	}
 	/* start of Gpp reserved region */
 	if (DSP_SUCCEEDED(status)) {
@@ -1588,7 +1640,10 @@ static DSP_STATUS registerSHMSegs(struct IO_MGR *hIOMgr,
 					&ulShm0_RsrvdStart);
 		DBG_Trace(DBG_LEVEL1, "***ulShm0_RsrvdStart  0x%x \n",
 			 ulShm0_RsrvdStart);
-		DBC_Assert(ulShm0_RsrvdStart != 0);
+		if (ulShm0_RsrvdStart == 0) {
+			status = DSP_EFAIL;
+			goto func_end;
+		}
 	}
 	/* Register with CMM */
 	if (DSP_SUCCEEDED(status)) {
@@ -1610,11 +1665,17 @@ static DSP_STATUS registerSHMSegs(struct IO_MGR *hIOMgr,
 		/* calc size (bytes) of SM the GPP can alloc from */
 		ulRsrvdSize = (ulShm0_End - ulShm0_RsrvdStart + 1) * hIOMgr->
 			      uWordSize;
-		DBC_Assert(ulRsrvdSize > 0);
+		if (ulRsrvdSize <= 0) {
+			status = DSP_EFAIL;
+			goto func_end;
+		}
 		/* calc size of SM DSP can alloc from */
 		ulDSPSize = (ulShm0_RsrvdStart - ulShm0_Base) * hIOMgr->
 			uWordSize;
-		DBC_Assert(ulDSPSize > 0);
+		if (ulDSPSize <= 0) {
+			status = DSP_EFAIL;
+			goto func_end;
+		}
 		/*  First TLB entry reserved for Bridge SM use.*/
 		ulGppPhys = hIOMgr->extProcInfo.tyTlb[0].ulGppPhys;
 		/* get size in bytes */
@@ -1627,7 +1688,10 @@ static DSP_STATUS registerSHMSegs(struct IO_MGR *hIOMgr,
 		else
 			dwOffset = ulDspVirt - dwGPPBasePA;
 
-		DBC_Assert(ulShm0_RsrvdStart * hIOMgr->uWordSize >= ulDspVirt);
+		if (ulShm0_RsrvdStart * hIOMgr->uWordSize < ulDspVirt) {
+			status = DSP_EFAIL;
+			goto func_end;
+		}
 		/* calc Gpp phys base of SM region */
 		/* Linux - this is actually uncached kernel virtual address*/
 		dwGPPBaseVA = ulGppPhys + ulShm0_RsrvdStart * hIOMgr->uWordSize
@@ -1647,8 +1711,10 @@ static DSP_STATUS registerSHMSegs(struct IO_MGR *hIOMgr,
 				 "Seg 0 \n");
 		}
 		/* first SM region is segId = 1 */
-		DBC_Assert(ulShmSegId0 == 1);
+		if (ulShmSegId0 != 1)
+			status = DSP_EFAIL;
 	}
+func_end:
 	return status;
 }
 
diff --git a/drivers/dsp/bridge/wmd/msg_sm.c b/drivers/dsp/bridge/wmd/msg_sm.c
index b9b2bec..6a736f9 100644
--- a/drivers/dsp/bridge/wmd/msg_sm.c
+++ b/drivers/dsp/bridge/wmd/msg_sm.c
@@ -86,11 +86,15 @@ DSP_STATUS WMD_MSG_Create(OUT struct MSG_MGR **phMsgMgr,
 	struct IO_MGR *hIOMgr;
 	DSP_STATUS status = DSP_SOK;
 
-	DBC_Require(phMsgMgr != NULL);
-	DBC_Require(msgCallback != NULL);
-	DBC_Require(hDevObject != NULL);
+	if (!phMsgMgr || !msgCallback || !hDevObject) {
+		status = DSP_EPOINTER;
+		goto func_end;
+	}
 	DEV_GetIOMgr(hDevObject, &hIOMgr);
-	DBC_Assert(hIOMgr != NULL);
+	if (!hIOMgr) {
+		status = DSP_EPOINTER;
+		goto func_end;
+	}
 	*phMsgMgr = NULL;
 	/* Allocate MSG manager object */
 	MEM_AllocObject(pMsgMgr, struct MSG_MGR, MSGMGR_SIGNATURE);
@@ -125,6 +129,7 @@ DSP_STATUS WMD_MSG_Create(OUT struct MSG_MGR **phMsgMgr,
 	} else {
 		status = DSP_EMEMORY;
 	}
+func_end:
 	return status;
 }
 
@@ -142,8 +147,11 @@ DSP_STATUS WMD_MSG_CreateQueue(struct MSG_MGR *hMsgMgr,
 	struct MSG_QUEUE *pMsgQ;
 	DSP_STATUS status = DSP_SOK;
 
-	DBC_Require(MEM_IsValidHandle(hMsgMgr, MSGMGR_SIGNATURE));
-	DBC_Require(phMsgQueue != NULL);
+	if (!MEM_IsValidHandle(hMsgMgr, MSGMGR_SIGNATURE) ||
+	   phMsgQueue == NULL) {
+		status = DSP_EMEMORY;
+		goto func_end;
+	}
 
 	*phMsgQueue = NULL;
 	/* Allocate MSG_QUEUE object */
@@ -226,9 +234,8 @@ func_end:
  */
 void WMD_MSG_Delete(struct MSG_MGR *hMsgMgr)
 {
-	DBC_Require(MEM_IsValidHandle(hMsgMgr, MSGMGR_SIGNATURE));
-
-	DeleteMsgMgr(hMsgMgr);
+	if (MEM_IsValidHandle(hMsgMgr, MSGMGR_SIGNATURE))
+		DeleteMsgMgr(hMsgMgr);
 }
 
 /*
@@ -237,10 +244,14 @@ void WMD_MSG_Delete(struct MSG_MGR *hMsgMgr)
  */
 void WMD_MSG_DeleteQueue(struct MSG_QUEUE *hMsgQueue)
 {
-	struct MSG_MGR *hMsgMgr = hMsgQueue->hMsgMgr;
+	struct MSG_MGR *hMsgMgr;
 	u32 refCount;
 
-	DBC_Require(MEM_IsValidHandle(hMsgQueue, MSGQ_SIGNATURE));
+	if (!MEM_IsValidHandle(hMsgQueue, MSGQ_SIGNATURE) ||
+			!hMsgQueue->hMsgMgr)
+		goto func_end;
+
+	hMsgMgr = hMsgQueue->hMsgMgr;
 	hMsgQueue->fDone = true;
 	 /*  Unblock all threads blocked in MSG_Get() or MSG_Put().  */
 	refCount = hMsgQueue->refCount;
@@ -262,6 +273,8 @@ void WMD_MSG_DeleteQueue(struct MSG_QUEUE *hMsgQueue)
 		SYNC_ResetEvent(hMsgMgr->hSyncEvent);
 func_cont:
 	(void)SYNC_LeaveCS(hMsgMgr->hSyncCS);
+func_end:
+	return;
 }
 
 /*
@@ -278,8 +291,10 @@ DSP_STATUS WMD_MSG_Get(struct MSG_QUEUE *hMsgQueue,
 	u32 uIndex;
 	DSP_STATUS status = DSP_SOK;
 
-	DBC_Require(MEM_IsValidHandle(hMsgQueue, MSGQ_SIGNATURE));
-	DBC_Require(pMsg != NULL);
+	if (!MEM_IsValidHandle(hMsgQueue, MSGQ_SIGNATURE) || pMsg == NULL) {
+		status = DSP_EMEMORY;
+		goto func_end;
+	}
 
 	hMsgMgr = hMsgQueue->hMsgMgr;
        if (!hMsgQueue->msgUsedList) {
@@ -371,11 +386,12 @@ DSP_STATUS WMD_MSG_Put(struct MSG_QUEUE *hMsgQueue,
 	u32 uIndex;
 	DSP_STATUS status = DSP_SOK;
 
-	DBC_Require(MEM_IsValidHandle(hMsgQueue, MSGQ_SIGNATURE));
-	DBC_Require(pMsg != NULL);
-
+	if (!MEM_IsValidHandle(hMsgQueue, MSGQ_SIGNATURE) || !pMsg ||
+						!hMsgQueue->hMsgMgr) {
+		status = DSP_EMEMORY;
+		goto func_end;
+	}
 	hMsgMgr = hMsgQueue->hMsgMgr;
-
        if (!hMsgMgr->msgFreeList) {
                status = DSP_EHANDLE;
                goto func_end;
@@ -474,10 +490,20 @@ DSP_STATUS WMD_MSG_RegisterNotify(struct MSG_QUEUE *hMsgQueue, u32 uEventMask,
 {
 	DSP_STATUS status = DSP_SOK;
 
-	DBC_Require(MEM_IsValidHandle(hMsgQueue, MSGQ_SIGNATURE));
-	DBC_Require(hNotification != NULL);
-	DBC_Require(uEventMask == DSP_NODEMESSAGEREADY || uEventMask == 0);
-	DBC_Require(uNotifyType == DSP_SIGNALEVENT);
+	if (!MEM_IsValidHandle(hMsgQueue, MSGQ_SIGNATURE) || !hNotification) {
+		status = DSP_EMEMORY;
+		goto func_end;
+	}
+
+	if (!(uEventMask == DSP_NODEMESSAGEREADY || uEventMask == 0)) {
+		status = DSP_ENODETYPE;
+		goto func_end;
+	}
+
+	if (uNotifyType != DSP_SIGNALEVENT) {
+		status = DSP_EWRONGSTATE;
+		goto func_end;
+	}
 
 	status = NTFY_Register(hMsgQueue->hNtfy, hNotification, uEventMask,
 			      uNotifyType);
@@ -488,7 +514,7 @@ DSP_STATUS WMD_MSG_RegisterNotify(struct MSG_QUEUE *hMsgQueue, u32 uEventMask,
 		 *  by NODE, and message ready handled by MSG.  */
 		status = DSP_SOK;
 	}
-
+func_end:
 	return status;
 }
 
@@ -497,9 +523,6 @@ DSP_STATUS WMD_MSG_RegisterNotify(struct MSG_QUEUE *hMsgQueue, u32 uEventMask,
  */
 void WMD_MSG_SetQueueId(struct MSG_QUEUE *hMsgQueue, u32 dwId)
 {
-	DBC_Require(MEM_IsValidHandle(hMsgQueue, MSGQ_SIGNATURE));
-	/* DBC_Require(dwId != 0); */
-
 	/*
 	 *  A message queue must be created when a node is allocated,
 	 *  so that NODE_RegisterNotify() can be called before the node
@@ -507,7 +530,8 @@ void WMD_MSG_SetQueueId(struct MSG_QUEUE *hMsgQueue, u32 dwId)
 	 *  node is created, we need this function to set hMsgQueue->dwId
 	 *  to the node environment, after the node is created.
 	 */
-	hMsgQueue->dwId = dwId;
+	if (MEM_IsValidHandle(hMsgQueue, MSGQ_SIGNATURE))
+		hMsgQueue->dwId = dwId;
 }
 
 /*
@@ -536,7 +560,8 @@ static DSP_STATUS AddNewMsg(struct LST_LIST *msgList)
  */
 static void DeleteMsgMgr(struct MSG_MGR *hMsgMgr)
 {
-	DBC_Require(MEM_IsValidHandle(hMsgMgr, MSGMGR_SIGNATURE));
+	if (!MEM_IsValidHandle(hMsgMgr, MSGMGR_SIGNATURE))
+		goto func_end;
 
 	if (hMsgMgr->queueList) {
                if (LST_IsEmpty(hMsgMgr->queueList)) {
@@ -562,6 +587,8 @@ static void DeleteMsgMgr(struct MSG_MGR *hMsgMgr)
 		SYNC_DeleteCS(hMsgMgr->hSyncCS);
 
 	MEM_FreeObject(hMsgMgr);
+func_end:
+	return;
 }
 
 /*
-- 
1.6.2.4

