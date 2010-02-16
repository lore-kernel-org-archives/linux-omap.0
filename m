From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 01/18] DSPBRIDGE: Remove entry point custom debug statements for rmgr
Date: Tue, 16 Feb 2010 02:42:11 -0600
Message-ID: <1266309748-11714-2-git-send-email-omar.ramirez@ti.com>
References: <1266309748-11714-1-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:57651 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755856Ab0BPIaL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Feb 2010 03:30:11 -0500
In-Reply-To: <1266309748-11714-1-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Ameya Palande <ameya.palande@nokia.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>, Nishanth Menon <nm@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>

Remove statements using GT_ENTER custom bridge level which is
used to print entry and exit points from functions. Only NODE,
PROC and STRM meaningful prints were left for reference when
migrating to dev_dbg.

This changes are split to touch rmgr folder only.

As kernel contains ftrace tool no point in having this statements.

I.e. from ftrace:
       cexec.out-440   [000]  1201.767853: bridge_ioctl <-vfs_ioctl
       cexec.out-440   [000]  1201.767853: WCD_CallDevIOCtl <-bridge_ioctl
       cexec.out-440   [000]  1201.767883: PROCWRAP_Start <-WCD_CallDevIOCtl
       cexec.out-440   [000]  1201.767883: PROC_Start <-PROCWRAP_Start

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 drivers/dsp/bridge/rmgr/dbdcd.c         |   44 -------------
 drivers/dsp/bridge/rmgr/disp.c          |   35 -----------
 drivers/dsp/bridge/rmgr/drv.c           |  102 +++++++------------------------
 drivers/dsp/bridge/rmgr/drv_interface.c |   14 ----
 drivers/dsp/bridge/rmgr/dspdrv.c        |    4 -
 drivers/dsp/bridge/rmgr/mgr.c           |   33 +---------
 drivers/dsp/bridge/rmgr/nldr.c          |   29 +--------
 drivers/dsp/bridge/rmgr/node.c          |   49 ++-------------
 drivers/dsp/bridge/rmgr/proc.c          |   74 +---------------------
 drivers/dsp/bridge/rmgr/rmm.c           |   20 ------
 drivers/dsp/bridge/rmgr/strm.c          |   28 ---------
 11 files changed, 37 insertions(+), 395 deletions(-)

