From: "Gomez Castellanos, Ivan" <ivan.gomez@ti.com>
Subject: [PATCH] DSPBRIDGE: Check pointers before they are dereferenced
Date: Mon, 8 Feb 2010 15:41:44 -0600
Message-ID: <818EF96F5A7CC84789DD014773DB095484859F86@dlee01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:58760 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750812Ab0BHVpN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Feb 2010 16:45:13 -0500
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Ameya.Palande@nokia.com" <Ameya.Palande@nokia.com>, "Hiroshi.DOYU@nokia.com" <Hiroshi.DOYU@nokia.com>, "felipe.contreras@nokia.com" <felipe.contreras@nokia.com>, "Menon, Nishanth" <nm@ti.com>

>From 124638072d09d79333fb03d59bb66b8aae184860 Mon Sep 17 00:00:00 2001
From: Ivan Gomez <ivan.gomez@ti.com>
Date: Tue, 2 Feb 2010 19:37:17 -0600
Subject: [PATCH] DSPBRIDGE: Check pointers before they are dereferenced

Check if pointers are NULL before they are dereferenced.

Signed-off-by: Ivan Gomez <ivan.gomez@ti.com>
---
 drivers/dsp/bridge/pmgr/chnl.c  |   10 ++++++----
 drivers/dsp/bridge/pmgr/cmm.c   |    6 ++++--
 drivers/dsp/bridge/pmgr/io.c    |   10 ++++++----
 drivers/dsp/bridge/pmgr/msg.c   |    9 ++++++---
 drivers/dsp/bridge/rmgr/dbdcd.c |   23 +++++++++++++++++++++++
 drivers/dsp/bridge/rmgr/disp.c  |    2 +-
 drivers/dsp/bridge/rmgr/nldr.c  |   15 +++++----------
 drivers/dsp/bridge/rmgr/node.c  |   10 +++++-----
 drivers/dsp/bridge/rmgr/proc.c  |   10 +++++-----
 9 files changed, 61 insertions(+), 34 deletions(-)

