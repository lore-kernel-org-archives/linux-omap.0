From: Omar Ramirez Luna <x00omar@ti.com>
Subject: [PATCH 07/14] DSPBRIDGE: base image reload suppor after DSP error
Date: Wed, 20 May 2009 00:02:13 -0500
Message-ID: <1242795740-21535-7-git-send-email-x00omar@ti.com>
References: <1242795740-21535-1-git-send-email-x00omar@ti.com>
 <1242795740-21535-2-git-send-email-x00omar@ti.com>
 <1242795740-21535-3-git-send-email-x00omar@ti.com>
 <1242795740-21535-4-git-send-email-x00omar@ti.com>
 <1242795740-21535-5-git-send-email-x00omar@ti.com>
 <1242795740-21535-6-git-send-email-x00omar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:39056 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751819AbZETE6d (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 20 May 2009 00:58:33 -0400
In-Reply-To: <1242795740-21535-6-git-send-email-x00omar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Hiroshi.DOYU@nokia.com, ameya.palande@nokia.com, Fernando Guzman Lugo <x0095840@ti.com>, Hari Kanigeri <h-kanigeri2@ti.com>, Omar Ramirez Luna <x00omar@ti.com>

From: Fernando Guzman Lugo <x0095840@ti.com>

Added support for reloading the base image after DSP error

Signed-off-by: Hari Kanigeri <h-kanigeri2@ti.com>
Signed-off-by: Fernando Guzman Lugo <x0095840@ti.com>
Signed-off-by: Omar Ramirez Luna <x00omar@ti.com>
---
 arch/arm/plat-omap/include/dspbridge/wmddeh.h |    2 +
 drivers/dsp/bridge/rmgr/node.c                |   72 +++++++------
 drivers/dsp/bridge/rmgr/proc.c                |  153 +++++++++++++++++++------
 drivers/dsp/bridge/wmd/ue_deh.c               |   37 +++++-
 4 files changed, 188 insertions(+), 76 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/wmddeh.h b/arch/arm/plat-omap/include/dspbridge/wmddeh.h
index dd50a3a..60704da 100644
--- a/arch/arm/plat-omap/include/dspbridge/wmddeh.h
+++ b/arch/arm/plat-omap/include/dspbridge/wmddeh.h
@@ -61,4 +61,6 @@
 
 	extern void WMD_DEH_Notify(struct DEH_MGR *hDehMgr,
 				   u32 ulEventMask, u32 dwErrInfo);
+
+	extern void WMD_DEH_ReleaseDummyMem(void);
 #endif				/* WMDDEH_ */
diff --git a/drivers/dsp/bridge/rmgr/node.c b/drivers/dsp/bridge/rmgr/node.c
index af604f9..53a42bf 100644
--- a/drivers/dsp/bridge/rmgr/node.c
+++ b/drivers/dsp/bridge/rmgr/node.c
@@ -864,8 +864,7 @@ DBAPI NODE_AllocMsgBuf(struct NODE_OBJECT *hNode, u32 uSize,
 
 	if (!MEM_IsValidHandle(pNode, NODE_SIGNATURE))
 		status = DSP_EHANDLE;
-
-	if (NODE_GetType(pNode) == NODE_DEVICE)
+	else if (NODE_GetType(pNode) == NODE_DEVICE)
 		status = DSP_ENODETYPE;
 
 	if (DSP_FAILED(status))
@@ -1337,6 +1336,10 @@ DSP_STATUS NODE_Create(struct NODE_OBJECT *hNode)
 	DBC_Require(cRefs > 0);
 	GT_1trace(NODE_debugMask, GT_ENTER, "NODE_Create: hNode: 0x%x\n",
 		 hNode);
+	if (!MEM_IsValidHandle(pNode, NODE_SIGNATURE)) {
+		status = DSP_EHANDLE;
+		goto func_end;
+	}
 	hProcessor = hNode->hProcessor;
 	status = PROC_GetState(hProcessor, &procStatus,
 					sizeof(struct DSP_PROCESSORSTATE));
@@ -1921,9 +1924,10 @@ DSP_STATUS NODE_FreeMsgBuf(struct NODE_OBJECT *hNode, IN u8 *pBuffer,
 	DBC_Require(pNode->hXlator != NULL);
 	GT_3trace(NODE_debugMask, GT_ENTER, "NODE_FreeMsgBuf: hNode: 0x%x\t"
 		 "pBuffer: 0x%x\tpAttr: 0x%x\n", hNode, pBuffer, pAttr);
-	if (!MEM_IsValidHandle(hNode, NODE_SIGNATURE))
+	if (!MEM_IsValidHandle(hNode, NODE_SIGNATURE)) {
 		status = DSP_EHANDLE;
-
+		goto func_end;
+	}
 	status = PROC_GetProcessorId(pNode->hProcessor, &procId);
 	if (procId == DSP_UNIT) {
 		if (DSP_SUCCEEDED(status)) {
@@ -1946,6 +1950,7 @@ DSP_STATUS NODE_FreeMsgBuf(struct NODE_OBJECT *hNode, IN u8 *pBuffer,
 	} else {
 		DBC_Assert(NULL);	/* BUG */
 	}
+func_end:
 	return status;
 }
 
@@ -2063,6 +2068,10 @@ DSP_STATUS NODE_GetMessage(struct NODE_OBJECT *hNode, OUT struct DSP_MSG *pMsg,
 	GT_3trace(NODE_debugMask, GT_ENTER,
 		 "NODE_GetMessage: hNode: 0x%x\tpMsg: "
 		 "0x%x\tuTimeout: 0x%x\n", hNode, pMsg, uTimeout);
+	if (!MEM_IsValidHandle(hNode, NODE_SIGNATURE)) {
+		status = DSP_EHANDLE;
+		goto func_end;
+	}
 	hProcessor = hNode->hProcessor;
 	status = PROC_GetState(hProcessor, &procStatus,
 					sizeof(struct DSP_PROCESSORSTATE));
@@ -2076,10 +2085,6 @@ DSP_STATUS NODE_GetMessage(struct NODE_OBJECT *hNode, OUT struct DSP_MSG *pMsg,
 		status = DSP_EFAIL;
 		goto func_end;
 	}
-	if (!MEM_IsValidHandle(hNode, NODE_SIGNATURE)) {
-		status = DSP_EHANDLE;
-		goto func_end;
-	}
 	hNodeMgr = hNode->hNodeMgr;
 	nodeType = NODE_GetType(hNode);
 	if (nodeType != NODE_MESSAGE && nodeType != NODE_TASK &&
@@ -2295,12 +2300,14 @@ DSP_STATUS NODE_Pause(struct NODE_OBJECT *hNode)
 
 	if (!MEM_IsValidHandle(hNode, NODE_SIGNATURE)) {
 		status = DSP_EHANDLE;
+		goto func_end;
 	} else {
 		nodeType = NODE_GetType(hNode);
 		if (nodeType != NODE_TASK && nodeType != NODE_DAISSOCKET)
 			status = DSP_ENODETYPE;
-
 	}
+	if (DSP_FAILED(status))
+		goto func_end;
 
 	status = PROC_GetProcessorId(pNode->hProcessor, &procId);
 
@@ -2387,6 +2394,10 @@ DSP_STATUS NODE_PutMessage(struct NODE_OBJECT *hNode,
 	GT_3trace(NODE_debugMask, GT_ENTER,
 		 "NODE_PutMessage: hNode: 0x%x\tpMsg: "
 		 "0x%x\tuTimeout: 0x%x\n", hNode, pMsg, uTimeout);
+	if (!MEM_IsValidHandle(hNode, NODE_SIGNATURE)) {
+		status = DSP_EHANDLE;
+		goto func_end;
+	}
 	hProcessor = hNode->hProcessor;
 	status = PROC_GetState(hProcessor, &procStatus,
 					sizeof(struct DSP_PROCESSORSTATE));
@@ -2400,15 +2411,12 @@ DSP_STATUS NODE_PutMessage(struct NODE_OBJECT *hNode,
 		status = DSP_EFAIL;
 		goto func_end;
 	}
-	if (!MEM_IsValidHandle(hNode, NODE_SIGNATURE))
-		status = DSP_EHANDLE;
-	else {
-		hNodeMgr = hNode->hNodeMgr;
-		nodeType = NODE_GetType(hNode);
-		if (nodeType != NODE_MESSAGE && nodeType != NODE_TASK &&
-		    nodeType != NODE_DAISSOCKET)
-			status = DSP_ENODETYPE;
-	}
+	hNodeMgr = hNode->hNodeMgr;
+	nodeType = NODE_GetType(hNode);
+	if (nodeType != NODE_MESSAGE && nodeType != NODE_TASK &&
+	    nodeType != NODE_DAISSOCKET)
+		status = DSP_ENODETYPE;
+
 	if (DSP_SUCCEEDED(status)) {
 		/*  Check node state. Can't send messages to a node after
 		 *  we've sent the RMS_EXIT command. There is still the
@@ -2545,6 +2553,10 @@ DSP_STATUS NODE_Run(struct NODE_OBJECT *hNode)
 
 	DBC_Require(cRefs > 0);
 	GT_1trace(NODE_debugMask, GT_ENTER, "NODE_Run: hNode: 0x%x\n", hNode);
+	if (!MEM_IsValidHandle(hNode, NODE_SIGNATURE)) {
+		status = DSP_EHANDLE;
+		goto func_end;
+	}
 	hProcessor = hNode->hProcessor;
 	status = PROC_GetState(hProcessor, &procStatus,
 					sizeof(struct DSP_PROCESSORSTATE));
@@ -2557,13 +2569,9 @@ DSP_STATUS NODE_Run(struct NODE_OBJECT *hNode)
 		status = DSP_EFAIL;
 		goto func_end;
 	}
-	if (!MEM_IsValidHandle(hNode, NODE_SIGNATURE)) {
-		status = DSP_EHANDLE;
-	} else {
-		nodeType = NODE_GetType(hNode);
-		if (nodeType == NODE_DEVICE)
-			status = DSP_ENODETYPE;
-	}
+	nodeType = NODE_GetType(hNode);
+	if (nodeType == NODE_DEVICE)
+		status = DSP_ENODETYPE;
 	if (DSP_FAILED(status))
 		goto func_end;
 
@@ -2666,7 +2674,10 @@ DSP_STATUS NODE_Terminate(struct NODE_OBJECT *hNode, OUT DSP_STATUS *pStatus)
 
 	GT_1trace(NODE_debugMask, GT_ENTER,
 		 "NODE_Terminate: hNode: 0x%x\n", hNode);
-
+	if (!MEM_IsValidHandle(hNode, NODE_SIGNATURE)) {
+		status = DSP_EHANDLE;
+		goto func_end;
+	}
 	if (pNode->hProcessor == NULL) {
 		GT_1trace(NODE_debugMask, GT_4CLASS,
 		"NODE_Terminate: pNode->hProcessor = 0x%x\n",
@@ -2677,15 +2688,10 @@ DSP_STATUS NODE_Terminate(struct NODE_OBJECT *hNode, OUT DSP_STATUS *pStatus)
 
 	if (DSP_SUCCEEDED(status)) {
 		hNodeMgr = hNode->hNodeMgr;
-
-		if (!MEM_IsValidHandle(hNode, NODE_SIGNATURE))
-			status = DSP_EHANDLE;
-		else {
-			nodeType = NODE_GetType(hNode);
-			if (nodeType != NODE_TASK && nodeType !=
+		nodeType = NODE_GetType(hNode);
+		if (nodeType != NODE_TASK && nodeType !=
 			   NODE_DAISSOCKET)
 				status = DSP_ENODETYPE;
-		}
 	}
 	if (DSP_SUCCEEDED(status)) {
 		/* Check node state */
diff --git a/drivers/dsp/bridge/rmgr/proc.c b/drivers/dsp/bridge/rmgr/proc.c
index 59073dd..bb8cff3 100644
--- a/drivers/dsp/bridge/rmgr/proc.c
+++ b/drivers/dsp/bridge/rmgr/proc.c
@@ -121,7 +121,7 @@
 #include <dspbridge/sync.h>
 /*  ----------------------------------- Mini Driver */
 #include <dspbridge/wmd.h>
-
+#include <dspbridge/wmddeh.h>
 /*  ----------------------------------- Platform Manager */
 #include <dspbridge/cod.h>
 #include <dspbridge/dev.h>
@@ -197,6 +197,37 @@ static s32 GetEnvpCount(char **envp);
 static char **PrependEnvp(char **newEnvp, char **envp, s32 cEnvp, s32 cNewEnvp,
 			 char *szVar);
 
+/*
+ *  ======== PROC_CleanupAllResources =====
+ *  Purpose:
+ *      Funtion to clean the process resources.
+ *      This function is intended to be called when the
+ *       processor is in error state
+ */
+DSP_STATUS PROC_CleanupAllResources(void)
+{
+	DSP_STATUS dsp_status = DSP_SOK;
+	HANDLE	     hDrvObject = NULL;
+	struct PROCESS_CONTEXT    *pCtxtclosed = NULL;
+	GT_0trace(PROC_DebugMask, GT_ENTER, "PROC_CleanupAllResources\n");
+	dsp_status = CFG_GetObject((u32 *)&hDrvObject, REG_DRV_OBJECT);
+	if (DSP_FAILED(dsp_status))
+		goto func_end;
+	DRV_GetProcCtxtList(&pCtxtclosed, (struct DRV_OBJECT *)hDrvObject);
+	while (pCtxtclosed != NULL) {
+		if (current->pid != pCtxtclosed->pid) {
+			GT_1trace(PROC_DebugMask, GT_5CLASS,
+				 "***Cleanup of "
+				 "process***%d\n", pCtxtclosed->pid);
+			if (pCtxtclosed->hProcessor)
+				PROC_Detach(pCtxtclosed->hProcessor);
+		}
+		pCtxtclosed = pCtxtclosed->next;
+	}
+	WMD_DEH_ReleaseDummyMem();
+func_end:
+	return dsp_status;
+}
 
 /*
  *  ======== PROC_Attach ========
@@ -619,33 +650,30 @@ DSP_STATUS PROC_Detach(DSP_HPROCESSOR hProcessor)
 		 "hProcessor:  0x%x\n", hProcessor);
 
 	if (MEM_IsValidHandle(pProcObject, PROC_SIGNATURE)) {
-		/* Notify the Client */
-		NTFY_Notify(pProcObject->hNtfy, DSP_PROCESSORDETACH);
-		/* Remove the notification memory */
-		if (pProcObject->hNtfy)
-			NTFY_Delete(pProcObject->hNtfy);
-
-		if (pProcObject->g_pszLastCoff) {
-			MEM_Free(pProcObject->g_pszLastCoff);
-			pProcObject->g_pszLastCoff = NULL;
-		}
-
 #ifndef RES_CLEANUP_DISABLE
 		/* Return PID instead of process handle */
-		hProcess = current->pid;
-
+		hProcess = pProcObject->hProcess;
 		res_status = CFG_GetObject((u32 *)&hDRVObject, REG_DRV_OBJECT);
 		if (DSP_SUCCEEDED(res_status)) {
 			DRV_GetProcContext(hProcess,
 				(struct DRV_OBJECT *)hDRVObject, &pPctxt,
 					 NULL, 0);
 			if (pPctxt != NULL) {
-				DRV_ProcFreeDMMRes(pPctxt);
+				DRV_RemoveAllResources(pPctxt);
 				pPctxt->hProcessor = NULL;
 			}
 		}
 #endif
+		/* Notify the Client */
+		NTFY_Notify(pProcObject->hNtfy, DSP_PROCESSORDETACH);
+		/* Remove the notification memory */
+		if (pProcObject->hNtfy)
+			NTFY_Delete(pProcObject->hNtfy);
 
+		if (pProcObject->g_pszLastCoff) {
+			MEM_Free(pProcObject->g_pszLastCoff);
+			pProcObject->g_pszLastCoff = NULL;
+		}
 		/* Remove the Proc from the DEV List */
 		(void)DEV_RemoveProcObject(pProcObject->hDevObject,
 			(u32)pProcObject);
@@ -720,17 +748,23 @@ DSP_STATUS PROC_FlushMemory(DSP_HPROCESSOR hProcessor, void *pMpuAddr,
 	/* Keep STATUS here for future additions to this function */
 	DSP_STATUS status = DSP_SOK;
 	enum DSP_FLUSHTYPE FlushMemType = PROC_WRITEBACK_INVALIDATE_MEM;
+	struct PROC_OBJECT *pProcObject = (struct PROC_OBJECT *)hProcessor;
 	DBC_Require(cRefs > 0);
 
 	GT_4trace(PROC_DebugMask, GT_ENTER,
 		 "Entered PROC_FlushMemory, args:\n\t"
 		 "hProcessor: 0x%x pMpuAddr: 0x%x ulSize 0x%x, ulFlags 0x%x\n",
 		 hProcessor, pMpuAddr, ulSize, ulFlags);
-	/* Critical section */
-	(void)SYNC_EnterCS(hProcLock);
-	MEM_FlushCache(pMpuAddr, ulSize, FlushMemType);
-	(void)SYNC_LeaveCS(hProcLock);
-
+	if (MEM_IsValidHandle(pProcObject, PROC_SIGNATURE)) {
+		/* Critical section */
+		(void)SYNC_EnterCS(hProcLock);
+		MEM_FlushCache(pMpuAddr, ulSize, FlushMemType);
+		(void)SYNC_LeaveCS(hProcLock);
+	} else {
+		status = DSP_EHANDLE;
+		GT_0trace(PROC_DebugMask, GT_7CLASS, "PROC_FlushMemory: "
+			 "InValid Processor Handle \n");
+	}
 	GT_1trace(PROC_DebugMask, GT_ENTER, "Leaving PROC_FlushMemory [0x%x]",
 		 status);
 	return status;
@@ -748,15 +782,21 @@ DSP_STATUS PROC_InvalidateMemory(DSP_HPROCESSOR hProcessor, void *pMpuAddr,
 	/* Keep STATUS here for future additions to this function */
 	DSP_STATUS status = DSP_SOK;
 	enum DSP_FLUSHTYPE FlushMemType = PROC_INVALIDATE_MEM;
+	struct PROC_OBJECT *pProcObject = (struct PROC_OBJECT *)hProcessor;
 	DBC_Require(cRefs > 0);
 	GT_3trace(PROC_DebugMask, GT_ENTER,
 		 "Entered PROC_InvalidateMemory, args:\n\t"
 		 "hProcessor: 0x%x pMpuAddr: 0x%x ulSize 0x%x\n", hProcessor,
 		 pMpuAddr, ulSize);
-	(void)SYNC_EnterCS(hProcLock);
-	MEM_FlushCache(pMpuAddr, ulSize, FlushMemType);
-	(void)SYNC_LeaveCS(hProcLock);
-
+	if (MEM_IsValidHandle(pProcObject, PROC_SIGNATURE)) {
+		(void)SYNC_EnterCS(hProcLock);
+		MEM_FlushCache(pMpuAddr, ulSize, FlushMemType);
+		(void)SYNC_LeaveCS(hProcLock);
+	} else {
+		status = DSP_EHANDLE;
+		GT_0trace(PROC_DebugMask, GT_7CLASS, "PROC_InvalidateMemory: "
+			 "InValid Processor Handle \n");
+	}
 	GT_1trace(PROC_DebugMask, GT_ENTER,
 		 "Leaving PROC_InvalidateMemory [0x%x]", status);
 	return status;
@@ -874,6 +914,7 @@ DSP_STATUS PROC_GetDevObject(DSP_HPROCESSOR hProcessor,
 		status = DSP_SOK;
 	} else {
 		*phDevObject = NULL;
+		status = DSP_EHANDLE;
 	}
 
 	DBC_Ensure((DSP_SUCCEEDED(status) && *phDevObject != NULL) ||
@@ -1061,11 +1102,9 @@ DSP_STATUS PROC_Load(DSP_HPROCESSOR hProcessor, IN CONST s32 iArgc,
 		goto func_end;
 	}
 	if (pProcObject->bIsAlreadyAttached) {
-		status = DSP_EATTACHED;
-		GT_1trace(PROC_DebugMask, GT_7CLASS,
-			 "PROC_Load  Abort becuase a GPP "
-			 "Client is already attached status 0x%x \n", status);
-		goto func_end;
+		GT_0trace(PROC_DebugMask, GT_7CLASS,
+			 "PROC_Load GPP "
+			 "Client is already attached status  \n");
 	}
 	if (DSP_FAILED(DEV_GetCodMgr(pProcObject->hDevObject, &hCodMgr))) {
 		status = DSP_EFAIL;
@@ -1370,6 +1409,12 @@ DSP_STATUS PROC_Map(DSP_HPROCESSOR hProcessor, void *pMpuAddr, u32 ulSize,
 	GT_3trace(PROC_DebugMask, GT_ENTER, "PROC_Map: vaAlign %x, paAlign %x, "
 		 "sizeAlign %x\n", vaAlign, paAlign, sizeAlign);
 
+	if (!MEM_IsValidHandle(pProcObject, PROC_SIGNATURE)) {
+		status = DSP_EHANDLE;
+		GT_0trace(PROC_DebugMask, GT_7CLASS, "PROC_Map: "
+			 "InValid Processor Handle \n");
+		goto func_end;
+	}
 	/* Critical section */
 	(void)SYNC_EnterCS(hProcLock);
 	status = DMM_GetHandle(pProcObject, &hDmmMgr);
@@ -1416,6 +1461,7 @@ DSP_STATUS PROC_Map(DSP_HPROCESSOR hProcessor, void *pMpuAddr, u32 ulSize,
 		}
 	}
 #endif
+func_end:
 	GT_1trace(PROC_DebugMask, GT_ENTER, "Leaving PROC_Map [0x%x]", status);
 	return status;
 }
@@ -1518,6 +1564,12 @@ DSP_STATUS PROC_ReserveMemory(DSP_HPROCESSOR hProcessor, u32 ulSize,
 		 "Entered PROC_ReserveMemory, args:\n\t"
 		 "hProcessor: 0x%x ulSize: 0x%x ppRsvAddr: 0x%x\n", hProcessor,
 		 ulSize, ppRsvAddr);
+	if (!MEM_IsValidHandle(pProcObject, PROC_SIGNATURE)) {
+		status = DSP_EHANDLE;
+		GT_0trace(PROC_DebugMask, GT_7CLASS, "PROC_Map: "
+			 "InValid Processor Handle \n");
+		goto func_end;
+	}
 	status = DMM_GetHandle(pProcObject, &hDmmMgr);
 	if (DSP_FAILED(status)) {
 		GT_1trace(PROC_DebugMask, GT_7CLASS, "PROC_ReserveMemory: "
@@ -1527,6 +1579,7 @@ DSP_STATUS PROC_ReserveMemory(DSP_HPROCESSOR hProcessor, u32 ulSize,
 
 	GT_1trace(PROC_DebugMask, GT_ENTER, "Leaving PROC_ReserveMemory [0x%x]",
 		 status);
+func_end:
 	return status;
 }
 
@@ -1642,9 +1695,8 @@ DSP_STATUS PROC_Stop(DSP_HPROCESSOR hProcessor)
 	u32 uNodeTabSize = 1;
 	u32 uNumNodes = 0;
 	u32 uNodesAllocated = 0;
-#ifdef DEBUG
 	BRD_STATUS uBrdState;
-#endif
+
 	DBC_Require(cRefs > 0);
 	GT_1trace(PROC_DebugMask, GT_ENTER, "Entered PROC_Stop, args:\n\t"
 		 "hProcessor:  0x%x\n", hProcessor);
@@ -1654,6 +1706,13 @@ DSP_STATUS PROC_Stop(DSP_HPROCESSOR hProcessor)
 			 "PROC_Stop :InValid Handle \n");
 		goto func_end;
 	}
+	if (DSP_SUCCEEDED((*pProcObject->pIntfFxns->pfnBrdStatus)
+	   (pProcObject->hWmdContext, &uBrdState))) {
+		/* Clean up all the resources except the current running
+		 * process resources */
+		if (uBrdState == BRD_ERROR)
+			PROC_CleanupAllResources();
+	}
 	/* check if there are any running nodes */
 	status = DEV_GetNodeManager(pProcObject->hDevObject, &hNodeMgr);
 	if (DSP_SUCCEEDED(status) && hNodeMgr) {
@@ -1731,6 +1790,12 @@ DSP_STATUS PROC_UnMap(DSP_HPROCESSOR hProcessor, void *pMapAddr)
 		 "0x%x pMapAddr: 0x%x\n", hProcessor, pMapAddr);
 
 	vaAlign = PG_ALIGN_LOW((u32) pMapAddr, PG_SIZE_4K);
+	if (!MEM_IsValidHandle(pProcObject, PROC_SIGNATURE)) {
+		status = DSP_EHANDLE;
+		GT_0trace(PROC_DebugMask, GT_7CLASS, "PROC_UnMap: "
+			 "InValid Processor Handle \n");
+		goto func_end;
+	}
 
 	status = DMM_GetHandle(hProcessor, &hDmmMgr);
 	/* Critical section */
@@ -1792,7 +1857,12 @@ DSP_STATUS PROC_UnReserveMemory(DSP_HPROCESSOR hProcessor, void *pRsvAddr)
 	GT_2trace(PROC_DebugMask, GT_ENTER,
 		 "Entered PROC_UnReserveMemory, args:\n\t"
 		 "hProcessor: 0x%x pRsvAddr: 0x%x\n", hProcessor, pRsvAddr);
-
+	if (!MEM_IsValidHandle(pProcObject, PROC_SIGNATURE)) {
+		status = DSP_EHANDLE;
+		GT_0trace(PROC_DebugMask, GT_7CLASS, "PROC_UnMap: "
+			 "InValid Processor Handle \n");
+		goto func_end;
+	}
 	status = DMM_GetHandle(pProcObject, &hDmmMgr);
 	if (DSP_FAILED(status))
 		GT_1trace(PROC_DebugMask, GT_7CLASS,
@@ -1804,7 +1874,7 @@ DSP_STATUS PROC_UnReserveMemory(DSP_HPROCESSOR hProcessor, void *pRsvAddr)
 	GT_1trace(PROC_DebugMask, GT_ENTER,
 		 "Leaving PROC_UnReserveMemory [0x%x]",
 		 status);
-
+func_end:
 	return status;
 }
 
@@ -1938,11 +2008,17 @@ DSP_STATUS PROC_NotifyClients(DSP_HPROCESSOR hProc, u32 uEvents)
 	DBC_Require(MEM_IsValidHandle(pProcObject, PROC_SIGNATURE));
 	DBC_Require(IsValidProcEvent(uEvents));
 	DBC_Require(cRefs > 0);
+	if (!MEM_IsValidHandle(pProcObject, PROC_SIGNATURE)) {
+		status = DSP_EHANDLE;
+		GT_0trace(PROC_DebugMask, GT_7CLASS, "PROC_NotifyClients: "
+			 "InValid Processor Handle \n");
+		goto func_end;
+	}
 
 	NTFY_Notify(pProcObject->hNtfy, uEvents);
 	GT_0trace(PROC_DebugMask, GT_1CLASS,
 		 "PROC_NotifyClients :Signaled. \n");
-
+func_end:
 	return status;
 }
 
@@ -1979,8 +2055,13 @@ DSP_STATUS PROC_GetProcessorId(DSP_HPROCESSOR hProc, u32 *procID)
 	DSP_STATUS status = DSP_SOK;
 	struct PROC_OBJECT *pProcObject = (struct PROC_OBJECT *)hProc;
 
-	*procID = pProcObject->uProcessor;
-
+	if (MEM_IsValidHandle(pProcObject, PROC_SIGNATURE))
+		*procID = pProcObject->uProcessor;
+	else {
+		status = DSP_EHANDLE;
+		GT_0trace(PROC_DebugMask, GT_7CLASS, "PROC_GetProcessorId: "
+			 "InValid Processor Handle \n");
+	}
 	return status;
 }
 
diff --git a/drivers/dsp/bridge/wmd/ue_deh.c b/drivers/dsp/bridge/wmd/ue_deh.c
index 278dae2..b7fd795 100644
--- a/drivers/dsp/bridge/wmd/ue_deh.c
+++ b/drivers/dsp/bridge/wmd/ue_deh.c
@@ -74,6 +74,8 @@ static struct HW_MMUMapAttrs_t  mapAttrs = { HW_LITTLE_ENDIAN,
 					HW_ELEM_SIZE_16BIT,
 					HW_MMU_CPUES} ;
 #define VirtToPhys(x)       ((x) - PAGE_OFFSET + PHYS_OFFSET)
+
+static u32 dummyVaAddr;
 /*
  *  ======== WMD_DEH_Create ========
  *      Creates DEH manager object.
@@ -94,6 +96,7 @@ DSP_STATUS WMD_DEH_Create(OUT struct DEH_MGR **phDehMgr,
 	/* Get WMD context info. */
 	DEV_GetWMDContext(hDevObject, &hWmdContext);
 	DBC_Assert(hWmdContext);
+	dummyVaAddr = 0;
 	/* Allocate IO manager object: */
 	MEM_AllocObject(pDehMgr, struct DEH_MGR, SIGNATURE);
 	if (pDehMgr == NULL) {
@@ -151,6 +154,8 @@ DSP_STATUS WMD_DEH_Destroy(struct DEH_MGR *hDehMgr)
 
 	DBG_Trace(DBG_LEVEL1, "Entering DEH_Destroy: 0x%x\n", pDehMgr);
 	if (MEM_IsValidHandle(pDehMgr, SIGNATURE)) {
+		/* Release dummy VA buffer */
+		WMD_DEH_ReleaseDummyMem();
 		/* If notification object exists, delete it */
 		if (pDehMgr->hNtfy)
 			(void)NTFY_Delete(pDehMgr->hNtfy);
@@ -202,7 +207,6 @@ void WMD_DEH_Notify(struct DEH_MGR *hDehMgr, u32 ulEventMask,
 	u32 HW_MMU_MAX_TLB_COUNT = 31;
 	u32 extern faultAddr;
 	struct CFG_HOSTRES resources;
-	u32 dummyVaAddr;
 	HW_STATUS hwStatus;
 
 	status = CFG_GetHostResources(
@@ -246,12 +250,9 @@ void WMD_DEH_Notify(struct DEH_MGR *hDehMgr, u32 ulEventMask,
 				"address = 0x%x\n", (unsigned int)faultAddr);
 			dummyVaAddr = (u32)MEM_Calloc(sizeof(char) * 0x1000,
 					MEM_PAGED);
-			memPhysical = (u32)MEM_Calloc(sizeof(char) * 0x1000,
-					MEM_PAGED);
-			dummyVaAddr = PG_ALIGN_LOW((u32)dummyVaAddr,
-					PG_SIZE_4K);
-			memPhysical  = VirtToPhys(dummyVaAddr);
-			DBG_Trace(DBG_LEVEL6, "WMD_DEH_Notify: DSP_MMUFAULT, "
+			memPhysical  = VirtToPhys(PG_ALIGN_LOW((u32)dummyVaAddr,
+								PG_SIZE_4K));
+DBG_Trace(DBG_LEVEL6, "WMD_DEH_Notify: DSP_MMUFAULT, "
 				 "mem Physical= 0x%x\n", memPhysical);
 			pDevContext = (struct WMD_DEV_CONTEXT *)
 						pDehMgr->hWmdContext;
@@ -288,6 +289,14 @@ void WMD_DEH_Notify(struct DEH_MGR *hDehMgr, u32 ulEventMask,
 		}
 
 		/* Filter subsequent notifications when an error occurs */
+		if (pDevContext->dwBrdState != BRD_ERROR) {
+			/* Use it as a flag to send notifications the
+			 * first time and error occurred, next time
+			 * state will be BRD_ERROR */
+			status1 = DSP_EFAIL;
+		}
+
+		/* Filter subsequent notifications when an error occurs */
 		if (pDevContext->dwBrdState != BRD_ERROR)
 			status1 = DSP_SOK;
 
@@ -336,3 +345,17 @@ DSP_STATUS WMD_DEH_GetInfo(struct DEH_MGR *hDehMgr,
 
 	return status;
 }
+
+
+/*
+ *  ======== WMD_DEH_ReleaseDummyMem ========
+ *      Releases memory allocated for dummy page
+ */
+void WMD_DEH_ReleaseDummyMem(void)
+{
+	if (dummyVaAddr) {
+		MEM_Free((void *)dummyVaAddr);
+		dummyVaAddr = 0;
+	}
+}
+
-- 
1.6.2.4

