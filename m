From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 3/3] DSPBRIDGE: return right error codes rmgr directory
Date: Tue, 19 Jan 2010 12:15:11 -0600
Message-ID: <1263924911-7404-4-git-send-email-omar.ramirez@ti.com>
References: <1263924911-7404-1-git-send-email-omar.ramirez@ti.com>
 <1263924911-7404-2-git-send-email-omar.ramirez@ti.com>
 <1263924911-7404-3-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:39100 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754854Ab0ASSFv (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 19 Jan 2010 13:05:51 -0500
In-Reply-To: <1263924911-7404-3-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Ameya Palande <ameya.palande@nokia.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>, Nishanth Menon <nm@ti.com>, Fernando Guzman Lugo <x0095840@ti.com>

From: Fernando Guzman Lugo <x0095840@ti.com>

This patch fixes bad error codes returned by some functions,
it validates status of previously unchecked functions and
removes unused conditional statements or status variables.

Signed-off-by: Fernando Guzman Lugo <x0095840@ti.com>
---
 drivers/dsp/bridge/rmgr/dbdcd.c  |   31 ++++------
 drivers/dsp/bridge/rmgr/disp.c   |   36 +++++------
 drivers/dsp/bridge/rmgr/drv.c    |   89 ++++++++++++++-------------
 drivers/dsp/bridge/rmgr/dspdrv.c |   27 ++++-----
 drivers/dsp/bridge/rmgr/mgr.c    |   23 +++----
 drivers/dsp/bridge/rmgr/nldr.c   |   32 ++++-------
 drivers/dsp/bridge/rmgr/node.c   |  123 ++++++++++++++++++--------------------
 drivers/dsp/bridge/rmgr/proc.c   |  100 +++++++++++++-----------------
 drivers/dsp/bridge/rmgr/strm.c   |   31 +++-------
 9 files changed, 217 insertions(+), 275 deletions(-)

diff --git a/drivers/dsp/bridge/rmgr/dbdcd.c b/drivers/dsp/bridge/rmgr/dbdcd.c
index fed9f38..3d50952 100644
--- a/drivers/dsp/bridge/rmgr/dbdcd.c
+++ b/drivers/dsp/bridge/rmgr/dbdcd.c
@@ -161,7 +161,6 @@ DSP_STATUS DCD_CreateManager(IN char *pszZlDllName,
 	status = COD_Create(&hCodMgr, pszZlDllName, NULL);
 
 	if (DSP_FAILED(status)) {
-		status = DSP_EFAIL;
 		GT_0trace(curTrace, GT_6CLASS,
 			 "DCD_CreateManager: COD_Create failed\n");
 		goto func_end;
@@ -442,8 +441,10 @@ DSP_STATUS DCD_GetObjectDef(IN struct DCD_MANAGER *hDcdMgr,
 		 " 0x%x, objType 0x%x, pObjDef 0x%x\n", hDcdMgr, pObjUuid,
 		 objType, pObjDef);
 	szUuid = (char *)MEM_Calloc(MAXUUIDLEN, MEM_PAGED);
-	if (!szUuid)
-		return status = DSP_EMEMORY;
+	if (!szUuid) {
+		status = DSP_EMEMORY;
+		goto func_end;
+	}
 
 	if (!IsValidHandle(hDcdMgr)) {
 		status = DSP_EHANDLE;
@@ -759,13 +760,10 @@ DSP_STATUS DCD_GetLibraryName(IN struct DCD_MANAGER *hDcdMgr,
 		sprintf(szObjType, "%d", DSP_DCDLIBRARYTYPE);
 		break;
 	default:
-		status = -1;
+		status = DSP_EINVALIDARG;
 		DBC_Assert(false);
 	}
-	if (status == -1) {
-		status = DSP_EFAIL;
-	} else {
-		status = DSP_SOK;
+	if (DSP_SUCCEEDED(status)) {
 		if ((strlen(szRegKey) + strlen(szObjType)) <
 		   REG_MAXREGPATHLENGTH) {
 			strncat(szRegKey, szObjType, strlen(szObjType) + 1);
@@ -943,23 +941,18 @@ DSP_STATUS DCD_RegisterObject(IN struct DSP_UUID *pUuid,
 		/* Add new reg value (UUID+objType) with COFF path info */
 		dwPathSize = strlen(pszPathName) + 1;
 		status = REG_SetValue(szRegKey, (u8 *)pszPathName, dwPathSize);
-		GT_2trace(curTrace, GT_6CLASS, "REG_SetValue "
-			"(u8 *)pszPathName=%s, dwPathSize=%d\n",
-			pszPathName, dwPathSize);
-
-		if (DSP_FAILED(status)) {
-			status = DSP_EFAIL;
+		GT_2trace(curTrace, GT_6CLASS, "REG_SetValue  "
+			  "(u8 *)pszPathName=%s, dwPathSize=%d\n",
+			  pszPathName, dwPathSize);
+		if (DSP_FAILED(status))
 			GT_0trace(curTrace, GT_6CLASS,
-				  "DCD_RegisterObject: REG_SetValue failed!\n");
-		}
+				"DCD_RegisterObject: REG_SetValue failed!\n");
 	} else {
 		/* Deregister an existing object */
 		status = REG_DeleteValue(szRegKey);
-		if (DSP_FAILED(status)) {
-			status = DSP_EFAIL;
+		if (DSP_FAILED(status))
 			GT_0trace(curTrace, GT_6CLASS, "DCD_UnregisterObject: "
 				"REG_DeleteValue failed!\n");
-		}
 	}
 
 
diff --git a/drivers/dsp/bridge/rmgr/disp.c b/drivers/dsp/bridge/rmgr/disp.c
index 6ea15b4..949c5e3 100644
--- a/drivers/dsp/bridge/rmgr/disp.c
+++ b/drivers/dsp/bridge/rmgr/disp.c
@@ -160,23 +160,22 @@ DSP_STATUS DISP_Create(OUT struct DISP_OBJECT **phDispObject,
 		status = DSP_EFAIL;
 		goto func_cont;
 	}
-	if (DSP_SUCCEEDED(status)) {
-		pDisp->uCharSize = DSPWORDSIZE;
-		pDisp->uWordSize = DSPWORDSIZE;
-		pDisp->uDataMauSize = DSPWORDSIZE;
-		/* Open channels for communicating with the RMS */
-		chnlAttrs.uIOReqs = CHNLIOREQS;
-		chnlAttrs.hEvent = NULL;
-		ulChnlId = pDispAttrs->ulChnlOffset + CHNLTORMSOFFSET;
-		status = (*pIntfFxns->pfnChnlOpen)(&(pDisp->hChnlToDsp),
-			 pDisp->hChnlMgr, CHNL_MODETODSP, ulChnlId, &chnlAttrs);
-		if (DSP_FAILED(status)) {
-			GT_2trace(DISP_DebugMask, GT_6CLASS,
-				 "DISP_Create:  Channel to RMS "
-				 "open failed, chnl id = %d, status = 0x%x\n",
-				 ulChnlId, status);
-		}
-	}
+
+	pDisp->uCharSize = DSPWORDSIZE;
+	pDisp->uWordSize = DSPWORDSIZE;
+	pDisp->uDataMauSize = DSPWORDSIZE;
+	/* Open channels for communicating with the RMS */
+	chnlAttrs.uIOReqs = CHNLIOREQS;
+	chnlAttrs.hEvent = NULL;
+	ulChnlId = pDispAttrs->ulChnlOffset + CHNLTORMSOFFSET;
+	status = (*pIntfFxns->pfnChnlOpen)(&(pDisp->hChnlToDsp),
+		 pDisp->hChnlMgr, CHNL_MODETODSP, ulChnlId, &chnlAttrs);
+	if (DSP_FAILED(status))
+		GT_2trace(DISP_DebugMask, GT_6CLASS,
+			 "DISP_Create:  Channel to RMS "
+			 "open failed, chnl id = %d, status = 0x%x\n",
+			 ulChnlId, status);
+
 	if (DSP_SUCCEEDED(status)) {
 		ulChnlId = pDispAttrs->ulChnlOffset + CHNLFROMRMSOFFSET;
 		status = (*pIntfFxns->pfnChnlOpen)(&(pDisp->hChnlFromDsp),
@@ -819,7 +818,7 @@ static DSP_STATUS SendMessage(struct DISP_OBJECT *hDisp, u32 dwTimeout,
 		GT_1trace(DISP_DebugMask, GT_6CLASS,
 			 "SendMessage: Channel AddIOReq to"
 			 " RMS failed! Status = 0x%x\n", status);
-		goto func_cont;
+		goto func_end;
 	}
 	status = (*pIntfFxns->pfnChnlGetIOC) (hChnl, dwTimeout, &chnlIOC);
 	if (DSP_SUCCEEDED(status)) {
@@ -839,7 +838,6 @@ static DSP_STATUS SendMessage(struct DISP_OBJECT *hDisp, u32 dwTimeout,
 			 "SendMessage: Channel GetIOC to"
 			 " RMS failed! Status = 0x%x\n", status);
 	}
-func_cont:
 	/* Get the reply */
 	if (DSP_FAILED(status))
 		goto func_end;
diff --git a/drivers/dsp/bridge/rmgr/drv.c b/drivers/dsp/bridge/rmgr/drv.c
index 440bb91..0120989 100644
--- a/drivers/dsp/bridge/rmgr/drv.c
+++ b/drivers/dsp/bridge/rmgr/drv.c
@@ -91,6 +91,7 @@ DSP_STATUS DRV_ProcUpdatestate(HANDLE hPCtxt, enum GPP_PROC_RES_STATE status)
 	if (pCtxt != NULL) {
 		pCtxt->resState = status;
 	} else {
+		status1 = DSP_EHANDLE;
 		GT_0trace(curTrace, GT_ENTER,
 			 "DRV_ProcUpdatestate: Failed to update "
 			 "process state");
@@ -313,8 +314,14 @@ DSP_STATUS  DRV_ProcFreeDMMRes(HANDLE hPCtxt)
 		if (pDMMRes->dmmAllocated) {
 			status = PROC_UnMap(pDMMRes->hProcessor,
 				 (void *)pDMMRes->ulDSPResAddr, pCtxt);
+			if (DSP_FAILED(status))
+				pr_debug("%s: PROC_UnMap failed! status ="
+						" 0x%xn", __func__, status);
 			status = PROC_UnReserveMemory(pDMMRes->hProcessor,
 				 (void *)pDMMRes->ulDSPResAddr);
+			if (DSP_FAILED(status))
+				pr_debug("%s: PROC_UnReserveMemory failed!"
+					" status = 0x%xn", __func__, status);
 			pDMMRes->dmmAllocated = 0;
 		}
 	}
@@ -629,32 +636,31 @@ DSP_STATUS DRV_Create(OUT struct DRV_OBJECT **phDRVObject)
 				MEM_FreeObject(pDRVObject);
 			}
 		} else {
-			status = DSP_EFAIL;
+			status = DSP_EMEMORY;
 			GT_0trace(curTrace, GT_7CLASS,
 				 "Failed to Create Dev List ");
 			MEM_FreeObject(pDRVObject);
 		}
 	} else {
-		status = DSP_EFAIL;
+		status = DSP_EMEMORY;
 		GT_0trace(curTrace, GT_7CLASS,
 			 "Failed to Allocate Memory for DRV Obj");
 	}
+	/* Store the DRV Object in the Registry */
+	if (DSP_SUCCEEDED(status))
+		status = CFG_SetObject((u32) pDRVObject, REG_DRV_OBJECT);
 	if (DSP_SUCCEEDED(status)) {
-		/* Store the DRV Object in the Registry */
-		if (DSP_SUCCEEDED
-		    (CFG_SetObject((u32) pDRVObject, REG_DRV_OBJECT))) {
-			GT_1trace(curTrace, GT_1CLASS,
-				 "DRV Obj Created pDrvObject 0x%x\n ",
-				 pDRVObject);
-			*phDRVObject = pDRVObject;
-		} else {
-			/* Free the DRV Object */
-			status = DSP_EFAIL;
-			MEM_Free(pDRVObject);
-			GT_0trace(curTrace, GT_7CLASS,
-				 "Failed to update the Registry with "
+		GT_1trace(curTrace, GT_1CLASS,
+			 "DRV Obj Created pDrvObject 0x%x\n ",
+			 pDRVObject);
+		*phDRVObject = pDRVObject;
+	} else {
+		/* Free the DRV Object */
+		MEM_Free(pDRVObject);
+		GT_0trace(curTrace, GT_7CLASS,
+			 "Failed to update the Registry with "
 				 "DRV Object ");
-		}
+
 	}
 	GT_2trace(curTrace, GT_ENTER,
 		 "Exiting DRV_Create: phDRVObject: 0x%x\tstatus:"
@@ -748,7 +754,6 @@ DSP_STATUS DRV_GetDevObject(u32 uIndex, struct DRV_OBJECT *hDrvObject,
 	}
 	if (pDevObject) {
 		*phDevObject = (struct DEV_OBJECT *) pDevObject;
-		status = DSP_SOK;
 	} else {
 		*phDevObject = NULL;
 		status = DSP_EFAIL;
@@ -976,8 +981,9 @@ DSP_STATUS DRV_RequestResources(u32 dwContext, u32 *pDevNodeString)
 	 *  it is freed in the Release resources. Update the driver object
 	 *  list.
 	 */
-	if (DSP_SUCCEEDED(CFG_GetObject((u32 *)&pDRVObject,
-	   REG_DRV_OBJECT))) {
+
+	status = CFG_GetObject((u32 *)&pDRVObject, REG_DRV_OBJECT);
+	if (DSP_SUCCEEDED(status)) {
 		pszdevNode = MEM_Calloc(sizeof(struct DRV_EXT), MEM_NONPAGED);
 		if (pszdevNode) {
 			LST_InitElem(&pszdevNode->link);
@@ -991,11 +997,10 @@ DSP_STATUS DRV_RequestResources(u32 dwContext, u32 *pDevNodeString)
 		} else {
 			GT_0trace(curTrace, GT_7CLASS,
 				"Failed to Allocate Memory devNodeString ");
-			status = DSP_EFAIL;
+			status = DSP_EMEMORY;
 			*pDevNodeString = 0;
 		}
 	} else {
-		status = DSP_EFAIL;
 		GT_0trace(curTrace, GT_7CLASS,
 			 "Failed to get Driver Object from Registry");
 		*pDevNodeString = 0;
@@ -1043,10 +1048,9 @@ DSP_STATUS DRV_ReleaseResources(u32 dwContext, struct DRV_OBJECT *hDrvObject)
 		GT_0trace(curTrace, GT_1CLASS, " Unknown device\n");
 	}
 
-	if (DSP_SUCCEEDED(status)) {
+	if (DSP_FAILED(status))
 		GT_0trace(curTrace, GT_1CLASS,
 			 "Failed to relese bridge resources\n");
-	}
 
 	/*
 	 *  Irrespective of the status go ahead and clean it
@@ -1212,27 +1216,26 @@ static DSP_STATUS RequestBridgeResources(u32 dwContext, s32 bRequest)
 		/* for 24xx base port is not mapping the mamory for DSP
 		 * internal memory TODO Do a ioremap here */
 		/* Second window is for DSP external memory shared with MPU */
+
+		/* For Linux, these are hard-coded values */
+		pResources->bIRQRegisters = 0;
+		pResources->bIRQAttrib = 0;
+		pResources->dwOffsetForMonitor = 0;
+		pResources->dwChnlOffset = 0;
+		/* CHNL_MAXCHANNELS */
+		pResources->dwNumChnls = CHNL_MAXCHANNELS;
+		pResources->dwChnlBufSize = 0x400;
+		dwBuffSize = sizeof(struct CFG_HOSTRES);
+		status = REG_SetValue(CURRENTCONFIG, (u8 *)pResources,
+						sizeof(struct CFG_HOSTRES));
 		if (DSP_SUCCEEDED(status)) {
-			/* for Linux, these are hard-coded values */
-			pResources->bIRQRegisters = 0;
-			pResources->bIRQAttrib = 0;
-			pResources->dwOffsetForMonitor = 0;
-			pResources->dwChnlOffset = 0;
-			/* CHNL_MAXCHANNELS */
-			pResources->dwNumChnls = CHNL_MAXCHANNELS;
-			pResources->dwChnlBufSize = 0x400;
-			dwBuffSize = sizeof(struct CFG_HOSTRES);
-			status = REG_SetValue(CURRENTCONFIG, (u8 *)pResources,
-					     sizeof(struct CFG_HOSTRES));
-			if (DSP_SUCCEEDED(status)) {
-				GT_0trace(curTrace, GT_1CLASS,
-					 " Successfully set the registry "
-					 "value for CURRENTCONFIG\n");
-			} else {
-				GT_0trace(curTrace, GT_7CLASS,
-					 " Failed to set the registry "
-					 "value for CURRENTCONFIG\n");
-			}
+			GT_0trace(curTrace, GT_1CLASS,
+				 " Successfully set the registry "
+				 "value for CURRENTCONFIG\n");
+		} else {
+			GT_0trace(curTrace, GT_7CLASS,
+				 " Failed to set the registry "
+				 "value for CURRENTCONFIG\n");
 		}
 		MEM_Free(pResources);
 	}
diff --git a/drivers/dsp/bridge/rmgr/dspdrv.c b/drivers/dsp/bridge/rmgr/dspdrv.c
index 183aba6..9920059 100644
--- a/drivers/dsp/bridge/rmgr/dspdrv.c
+++ b/drivers/dsp/bridge/rmgr/dspdrv.c
@@ -56,7 +56,6 @@ u32 DSP_Init(OUT u32 *initStatus)
 	char devNode[MAXREGPATHLENGTH] = "TIOMAP1510";
 	DSP_STATUS status = DSP_EFAIL;
 	struct DRV_OBJECT *drvObject = NULL;
-	u32 index = 0;
 	u32 deviceNode;
 	u32 deviceNodeString;
 
@@ -64,11 +63,12 @@ u32 DSP_Init(OUT u32 *initStatus)
 
 	GT_0trace(curTrace, GT_ENTER, "Entering DSP_Init \r\n");
 
-	if (DSP_FAILED(WCD_Init())) {
+	if (!WCD_Init()) {
 		GT_0trace(curTrace, GT_7CLASS, "DSP_Init Failed \n");
 		goto func_cont;
 	}			/* End WCD_Exit */
-	if (DSP_FAILED(DRV_Create(&drvObject))) {
+	status = DRV_Create(&drvObject);
+	if (DSP_FAILED(status)) {
 		GT_0trace(curTrace, GT_7CLASS, "DSP_Init:DRV_Create Failed \n");
 		WCD_Exit();
 		goto func_cont;
@@ -76,29 +76,27 @@ u32 DSP_Init(OUT u32 *initStatus)
 	GT_0trace(curTrace, GT_5CLASS, "DSP_Init:DRV Created \r\n");
 
 	/* Request Resources */
-	if (DSP_SUCCEEDED(DRV_RequestResources((u32)&devNode,
-	   &deviceNodeString))) {
+	status = DRV_RequestResources((u32)&devNode, &deviceNodeString);
+	if (DSP_SUCCEEDED(status)) {
 		/* Attempt to Start the Device */
-		if (DSP_SUCCEEDED(DEV_StartDevice(
-		   (struct CFG_DEVNODE *)deviceNodeString))) {
+		status = DEV_StartDevice((struct CFG_DEVNODE *)
+							deviceNodeString);
+		if (DSP_SUCCEEDED(status)) {
 			/* Retreive the DevObject from the Registry */
-			GT_2trace(curTrace, GT_1CLASS,
-				 "DSP_Init Succeeded for Device1:"
-				 "%d: value: %x\n", index, deviceNodeString);
-			status = DSP_SOK;
+			GT_1trace(curTrace, GT_1CLASS,
+				 "DSP_Init Succeeded for Device1 value: %x\n",
+				 deviceNodeString);
 		} else {
 			GT_0trace(curTrace, GT_7CLASS,
 				 "DSP_Init:DEV_StartDevice Failed\n");
 			(void)DRV_ReleaseResources
 				((u32) deviceNodeString, drvObject);
-			status = DSP_EFAIL;
 		}
 	} else {
 		GT_0trace(curTrace, GT_7CLASS,
 			 "DSP_Init:DRV_RequestResources Failed \r\n");
 		status = DSP_EFAIL;
-	}	/* DRV_RequestResources */
-	index++;
+	}
 
 	/* Unwind whatever was loaded */
 	if (DSP_FAILED(status)) {
@@ -106,7 +104,6 @@ u32 DSP_Init(OUT u32 *initStatus)
 		 * unloading. Get the Driver Object iterate through and remove.
 		 * Reset the status to E_FAIL to avoid going through
 		 * WCD_InitComplete2. */
-		status = DSP_EFAIL;
 		for (deviceNode = DRV_GetFirstDevExtension(); deviceNode != 0;
 		    deviceNode = DRV_GetNextDevExtension(deviceNode)) {
 			(void)DEV_RemoveDevice
diff --git a/drivers/dsp/bridge/rmgr/mgr.c b/drivers/dsp/bridge/rmgr/mgr.c
index d96716a..4562157 100644
--- a/drivers/dsp/bridge/rmgr/mgr.c
+++ b/drivers/dsp/bridge/rmgr/mgr.c
@@ -74,16 +74,16 @@ DSP_STATUS MGR_Create(OUT struct MGR_OBJECT **phMgrObject,
 		 phMgrObject);
 	MEM_AllocObject(pMgrObject, struct MGR_OBJECT, SIGNATURE);
 	if (pMgrObject) {
-		if (DSP_SUCCEEDED(DCD_CreateManager(ZLDLLNAME,
-		   &pMgrObject->hDcdMgr))) {
+		status = DCD_CreateManager(ZLDLLNAME, &pMgrObject->hDcdMgr);
+		if (DSP_SUCCEEDED(status)) {
 			/* If succeeded store the handle in the MGR Object */
-			if (DSP_SUCCEEDED(CFG_SetObject((u32)pMgrObject,
-			   REG_MGR_OBJECT))) {
+			status = CFG_SetObject((u32)pMgrObject,
+							REG_MGR_OBJECT);
+			if (DSP_SUCCEEDED(status)) {
 				*phMgrObject = pMgrObject;
 				GT_0trace(MGR_DebugMask, GT_1CLASS,
 					 "MGR_Create:MGR Created\r\n");
 			} else {
-				status = DSP_EFAIL;
 				GT_0trace(MGR_DebugMask, GT_7CLASS,
 					 "MGR_Create:CFG_SetObject "
 					 "Failed\r\n");
@@ -92,7 +92,6 @@ DSP_STATUS MGR_Create(OUT struct MGR_OBJECT **phMgrObject,
 			}
 		} else {
 			/* failed to Create DCD Manager */
-			status = DSP_EFAIL;
 			GT_0trace(MGR_DebugMask, GT_7CLASS,
 				 "MGR_Create:DCD_ManagerCreate Failed\r\n");
 			MEM_FreeObject(pMgrObject);
@@ -151,7 +150,6 @@ DSP_STATUS MGR_EnumNodeInfo(u32 uNode, OUT struct DSP_NDBPROPS *pNDBProps,
 			   u32 uNDBPropsSize, OUT u32 *puNumNodes)
 {
 	DSP_STATUS status = DSP_SOK;
-	DSP_STATUS status1 = DSP_SOK;
 	struct DSP_UUID Uuid, uTempUuid;
 	u32 uTempIndex = 0;
 	u32 uNodeIndex = 0;
@@ -169,8 +167,8 @@ DSP_STATUS MGR_EnumNodeInfo(u32 uNode, OUT struct DSP_NDBPROPS *pNDBProps,
 		 uNDBPropsSize, puNumNodes);
 	*puNumNodes = 0;
 	/* Get The Manager Object from the Registry */
-	if (DSP_FAILED(CFG_GetObject((u32 *)&pMgrObject,
-	   REG_MGR_OBJECT))) {
+	status = CFG_GetObject((u32 *)&pMgrObject, REG_MGR_OBJECT);
+	if (DSP_FAILED(status)) {
 		GT_0trace(MGR_DebugMask, GT_7CLASS,
 			 "Manager_EnumNodeInfo:Failed To Get"
 			 " MGR Object from Registry\r\n");
@@ -196,26 +194,23 @@ DSP_STATUS MGR_EnumNodeInfo(u32 uNode, OUT struct DSP_NDBPROPS *pNDBProps,
 				 "Manager_EnumNodeInfo: uNode"
 				 " is Invalid \r\n");
 		} else {
-			status1 = DCD_GetObjectDef(pMgrObject->hDcdMgr,
+			status = DCD_GetObjectDef(pMgrObject->hDcdMgr,
 						(struct DSP_UUID *)&Uuid,
 						DSP_DCDNODETYPE, &GenObj);
-			if (DSP_SUCCEEDED(status1)) {
+			if (DSP_SUCCEEDED(status)) {
 				/* Get the Obj def */
 				*pNDBProps = GenObj.objData.nodeObj.ndbProps;
 				*puNumNodes = uNodeIndex;
-				status = DSP_SOK;
 			} else {
 				GT_0trace(MGR_DebugMask, GT_7CLASS,
 					 "Manager_EnumNodeInfo: "
 					 "Failed to Get Node Info \r\n");
-				status = DSP_EFAIL;
 			}
 		}
 	} else {
 		/* This could be changed during enum, EFAIL ... */
 		GT_0trace(MGR_DebugMask, GT_7CLASS, "Manager_EnumNodeInfo: "
 			 "Enumeration failure\r\n");
-		status = DSP_EFAIL;
 	}
 func_cont:
 	GT_4trace(MGR_DebugMask, GT_ENTER,
diff --git a/drivers/dsp/bridge/rmgr/nldr.c b/drivers/dsp/bridge/rmgr/nldr.c
index 5f0d4e1..19861bd 100644
--- a/drivers/dsp/bridge/rmgr/nldr.c
+++ b/drivers/dsp/bridge/rmgr/nldr.c
@@ -1018,7 +1018,7 @@ static DSP_STATUS AddOvlyInfo(void *handle, struct DBLL_SectInfo *sectInfo,
 
 	/* Determine which phase this section belongs to */
 	for (pch = pSectName + 1; *pch && *pch != seps; pch++)
-		;;
+		;
 
 	if (*pch) {
 		pch++;	/* Skip over the ':' */
@@ -1398,7 +1398,7 @@ static DSP_STATUS LoadLib(struct NLDR_NODEOBJECT *hNldrNode,
 	/*
 	 *  Recursively load dependent libraries.
 	 */
-	if (DSP_SUCCEEDED(status) && persistentDepLibs) {
+	if (DSP_SUCCEEDED(status)) {
 		for (i = 0; i < nLibs; i++) {
 			/* If root library is NOT persistent, and dep library
 			 * is, then record it.  If root library IS persistent,
@@ -1422,15 +1422,11 @@ static DSP_STATUS LoadLib(struct NLDR_NODEOBJECT *hNldrNode,
 				pDepLib = &root->pDepLibs[nLoaded];
 			}
 
-			if (depLibUUIDs) {
-				status = LoadLib(hNldrNode, pDepLib,
+			status = LoadLib(hNldrNode, pDepLib,
 						depLibUUIDs[i],
 						persistentDepLibs[i], libPath,
 						phase,
 						depth);
-			} else {
-				status = DSP_EMEMORY;
-			}
 
 			if (DSP_SUCCEEDED(status)) {
 				if ((status != DSP_SALREADYLOADED) &&
@@ -1555,10 +1551,6 @@ static DSP_STATUS LoadOvly(struct NLDR_NODEOBJECT *hNldrNode,
 		break;
 	}
 
-	DBC_Assert(pRefCount != NULL);
-	if (DSP_FAILED(status))
-		goto func_end;
-
 	if (pRefCount == NULL)
 		goto func_end;
 
@@ -1837,7 +1829,6 @@ static void UnloadOvly(struct NLDR_NODEOBJECT *hNldrNode, enum NLDR_PHASE phase)
 	u16 nOtherAlloc = 0;
 	u16 *pRefCount = NULL;
 	u16 *pOtherRef = NULL;
-	DSP_STATUS status = DSP_SOK;
 
 	/* Find the node in the table */
 	for (i = 0; i < hNldr->nOvlyNodes; i++) {
@@ -1878,17 +1869,16 @@ static void UnloadOvly(struct NLDR_NODEOBJECT *hNldrNode, enum NLDR_PHASE phase)
 		DBC_Assert(false);
 		break;
 	}
-	if (DSP_SUCCEEDED(status)) {
-		DBC_Assert(pRefCount && (*pRefCount > 0));
-		 if (pRefCount && (*pRefCount > 0)) {
-			*pRefCount -= 1;
-			if (pOtherRef) {
-				DBC_Assert(*pOtherRef > 0);
-				*pOtherRef -= 1;
-			}
+	DBC_Assert(pRefCount && (*pRefCount > 0));
+	if (pRefCount && (*pRefCount > 0)) {
+		*pRefCount -= 1;
+		if (pOtherRef) {
+			DBC_Assert(*pOtherRef > 0);
+			*pOtherRef -= 1;
 		}
 	}
-	if (pRefCount && (*pRefCount == 0)) {
+
+	if (pRefCount && *pRefCount == 0) {
 		/* 'Deallocate' memory */
 		FreeSects(hNldr, pPhaseSects, nAlloc);
 	}
diff --git a/drivers/dsp/bridge/rmgr/node.c b/drivers/dsp/bridge/rmgr/node.c
index e8ba0dd..7fd9977 100644
--- a/drivers/dsp/bridge/rmgr/node.c
+++ b/drivers/dsp/bridge/rmgr/node.c
@@ -357,6 +357,9 @@ DSP_STATUS NODE_Allocate(struct PROC_OBJECT *hProcessor,
 
 	status = PROC_GetProcessorId(hProcessor, &procId);
 
+	if (procId != DSP_UNIT)
+		goto func_end;
+
 	status = PROC_GetDevObject(hProcessor, &hDevObject);
 	if (DSP_SUCCEEDED(status)) {
 		status = DEV_GetNodeManager(hDevObject, &hNodeMgr);
@@ -364,11 +367,9 @@ DSP_STATUS NODE_Allocate(struct PROC_OBJECT *hProcessor,
 			status = DSP_EFAIL;
 
 	}
-	if (procId != DSP_UNIT)
-		goto func_cont;
 
 	if (DSP_FAILED(status))
-		goto func_cont;
+		goto func_end;
 
 	status = PROC_GetState(hProcessor, &procStatus,
 			sizeof(struct DSP_PROCESSORSTATE));
@@ -399,27 +400,27 @@ DSP_STATUS NODE_Allocate(struct PROC_OBJECT *hProcessor,
 				status = DSP_ERANGE;
 		}
 	}
-func_cont:
 	/* Allocate node object and fill in */
 	if (DSP_FAILED(status))
-		goto func_cont2;
+		goto func_end;
 
 	MEM_AllocObject(pNode, struct NODE_OBJECT, NODE_SIGNATURE);
 	if (pNode == NULL) {
 		status = DSP_EMEMORY;
-		goto func_cont1;
+		goto func_end;
 	}
 	pNode->hNodeMgr = hNodeMgr;
 	/* This critical section protects GetNodeProps */
 	status = SYNC_EnterCS(hNodeMgr->hSync);
-	if (procId != DSP_UNIT)
-		goto func_cont3;
+
+	if (DSP_FAILED(status))
+		goto func_end;
 
 	/* Get DSP_NDBPROPS from node database */
 	status = GetNodeProps(hNodeMgr->hDcdMgr, pNode, pNodeId,
 			     &(pNode->dcdProps));
 	if (DSP_FAILED(status))
-		goto func_cont3;
+		goto func_cont;
 
 	pNode->nodeId = *pNodeId;
 	pNode->hProcessor = hProcessor;
@@ -434,11 +435,11 @@ func_cont:
 	pNode->createArgs.asa.taskArgs.uDSPHeapResAddr = 0;
 	pNode->createArgs.asa.taskArgs.uGPPHeapAddr = 0;
 	if (!pAttrIn)
-		goto func_cont3;
+		goto func_cont;
 
 	/* Check if we have a user allocated node heap */
 	if (!(pAttrIn->pGPPVirtAddr))
-		goto func_cont3;
+		goto func_cont;
 
 	/* check for page aligned Heap size */
 	if (((pAttrIn->uHeapSize) & (PG_SIZE_4K - 1))) {
@@ -453,7 +454,7 @@ func_cont:
 						 (u32)pAttrIn->pGPPVirtAddr;
 	}
 	if (DSP_FAILED(status))
-		goto func_cont3;
+		goto func_cont;
 
 	status = PROC_ReserveMemory(hProcessor,
 			pNode->createArgs.asa.taskArgs.uHeapSize + PAGE_SIZE,
@@ -463,18 +464,16 @@ func_cont:
 		GT_1trace(NODE_debugMask, GT_5CLASS,
 			 "NODE_Allocate:Failed to reserve "
 			 "memory for Heap: 0x%x\n", status);
-	} else {
-		GT_1trace(NODE_debugMask, GT_5CLASS,
-			 "NODE_Allocate: DSPProcessor_Reserve"
-			 " Memory successful: 0x%x\n", status);
+
+		goto func_cont;
 	}
 #ifdef DSP_DMM_DEBUG
 	status = DMM_GetHandle(pProcObject, &hDmmMgr);
-	if (DSP_SUCCEEDED(status))
-		DMM_MemMapDump(hDmmMgr);
-#endif
 	if (DSP_FAILED(status))
-		goto func_cont3;
+		goto func_cont;
+
+	DMM_MemMapDump(hDmmMgr);
+#endif
 
 	mapAttrs |= DSP_MAPLITTLEENDIAN;
 	mapAttrs |= DSP_MAPELEMSIZE32;
@@ -495,15 +494,13 @@ func_cont:
 			 " successful: 0x%x\n", status);
 	}
 
-func_cont3:
+func_cont:
 	(void)SYNC_LeaveCS(hNodeMgr->hSync);
-func_cont1:
 	if (pAttrIn != NULL) {
 		/* Overrides of NBD properties */
 		pNode->uTimeout = pAttrIn->uTimeout;
 		pNode->nPriority = pAttrIn->iPriority;
 	}
-func_cont2:
 	/* Create object to manage notifications */
 	if (DSP_SUCCEEDED(status))
 		status = NTFY_Create(&pNode->hNtfy);
@@ -645,6 +642,7 @@ func_cont2:
 				GT_1trace(NODE_debugMask, GT_5CLASS,
 				"NODE_Allocate: Failed to get host resource "
 				"0x%x\n", status);
+				goto func_end;
 			}
 
 			ulGppMemBase = (u32)hostRes.dwMemBase[1];
@@ -848,7 +846,7 @@ DSP_STATUS NODE_ChangePriority(struct NODE_OBJECT *hNode, s32 nPriority)
 	/* Enter critical section */
 	status = SYNC_EnterCS(hNodeMgr->hSync);
 	if (DSP_FAILED(status))
-		goto func_cont;
+		goto func_end;
 
 	state = NODE_GetState(hNode);
 	if (state == NODE_ALLOCATED || state == NODE_PAUSED) {
@@ -858,19 +856,16 @@ DSP_STATUS NODE_ChangePriority(struct NODE_OBJECT *hNode, s32 nPriority)
 			status = DSP_EWRONGSTATE;
 			goto func_cont;
 		}
-		if (DSP_SUCCEEDED(status)) {
-			status = PROC_GetProcessorId(pNode->hProcessor,
-						    &procId);
-			if (procId == DSP_UNIT) {
-				status = DISP_NodeChangePriority(hNodeMgr->
-				    hDisp, hNode,
-				    hNodeMgr->ulFxnAddrs[RMSCHANGENODEPRIORITY],
-				    hNode->nodeEnv, nPriority);
-			}
-			if (DSP_SUCCEEDED(status))
-				NODE_SetPriority(hNode, nPriority);
-
+		status = PROC_GetProcessorId(pNode->hProcessor, &procId);
+		if (procId == DSP_UNIT) {
+			status = DISP_NodeChangePriority(hNodeMgr->
+			    hDisp, hNode,
+			    hNodeMgr->ulFxnAddrs[RMSCHANGENODEPRIORITY],
+			    hNode->nodeEnv, nPriority);
 		}
+		if (DSP_SUCCEEDED(status))
+			NODE_SetPriority(hNode, nPriority);
+
 	}
 func_cont:
 		/* Leave critical section */
@@ -909,13 +904,13 @@ DSP_STATUS NODE_Connect(struct NODE_OBJECT *hNode1, u32 uStream1,
 		 "NODE_Connect: hNode1: 0x%x\tuStream1:"
 		 " %d\thNode2: 0x%x\tuStream2: %d\tpAttrs: 0x%x\n", hNode1,
 		 uStream1, hNode2, uStream2, pAttrs);
-	if (DSP_SUCCEEDED(status)) {
-		if ((hNode1 != (struct NODE_OBJECT *) DSP_HGPPNODE &&
-		   !MEM_IsValidHandle(hNode1, NODE_SIGNATURE)) ||
-		   (hNode2 != (struct NODE_OBJECT *) DSP_HGPPNODE &&
-		   !MEM_IsValidHandle(hNode2, NODE_SIGNATURE)))
-			status = DSP_EHANDLE;
-	}
+
+	if ((hNode1 != (struct NODE_OBJECT *) DSP_HGPPNODE &&
+			!MEM_IsValidHandle(hNode1, NODE_SIGNATURE)) ||
+			(hNode2 != (struct NODE_OBJECT *) DSP_HGPPNODE &&
+			!MEM_IsValidHandle(hNode2, NODE_SIGNATURE)))
+		status = DSP_EHANDLE;
+
 	if (DSP_SUCCEEDED(status)) {
 		/* The two nodes must be on the same processor */
 		if (hNode1 != (struct NODE_OBJECT *)DSP_HGPPNODE &&
@@ -1236,7 +1231,7 @@ DSP_STATUS NODE_Create(struct NODE_OBJECT *hNode)
 	/* Get access to node dispatcher */
 	status = SYNC_EnterCS(hNodeMgr->hSync);
 	if (DSP_FAILED(status))
-		goto func_cont;
+		goto func_end;
 
 	/* Check node state */
 	if (NODE_GetState(hNode) != NODE_ALLOCATED)
@@ -1432,8 +1427,6 @@ DSP_STATUS NODE_CreateMgr(OUT struct NODE_MGR **phNodeMgr,
 		/* Get MSG queue manager */
 		DEV_GetMsgMgr(hDevObject, &pNodeMgr->hMsg);
 		status = SYNC_InitializeCS(&pNodeMgr->hSync);
-		if (DSP_FAILED(status))
-			status = DSP_EMEMORY;
 	}
 	if (DSP_SUCCEEDED(status)) {
 		pNodeMgr->chnlMap = GB_create(pNodeMgr->ulNumChnls);
@@ -1796,11 +1789,6 @@ DSP_STATUS NODE_FreeMsgBuf(struct NODE_OBJECT *hNode, IN u8 *pBuffer,
 
 			/* pBuffer is clients Va. */
 			status = CMM_XlatorFreeBuf(pNode->hXlator, pBuffer);
-			if (DSP_FAILED(status))
-				status = DSP_EFAIL;
-			else
-				status = DSP_SOK;
-
 		}
 	} else {
 		DBC_Assert(NULL);	/* BUG */
@@ -2092,8 +2080,6 @@ enum NODE_TYPE NODE_GetType(struct NODE_OBJECT *hNode)
  */
 bool NODE_Init(void)
 {
-	bool fRetVal = true;
-
 	DBC_Require(cRefs >= 0);
 
 	if (cRefs == 0) {
@@ -2101,14 +2087,12 @@ bool NODE_Init(void)
 		GT_create(&NODE_debugMask, "NO");	/* "NO" for NOde */
 	}
 
-	if (fRetVal)
-		cRefs++;
+	cRefs++;
 
 	GT_1trace(NODE_debugMask, GT_5CLASS, "NODE_Init(), ref count: 0x%x\n",
 		 cRefs);
 
-	DBC_Ensure((fRetVal && (cRefs > 0)) || (!fRetVal && (cRefs >= 0)));
-	return fRetVal;
+	return true;
 }
 
 /*
@@ -2158,7 +2142,6 @@ DSP_STATUS NODE_Pause(struct NODE_OBJECT *hNode)
 
 	if (!MEM_IsValidHandle(hNode, NODE_SIGNATURE)) {
 		status = DSP_EHANDLE;
-		goto func_end;
 	} else {
 		nodeType = NODE_GetType(hNode);
 		if (nodeType != NODE_TASK && nodeType != NODE_DAISSOCKET)
@@ -2184,11 +2167,13 @@ DSP_STATUS NODE_Pause(struct NODE_OBJECT *hNode)
 			if (state != NODE_RUNNING)
 				status = DSP_EWRONGSTATE;
 
+			if (DSP_FAILED(status))
+				goto func_cont;
 			hProcessor = hNode->hProcessor;
 			status = PROC_GetState(hProcessor, &procStatus,
 					sizeof(struct DSP_PROCESSORSTATE));
 			if (DSP_FAILED(status))
-				goto func_end;
+				goto func_cont;
 			/* If processor is in error state then don't attempt
 			    to send the message */
 			if (procStatus.iState == PROC_ERROR) {
@@ -2196,7 +2181,7 @@ DSP_STATUS NODE_Pause(struct NODE_OBJECT *hNode)
 					"NODE_Pause: proc Status 0x%x\n",
 					procStatus.iState);
 				status = DSP_EFAIL;
-				goto func_end;
+				goto func_cont;
 			}
 			if (DSP_SUCCEEDED(status)) {
 				status = DISP_NodeChangePriority(hNodeMgr->
@@ -2214,6 +2199,7 @@ DSP_STATUS NODE_Pause(struct NODE_OBJECT *hNode)
 					 " 0x%x\n", hNode);
 			}
 		}
+func_cont:
 		/* End of SYNC_EnterCS */
 		/* Leave critical section */
 		(void)SYNC_LeaveCS(hNodeMgr->hSync);
@@ -3374,11 +3360,18 @@ static u32 Ovly(void *pPrivRef, u32 ulDspRunAddr, u32 ulDspLoadAddr,
 	/* Call new MemCopy function */
 	pIntfFxns = hNodeMgr->pIntfFxns;
 	status = DEV_GetWMDContext(hNodeMgr->hDevObject, &hWmdContext);
-	status = (*pIntfFxns->pfnBrdMemCopy)(hWmdContext, ulDspRunAddr,
-		 ulDspLoadAddr,	ulNumBytes, (u32) nMemSpace);
-
-	if (DSP_SUCCEEDED(status))
-		ulBytes = ulNumBytes;
+	if (DSP_SUCCEEDED(status)) {
+		status = (*pIntfFxns->pfnBrdMemCopy)(hWmdContext, ulDspRunAddr,
+			 ulDspLoadAddr,	ulNumBytes, (u32) nMemSpace);
+		if (DSP_SUCCEEDED(status))
+			ulBytes = ulNumBytes;
+		else
+			pr_debug("%s: failed to copy brd memory, status 0x%x\n",
+							__func__, status);
+	} else {
+		pr_debug("%s: failed to get WMD context, status 0x%x\n",
+							__func__, status);
+	}
 
 	return ulBytes;
 }
diff --git a/drivers/dsp/bridge/rmgr/proc.c b/drivers/dsp/bridge/rmgr/proc.c
index 9eae2f9..fd8fdbc 100644
--- a/drivers/dsp/bridge/rmgr/proc.c
+++ b/drivers/dsp/bridge/rmgr/proc.c
@@ -182,7 +182,7 @@ PROC_Attach(u32 uProcessor, OPTIONAL CONST struct DSP_PROCESSORATTRIN *pAttrIn,
 	if (pProcObject == NULL) {
 		GT_0trace(PROC_DebugMask, GT_7CLASS,
 			 "PROC_Attach:Out of memeory \n");
-		status = DSP_EFAIL;
+		status = DSP_EMEMORY;
 		goto func_end;
 	}
 	pProcObject->hDevObject = hDevObject;
@@ -329,8 +329,8 @@ DSP_STATUS PROC_AutoStart(struct CFG_DEVNODE *hDevNode,
 		 "Entered PROC_AutoStart, args:\n\t"
 		 "hDevNode: 0x%x\thDevObject: 0x%x\n", hDevNode, hDevObject);
 	/* Create a Dummy PROC Object */
-	if (DSP_FAILED(CFG_GetObject((u32 *)&hMgrObject,
-	   REG_MGR_OBJECT))) {
+	status = CFG_GetObject((u32 *)&hMgrObject, REG_MGR_OBJECT);
+	if (DSP_FAILED(status)) {
 		GT_0trace(PROC_DebugMask, GT_7CLASS,
 			 "PROC_AutoStart: DSP_FAILED to "
 			 "Get MGR Object\n");
@@ -341,18 +341,18 @@ DSP_STATUS PROC_AutoStart(struct CFG_DEVNODE *hDevNode,
 		GT_0trace(PROC_DebugMask, GT_7CLASS,
 			 "PROC_AutoStart: DSP_FAILED "
 			 "to Create a dummy Processor\n");
+		status = DSP_EMEMORY;
 		goto func_end;
 	}
 	GT_0trace(PROC_DebugMask, GT_1CLASS, "NTFY Created \n");
 	pProcObject->hDevObject = hDevObject;
 	pProcObject->hMgrObject = hMgrObject;
 	hProcObject = pProcObject;
-	if (DSP_SUCCEEDED(DEV_GetIntfFxns(hDevObject,
-	   &pProcObject->pIntfFxns))) {
-		if (DSP_SUCCEEDED(DEV_GetWMDContext(hDevObject,
-				 &pProcObject->hWmdContext))) {
-			status = DSP_SOK;
-		} else {
+	status = DEV_GetIntfFxns(hDevObject, &pProcObject->pIntfFxns);
+	if (DSP_SUCCEEDED(status)) {
+		status = DEV_GetWMDContext(hDevObject,
+					&pProcObject->hWmdContext);
+		if (DSP_FAILED(status)) {
 			MEM_FreeObject(hProcObject);
 			GT_0trace(PROC_DebugMask, GT_7CLASS,
 				 "PROC_AutoStart: Failed "
@@ -365,12 +365,16 @@ DSP_STATUS PROC_AutoStart(struct CFG_DEVNODE *hDevNode,
 			 "get IntFxns \n");
 	}
 	if (DSP_FAILED(status))
-		goto func_end;
+		goto func_cont;
 
 	/* Stop the Device, put it into standby mode */
 	status = PROC_Stop(hProcObject);
-	if (DSP_FAILED(CFG_GetAutoStart(hDevNode, &dwAutoStart)) ||
-			   !dwAutoStart) {
+
+	if (DSP_FAILED(status))
+		goto func_cont;
+
+	status = CFG_GetAutoStart(hDevNode, &dwAutoStart);
+	if (DSP_FAILED(status) || !dwAutoStart) {
 		status = DSP_EFAIL;
 		/* DSP_FAILED to Get s32 Fxn or Wmd Context */
 		GT_0trace(PROC_DebugMask, GT_1CLASS, "PROC_AutoStart: "
@@ -380,8 +384,9 @@ DSP_STATUS PROC_AutoStart(struct CFG_DEVNODE *hDevNode,
 	/* Get the default executable for this board... */
 	DEV_GetDevType(hDevObject, (u32 *)&devType);
 	pProcObject->uProcessor = devType;
-	if (DSP_SUCCEEDED(GetExecFile(hDevNode, hDevObject,
-			 sizeof(szExecFile), szExecFile))) {
+	status = GetExecFile(hDevNode, hDevObject, sizeof(szExecFile),
+							szExecFile);
+	if (DSP_SUCCEEDED(status)) {
 		argv[0] = szExecFile;
 		argv[1] = NULL;
 		/* ...and try to load it: */
@@ -402,7 +407,6 @@ DSP_STATUS PROC_AutoStart(struct CFG_DEVNODE *hDevNode,
 				  "PROC_AutoStart: DSP_FAILED to Load\n");
 		}
 	} else {
-		status = DSP_EFILE;
 		GT_0trace(PROC_DebugMask, GT_7CLASS, "PROC_AutoStart: "
 			 "No Exec file found \n");
 	}
@@ -706,31 +710,33 @@ DSP_STATUS PROC_GetResourceInfo(DSP_HPROCESSOR hProcessor, u32 uResourceType,
 	case DSP_RESOURCE_DYNSARAM:
 	case DSP_RESOURCE_DYNEXTERNAL:
 	case DSP_RESOURCE_DYNSRAM:
-		if (DSP_FAILED(DEV_GetNodeManager(pProcObject->hDevObject,
-		   &hNodeMgr)))
+		status = DEV_GetNodeManager(pProcObject->hDevObject,
+								&hNodeMgr);
+		if (DSP_FAILED(status))
 			goto func_end;
 
-		if (DSP_SUCCEEDED(NODE_GetNldrObj(hNodeMgr, &hNldr))) {
-			if (DSP_SUCCEEDED(NLDR_GetRmmManager(hNldr, &rmm))) {
+		status = NODE_GetNldrObj(hNodeMgr, &hNldr);
+		if (DSP_SUCCEEDED(status)) {
+			status = NLDR_GetRmmManager(hNldr, &rmm);
+			if (DSP_SUCCEEDED(status)) {
 				DBC_Assert(rmm != NULL);
-				status = DSP_EVALUE;
-				if (RMM_stat(rmm,
+				if (!RMM_stat(rmm,
 				   (enum DSP_MEMTYPE)uResourceType,
 				   (struct DSP_MEMSTAT *)&(pResourceInfo->
 				   result.memStat)))
-					status = DSP_SOK;
+					status = DSP_EVALUE;
 			}
 		}
 		break;
 	case DSP_RESOURCE_PROCLOAD:
 		status = DEV_GetIOMgr(pProcObject->hDevObject, &hIOMgr);
-		status = pProcObject->pIntfFxns->pfnIOGetProcLoad(hIOMgr,
-			 (struct DSP_PROCLOADSTAT *)&(pResourceInfo->
-			 result.procLoadStat));
-		if (DSP_FAILED(status)) {
+		if (DSP_SUCCEEDED(status))
+			status = pProcObject->pIntfFxns->pfnIOGetProcLoad(
+				hIOMgr, (struct DSP_PROCLOADSTAT *)&
+				(pResourceInfo->result.procLoadStat));
+		if (DSP_FAILED(status))
 			GT_1trace(PROC_DebugMask, GT_7CLASS,
 			"Error in procLoadStat function 0x%x\n", status);
-		}
 		break;
 	default:
 		status = DSP_EFAIL;
@@ -814,8 +820,9 @@ DSP_STATUS PROC_GetState(DSP_HPROCESSOR hProcessor,
 		 " 0x%x\n", pProcStatus, hProcessor, uStateInfoSize);
 	if (MEM_IsValidHandle(pProcObject, PROC_SIGNATURE)) {
 		/* First, retrieve BRD state information */
-		if (DSP_SUCCEEDED((*pProcObject->pIntfFxns->pfnBrdStatus)
-		   (pProcObject->hWmdContext, &brdStatus))) {
+		status = (*pProcObject->pIntfFxns->pfnBrdStatus)
+				   (pProcObject->hWmdContext, &brdStatus);
+		if (DSP_SUCCEEDED(status)) {
 			switch (brdStatus) {
 			case BRD_STOPPED:
 				pProcStatus->iState = PROC_STOPPED;
@@ -837,7 +844,6 @@ DSP_STATUS PROC_GetState(DSP_HPROCESSOR hProcessor,
 				break;
 			}
 		} else {
-			status = DSP_EFAIL;
 			GT_0trace(PROC_DebugMask, GT_7CLASS,
 				 "PROC_GetState: General Failure"
 				 " to read the PROC Status \n");
@@ -853,7 +859,6 @@ DSP_STATUS PROC_GetState(DSP_HPROCESSOR hProcessor,
 					 "retrieve exception info.\n");
 			}
 		} else {
-			status = DSP_EFAIL;
 			GT_0trace(PROC_DebugMask, GT_7CLASS,
 				 "PROC_GetState: Failed to "
 				 "retrieve DEH handle.\n");
@@ -1100,30 +1105,19 @@ DSP_STATUS PROC_Load(DSP_HPROCESSOR hProcessor, IN CONST s32 iArgc,
 			DBC_Assert(DSP_SUCCEEDED(status));
 			DEV_SetMsgMgr(pProcObject->hDevObject, hMsgMgr);
 		}
-		if (status == DSP_ENOTIMPL) {
-			/* It's OK not to have a message manager */
-			status = DSP_SOK;
-		}
 	}
 	if (DSP_SUCCEEDED(status)) {
 		/* Set the Device object's message manager */
 		status = DEV_GetIOMgr(pProcObject->hDevObject, &hIOMgr);
 		DBC_Assert(DSP_SUCCEEDED(status));
 		status = (*pProcObject->pIntfFxns->pfnIOOnLoaded)(hIOMgr);
-		if (status == DSP_ENOTIMPL) {
-			/* Ok not to implement this function */
-			status = DSP_SOK;
-		} else {
-			if (DSP_FAILED(status)) {
-				GT_1trace(PROC_DebugMask, GT_7CLASS,
-					  "PROC_Load: Failed to get shared "
-					  "memory or message buffer address "
-					  "from COFF status 0x%x\n", status);
-				status = DSP_EFAIL;
-			}
-		}
+		if (DSP_FAILED(status))
+			GT_1trace(PROC_DebugMask, GT_7CLASS,
+				  "PROC_Load: Failed to get shared "
+				  "memory or message buffer address "
+				  "from COFF status 0x%x\n", status);
+
 	} else {
-		status = DSP_EFAIL;
 		GT_1trace(PROC_DebugMask, GT_7CLASS,
 			  "PROC_Load: DSP_FAILED in "
 			  "MSG_Create status 0x%x\n", status);
@@ -1166,15 +1160,13 @@ DSP_STATUS PROC_Load(DSP_HPROCESSOR hProcessor, IN CONST s32 iArgc,
 			 (pProcObject->hWmdContext, BRD_LOADED);
 		if (DSP_SUCCEEDED(status)) {
 			pProcObject->sState = PROC_LOADED;
-			if (pProcObject->hNtfy) {
+			if (pProcObject->hNtfy)
 				PROC_NotifyClients(pProcObject,
 						 DSP_PROCESSORSTATECHANGE);
-			}
 		} else {
 			GT_1trace(PROC_DebugMask, GT_7CLASS,
 				 "PROC_Load, pfnBrdSetState "
 				 "failed: 0x%x\n", status);
-			status = DSP_EFAIL;
 		}
 	}
 	if (DSP_SUCCEEDED(status)) {
@@ -1396,8 +1388,6 @@ DSP_STATUS PROC_RegisterNotify(DSP_HPROCESSOR hProcessor, u32 uEventMask,
 			status = (*pProcObject->pIntfFxns->pfnDehRegisterNotify)
 				 (hDehMgr, uEventMask, uNotifyType,
 				 hNotification);
-			if (DSP_FAILED(status))
-				status = DSP_EFAIL;
 
 		}
 	}
@@ -1472,7 +1462,6 @@ DSP_STATUS PROC_Start(DSP_HPROCESSOR hProcessor)
 	}
 	status = DEV_GetCodMgr(pProcObject->hDevObject, &hCodMgr);
 	if (DSP_FAILED(status)) {
-		status = DSP_EFAIL;
 		GT_1trace(PROC_DebugMask, GT_7CLASS,
 			 "Processor Start DSP_FAILED "
 			 "in Getting DEV_GetCodMgr status 0x%x\n", status);
@@ -1480,7 +1469,6 @@ DSP_STATUS PROC_Start(DSP_HPROCESSOR hProcessor)
 	}
 	status = COD_GetEntry(hCodMgr, &dwDspAddr);
 	if (DSP_FAILED(status)) {
-		status = DSP_EFAIL;
 		GT_1trace(PROC_DebugMask, GT_7CLASS,
 			 "Processor Start  DSP_FAILED in "
 			 "Getting COD_GetEntry status 0x%x\n", status);
@@ -1489,7 +1477,6 @@ DSP_STATUS PROC_Start(DSP_HPROCESSOR hProcessor)
 	status = (*pProcObject->pIntfFxns->pfnBrdStart)
 		 (pProcObject->hWmdContext, dwDspAddr);
 	if (DSP_FAILED(status)) {
-		status = DSP_EFAIL;
 		GT_0trace(PROC_DebugMask, GT_7CLASS,
 			 "PROC_Start Failed to Start the board\n");
 		goto func_cont;
@@ -1513,7 +1500,6 @@ DSP_STATUS PROC_Start(DSP_HPROCESSOR hProcessor)
 		 * Stop the Processor from running. Put it in STOPPED State */
 		(void)(*pProcObject->pIntfFxns->pfnBrdStop)(pProcObject->
 			hWmdContext);
-		status = DSP_EFAIL;
 		pProcObject->sState = PROC_STOPPED;
 		GT_0trace(PROC_DebugMask, GT_7CLASS, "PROC_Start "
 			 "Failed to Create the Node Manager\n");
diff --git a/drivers/dsp/bridge/rmgr/strm.c b/drivers/dsp/bridge/rmgr/strm.c
index 9200aed..b0b4d32 100644
--- a/drivers/dsp/bridge/rmgr/strm.c
+++ b/drivers/dsp/bridge/rmgr/strm.c
@@ -130,11 +130,13 @@ DSP_STATUS STRM_AllocateBuffer(struct STRM_OBJECT *hStrm, u32 uSize,
 		if (uSize == 0)
 			status = DSP_ESIZE;
 
-	}
-	if (DSP_FAILED(status)) {
+	} else {
 		status = DSP_EHANDLE;
-		goto func_end;
 	}
+
+	if (DSP_FAILED(status))
+		goto func_end;
+
 	for (i = 0; i < uNumBufs; i++) {
 		DBC_Assert(hStrm->hXlator != NULL);
 		(void)CMM_XlatorAllocBuf(hStrm->hXlator, &apBuffer[i], uSize);
@@ -191,20 +193,10 @@ DSP_STATUS STRM_Close(struct STRM_OBJECT *hStrm,
 		status = (*pIntfFxns->pfnChnlGetInfo) (hStrm->hChnl, &chnlInfo);
 		DBC_Assert(DSP_SUCCEEDED(status));
 
-		if (chnlInfo.cIOCs > 0 || chnlInfo.cIOReqs > 0) {
+		if (chnlInfo.cIOCs > 0 || chnlInfo.cIOReqs > 0)
 			status = DSP_EPENDING;
-		} else {
-
+		else
 			status = DeleteStrm(hStrm);
-
-			if (DSP_FAILED(status)) {
-				/* we already validated the handle. */
-				DBC_Assert(status != DSP_EHANDLE);
-
-				/* make sure we return a documented result */
-				status = DSP_EFAIL;
-			}
-		}
 	}
 #ifndef RES_CLEANUP_DISABLE
 	if (DSP_FAILED(status))
@@ -511,13 +503,8 @@ DSP_STATUS STRM_Issue(struct STRM_OBJECT *hStrm, IN u8 *pBuf, u32 ulBytes,
 				 (hStrm->hChnl, pBuf, ulBytes, ulBufSize,
 				 (u32) pTmpBuf, dwArg);
 		}
-		if (DSP_FAILED(status)) {
-			if (status == CHNL_E_NOIORPS)
-				status = DSP_ESTREAMFULL;
-			else
-				status = DSP_EFAIL;
-
-		}
+		if (status == CHNL_E_NOIORPS)
+			status = DSP_ESTREAMFULL;
 	}
 	return status;
 }
-- 
1.6.2.4