diff --git a/drivers/dsp/bridge/pmgr/chnl.c b/drivers/dsp/bridge/pmgr/chnl.c
index fd487f0..e92d402 100644
--- a/drivers/dsp/bridge/pmgr/chnl.c
+++ b/drivers/dsp/bridge/pmgr/chnl.c
@@ -106,10 +106,12 @@ DSP_STATUS CHNL_Create(OUT struct CHNL_MGR **phChnlMgr,
 
 	if (DSP_SUCCEEDED(status)) {
 		struct WMD_DRV_INTERFACE *pIntfFxns;
-		DEV_GetIntfFxns(hDevObject, &pIntfFxns);
-		/* Let WMD channel module finish the create: */
-		status = (*pIntfFxns->pfnChnlCreate)(&hChnlMgr, hDevObject,
-			  pMgrAttrs);
+		status = DEV_GetIntfFxns(hDevObject, &pIntfFxns);
+		if (pIntfFxns) {
+			/* Let WMD channel module finish the create */
+			status = (*pIntfFxns->pfnChnlCreate)(&hChnlMgr,
+						hDevObject, pMgrAttrs);
+		}
 		if (DSP_SUCCEEDED(status)) {
 			/* Fill in WCD channel module's fields of the
 			 * CHNL_MGR structure */
diff --git a/drivers/dsp/bridge/pmgr/cmm.c b/drivers/dsp/bridge/pmgr/cmm.c
index 63d1dec..d3b7c01 100644
--- a/drivers/dsp/bridge/pmgr/cmm.c
+++ b/drivers/dsp/bridge/pmgr/cmm.c
@@ -212,8 +212,10 @@ void *CMM_CallocBuf(struct CMM_OBJECT *hCmmMgr, u32 uSize,
 				pNewNode = GetNode(pCmmMgr, pNode->dwPA + uSize,
 					   pNode->dwVA + uSize,
 					   (u32)uDeltaSize);
-				/* leftovers go free */
-				AddToFreeList(pAllocator, pNewNode);
+				if (pNewNode) {
+					/* leftovers go free */
+					AddToFreeList(pAllocator, pNewNode);
+				}
 				/* adjust our node's size */
 				pNode->ulSize = uSize;
 			}
diff --git a/drivers/dsp/bridge/pmgr/io.c b/drivers/dsp/bridge/pmgr/io.c
index 5dbb784..ce2912e 100644
--- a/drivers/dsp/bridge/pmgr/io.c
+++ b/drivers/dsp/bridge/pmgr/io.c
@@ -85,11 +85,13 @@ DSP_STATUS IO_Create(OUT struct IO_MGR **phIOMgr, struct DEV_OBJECT *hDevObject,
 	}
 
 	if (DSP_SUCCEEDED(status)) {
-		DEV_GetIntfFxns(hDevObject, &pIntfFxns);
+		status = DEV_GetIntfFxns(hDevObject, &pIntfFxns);
 
-		/* Let WMD channel module finish the create: */
-		status = (*pIntfFxns->pfnIOCreate)(&hIOMgr, hDevObject,
-			 pMgrAttrs);
+		if (pIntfFxns) {
+			/* Let WMD channel module finish the create */
+			status = (*pIntfFxns->pfnIOCreate)(&hIOMgr, hDevObject,
+					pMgrAttrs);
+		}
 
 		if (DSP_SUCCEEDED(status)) {
 			pIOMgr = (struct IO_MGR_ *) hIOMgr;
diff --git a/drivers/dsp/bridge/pmgr/msg.c b/drivers/dsp/bridge/pmgr/msg.c
index 355470a..a03d3eb 100644
--- a/drivers/dsp/bridge/pmgr/msg.c
+++ b/drivers/dsp/bridge/pmgr/msg.c
@@ -73,10 +73,13 @@ DSP_STATUS MSG_Create(OUT struct MSG_MGR **phMsgMgr,
 
 	*phMsgMgr = NULL;
 
-	DEV_GetIntfFxns(hDevObject, &pIntfFxns);
+	status = DEV_GetIntfFxns(hDevObject, &pIntfFxns);
 
-	/* Let WMD message module finish the create: */
-	status = (*pIntfFxns->pfnMsgCreate)(&hMsgMgr, hDevObject, msgCallback);
+	if (pIntfFxns) {
+		/* Let WMD message module finish the create */
+		status = (*pIntfFxns->pfnMsgCreate)(&hMsgMgr,
+				hDevObject, msgCallback);
+	}
 
 	if (DSP_SUCCEEDED(status)) {
 		/* Fill in WCD message module's fields of the MSG_MGR
diff --git a/drivers/dsp/bridge/rmgr/dbdcd.c b/drivers/dsp/bridge/rmgr/dbdcd.c
index 261ef4f..214131c 100644
--- a/drivers/dsp/bridge/rmgr/dbdcd.c
+++ b/drivers/dsp/bridge/rmgr/dbdcd.c
@@ -1194,6 +1194,10 @@ static DSP_STATUS GetAttrsFromBuf(char *pszBuf, u32 ulBufSize,
 		cLen = strlen(token);
 		pGenObj->objData.nodeObj.pstrCreatePhaseFxn =
 			MEM_Calloc(cLen + 1, MEM_PAGED);
+		if (!pGenObj->objData.nodeObj.pstrCreatePhaseFxn) {
+			status = DSP_EMEMORY;
+			break;
+		}
 		strncpy(pGenObj->objData.nodeObj.pstrCreatePhaseFxn,
 			token, cLen);
 		pGenObj->objData.nodeObj.pstrCreatePhaseFxn[cLen] = '\0';
@@ -1204,6 +1208,10 @@ static DSP_STATUS GetAttrsFromBuf(char *pszBuf, u32 ulBufSize,
 		cLen = strlen(token);
 		pGenObj->objData.nodeObj.pstrExecutePhaseFxn =
 			 MEM_Calloc(cLen + 1, MEM_PAGED);
+		if (!pGenObj->objData.nodeObj.pstrExecutePhaseFxn) {
+			status = DSP_EMEMORY;
+			break;
+		}
 		strncpy(pGenObj->objData.nodeObj.pstrExecutePhaseFxn,
 			token, cLen);
 		pGenObj->objData.nodeObj.pstrExecutePhaseFxn[cLen] = '\0';
@@ -1214,6 +1222,10 @@ static DSP_STATUS GetAttrsFromBuf(char *pszBuf, u32 ulBufSize,
 		cLen = strlen(token);
 		pGenObj->objData.nodeObj.pstrDeletePhaseFxn =
 			MEM_Calloc(cLen + 1, MEM_PAGED);
+		if (!pGenObj->objData.nodeObj.pstrDeletePhaseFxn) {
+			status = DSP_EMEMORY;
+			break;
+		}
 		strncpy(pGenObj->objData.nodeObj.pstrDeletePhaseFxn,
 			token, cLen);
 		pGenObj->objData.nodeObj.pstrDeletePhaseFxn[cLen] = '\0';
@@ -1232,6 +1244,10 @@ static DSP_STATUS GetAttrsFromBuf(char *pszBuf, u32 ulBufSize,
 			cLen = strlen(token);
 			pGenObj->objData.nodeObj.pstrIAlgName =
 				MEM_Calloc(cLen + 1, MEM_PAGED);
+			if (!pGenObj->objData.nodeObj.pstrIAlgName) {
+				status = DSP_EMEMORY;
+				break;
+			}
 			strncpy(pGenObj->objData.nodeObj.pstrIAlgName,
 				token, cLen);
 			pGenObj->objData.nodeObj.pstrIAlgName[cLen] = '\0';
@@ -1338,6 +1354,13 @@ static DSP_STATUS GetAttrsFromBuf(char *pszBuf, u32 ulBufSize,
 		break;
 	}
 
+	/* Check for Memory leak */
+	if (status == DSP_EMEMORY) {
+		MEM_Free(pGenObj->objData.nodeObj.pstrCreatePhaseFxn);
+		MEM_Free(pGenObj->objData.nodeObj.pstrExecutePhaseFxn);
+		MEM_Free(pGenObj->objData.nodeObj.pstrDeletePhaseFxn);
+	}
+
 	return status;
 }
 
diff --git a/drivers/dsp/bridge/rmgr/disp.c b/drivers/dsp/bridge/rmgr/disp.c
index 949c5e3..c02cb0d 100644
--- a/drivers/dsp/bridge/rmgr/disp.c
+++ b/drivers/dsp/bridge/rmgr/disp.c
@@ -133,7 +133,7 @@ DSP_STATUS DISP_Create(OUT struct DISP_OBJECT **phDispObject,
 	if (DSP_SUCCEEDED(status)) {
 		status = DEV_GetChnlMgr(hDevObject, &(pDisp->hChnlMgr));
 		if (DSP_SUCCEEDED(status)) {
-			(void) DEV_GetIntfFxns(hDevObject, &pIntfFxns);
+			status = DEV_GetIntfFxns(hDevObject, &pIntfFxns);
 			pDisp->pIntfFxns = pIntfFxns;
 		} else {
 			GT_1trace(DISP_DebugMask, GT_6CLASS,
diff --git a/drivers/dsp/bridge/rmgr/nldr.c b/drivers/dsp/bridge/rmgr/nldr.c
index 4d38419..1e9eb07 100644
--- a/drivers/dsp/bridge/rmgr/nldr.c
+++ b/drivers/dsp/bridge/rmgr/nldr.c
@@ -478,17 +478,12 @@ DSP_STATUS NLDR_Create(OUT struct NLDR_OBJECT **phNldr,
 	MEM_AllocObject(pNldr, struct NLDR_OBJECT, NLDR_SIGNATURE);
 	if (pNldr) {
 		pNldr->hDevObject = hDevObject;
-		/* warning, lazy status checking alert! */
 		status = DEV_GetCodMgr(hDevObject, &hCodMgr);
-		DBC_Assert(DSP_SUCCEEDED(status));
-		status = COD_GetLoader(hCodMgr, &pNldr->dbll);
-		DBC_Assert(DSP_SUCCEEDED(status));
-		status = COD_GetBaseLib(hCodMgr, &pNldr->baseLib);
-		DBC_Assert(DSP_SUCCEEDED(status));
-		status = COD_GetBaseName(hCodMgr, szZLFile, COD_MAXPATHLENGTH);
-		DBC_Assert(DSP_SUCCEEDED(status));
-		status = DSP_SOK;
-		/* end lazy status checking */
+		if (hCodMgr) {
+			COD_GetLoader(hCodMgr, &pNldr->dbll);
+			COD_GetBaseLib(hCodMgr, &pNldr->baseLib);
+			COD_GetBaseName(hCodMgr, szZLFile, COD_MAXPATHLENGTH);
+		}
 		pNldr->usDSPMauSize = pAttrs->usDSPMauSize;
 		pNldr->usDSPWordSize = pAttrs->usDSPWordSize;
 		pNldr->dbllFxns = dbllFxns;
diff --git a/drivers/dsp/bridge/rmgr/node.c b/drivers/dsp/bridge/rmgr/node.c
index 28513b8..00945a7 100644
--- a/drivers/dsp/bridge/rmgr/node.c
+++ b/drivers/dsp/bridge/rmgr/node.c
@@ -3238,12 +3238,12 @@ DSP_STATUS NODE_GetUUIDProps(DSP_HPROCESSOR hProcessor,
 		 pNodeId, pNodeProps);
 
 	status = PROC_GetDevObject(hProcessor, &hDevObject);
-	if (hDevObject != NULL) {
+	if (hDevObject != NULL)
 		status = DEV_GetNodeManager(hDevObject, &hNodeMgr);
-		if (hNodeMgr == NULL) {
-			status = DSP_EHANDLE;
-			goto func_end;
-		}
+
+	if (hNodeMgr == NULL) {
+		status = DSP_EHANDLE;
+		goto func_end;
 	}
 
 	/*
diff --git a/drivers/dsp/bridge/rmgr/proc.c b/drivers/dsp/bridge/rmgr/proc.c
index 0c105ee..b45560b 100644
--- a/drivers/dsp/bridge/rmgr/proc.c
+++ b/drivers/dsp/bridge/rmgr/proc.c
@@ -504,12 +504,12 @@ DSP_STATUS PROC_Detach(struct PROCESS_CONTEXT *pr_ctxt)
 		pProcObject = (struct PROC_OBJECT *)pr_ctxt->hProcessor;
 
 	if (MEM_IsValidHandle(pProcObject, PROC_SIGNATURE)) {
-		/* Notify the Client */
-		NTFY_Notify(pProcObject->hNtfy, DSP_PROCESSORDETACH);
-		/* Remove the notification memory */
-		if (pProcObject->hNtfy)
+		if (pProcObject->hNtfy) {
+			/* Notify the Client */
+			NTFY_Notify(pProcObject->hNtfy, DSP_PROCESSORDETACH);
+			/* Remove the notification memory */
 			NTFY_Delete(pProcObject->hNtfy);
-
+		}
 		if (pProcObject->g_pszLastCoff) {
 			MEM_Free(pProcObject->g_pszLastCoff);
 			pProcObject->g_pszLastCoff = NULL;
-- 
1.5.4.3