diff --git a/drivers/dsp/bridge/rmgr/dbdcd.c b/drivers/dsp/bridge/rmgr/dbdcd.c
index 9efb7dc..4e5e7f9 100644
--- a/drivers/dsp/bridge/rmgr/dbdcd.c
+++ b/drivers/dsp/bridge/rmgr/dbdcd.c
@@ -96,9 +96,6 @@ DSP_STATUS DCD_AutoRegister(IN struct DCD_MANAGER *hDcdMgr,
 
 	DBC_Require(cRefs > 0);
 
-	GT_1trace(curTrace, GT_ENTER, "DCD_AutoRegister: hDcdMgr 0x%x\n",
-		 hDcdMgr);
-
 	if (IsValidHandle(hDcdMgr)) {
 		status = DCD_GetObjects(hDcdMgr, pszCoffPath,
 					(DCD_REGISTERFXN)DCD_RegisterObject,
@@ -124,9 +121,6 @@ DSP_STATUS DCD_AutoUnregister(IN struct DCD_MANAGER *hDcdMgr,
 
 	DBC_Require(cRefs > 0);
 
-	GT_1trace(curTrace, GT_ENTER, "DCD_AutoUnregister: hDcdMgr 0x%x\n",
-		 hDcdMgr);
-
 	if (IsValidHandle(hDcdMgr)) {
 		status = DCD_GetObjects(hDcdMgr, pszCoffPath,
 				(DCD_REGISTERFXN)DCD_RegisterObject, NULL);
@@ -155,9 +149,6 @@ DSP_STATUS DCD_CreateManager(IN char *pszZlDllName,
 	DBC_Require(cRefs >= 0);
 	DBC_Require(phDcdMgr);
 
-	GT_1trace(curTrace, GT_ENTER, "DCD_CreateManager: phDcdMgr 0x%x\n",
-		 phDcdMgr);
-
 	status = COD_Create(&hCodMgr, pszZlDllName, NULL);
 
 	if (DSP_FAILED(status)) {
@@ -211,9 +202,6 @@ DSP_STATUS DCD_DestroyManager(IN struct DCD_MANAGER *hDcdMgr)
 
 	DBC_Require(cRefs >= 0);
 
-	GT_1trace(curTrace, GT_ENTER, "DCD_DestroyManager: hDcdMgr 0x%x\n",
-		 hDcdMgr);
-
 	if (IsValidHandle(hDcdMgr)) {
 		/* Delete the COD manager. */
 		COD_Delete(pDcdMgr->hCodMgr);
@@ -252,10 +240,6 @@ DSP_STATUS DCD_EnumerateObject(IN s32 cIndex, IN enum DSP_DCDOBJTYPE objType,
 	DBC_Require(cIndex >= 0);
 	DBC_Require(pUuid != NULL);
 
-	GT_3trace(curTrace, GT_ENTER,
-		 "DCD_EnumerateObject: cIndex %d, objType %d, "
-		 " pUuid 0x%x\n", cIndex, objType, pUuid);
-
 	if ((cIndex != 0) && (cEnumRefs == 0)) {
 		/*
 		 * If an enumeration is being performed on an index greater
@@ -346,8 +330,6 @@ void DCD_Exit(void)
 {
 	DBC_Require(cRefs > 0);
 
-	GT_1trace(curTrace, GT_5CLASS, "DCD_Exit: cRefs 0x%x\n", cRefs);
-
 	cRefs--;
 	if (cRefs == 0) {
 		COD_Exit();
@@ -372,9 +354,6 @@ DSP_STATUS DCD_GetDepLibs(IN struct DCD_MANAGER *hDcdMgr,
 	DBC_Require(pDepLibUuids != NULL);
 	DBC_Require(pPersistentDepLibs != NULL);
 
-	GT_1trace(curTrace, GT_ENTER, "DCD_GetDepLibs: hDcdMgr 0x%x\n",
-		 hDcdMgr);
-
 	status = GetDepLibInfo(hDcdMgr, pUuid, &numLibs, NULL, pDepLibUuids,
 			      pPersistentDepLibs, phase);
 
@@ -396,9 +375,6 @@ DSP_STATUS DCD_GetNumDepLibs(IN struct DCD_MANAGER *hDcdMgr,
 	DBC_Require(pNumPersLibs != NULL);
 	DBC_Require(pUuid != NULL);
 
-	GT_1trace(curTrace, GT_ENTER, "DCD_GetNumDepLibs: hDcdMgr 0x%x\n",
-		 hDcdMgr);
-
 	status = GetDepLibInfo(hDcdMgr, pUuid, pNumLibs, pNumPersLibs,
 				NULL, NULL, phase);
 
@@ -434,10 +410,6 @@ DSP_STATUS DCD_GetObjectDef(IN struct DCD_MANAGER *hDcdMgr,
 	DBC_Require(pObjDef != NULL);
 	DBC_Require(pObjUuid != NULL);
 
-	GT_4trace(curTrace, GT_ENTER,
-		 "DCD_GetObjectDef: hDcdMgr 0x%x, " "objUuid"
-		 " 0x%x, objType 0x%x, pObjDef 0x%x\n", hDcdMgr, pObjUuid,
-		 objType, pObjDef);
 	szUuid = (char *)MEM_Calloc(MAXUUIDLEN, MEM_PAGED);
 	if (!szUuid) {
 		status = DSP_EMEMORY;
@@ -592,8 +564,6 @@ DSP_STATUS DCD_GetObjects(IN struct DCD_MANAGER *hDcdMgr, IN char *pszCoffPath,
 	s32 cObjectType;
 
 	DBC_Require(cRefs > 0);
-	GT_1trace(curTrace, GT_ENTER,
-		 "DCD_GetObjects: hDcdMgr 0x%x\n", hDcdMgr);
 	if (!IsValidHandle(hDcdMgr)) {
 		status = DSP_EHANDLE;
 		GT_0trace(curTrace, GT_6CLASS,
@@ -824,9 +794,6 @@ bool DCD_Init(void)
 
 	DBC_Require(cRefs >= 0);
 
-	GT_1trace(curTrace, GT_ENTER, "DCD_Init: (on enter) cRefs = 0x%x\n",
-		 cRefs);
-
 	if (cRefs == 0) {
 		/* Initialize required modules. */
 		fInitCOD = COD_Init();
@@ -843,10 +810,6 @@ bool DCD_Init(void)
 	if (fInit)
 		cRefs++;
 
-
-	GT_1trace(curTrace, GT_5CLASS, "DCD_Init: (on exit) cRefs = 0x%x\n",
-		 cRefs);
-
 	DBC_Ensure((fInit && (cRefs > 0)) || (!fInit && (cRefs == 0)));
 
 	return fInit;
@@ -975,10 +938,6 @@ DSP_STATUS DCD_UnregisterObject(IN struct DSP_UUID *pUuid,
 		   (objType == DSP_DCDEXECUTELIBTYPE) ||
 		   (objType == DSP_DCDDELETELIBTYPE));
 
-	GT_2trace(curTrace, GT_ENTER,
-		 "DCD_UnregisterObject: object UUID 0x%x, "
-		 "objType %d\n", pUuid, objType);
-
 	/*
 	 *  When DCD_RegisterObject is called with NULL as pathname,
 	 *  it indicates an unregister object operation.
@@ -1430,9 +1389,6 @@ static DSP_STATUS GetDepLibInfo(IN struct DCD_MANAGER *hDcdMgr,
 	DBC_Require(pNumLibs != NULL);
 	DBC_Require(pUuid != NULL);
 
-	GT_1trace(curTrace, GT_ENTER, "DCD_GetNumDepLibs: hDcdMgr 0x%x\n",
-		 hDcdMgr);
-
 	/*  Initialize to 0 dependent libraries, if only counting number of
 	 *  dependent libraries */
 	if (!fGetUuids) {
diff --git a/drivers/dsp/bridge/rmgr/disp.c b/drivers/dsp/bridge/rmgr/disp.c
index e53b11f..ac2af3c 100644
--- a/drivers/dsp/bridge/rmgr/disp.c
+++ b/drivers/dsp/bridge/rmgr/disp.c
@@ -113,10 +113,6 @@ DSP_STATUS DISP_Create(OUT struct DISP_OBJECT **phDispObject,
 	DBC_Require(pDispAttrs != NULL);
 	DBC_Require(hDevObject != NULL);
 
-	GT_3trace(DISP_DebugMask, GT_ENTER, "DISP_Create: phDispObject: 0x%x\t"
-		 "hDevObject: 0x%x\tpDispAttrs: 0x%x\n", phDispObject,
-		 hDevObject, pDispAttrs);
-
 	*phDispObject = NULL;
 
 	/* Allocate Node Dispatcher object */
@@ -221,9 +217,6 @@ void DISP_Delete(struct DISP_OBJECT *hDisp)
 	DBC_Require(cRefs > 0);
 	DBC_Require(MEM_IsValidHandle(hDisp, DISP_SIGNATURE));
 
-	GT_1trace(DISP_DebugMask, GT_ENTER,
-		 "DISP_Delete: hDisp: 0x%x\n", hDisp);
-
 	DeleteDisp(hDisp);
 
 	DBC_Ensure(!MEM_IsValidHandle(hDisp, DISP_SIGNATURE));
@@ -239,9 +232,6 @@ void DISP_Exit(void)
 
 	cRefs--;
 
-	GT_1trace(DISP_DebugMask, GT_5CLASS,
-		 "Entered DISP_Exit, ref count:  0x%x\n", cRefs);
-
 	DBC_Ensure(cRefs >= 0);
 }
 
@@ -263,9 +253,6 @@ bool DISP_Init(void)
 	if (fRetVal)
 		cRefs++;
 
-	GT_1trace(DISP_DebugMask, GT_5CLASS,
-		 "DISP_Init(), ref count:  0x%x\n", cRefs);
-
 	DBC_Ensure((fRetVal && (cRefs > 0)) || (!fRetVal && (cRefs >= 0)));
 	return fRetVal;
 }
@@ -287,10 +274,6 @@ DSP_STATUS DISP_NodeChangePriority(struct DISP_OBJECT *hDisp,
 	DBC_Require(MEM_IsValidHandle(hDisp, DISP_SIGNATURE));
 	DBC_Require(hNode != NULL);
 
-	GT_5trace(DISP_DebugMask, GT_ENTER, "DISP_NodeChangePriority: hDisp: "
-		"0x%x\thNode: 0x%x\tulRMSFxn: 0x%x\tnodeEnv: 0x%x\tnPriority\n",
-		hDisp, hNode, ulRMSFxn, nodeEnv, nPriority);
-
 	/* Send message to RMS to change priority */
 	pCommand = (struct RMS_Command *)(hDisp->pBuf);
 	pCommand->fxn = (RMS_WORD)(ulRMSFxn);
@@ -345,11 +328,6 @@ DSP_STATUS DISP_NodeCreate(struct DISP_OBJECT *hDisp, struct NODE_OBJECT *hNode,
 	DBC_Require(NODE_GetType(hNode) != NODE_DEVICE);
 	DBC_Require(pNodeEnv != NULL);
 
-	GT_6trace(DISP_DebugMask, GT_ENTER,
-	     "DISP_NodeCreate: hDisp: 0x%x\thNode:"
-	     " 0x%x\tulRMSFxn: 0x%x\tulCreateFxn: 0x%x\tpArgs: 0x%x\tpNodeEnv:"
-	     " 0x%x\n", hDisp, hNode, ulRMSFxn, ulCreateFxn, pArgs, pNodeEnv);
-
 	status = DEV_GetDevType(hDisp->hDevObject, &devType);
 
 	GT_1trace(DISP_DebugMask, GT_6CLASS, "DISP_Create: Creating DISP "
@@ -468,10 +446,6 @@ DSP_STATUS DISP_NodeCreate(struct DISP_OBJECT *hDisp, struct NODE_OBJECT *hNode,
 			 * that would break the node object's abstraction.
 			 */
 			GetNodeInfo(hNode, &nodeInfo);
-			GT_2trace(DISP_DebugMask, GT_ENTER,
-				 "uExecutionPriority %x, nPriority %x\n",
-				 nodeInfo.uExecutionPriority,
-				 taskArgs.nPriority);
 			pMoreTaskArgs->priority = nodeInfo.uExecutionPriority;
 			pMoreTaskArgs->stackSize = taskArgs.uStackSize;
 			pMoreTaskArgs->sysstackSize = taskArgs.uSysStackSize;
@@ -581,11 +555,6 @@ DSP_STATUS DISP_NodeDelete(struct DISP_OBJECT *hDisp, struct NODE_OBJECT *hNode,
 	DBC_Require(MEM_IsValidHandle(hDisp, DISP_SIGNATURE));
 	DBC_Require(hNode != NULL);
 
-	GT_5trace(DISP_DebugMask, GT_ENTER,
-		 "DISP_NodeDelete: hDisp: 0x%xthNode: "
-		 "0x%x\tulRMSFxn: 0x%x\tulDeleteFxn: 0x%x\tnodeEnv: 0x%x\n",
-		 hDisp, hNode, ulRMSFxn, ulDeleteFxn, nodeEnv);
-
 	status = DEV_GetDevType(hDisp->hDevObject, &devType);
 
 	if (DSP_SUCCEEDED(status)) {
@@ -645,10 +614,6 @@ DSP_STATUS DISP_NodeRun(struct DISP_OBJECT *hDisp, struct NODE_OBJECT *hNode,
 	DBC_Require(MEM_IsValidHandle(hDisp, DISP_SIGNATURE));
 	DBC_Require(hNode != NULL);
 
-	GT_5trace(DISP_DebugMask, GT_ENTER, "DISP_NodeRun: hDisp: 0x%xthNode: \
-		 0x%x\tulRMSFxn: 0x%x\tulExecuteFxn: 0x%x\tnodeEnv: 0x%x\n", \
-		 hDisp, hNode, ulRMSFxn, ulExecuteFxn, nodeEnv);
-
 	status = DEV_GetDevType(hDisp->hDevObject, &devType);
 
 	if (DSP_SUCCEEDED(status)) {
diff --git a/drivers/dsp/bridge/rmgr/drv.c b/drivers/dsp/bridge/rmgr/drv.c
index 36bab9f..d3c5df8 100644
--- a/drivers/dsp/bridge/rmgr/drv.c
+++ b/drivers/dsp/bridge/rmgr/drv.c
@@ -89,13 +89,12 @@ DSP_STATUS DRV_InsertNodeResElement(HANDLE hNode, HANDLE hNodeRes,
 	struct PROCESS_CONTEXT *pCtxt = (struct PROCESS_CONTEXT *)hPCtxt;
 	DSP_STATUS status = DSP_SOK;
 	struct NODE_RES_OBJECT   *pTempNodeRes = NULL;
-	GT_0trace(curTrace, GT_ENTER, "DRV_InsertNodeResElement: 1");
+
 	*pNodeRes = (struct NODE_RES_OBJECT *)MEM_Calloc
 		    (1 * sizeof(struct NODE_RES_OBJECT), MEM_PAGED);
-	if (*pNodeRes == NULL) {
-		GT_0trace(curTrace, GT_ENTER, "DRV_InsertNodeResElement: 12");
+	if (*pNodeRes == NULL)
 		status = DSP_EHANDLE;
-	}
+
 	if (DSP_SUCCEEDED(status)) {
 		(*pNodeRes)->hNode = hNode;
 		if (pCtxt->pNodeList != NULL) {
@@ -104,15 +103,11 @@ DSP_STATUS DRV_InsertNodeResElement(HANDLE hNode, HANDLE hNodeRes,
 				pTempNodeRes = pTempNodeRes->next;
 
 			pTempNodeRes->next = *pNodeRes;
-			GT_0trace(curTrace, GT_ENTER,
-				 "DRV_InsertNodeResElement: 2");
 		} else {
 			pCtxt->pNodeList = *pNodeRes;
-			GT_0trace(curTrace, GT_ENTER,
-				 "DRV_InsertNodeResElement: 3");
 		}
 	}
-	GT_0trace(curTrace, GT_ENTER, "DRV_InsertNodeResElement: 4");
+
 	return status;
 }
 
@@ -149,7 +144,6 @@ static DSP_STATUS DRV_ProcFreeNodeRes(HANDLE hPCtxt)
 
 	pNodeList = pCtxt->pNodeList;
 	while (pNodeList != NULL) {
-		GT_0trace(curTrace, GT_ENTER, "DRV_ProcFreeNodeRes: 1");
 		pNodeRes = pNodeList;
 		pNodeList = pNodeList->next;
 		if (pNodeRes->nodeAllocated) {
@@ -194,7 +188,6 @@ DSP_STATUS DRV_InsertDMMResElement(HANDLE hDMMRes, HANDLE hPCtxt)
 
 	*pDMMRes = (struct DMM_RES_OBJECT *)
 		    MEM_Calloc(1 * sizeof(struct DMM_RES_OBJECT), MEM_PAGED);
-	GT_0trace(curTrace, GT_ENTER, "DRV_InsertDMMResElement: 1");
 	if (*pDMMRes == NULL) {
 		GT_0trace(curTrace, GT_5CLASS, "DRV_InsertDMMResElement: 2");
 		status = DSP_EHANDLE;
@@ -214,7 +207,7 @@ DSP_STATUS DRV_InsertDMMResElement(HANDLE hDMMRes, HANDLE hPCtxt)
 				 "DRV_InsertDMMResElement: 4");
 		}
 	}
-	GT_0trace(curTrace, GT_ENTER, "DRV_InsertDMMResElement: 5");
+
 	return status;
 }
 
@@ -267,7 +260,6 @@ DSP_STATUS  DRV_ProcFreeDMMRes(HANDLE hPCtxt)
 	struct DMM_RES_OBJECT *pDMMList = pCtxt->pDMMList;
 	struct DMM_RES_OBJECT *pDMMRes = NULL;
 
-	GT_0trace(curTrace, GT_ENTER, "\nDRV_ProcFreeDMMRes: 1\n");
 	while (pDMMList != NULL) {
 		pDMMRes = pDMMList;
 		pDMMList = pDMMList->next;
@@ -316,19 +308,14 @@ DSP_STATUS DRV_GetDMMResElement(u32 pMapAddr, HANDLE hDMMRes, HANDLE hPCtxt)
 	struct DMM_RES_OBJECT *pTempDMM = NULL;
 
 	pTempDMM = pCtxt->pDMMList;
-	while ((pTempDMM != NULL) && (pTempDMM->ulDSPAddr != pMapAddr)) {
-		GT_3trace(curTrace, GT_ENTER,
-			 "DRV_GetDMMResElement: 2 pTempDMM:%x "
-			 "pTempDMM->ulDSPAddr:%x pMapAddr:%x\n", pTempDMM,
-			 pTempDMM->ulDSPAddr, pMapAddr);
+	while ((pTempDMM != NULL) && (pTempDMM->ulDSPAddr != pMapAddr))
 		pTempDMM = pTempDMM->next;
-	}
-	if (pTempDMM != NULL) {
-		GT_0trace(curTrace, GT_ENTER, "DRV_GetDMMResElement: 3");
+
+	if (pTempDMM != NULL)
 		*pDMMRes = pTempDMM;
-	} else {
+	else
 		status = DSP_ENOTFOUND;
-	} GT_0trace(curTrace, GT_ENTER, "DRV_GetDMMResElement: 4");
+
 	return status;
 }
 
@@ -379,7 +366,6 @@ DSP_STATUS DRV_GetNodeResElement(HANDLE hNode, HANDLE hNodeRes, HANDLE hPCtxt)
 	struct NODE_RES_OBJECT *pTempNode = NULL;
 
 	pTempNode = pCtxt->pNodeList;
-	GT_0trace(curTrace, GT_ENTER, "DRV_GetNodeResElement: 1");
 	while ((pTempNode != NULL) && (pTempNode->hNode != hNode)) {
 		pTempNode2 = pTempNode;
 		pTempNode = pTempNode->next;
@@ -405,15 +391,12 @@ DSP_STATUS DRV_ProcInsertSTRMResElement(HANDLE hStreamHandle, HANDLE hSTRMRes,
 
 	*pSTRMRes = (struct STRM_RES_OBJECT *)
 		    MEM_Calloc(1 * sizeof(struct STRM_RES_OBJECT), MEM_PAGED);
-	if (*pSTRMRes == NULL) {
-		GT_0trace(curTrace, GT_ENTER, "DRV_InsertSTRMResElement: 2");
+	if (*pSTRMRes == NULL)
 		status = DSP_EHANDLE;
-	}
+
 	if (DSP_SUCCEEDED(status)) {
 		(*pSTRMRes)->hStream = hStreamHandle;
 		if (pCtxt->pSTRMList != NULL) {
-			GT_0trace(curTrace, GT_ENTER,
-				 "DRV_InsertiSTRMResElement: 3");
 			pTempSTRMRes = pCtxt->pSTRMList;
 			while (pTempSTRMRes->next != NULL)
 				pTempSTRMRes = pTempSTRMRes->next;
@@ -421,8 +404,6 @@ DSP_STATUS DRV_ProcInsertSTRMResElement(HANDLE hStreamHandle, HANDLE hSTRMRes,
 			pTempSTRMRes->next = *pSTRMRes;
 		} else {
 			pCtxt->pSTRMList = *pSTRMRes;
-			GT_0trace(curTrace, GT_ENTER,
-				 "DRV_InsertSTRMResElement: 4");
 		}
 	}
 	return status;
@@ -525,18 +506,15 @@ DSP_STATUS DRV_GetSTRMResElement(HANDLE hStrm, HANDLE hSTRMRes, HANDLE hPCtxt)
 	struct STRM_RES_OBJECT *pTempSTRM = pCtxt->pSTRMList;
 
 	while ((pTempSTRM != NULL) && (pTempSTRM->hStream != hStrm)) {
-		GT_0trace(curTrace, GT_ENTER, "DRV_GetSTRMResElement: 2");
 		pTempSTRM2 = pTempSTRM;
 		pTempSTRM = pTempSTRM->next;
 	}
-	if (pTempSTRM != NULL) {
-		GT_0trace(curTrace, GT_ENTER, "DRV_GetSTRMResElement: 3");
+
+	if (pTempSTRM != NULL)
 		*STRMRes = pTempSTRM;
-	} else {
-		GT_0trace(curTrace, GT_ENTER, "DRV_GetSTRMResElement: 4");
+	else
 		status = DSP_ENOTFOUND;
-	}
-	GT_0trace(curTrace, GT_ENTER, "DRV_GetSTRMResElement: 5");
+
 	return status;
 }
 
@@ -564,8 +542,7 @@ DSP_STATUS DRV_Create(OUT struct DRV_OBJECT **phDRVObject)
 
 	DBC_Require(phDRVObject != NULL);
 	DBC_Require(cRefs > 0);
-	GT_1trace(curTrace, GT_ENTER, "Entering DRV_Create"
-			" phDRVObject 0x%x\n", phDRVObject);
+
 	MEM_AllocObject(pDRVObject, struct DRV_OBJECT, SIGNATURE);
 	if (pDRVObject) {
 		/* Create and Initialize List of device objects */
@@ -612,9 +589,7 @@ DSP_STATUS DRV_Create(OUT struct DRV_OBJECT **phDRVObject)
 				 "DRV Object ");
 
 	}
-	GT_2trace(curTrace, GT_ENTER,
-		 "Exiting DRV_Create: phDRVObject: 0x%x\tstatus:"
-		 "0x%x\n", phDRVObject, status);
+
 	DBC_Ensure(DSP_FAILED(status) ||
 		  MEM_IsValidHandle(pDRVObject, SIGNATURE));
 	return status;
@@ -629,8 +604,6 @@ void DRV_Exit(void)
 {
 	DBC_Require(cRefs > 0);
 
-	GT_0trace(curTrace, GT_5CLASS, "Entering DRV_Exit \n");
-
 	cRefs--;
 
 	DBC_Ensure(cRefs >= 0);
@@ -649,8 +622,6 @@ DSP_STATUS DRV_Destroy(struct DRV_OBJECT *hDRVObject)
 	DBC_Require(cRefs > 0);
 	DBC_Require(MEM_IsValidHandle(pDRVObject, SIGNATURE));
 
-	GT_1trace(curTrace, GT_ENTER, "Entering DRV_Destroy"
-			" hDRVObject 0x%x\n", hDRVObject);
 	/*
 	 *  Delete the List if it exists.Should not come here
 	 *  as the DRV_RemoveDevObject and the Last DRV_RequestResources
@@ -661,9 +632,6 @@ DSP_STATUS DRV_Destroy(struct DRV_OBJECT *hDRVObject)
 	MEM_FreeObject(pDRVObject);
 	/* Update the DRV Object in Registry to be 0 */
 	(void)CFG_SetObject(0, REG_DRV_OBJECT);
-	GT_2trace(curTrace, GT_ENTER,
-		 "Exiting DRV_Destroy: hDRVObject: 0x%x\tstatus:"
-		 "0x%x\n", hDRVObject, status);
 	DBC_Ensure(!MEM_IsValidHandle(pDRVObject, SIGNATURE));
 	return status;
 }
@@ -687,10 +655,7 @@ DSP_STATUS DRV_GetDevObject(u32 uIndex, struct DRV_OBJECT *hDrvObject,
 	DBC_Require(uIndex >= 0);
 	DBC_Require(cRefs > 0);
 	DBC_Assert(!(LST_IsEmpty(pDrvObject->devList)));
-	GT_3trace(curTrace, GT_ENTER,
-		 "Entered DRV_GetDevObject, args:\n\tuIndex: "
-		 "0x%x\n\thDrvObject:  0x%x\n\tphDevObject:  0x%x\n",
-		 uIndex, hDrvObject, phDevObject);
+
 	pDevObject = (struct DEV_OBJECT *)DRV_GetFirstDevObject();
 	for (i = 0; i < uIndex; i++) {
 		pDevObject =
@@ -704,9 +669,7 @@ DSP_STATUS DRV_GetDevObject(u32 uIndex, struct DRV_OBJECT *hDrvObject,
 		GT_0trace(curTrace, GT_7CLASS,
 			 "DRV: Could not get the DevObject\n");
 	}
-	GT_2trace(curTrace, GT_ENTER,
-		 "Exiting Drv_GetDevObject\n\tstatus: 0x%x\n\t"
-		 "hDevObject: 0x%x\n", status, *phDevObject);
+
 	return status;
 }
 
@@ -823,9 +786,6 @@ DSP_STATUS DRV_Init(void)
 	if (fRetval)
 		cRefs++;
 
-	GT_1trace(curTrace, GT_5CLASS, "Entering DRV_Entry  crefs 0x%x \n",
-		 cRefs);
-
 	DBC_Ensure((fRetval && (cRefs > 0)) || (!fRetval && (cRefs >= 0)));
 
 	return fRetval;
@@ -847,15 +807,8 @@ DSP_STATUS DRV_InsertDevObject(struct DRV_OBJECT *hDRVObject,
 	DBC_Require(MEM_IsValidHandle(pDRVObject, SIGNATURE));
 	DBC_Assert(pDRVObject->devList);
 
-	GT_2trace(curTrace, GT_ENTER,
-		 "Entering DRV_InsertProcObject hDRVObject "
-		 "0x%x\n, hDevObject 0x%x\n", hDRVObject, hDevObject);
-
 	LST_PutTail(pDRVObject->devList, (struct list_head *)hDevObject);
 
-	GT_1trace(curTrace, GT_ENTER,
-		 "Exiting InsertDevObject status 0x%x\n", status);
-
 	DBC_Ensure(DSP_SUCCEEDED(status) && !LST_IsEmpty(pDRVObject->devList));
 
 	return status;
@@ -881,9 +834,6 @@ DSP_STATUS DRV_RemoveDevObject(struct DRV_OBJECT *hDRVObject,
 	DBC_Require(pDRVObject->devList != NULL);
 	DBC_Require(!LST_IsEmpty(pDRVObject->devList));
 
-	GT_2trace(curTrace, GT_ENTER,
-		 "Entering DRV_RemoveDevObject hDevObject "
-		 "0x%x\n, hDRVObject 0x%x\n", hDevObject, hDRVObject);
 	/* Search list for pProcObject: */
 	for (pCurElem = LST_First(pDRVObject->devList); pCurElem != NULL;
 	    pCurElem = LST_Next(pDRVObject->devList, pCurElem)) {
@@ -901,8 +851,7 @@ DSP_STATUS DRV_RemoveDevObject(struct DRV_OBJECT *hDRVObject,
 	}
 	DBC_Ensure((pDRVObject->devList == NULL) ||
 		  !LST_IsEmpty(pDRVObject->devList));
-	GT_1trace(curTrace, GT_ENTER,
-		 "DRV_RemoveDevObject returning 0x%x\n", status);
+
 	return status;
 }
 
@@ -919,7 +868,7 @@ DSP_STATUS DRV_RequestResources(u32 dwContext, u32 *pDevNodeString)
 
 	DBC_Require(dwContext != 0);
 	DBC_Require(pDevNodeString != NULL);
-	GT_0trace(curTrace, GT_ENTER, "Entering DRV_RequestResources\n");
+
 	/*
 	 *  Allocate memory to hold the string. This will live untill
 	 *  it is freed in the Release resources. Update the driver object
@@ -981,8 +930,6 @@ DSP_STATUS DRV_ReleaseResources(u32 dwContext, struct DRV_OBJECT *hDrvObject)
 	struct DRV_OBJECT *pDRVObject = (struct DRV_OBJECT *)hDrvObject;
 	struct DRV_EXT *pszdevNode;
 
-	GT_0trace(curTrace, GT_ENTER, "Entering DRV_Release Resources\n");
-
 	if (!(strcmp((char *)((struct DRV_EXT *)dwContext)->szString,
 	   "TIOMAP1510"))) {
 		GT_0trace(curTrace, GT_1CLASS,
@@ -1040,8 +987,6 @@ static DSP_STATUS RequestBridgeResources(u32 dwContext, s32 bRequest)
 
 	DBC_Require(dwContext != 0);
 
-	GT_0trace(curTrace, GT_ENTER, "->RequestBridgeResources \n");
-
 	if (!bRequest) {
 		driverExt = (struct DRV_EXT *)dwContext;
 		/* Releasing resources by deleting the registry key  */
@@ -1123,7 +1068,6 @@ static DSP_STATUS RequestBridgeResources(u32 dwContext, s32 bRequest)
 		} else {
 			status = DSP_EMEMORY;
 		}
-		GT_0trace(curTrace, GT_ENTER, " <- RequestBridgeResources \n");
 		return status;
 	}
 	dwBuffSize = sizeof(struct CFG_HOSTRES);
@@ -1201,8 +1145,6 @@ static DSP_STATUS RequestBridgeResourcesDSP(u32 dwContext, s32 bRequest)
 
 	DBC_Require(dwContext != 0);
 
-	GT_0trace(curTrace, GT_ENTER, "->RequestBridgeResourcesDSP \n");
-
 	dwBuffSize = sizeof(struct CFG_HOSTRES);
 
 	pResources = MEM_Calloc(dwBuffSize, MEM_NONPAGED);
diff --git a/drivers/dsp/bridge/rmgr/drv_interface.c b/drivers/dsp/bridge/rmgr/drv_interface.c
index 1676c78..4a909a9 100644
--- a/drivers/dsp/bridge/rmgr/drv_interface.c
+++ b/drivers/dsp/bridge/rmgr/drv_interface.c
@@ -269,8 +269,6 @@ static int __devinit omap34xx_bridge_probe(struct platform_device *pdev)
 	GT_set("**=67");
 #endif
 
-	GT_0trace(driverTrace, GT_ENTER, "-> driver_init\n");
-
 #ifdef CONFIG_PM
 	/* Initialize the wait queue */
 	if (!status) {
@@ -361,7 +359,6 @@ static int __devinit omap34xx_bridge_probe(struct platform_device *pdev)
 
 	DBC_Assert(status == 0);
 	DBC_Assert(DSP_SUCCEEDED(initStatus));
-	GT_0trace(driverTrace, GT_ENTER, " <- driver_init\n");
 
 	return 0;
 
@@ -378,8 +375,6 @@ static int __devexit omap34xx_bridge_remove(struct platform_device *pdev)
 	DSP_STATUS dsp_status = DSP_SOK;
 	HANDLE hDrvObject = NULL;
 
-	GT_0trace(driverTrace, GT_ENTER, "-> driver_exit\n");
-
 	dsp_status = CFG_GetObject((u32 *)&hDrvObject, REG_DRV_OBJECT);
 	if (DSP_FAILED(dsp_status))
 		goto func_cont;
@@ -485,8 +480,6 @@ static int bridge_open(struct inode *ip, struct file *filp)
 	int status = 0;
 	struct PROCESS_CONTEXT *pr_ctxt = NULL;
 
-	GT_0trace(driverTrace, GT_ENTER, "-> bridge_open\n");
-
 	/*
 	 * Allocate a new process context and insert it into global
 	 * process context list.
@@ -499,7 +492,6 @@ static int bridge_open(struct inode *ip, struct file *filp)
 
 	filp->private_data = pr_ctxt;
 
-	GT_0trace(driverTrace, GT_ENTER, "<- bridge_open\n");
 	return status;
 }
 
@@ -512,8 +504,6 @@ static int bridge_release(struct inode *ip, struct file *filp)
 	int status = 0;
 	struct PROCESS_CONTEXT *pr_ctxt;
 
-	GT_0trace(driverTrace, GT_ENTER, "-> bridge_release\n");
-
 	if (!filp->private_data) {
 		status = -EIO;
 		goto err;
@@ -528,7 +518,6 @@ static int bridge_release(struct inode *ip, struct file *filp)
 	filp->private_data = NULL;
 
 err:
-	GT_0trace(driverTrace, GT_ENTER, "<- bridge_release\n");
 	return status;
 }
 
@@ -547,8 +536,6 @@ static long bridge_ioctl(struct file *filp, unsigned int code,
 		return status;
 #endif
 
-	GT_0trace(driverTrace, GT_ENTER, " -> driver_ioctl\n");
-
 	if (!filp->private_data) {
 		status = -EIO;
 		goto err;
@@ -572,7 +559,6 @@ static long bridge_ioctl(struct file *filp, unsigned int code,
 	}
 
 err:
-	GT_0trace(driverTrace, GT_ENTER, " <- driver_ioctl\n");
 	return status;
 }
 
diff --git a/drivers/dsp/bridge/rmgr/dspdrv.c b/drivers/dsp/bridge/rmgr/dspdrv.c
index 9920059..522da73 100644
--- a/drivers/dsp/bridge/rmgr/dspdrv.c
+++ b/drivers/dsp/bridge/rmgr/dspdrv.c
@@ -61,8 +61,6 @@ u32 DSP_Init(OUT u32 *initStatus)
 
 	GT_create(&curTrace, "DD");
 
-	GT_0trace(curTrace, GT_ENTER, "Entering DSP_Init \r\n");
-
 	if (!WCD_Init()) {
 		GT_0trace(curTrace, GT_7CLASS, "DSP_Init Failed \n");
 		goto func_cont;
@@ -146,8 +144,6 @@ bool DSP_Deinit(u32 deviceContext)
 	u32 deviceNode;
 	struct MGR_OBJECT *mgrObject = NULL;
 
-	GT_0trace(curTrace, GT_ENTER, "Entering DSP_Deinit \r\n");
-
 	while ((deviceNode = DRV_GetFirstDevExtension()) != 0) {
 		(void)DEV_RemoveDevice((struct CFG_DEVNODE *)deviceNode);
 
diff --git a/drivers/dsp/bridge/rmgr/mgr.c b/drivers/dsp/bridge/rmgr/mgr.c
index 4562157..1f2fa48 100644
--- a/drivers/dsp/bridge/rmgr/mgr.c
+++ b/drivers/dsp/bridge/rmgr/mgr.c
@@ -69,9 +69,7 @@ DSP_STATUS MGR_Create(OUT struct MGR_OBJECT **phMgrObject,
 
 	DBC_Require(phMgrObject != NULL);
 	DBC_Require(cRefs > 0);
-	GT_1trace(MGR_DebugMask, GT_ENTER,
-		 "Entering MGR_Create phMgrObject 0x%x\n ",
-		 phMgrObject);
+
 	MEM_AllocObject(pMgrObject, struct MGR_OBJECT, SIGNATURE);
 	if (pMgrObject) {
 		status = DCD_CreateManager(ZLDLLNAME, &pMgrObject->hDcdMgr);
@@ -101,9 +99,7 @@ DSP_STATUS MGR_Create(OUT struct MGR_OBJECT **phMgrObject,
 		GT_0trace(MGR_DebugMask, GT_7CLASS,
 			 "MGR_Create DSP_FAILED to allocate memory \n");
 	}
-	GT_2trace(MGR_DebugMask, GT_ENTER,
-		 "Exiting MGR_Create: phMgrObject: 0x%x\t"
-		 "status: 0x%x\n", phMgrObject, status);
+
 	DBC_Ensure(DSP_FAILED(status) ||
 		  MEM_IsValidHandle(pMgrObject, SIGNATURE));
 	return status;
@@ -121,8 +117,6 @@ DSP_STATUS MGR_Destroy(struct MGR_OBJECT *hMgrObject)
 	DBC_Require(cRefs > 0);
 	DBC_Require(MEM_IsValidHandle(hMgrObject, SIGNATURE));
 
-	GT_1trace(MGR_DebugMask, GT_ENTER,
-		 "Entering MGR_Destroy hMgrObject 0x%x\n", hMgrObject);
 	/* Free resources */
 	if (hMgrObject->hDcdMgr)
 		DCD_DestroyManager(hMgrObject->hDcdMgr);
@@ -131,10 +125,6 @@ DSP_STATUS MGR_Destroy(struct MGR_OBJECT *hMgrObject)
 	/* Update the Registry with NULL for MGR Object */
 	(void)CFG_SetObject(0, REG_MGR_OBJECT);
 
-	GT_2trace(MGR_DebugMask, GT_ENTER,
-		 "Exiting MGR_Destroy: hMgrObject: 0x%x\t"
-		 "status: 0x%x\n", hMgrObject, status);
-
 	DBC_Ensure(DSP_FAILED(status) ||
 		 !MEM_IsValidHandle(hMgrObject, SIGNATURE));
 
@@ -161,10 +151,6 @@ DSP_STATUS MGR_EnumNodeInfo(u32 uNode, OUT struct DSP_NDBPROPS *pNDBProps,
 	DBC_Require(uNDBPropsSize >= sizeof(struct DSP_NDBPROPS));
 	DBC_Require(cRefs > 0);
 
-	GT_4trace(MGR_DebugMask, GT_ENTER, "Entered Manager_EnumNodeInfo, "
-		 "args:\n\t uNode: 0x%x\n\tpNDBProps:  0x%x\n\tuNDBPropsSize:"
-		 "0x%x\tpuNumNodes: 0x%x\n", uNode, pNDBProps,
-		 uNDBPropsSize, puNumNodes);
 	*puNumNodes = 0;
 	/* Get The Manager Object from the Registry */
 	status = CFG_GetObject((u32 *)&pMgrObject, REG_MGR_OBJECT);
@@ -213,11 +199,6 @@ DSP_STATUS MGR_EnumNodeInfo(u32 uNode, OUT struct DSP_NDBPROPS *pNDBProps,
 			 "Enumeration failure\r\n");
 	}
 func_cont:
-	GT_4trace(MGR_DebugMask, GT_ENTER,
-		 "Exiting Manager_EnumNodeInfo, args:\n\t"
-		 "uNode: 0x%x\n\tpNDBProps:  0x%x\n\tuNDBPropsSize:"
-		 " 0x%x\tuNumNodes: 0x%x\n", uNode, pNDBProps,
-		uNDBPropsSize, *puNumNodes);
 	DBC_Ensure((DSP_SUCCEEDED(status) && *puNumNodes > 0) ||
 		  (DSP_FAILED(status) && *puNumNodes == 0));
 
@@ -254,11 +235,6 @@ DSP_STATUS MGR_EnumProcessorInfo(u32 uProcessor,
 	DBC_Require(uProcessorInfoSize >= sizeof(struct DSP_PROCESSORINFO));
 	DBC_Require(cRefs > 0);
 
-	GT_4trace(MGR_DebugMask, GT_ENTER,
-		 "Entered Manager_EnumProcessorInfo, "
-		 "args:\n\tuProcessor:  0x%x\n\tpProcessorInfo: 0x%x\n\t"
-		 "uProcessorInfoSize: 0x%x\tpuNumProcs: 0x%x\n", uProcessor,
-		 pProcessorInfo, uProcessorInfoSize, puNumProcs);
 	*puNumProcs = 0;
 	status = CFG_GetObject((u32 *)&hDrvObject, REG_DRV_OBJECT);
 	if (DSP_SUCCEEDED(status)) {
@@ -372,8 +348,6 @@ void MGR_Exit(void)
 	if (cRefs == 0)
 		DCD_Exit();
 
-	GT_1trace(MGR_DebugMask, GT_5CLASS,
-		 "Entered MGR_Exit, ref count: 0x%x\n", cRefs);
 	DBC_Ensure(cRefs >= 0);
 }
 
@@ -430,9 +404,6 @@ bool MGR_Init(void)
 	if (fRetval)
 		cRefs++;
 
-
-	GT_1trace(MGR_DebugMask, GT_5CLASS,
-		 "Entered MGR_Init, ref count:  0x%x\n", cRefs);
 	DBC_Ensure((fRetval && (cRefs > 0)) || (!fRetval && (cRefs >= 0)));
 
 	return fRetval;
diff --git a/drivers/dsp/bridge/rmgr/nldr.c b/drivers/dsp/bridge/rmgr/nldr.c
index 8422a2b..71487be 100644
--- a/drivers/dsp/bridge/rmgr/nldr.c
+++ b/drivers/dsp/bridge/rmgr/nldr.c
@@ -347,10 +347,6 @@ DSP_STATUS NLDR_Allocate(struct NLDR_OBJECT *hNldr, void *pPrivRef,
 	DBC_Require(phNldrNode != NULL);
 	DBC_Require(MEM_IsValidHandle(hNldr, NLDR_SIGNATURE));
 
-	GT_5trace(NLDR_debugMask, GT_ENTER, "NLDR_Allocate(0x%x, 0x%x, 0x%x, "
-		 "0x%x, 0x%x)\n", hNldr, pPrivRef, pNodeProps, phNldrNode,
-		 pfPhaseSplit);
-
 	/* Initialize handle in case of failure */
 	*phNldrNode = NULL;
 	/* Allocate node object */
@@ -472,8 +468,7 @@ DSP_STATUS NLDR_Create(OUT struct NLDR_OBJECT **phNldr,
 	DBC_Require(pAttrs != NULL);
 	DBC_Require(pAttrs->pfnOvly != NULL);
 	DBC_Require(pAttrs->pfnWrite != NULL);
-	GT_3trace(NLDR_debugMask, GT_ENTER, "NLDR_Create(0x%x, 0x%x, 0x%x)\n",
-		 phNldr, hDevObject, pAttrs);
+
 	/* Allocate dynamic loader object */
 	MEM_AllocObject(pNldr, struct NLDR_OBJECT, NLDR_SIGNATURE);
 	if (pNldr) {
@@ -649,7 +644,7 @@ void NLDR_Delete(struct NLDR_OBJECT *hNldr)
 	u16 i;
 	DBC_Require(cRefs > 0);
 	DBC_Require(MEM_IsValidHandle(hNldr, NLDR_SIGNATURE));
-	GT_1trace(NLDR_debugMask, GT_ENTER, "NLDR_Delete(0x%x)\n", hNldr);
+
 	hNldr->dbllFxns.exitFxn();
 	if (hNldr->rmm)
 		RMM_delete(hNldr->rmm);
@@ -703,9 +698,6 @@ void NLDR_Exit(void)
 
 	cRefs--;
 
-	GT_1trace(NLDR_debugMask, GT_5CLASS,
-		 "Entered NLDR_Exit, ref count:  0x%x\n", cRefs);
-
 	if (cRefs == 0) {
 		RMM_exit();
 		NLDR_debugMask.flags = NULL;
@@ -730,8 +722,6 @@ DSP_STATUS NLDR_GetFxnAddr(struct NLDR_NODEOBJECT *hNldrNode, char *pstrFxn,
 	DBC_Require(MEM_IsValidHandle(hNldrNode, NLDR_NODESIGNATURE));
 	DBC_Require(pulAddr != NULL);
 	DBC_Require(pstrFxn != NULL);
-	GT_3trace(NLDR_debugMask, GT_ENTER, "NLDR_GetFxnAddr(0x%x, %s, 0x%x)\n",
-		 hNldrNode, pstrFxn, pulAddr);
 
 	hNldr = hNldrNode->pNldr;
 	/* Called from NODE_Create(), NODE_Delete(), or NODE_Run(). */
@@ -812,8 +802,7 @@ DSP_STATUS NLDR_GetRmmManager(struct NLDR_OBJECT *hNldrObject,
 	DSP_STATUS status = DSP_SOK;
 	struct NLDR_OBJECT *pNldrObject = hNldrObject;
 	DBC_Require(phRmmMgr != NULL);
-	GT_2trace(NLDR_debugMask, GT_ENTER, "NLDR_GetRmmManager(0x%x, 0x%x)\n",
-		 hNldrObject, phRmmMgr);
+
 	if (MEM_IsValidHandle(hNldrObject, NLDR_SIGNATURE)) {
 		*phRmmMgr = pNldrObject->rmm;
 	} else {
@@ -823,9 +812,6 @@ DSP_STATUS NLDR_GetRmmManager(struct NLDR_OBJECT *hNldrObject,
 			 "NLDR_GetRmmManager:Invalid handle");
 	}
 
-	GT_2trace(NLDR_debugMask, GT_ENTER, "Exit NLDR_GetRmmManager: status "
-		 "0x%x\n\tphRmmMgr:  0x%x\n", status, *phRmmMgr);
-
 	DBC_Ensure(DSP_SUCCEEDED(status) || ((phRmmMgr != NULL) &&
 		  (*phRmmMgr == NULL)));
 
@@ -849,9 +835,6 @@ bool NLDR_Init(void)
 
 	cRefs++;
 
-	GT_1trace(NLDR_debugMask, GT_5CLASS, "NLDR_Init(), ref count: 0x%x\n",
-		 cRefs);
-
 	DBC_Ensure(cRefs > 0);
 	return true;
 }
@@ -870,9 +853,6 @@ DSP_STATUS NLDR_Load(struct NLDR_NODEOBJECT *hNldrNode, enum NLDR_PHASE phase)
 
 	hNldr = hNldrNode->pNldr;
 
-	GT_2trace(NLDR_debugMask, GT_ENTER, "NLDR_Load(0x%x, 0x%x)\n",
-		 hNldrNode, phase);
-
 	if (hNldrNode->fDynamic) {
 		hNldrNode->phase = phase;
 
@@ -927,8 +907,7 @@ DSP_STATUS NLDR_Unload(struct NLDR_NODEOBJECT *hNldrNode, enum NLDR_PHASE phase)
 
 	DBC_Require(cRefs > 0);
 	DBC_Require(MEM_IsValidHandle(hNldrNode, NLDR_NODESIGNATURE));
-	GT_2trace(NLDR_debugMask, GT_ENTER, "NLDR_Unload(0x%x, 0x%x)\n",
-		 hNldrNode, phase);
+
 	if (hNldrNode != NULL) {
 		if (hNldrNode->fDynamic) {
 			if (*hNldrNode->pfPhaseSplit) {
diff --git a/drivers/dsp/bridge/rmgr/node.c b/drivers/dsp/bridge/rmgr/node.c
index b60d1ed..d974cda 100644
--- a/drivers/dsp/bridge/rmgr/node.c
+++ b/drivers/dsp/bridge/rmgr/node.c
@@ -724,11 +724,6 @@ DBAPI NODE_AllocMsgBuf(struct NODE_OBJECT *hNode, u32 uSize,
 
 	DBC_Require(uSize > 0);
 
-	GT_4trace(NODE_debugMask, GT_ENTER,
-		 "NODE_AllocMsgBuf: hNode: 0x%x\tuSize:"
-		 " 0x%x\tpAttr: 0x%x\tpBuffer: %d\n", pNode, uSize, pAttr,
-		 pBuffer);
-
 	if (!MEM_IsValidHandle(pNode, NODE_SIGNATURE))
 		status = DSP_EHANDLE;
 	else if (NODE_GetType(pNode) == NODE_DEVICE)
@@ -817,9 +812,6 @@ DSP_STATUS NODE_ChangePriority(struct NODE_OBJECT *hNode, s32 nPriority)
 
 	DBC_Require(cRefs > 0);
 
-	GT_2trace(NODE_debugMask, GT_ENTER, "NODE_ChangePriority: "
-		 "hNode: 0x%x\tnPriority: %d\n", hNode, nPriority);
-
 	if (!MEM_IsValidHandle(hNode, NODE_SIGNATURE) || !hNode->hNodeMgr) {
 		GT_1trace(NODE_debugMask, GT_7CLASS,
 			 "Invalid NODE Handle: 0x%x\n", hNode);
@@ -1365,8 +1357,7 @@ DSP_STATUS NODE_CreateMgr(OUT struct NODE_MGR **phNodeMgr,
 	DBC_Require(cRefs > 0);
 	DBC_Require(phNodeMgr != NULL);
 	DBC_Require(hDevObject != NULL);
-	GT_2trace(NODE_debugMask, GT_ENTER, "NODE_CreateMgr: phNodeMgr: 0x%x\t"
-		 "hDevObject: 0x%x\n", phNodeMgr, hDevObject);
+
 	*phNodeMgr = NULL;
 	/* Allocate Node manager object */
 	MEM_AllocObject(pNodeMgr, struct NODE_MGR, NODEMGR_SIGNATURE);
@@ -1637,12 +1628,10 @@ func_cont1:
 		GT_0trace(NODE_debugMask, GT_5CLASS, "\nNODE_Delete12:\n");
 		DRV_ProcNodeUpdateStatus(nodeRes, false);
 	}
-	GT_0trace(NODE_debugMask, GT_ENTER, "\nNODE_Delete13:\n ");
 	DeleteNode(hNode, pr_ctxt);
 
 	GT_0trace(NODE_debugMask, GT_5CLASS, "\nNODE_Delete2:\n ");
 	DRV_RemoveNodeResElement(nodeRes, pr_ctxt);
-	GT_0trace(NODE_debugMask, GT_ENTER, "\nNODE_Delete3:\n ");
 	/* Exit critical section */
 	(void)SYNC_LeaveCS(hNodeMgr->hSync);
 	PROC_NotifyClients(hProcessor, DSP_NODESTATECHANGE);
@@ -1661,8 +1650,6 @@ DSP_STATUS NODE_DeleteMgr(struct NODE_MGR *hNodeMgr)
 
 	DBC_Require(cRefs > 0);
 
-	GT_1trace(NODE_debugMask, GT_ENTER, "NODE_DeleteMgr: hNodeMgr: 0x%x\n",
-		 hNodeMgr);
 	if (MEM_IsValidHandle(hNodeMgr, NODEMGR_SIGNATURE))
 		DeleteNodeMgr(hNodeMgr);
 	else
@@ -1687,10 +1674,7 @@ DSP_STATUS NODE_EnumNodes(struct NODE_MGR *hNodeMgr, IN DSP_HNODE *aNodeTab,
 	DBC_Require(aNodeTab != NULL || uNodeTabSize == 0);
 	DBC_Require(puNumNodes != NULL);
 	DBC_Require(puAllocated != NULL);
-	GT_5trace(NODE_debugMask, GT_ENTER, "NODE_EnumNodes: hNodeMgr: 0x%x\t"
-		 "aNodeTab: %d\tuNodeTabSize: 0x%x\tpuNumNodes: 0x%x\t"
-		 "puAllocated\n", hNodeMgr, aNodeTab, uNodeTabSize, puNumNodes,
-		 puAllocated);
+
 	if (!MEM_IsValidHandle(hNodeMgr, NODEMGR_SIGNATURE)) {
 		status = DSP_EHANDLE;
 		goto func_end;
@@ -1734,9 +1718,6 @@ void NODE_Exit(void)
 
 	cRefs--;
 
-	GT_1trace(NODE_debugMask, GT_5CLASS,
-		 "Entered NODE_Exit, ref count:  0x%x\n", cRefs);
-
 	DBC_Ensure(cRefs >= 0);
 }
 
@@ -1755,8 +1736,7 @@ DSP_STATUS NODE_FreeMsgBuf(struct NODE_OBJECT *hNode, IN u8 *pBuffer,
 	DBC_Require(pBuffer != NULL);
 	DBC_Require(pNode != NULL);
 	DBC_Require(pNode->hXlator != NULL);
-	GT_3trace(NODE_debugMask, GT_ENTER, "NODE_FreeMsgBuf: hNode: 0x%x\t"
-		 "pBuffer: 0x%x\tpAttr: 0x%x\n", hNode, pBuffer, pAttr);
+
 	if (!MEM_IsValidHandle(hNode, NODE_SIGNATURE)) {
 		status = DSP_EHANDLE;
 		goto func_end;
@@ -1796,9 +1776,7 @@ DSP_STATUS NODE_GetAttr(struct NODE_OBJECT *hNode,
 	DBC_Require(cRefs > 0);
 	DBC_Require(pAttr != NULL);
 	DBC_Require(uAttrSize >= sizeof(struct DSP_NODEATTR));
-	GT_3trace(NODE_debugMask, GT_ENTER, "NODE_GetAttr: hNode: "
-		 "0x%x\tpAttr: 0x%x \tuAttrSize: 0x%x\n", hNode, pAttr,
-		 uAttrSize);
+
 	if (!MEM_IsValidHandle(hNode, NODE_SIGNATURE)) {
 		status = DSP_EHANDLE;
 	} else {
@@ -1844,9 +1822,7 @@ DSP_STATUS NODE_GetChannelId(struct NODE_OBJECT *hNode, u32 uDir, u32 uIndex,
 	DBC_Require(cRefs > 0);
 	DBC_Require(uDir == DSP_TONODE || uDir == DSP_FROMNODE);
 	DBC_Require(pulId != NULL);
-	GT_4trace(NODE_debugMask, GT_ENTER, "NODE_GetChannelId: hNode: "
-		 "0x%x\tuDir: %d\tuIndex: %d\tpulId: 0x%x\n", hNode, uDir,
-		 uIndex, pulId);
+
 	if (!MEM_IsValidHandle(hNode, NODE_SIGNATURE)) {
 		status = DSP_EHANDLE;
 		return status;
@@ -1966,17 +1942,12 @@ DSP_STATUS NODE_GetNldrObj(struct NODE_MGR *hNodeMgr,
 	DSP_STATUS status = DSP_SOK;
 	struct NODE_MGR *pNodeMgr = hNodeMgr;
 	DBC_Require(phNldrObj != NULL);
-	GT_2trace(NODE_debugMask, GT_ENTER,
-		 "Entered NODE_GetNldrObj, hNodeMgr: "
-		 "0x%x\n\tphNldrObj:  0x%x\n", hNodeMgr, phNldrObj);
+
 	if (!MEM_IsValidHandle(hNodeMgr, NODEMGR_SIGNATURE))
 		status = DSP_EHANDLE;
 	else
 		*phNldrObj = pNodeMgr->hNldr;
 
-	GT_2trace(NODE_debugMask, GT_ENTER,
-		 "Exit NODE_GetNldrObj: status 0x%x\n\t"
-		 "phNldrObj:  0x%x\n", status, *phNldrObj);
 	DBC_Ensure(DSP_SUCCEEDED(status) || ((phNldrObj != NULL) &&
 		  (*phNldrObj == NULL)));
 	return status;
@@ -2074,9 +2045,6 @@ bool NODE_Init(void)
 
 	cRefs++;
 
-	GT_1trace(NODE_debugMask, GT_5CLASS, "NODE_Init(), ref count: 0x%x\n",
-		 cRefs);
-
 	return true;
 }
 
@@ -3196,11 +3164,6 @@ DSP_STATUS NODE_GetUUIDProps(DSP_HPROCESSOR hProcessor,
 		goto func_end;
 	}
 
-	GT_3trace(NODE_debugMask, GT_ENTER,
-		 "NODE_GetUUIDProps: " "\thProcessor: "
-		 "0x%x\tpNodeId: 0x%x" "\tpNodeProps: 0x%x\n", hProcessor,
-		 pNodeId, pNodeProps);
-
 	status = PROC_GetDevObject(hProcessor, &hDevObject);
 	if (hDevObject) {
 		status = DEV_GetNodeManager(hDevObject, &hNodeMgr);
diff --git a/drivers/dsp/bridge/rmgr/proc.c b/drivers/dsp/bridge/rmgr/proc.c
index 2ccbc9b..7c0264e 100644
--- a/drivers/dsp/bridge/rmgr/proc.c
+++ b/drivers/dsp/bridge/rmgr/proc.c
@@ -129,10 +129,6 @@ PROC_Attach(u32 uProcessor, OPTIONAL CONST struct DSP_PROCESSORATTRIN *pAttrIn,
 	DBC_Require(cRefs > 0);
 	DBC_Require(phProcessor != NULL);
 
-	GT_3trace(PROC_DebugMask, GT_ENTER, "Entered PROC_Attach, args:\n\t"
-		 "uProcessor:  0x%x\n\tpAttrIn:  0x%x\n\tphProcessor:"
-		 "0x%x\n", uProcessor, pAttrIn, phProcessor);
-
 	if (pr_ctxt->hProcessor) {
 		*phProcessor = pr_ctxt->hProcessor;
 		return status;
@@ -267,8 +263,6 @@ func_end:
 		  MEM_IsValidHandle(pProcObject, PROC_SIGNATURE)) ||
 		  (status == DSP_SALREADYATTACHED &&
 		  MEM_IsValidHandle(pProcObject, PROC_SIGNATURE)));
-	GT_2trace(PROC_DebugMask, GT_ENTER, "Exiting PROC_Attach, results:\n\t"
-		 "status: 0x%x\n\thProcessor: 0x%x\n", status, *phProcessor);
 
 	return status;
 }
@@ -323,9 +317,6 @@ DSP_STATUS PROC_AutoStart(struct CFG_DEVNODE *hDevNode,
 	DBC_Require(hDevNode != NULL);
 	DBC_Require(hDevObject != NULL);
 
-	GT_2trace(PROC_DebugMask, GT_ENTER,
-		 "Entered PROC_AutoStart, args:\n\t"
-		 "hDevNode: 0x%x\thDevObject: 0x%x\n", hDevNode, hDevObject);
 	/* Create a Dummy PROC Object */
 	status = CFG_GetObject((u32 *)&hMgrObject, REG_MGR_OBJECT);
 	if (DSP_FAILED(status)) {
@@ -413,8 +404,6 @@ func_cont:
 	hProcObject->g_pszLastCoff = NULL;
 	MEM_FreeObject(hProcObject);
 func_end:
-	GT_1trace(PROC_DebugMask, GT_ENTER,
-		 "Exiting PROC_AutoStart, status:0x%x\n", status);
 	return status;
 }
 
@@ -437,9 +426,6 @@ DSP_STATUS PROC_Ctrl(DSP_HPROCESSOR hProcessor, u32 dwCmd,
 	u32 timeout = 0;
 
 	DBC_Require(cRefs > 0);
-	GT_3trace(PROC_DebugMask, GT_ENTER,
-		 "Entered PROC_Ctrl, args:\n\thProcessor:"
-		 " 0x%x\n\tdwCmd: 0x%x\n\targ: 0x%x\n", hProcessor, dwCmd, arg);
 
 	if (MEM_IsValidHandle(pProcObject, PROC_SIGNATURE)) {
 		/* intercept PWR deep sleep command */
@@ -477,8 +463,7 @@ DSP_STATUS PROC_Ctrl(DSP_HPROCESSOR hProcessor, u32 dwCmd,
 		GT_0trace(PROC_DebugMask, GT_7CLASS,
 			 "PROC_Ctrl: InValid Processor Handle \n");
 	}
-	GT_1trace(PROC_DebugMask, GT_ENTER, "Exiting PROC_Ctrl, 0x%x\n",
-		 status);
+
 	return status;
 }
 
@@ -494,7 +479,6 @@ DSP_STATUS PROC_Detach(struct PROCESS_CONTEXT *pr_ctxt)
 	struct PROC_OBJECT *pProcObject = NULL;
 
 	DBC_Require(cRefs > 0);
-	GT_0trace(PROC_DebugMask, GT_ENTER, "Entered PROC_Detach\n");
 
 	pProcObject = (struct PROC_OBJECT *)pr_ctxt->hProcessor;
 
@@ -518,8 +502,7 @@ DSP_STATUS PROC_Detach(struct PROCESS_CONTEXT *pr_ctxt)
 		GT_0trace(PROC_DebugMask, GT_7CLASS,
 			 "PROC_Detach: InValid Processor Handle \n");
 	}
-	GT_1trace(PROC_DebugMask, GT_ENTER, "Exiting PROC_Detach, 0x%x\n",
-		 status);
+
 	return status;
 }
 
@@ -542,11 +525,6 @@ DSP_STATUS PROC_EnumNodes(DSP_HPROCESSOR hProcessor, OUT DSP_HNODE *aNodeTab,
 	DBC_Require(puNumNodes != NULL);
 	DBC_Require(puAllocated != NULL);
 
-	GT_5trace(PROC_DebugMask, GT_ENTER, "Entered PROC_EnumNodes, args:\n\t"
-			"hProcessor:  0x%x\n\taNodeTab:  0x%x\n\tuNodeTabSize: "
-			" 0x%x\n\t puNumNodes 0x%x\n\t puAllocated: 0x%x\n",
-			hProcessor, aNodeTab, uNodeTabSize, puNumNodes,
-			puAllocated);
 	if (MEM_IsValidHandle(pProcObject, PROC_SIGNATURE)) {
 		if (DSP_SUCCEEDED(DEV_GetNodeManager(pProcObject->hDevObject,
 				 &hNodeMgr))) {
@@ -562,11 +540,6 @@ DSP_STATUS PROC_EnumNodes(DSP_HPROCESSOR hProcessor, OUT DSP_HNODE *aNodeTab,
 		GT_0trace(PROC_DebugMask, GT_7CLASS, "PROC_EnumNodes: "
 			 "InValid Processor Handle \n");
 	}
-	GT_6trace(PROC_DebugMask, GT_ENTER, "Exit PROC_EnumNodes, args:\n\t"
-			"hProcessor:  0x%x\n\taNodeTab:  0x%x\n\tuNodeTabSize: "
-			" 0x%x\n\t puNumNodes 0x%x\n\t puAllocated: 0x%x\n\t "
-			"status: 0x%x \n", hProcessor, aNodeTab, uNodeTabSize,
-			puNumNodes, puAllocated, status);
 
 	return status;
 }
@@ -652,10 +625,6 @@ static DSP_STATUS proc_memory_sync(DSP_HPROCESSOR hProcessor, void *pMpuAddr,
 	struct PROC_OBJECT *pProcObject = (struct PROC_OBJECT *)hProcessor;
 
 	DBC_Require(cRefs > 0);
-	GT_5trace(PROC_DebugMask, GT_ENTER,
-		  "Entered %s, args:\n\t"
-		  "hProcessor: 0x%x pMpuAddr: 0x%x ulSize 0x%x, ulFlags 0x%x\n",
-		  __func__, hProcessor, pMpuAddr, ulSize, ulFlags);
 
 	if (!MEM_IsValidHandle(pProcObject, PROC_SIGNATURE)) {
 		GT_1trace(PROC_DebugMask, GT_7CLASS,
@@ -675,8 +644,6 @@ static DSP_STATUS proc_memory_sync(DSP_HPROCESSOR hProcessor, void *pMpuAddr,
 	up_read(&current->mm->mmap_sem);
 
 err_out:
-	GT_2trace(PROC_DebugMask, GT_ENTER,
-		  "Leaving %s [0x%x]", __func__, status);
 
 	return status;
 }
@@ -727,10 +694,6 @@ DSP_STATUS PROC_GetResourceInfo(DSP_HPROCESSOR hProcessor, u32 uResourceType,
 	DBC_Require(pResourceInfo != NULL);
 	DBC_Require(uResourceInfoSize >= sizeof(struct DSP_RESOURCEINFO));
 
-	GT_4trace(PROC_DebugMask, GT_ENTER, "Entered PROC_GetResourceInfo,\n\t"
-		 "hProcessor:  0x%x\n\tuResourceType:  0x%x\n\tpResourceInfo:"
-		 " 0x%x\n\t uResourceInfoSize 0x%x\n", hProcessor,
-		 uResourceType, pResourceInfo, uResourceInfoSize);
 	if (!MEM_IsValidHandle(pProcObject, PROC_SIGNATURE)) {
 		status = DSP_EHANDLE;
 		GT_0trace(PROC_DebugMask, GT_7CLASS,
@@ -776,8 +739,6 @@ DSP_STATUS PROC_GetResourceInfo(DSP_HPROCESSOR hProcessor, u32 uResourceType,
 		break;
 	}
 func_end:
-	GT_1trace(PROC_DebugMask, GT_ENTER, "Exiting PROC_GetResourceInfo, "
-		 "status 0x%x\n", status);
 	return status;
 }
 
@@ -796,8 +757,6 @@ void PROC_Exit(void)
 
 	cRefs--;
 
-	GT_1trace(PROC_DebugMask, GT_5CLASS,
-		 "Entered PROC_Exit, ref count:0x%x\n",	cRefs);
 	DBC_Ensure(cRefs >= 0);
 }
 
@@ -848,9 +807,6 @@ DSP_STATUS PROC_GetState(DSP_HPROCESSOR hProcessor,
 	DBC_Require(pProcStatus != NULL);
 	DBC_Require(uStateInfoSize >= sizeof(struct DSP_PROCESSORSTATE));
 
-	GT_3trace(PROC_DebugMask, GT_ENTER, "Entering PROC_GetState, args:\n\t"
-		 "pProcStatus: 0x%x\n\thProcessor: 0x%x\n\t uStateInfoSize"
-		 " 0x%x\n", pProcStatus, hProcessor, uStateInfoSize);
 	if (MEM_IsValidHandle(pProcObject, PROC_SIGNATURE)) {
 		/* First, retrieve BRD state information */
 		status = (*pProcObject->pIntfFxns->pfnBrdStatus)
@@ -949,8 +905,6 @@ bool PROC_Init(void)
 	if (fRetval)
 		cRefs++;
 
-	GT_1trace(PROC_DebugMask, GT_5CLASS,
-		 "Entered PROC_Init, ref count:0x%x\n",	cRefs);
 	DBC_Ensure((fRetval && (cRefs > 0)) || (!fRetval && (cRefs >= 0)));
 
 	return fRetval;
@@ -1002,8 +956,6 @@ DSP_STATUS PROC_Load(DSP_HPROCESSOR hProcessor, IN CONST s32 iArgc,
 #ifdef OPT_LOAD_TIME_INSTRUMENTATION
 	do_gettimeofday(&tv1);
 #endif
-	GT_2trace(PROC_DebugMask, GT_ENTER, "Entered PROC_Load, args:\n\t"
-		 "hProcessor:  0x%x\taArgv: 0x%x\n", hProcessor, aArgv[0]);
 	/* Call the WMD_BRD_Load Fxn */
 	if (!MEM_IsValidHandle(pProcObject, PROC_SIGNATURE)) {
 		status = DSP_EHANDLE;
@@ -1253,8 +1205,6 @@ func_end:
 
 	}
 #endif
-	GT_1trace(PROC_DebugMask, GT_ENTER,
-		 "Exiting PROC_Load, status:  0x%x\n", status);
 	DBC_Ensure((DSP_SUCCEEDED(status) && pProcObject->sState == PROC_LOADED)
 		   || DSP_FAILED(status));
 #ifdef OPT_LOAD_TIME_INSTRUMENTATION
@@ -1359,12 +1309,6 @@ DSP_STATUS PROC_RegisterNotify(DSP_HPROCESSOR hProcessor, u32 uEventMask,
 	DBC_Require(hNotification != NULL);
 	DBC_Require(cRefs > 0);
 
-	GT_4trace(PROC_DebugMask, GT_ENTER,
-		 "Entered PROC_RegisterNotify, args:\n\t"
-		 "hProcessor:  0x%x\n\tuEventMask:  0x%x\n\tuNotifyMask:"
-		 " 0x%x\n\t hNotification 0x%x\n", hProcessor, uEventMask,
-		 uNotifyType, hNotification);
-
 	/* Check processor handle */
 	if (!MEM_IsValidHandle(pProcObject, PROC_SIGNATURE)) {
 		status = DSP_EHANDLE;
@@ -1474,8 +1418,6 @@ DSP_STATUS PROC_Start(DSP_HPROCESSOR hProcessor)
 	BRD_STATUS uBrdState;
 #endif
 	DBC_Require(cRefs > 0);
-	GT_1trace(PROC_DebugMask, GT_ENTER, "Entered PROC_Start, args:\n\t"
-		 "hProcessor:  0x%x\n", hProcessor);
 	if (!MEM_IsValidHandle(pProcObject, PROC_SIGNATURE)) {
 		status = DSP_EHANDLE;
 		GT_0trace(PROC_DebugMask, GT_7CLASS,
@@ -1545,8 +1487,6 @@ func_cont:
 	}
 #endif
 func_end:
-	GT_1trace(PROC_DebugMask, GT_ENTER,
-		 "Exiting PROC_Start, status  0x%x\n", status);
 	DBC_Ensure((DSP_SUCCEEDED(status) && pProcObject->sState ==
 		  PROC_RUNNING)	|| DSP_FAILED(status));
 	return status;
@@ -1570,8 +1510,6 @@ DSP_STATUS PROC_Stop(DSP_HPROCESSOR hProcessor)
 	BRD_STATUS uBrdState;
 
 	DBC_Require(cRefs > 0);
-	GT_1trace(PROC_DebugMask, GT_ENTER, "Entered PROC_Stop, args:\n\t"
-		 "hProcessor:  0x%x\n", hProcessor);
 	if (!MEM_IsValidHandle(pProcObject, PROC_SIGNATURE)) {
 		status = DSP_EHANDLE;
 		GT_0trace(PROC_DebugMask, GT_7CLASS,
@@ -1630,8 +1568,6 @@ DSP_STATUS PROC_Stop(DSP_HPROCESSOR hProcessor)
 			 "PROC_Stop Failed to Stop the processor/device \n");
 	}
 func_end:
-	GT_1trace(PROC_DebugMask, GT_ENTER, "Exiting PROC_Stop, status  0x%x\n",
-		 status);
 
 	return status;
 }
@@ -1763,8 +1699,6 @@ static DSP_STATUS PROC_Monitor(struct PROC_OBJECT *hProcObject)
 	DBC_Require(cRefs > 0);
 	DBC_Require(MEM_IsValidHandle(pProcObject, PROC_SIGNATURE));
 
-	GT_1trace(PROC_DebugMask, GT_ENTER, "Entered PROC_Monitor, args:\n\t"
-		 "hProcessor: 0x%x\n", hProcObject);
 	/* This is needed only when Device is loaded when it is
 	 * already 'ACTIVE' */
 	/* Destory the Node Manager, MSG Manager */
@@ -1795,9 +1729,7 @@ static DSP_STATUS PROC_Monitor(struct PROC_OBJECT *hProcObject)
 			 "PROC_Monitor: Processor Could not"
 			 "be put in Monitor mode \n");
 	}
-	GT_1trace(PROC_DebugMask, GT_ENTER,
-		 "Exiting PROC_Monitor, status  0x%x\n",
-		 status);
+
 #ifdef CONFIG_BRIDGE_DEBUG
 	DBC_Ensure((DSP_SUCCEEDED(status) && uBrdState == BRD_IDLE) ||
 		  DSP_FAILED(status));
diff --git a/drivers/dsp/bridge/rmgr/rmm.c b/drivers/dsp/bridge/rmgr/rmm.c
index fd61220..be8017f 100644
--- a/drivers/dsp/bridge/rmgr/rmm.c
+++ b/drivers/dsp/bridge/rmgr/rmm.c
@@ -116,10 +116,6 @@ DSP_STATUS RMM_alloc(struct RMM_TargetObj *target, u32 segid, u32 size,
 	DBC_Require(reserve || (target->numSegs > 0));
 	DBC_Require(cRefs > 0);
 
-	GT_6trace(RMM_debugMask, GT_ENTER,
-		 "RMM_alloc(0x%lx, 0x%lx, 0x%lx, 0x%lx, "
-		 "0x%lx, 0x%lx)\n", target, segid, size, align, dspAddr,
-		 reserve);
 	if (!reserve) {
 		if (!allocBlock(target, segid, size, align, dspAddr)) {
 			status = DSP_EMEMORY;
@@ -190,10 +186,6 @@ DSP_STATUS RMM_create(struct RMM_TargetObj **pTarget,
 	DBC_Require(pTarget != NULL);
 	DBC_Require(numSegs == 0 || segTab != NULL);
 
-	GT_3trace(RMM_debugMask, GT_ENTER,
-		 "RMM_create(0x%lx, 0x%lx, 0x%lx)\n",
-		 pTarget, segTab, numSegs);
-
 	/* Allocate DBL target object */
 	MEM_AllocObject(target, struct RMM_TargetObj, RMM_TARGSIGNATURE);
 
@@ -293,8 +285,6 @@ void RMM_delete(struct RMM_TargetObj *target)
 
 	DBC_Require(MEM_IsValidHandle(target, RMM_TARGSIGNATURE));
 
-	GT_1trace(RMM_debugMask, GT_ENTER, "RMM_delete(0x%lx)\n", target);
-
 	kfree(target->segTab);
 
 	if (target->ovlyList) {
@@ -331,9 +321,6 @@ void RMM_exit(void)
 
 	cRefs--;
 
-	GT_1trace(RMM_debugMask, GT_5CLASS, "RMM_exit() ref count: 0x%x\n",
-		 cRefs);
-
 	DBC_Ensure(cRefs >= 0);
 }
 
@@ -354,9 +341,6 @@ bool RMM_free(struct RMM_TargetObj *target, u32 segid, u32 addr, u32 size,
 		   (addr + size) <= (target->segTab[segid].base +
 		   target->segTab[segid].length)));
 
-	GT_5trace(RMM_debugMask, GT_ENTER,
-		 "RMM_free(0x%lx, 0x%lx, 0x%lx, 0x%lx, "
-		 "0x%lx)\n", target, segid, addr, size, reserved);
 	/*
 	 *  Free or unreserve memory.
 	 */
@@ -402,10 +386,6 @@ bool RMM_init(void)
 
 	cRefs++;
 
-	GT_1trace(RMM_debugMask, GT_5CLASS,
-		 "RMM_init(), ref count:  0x%x\n",
-		 cRefs);
-
 	return true;
 }
 
diff --git a/drivers/dsp/bridge/rmgr/strm.c b/drivers/dsp/bridge/rmgr/strm.c
index 1b24f08..5d74819 100644
--- a/drivers/dsp/bridge/rmgr/strm.c
+++ b/drivers/dsp/bridge/rmgr/strm.c
@@ -118,9 +118,6 @@ DSP_STATUS STRM_AllocateBuffer(struct STRM_OBJECT *hStrm, u32 uSize,
 	DBC_Require(cRefs > 0);
 	DBC_Require(apBuffer != NULL);
 
-	GT_4trace(STRM_debugMask, GT_ENTER, "STRM_AllocateBuffer: hStrm: 0x%x\t"
-		 "uSize: 0x%x\tapBuffer: 0x%x\tuNumBufs: 0x%x\n",
-		 hStrm, uSize, apBuffer, uNumBufs);
 	if (MEM_IsValidHandle(hStrm, STRM_SIGNATURE)) {
 		/*
 		 * Allocate from segment specified at time of stream open.
@@ -221,8 +218,6 @@ DSP_STATUS STRM_Create(OUT struct STRM_MGR **phStrmMgr, struct DEV_OBJECT *hDev)
 	DBC_Require(phStrmMgr != NULL);
 	DBC_Require(hDev != NULL);
 
-	GT_2trace(STRM_debugMask, GT_ENTER, "STRM_Create: phStrmMgr: "
-		 "0x%x\thDev: 0x%x\n", phStrmMgr, hDev);
 	*phStrmMgr = NULL;
 	/* Allocate STRM manager object */
 	MEM_AllocObject(pStrmMgr, struct STRM_MGR, STRMMGR_SIGNATURE);
@@ -270,9 +265,6 @@ void STRM_Delete(struct STRM_MGR *hStrmMgr)
 	DBC_Require(cRefs > 0);
 	DBC_Require(MEM_IsValidHandle(hStrmMgr, STRMMGR_SIGNATURE));
 
-	GT_1trace(STRM_debugMask, GT_ENTER, "STRM_Delete: hStrmMgr: 0x%x\n",
-		 hStrmMgr);
-
 	DeleteStrmMgr(hStrmMgr);
 
 	DBC_Ensure(!MEM_IsValidHandle(hStrmMgr, STRMMGR_SIGNATURE));
@@ -289,9 +281,6 @@ void STRM_Exit(void)
 
 	cRefs--;
 
-	GT_1trace(STRM_debugMask, GT_5CLASS,
-		 "Entered STRM_Exit, ref count:  0x%x\n", cRefs);
-
 	DBC_Ensure(cRefs >= 0);
 }
 
@@ -311,9 +300,6 @@ DSP_STATUS STRM_FreeBuffer(struct STRM_OBJECT *hStrm, u8 **apBuffer,
 	DBC_Require(cRefs > 0);
 	DBC_Require(apBuffer != NULL);
 
-	GT_3trace(STRM_debugMask, GT_ENTER, "STRM_FreeBuffer: hStrm: 0x%x\t"
-		 "apBuffer: 0x%x\tuNumBufs: 0x%x\n", hStrm, apBuffer, uNumBufs);
-
 	if (!MEM_IsValidHandle(hStrm, STRM_SIGNATURE))
 		status = DSP_EHANDLE;
 
@@ -355,9 +341,6 @@ DSP_STATUS STRM_GetInfo(struct STRM_OBJECT *hStrm,
 	DBC_Require(pStreamInfo != NULL);
 	DBC_Require(uStreamInfoSize >= sizeof(struct STRM_INFO));
 
-	GT_3trace(STRM_debugMask, GT_ENTER, "STRM_GetInfo: hStrm: 0x%x\t"
-		 "pStreamInfo: 0x%x\tuStreamInfoSize: 0x%x\n", hStrm,
-		 pStreamInfo, uStreamInfoSize);
 	if (!MEM_IsValidHandle(hStrm, STRM_SIGNATURE)) {
 		status = DSP_EHANDLE;
 	} else {
@@ -452,9 +435,6 @@ bool STRM_Init(void)
 	if (fRetVal)
 		cRefs++;
 
-	GT_1trace(STRM_debugMask, GT_5CLASS, "STRM_Init(), ref count: 0x%x\n",
-		 cRefs);
-
 	DBC_Ensure((fRetVal && (cRefs > 0)) || (!fRetVal && (cRefs >= 0)));
 
 	return fRetVal;
@@ -769,10 +749,6 @@ DSP_STATUS STRM_RegisterNotify(struct STRM_OBJECT *hStrm, u32 uEventMask,
 	DBC_Require(cRefs > 0);
 	DBC_Require(hNotification != NULL);
 
-	GT_4trace(STRM_debugMask, GT_ENTER,
-		 "STRM_RegisterNotify: hStrm: 0x%x\t"
-		 "uEventMask: 0x%x\tuNotifyType: 0x%x\thNotification: 0x%x\n",
-		 hStrm, uEventMask, uNotifyType, hNotification);
 	if (!MEM_IsValidHandle(hStrm, STRM_SIGNATURE)) {
 		status = DSP_EHANDLE;
 	} else if ((uEventMask & ~((DSP_STREAMIOCOMPLETION) |
@@ -816,10 +792,6 @@ DSP_STATUS STRM_Select(IN struct STRM_OBJECT **aStrmTab, u32 nStrms,
 	DBC_Require(pMask != NULL);
 	DBC_Require(nStrms > 0);
 
-	GT_4trace(STRM_debugMask, GT_ENTER,
-		 "STRM_Select: aStrmTab: 0x%x \tnStrms: "
-		 "0x%x\tpMask: 0x%x\tuTimeout: 0x%x\n", aStrmTab,
-		 nStrms, pMask, uTimeout);
 	*pMask = 0;
 	for (i = 0; i < nStrms; i++) {
 		if (!MEM_IsValidHandle(aStrmTab[i], STRM_SIGNATURE)) {
-- 
1.6.2.4

