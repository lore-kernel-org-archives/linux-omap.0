From: "Ramirez Luna, Omar" <x00omar@ti.com>
Subject: [OMAPZOOM][PATCH 4/6] DSPBRIDGE: Removed CSL wrapper functions
Date: Thu, 29 Jan 2009 18:22:46 -0600
Message-ID: <27F9C60D11D683428E133F85D2BB4A5303F7EA52C8@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:56530 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751601AbZA3AWx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 29 Jan 2009 19:22:53 -0500
Received: from dlep95.itg.ti.com ([157.170.170.107])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id n0U0MlLx024425
	for <linux-omap@vger.kernel.org>; Thu, 29 Jan 2009 18:22:52 -0600
Received: from dlee73.ent.ti.com (localhost [127.0.0.1])
	by dlep95.itg.ti.com (8.13.8/8.13.8) with ESMTP id n0U0MlkL019946
	for <linux-omap@vger.kernel.org>; Thu, 29 Jan 2009 18:22:47 -0600 (CST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pandita, Vikram" <vikram.pandita@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

From: Fernando Guzman Lugo <x0095840@ti.com>
Date: Wed, 28 Jan 2009 19:43:31 -0600
Subject: [PATCH] DSPBRIDGE: Removed CSL wrapper functions

Removed CSL wrapper functions.

Signed-off-by: Fernando Guzman Lugo <x0095840@ti.com>
---
 drivers/dsp/bridge/pmgr/dbll.c  |    6 +-
 drivers/dsp/bridge/rmgr/dbdcd.c |  113 +++++++++++++++++++--------------------
 drivers/dsp/bridge/rmgr/node.c  |   18 ++-----
 3 files changed, 63 insertions(+), 74 deletions(-)

diff --git a/drivers/dsp/bridge/pmgr/dbll.c b/drivers/dsp/bridge/pmgr/dbll.c
index 36bae65..c7db74a 100644
--- a/drivers/dsp/bridge/pmgr/dbll.c
+++ b/drivers/dsp/bridge/pmgr/dbll.c
@@ -1336,11 +1336,11 @@ static int rmmAlloc(struct Dynamic_Loader_Allocate *this,
 		goto func_cont;
 	}
 	strncpy(szSectName, (char *)(info->name), tokenLen);
-	pToken = CSL_Strtokr(szSectName, ":", &pszCur);
-	while (pToken) {
+	pszCur = szSectName;
+	while ((pToken = strsep(&pszCur, ":")) && *pToken != '\0') {
 		strncpy(szSecLastToken, szLastToken, strlen(szLastToken) + 1);
 		strncpy(szLastToken, pToken, strlen(pToken) + 1);
-		pToken = CSL_Strtokr(NULL, ":", &pszCur);
+		pToken = strsep(&pszCur, ":");
 		count++; 	/* optimizes processing*/
 	}
 	/* If pToken is 0 or 1, and szSecLastToken is DYN_DARAM or DYN_SARAM,
diff --git a/drivers/dsp/bridge/rmgr/dbdcd.c b/drivers/dsp/bridge/rmgr/dbdcd.c
index 6fbe03f..9bcf707 100644
--- a/drivers/dsp/bridge/rmgr/dbdcd.c
+++ b/drivers/dsp/bridge/rmgr/dbdcd.c
@@ -692,12 +692,12 @@ DSP_STATUS DCD_GetObjects(IN struct DCD_MANAGER *hDcdMgr, IN char *pszCoffPath,
 				 "with 1 word for IVA !!\n");
 		}
 		/* Read from buffer and register object in buffer. */
-		pToken = CSL_Strtokr(pszCoffBuf, seps, &pszCur);
-		while (pToken != NULL) {
+		pszCur = pszCoffBuf;
+		while ((pToken = strsep(&pszCur, seps)) && *pToken != '\0') {
 			/*  Retrieve UUID string. */
 			UUID_UuidFromString(pToken, &dspUuid);
 			/*  Retrieve object type */
-			pToken = CSL_Strtokr(NULL, seps, &pszCur);
+			pToken = strsep(&pszCur, seps);
 			/*  Retrieve object type */
 			cObjectType = Atoi(pToken);
 			/*
@@ -722,8 +722,6 @@ DSP_STATUS DCD_GetObjects(IN struct DCD_MANAGER *hDcdMgr, IN char *pszCoffPath,
 				/* if error occurs, break from while loop. */
 				break;
 			}
-			/* Get next token */
-			pToken = CSL_Strtokr(NULL, seps, &pszCur);
 		}
 	} else {
 		status = DSP_EDCDREADSECT;
@@ -1137,23 +1135,25 @@ static DSP_STATUS GetAttrsFromBuf(char *pszBuf, u32 ulBufSize,
 		    || (objType == DSP_DCDPROCESSORTYPE));
 	DBC_Require(pGenObj != NULL);
 
+
 	switch (objType) {
 	case DSP_DCDNODETYPE:
 		/*
 		 * Parse COFF sect buffer to retrieve individual tokens used
 		 * to fill in object attrs.
 		 */
-		token = CSL_Strtokr(pszBuf, seps, &pszCur);
+		pszCur = pszBuf;
+		token = strsep(&pszCur, seps);
 
 		/* u32 cbStruct */
 		pGenObj->objData.nodeObj.ndbProps.cbStruct =
 				(u32) Atoi(token);
-		token = CSL_Strtokr(NULL, seps, &pszCur);
+		token = strsep(&pszCur, seps);
 
 		/* DSP_UUID uiNodeID */
 		UUID_UuidFromString(token,
 				  &pGenObj->objData.nodeObj.ndbProps.uiNodeID);
-		token = CSL_Strtokr(NULL, seps, &pszCur);
+		token = strsep(&pszCur, seps);
 
 		/* acName */
 		DBC_Require(token);
@@ -1164,80 +1164,80 @@ static DSP_STATUS GetAttrsFromBuf(char *pszBuf, u32 ulBufSize,
 		strncpy(pGenObj->objData.nodeObj.ndbProps.acName,
 			   token, cLen);
 		pGenObj->objData.nodeObj.ndbProps.acName[cLen] = '\0';
-		token = CSL_Strtokr(NULL, seps, &pszCur);
+		token = strsep(&pszCur, seps);
 		/* u32 uNodeType */
 		pGenObj->objData.nodeObj.ndbProps.uNodeType = Atoi(token);
-		token = CSL_Strtokr(NULL, seps, &pszCur);
+		token = strsep(&pszCur, seps);
 		/* u32 bCacheOnGPP */
 		pGenObj->objData.nodeObj.ndbProps.bCacheOnGPP = Atoi(token);
-		token = CSL_Strtokr(NULL, seps, &pszCur);
+		token = strsep(&pszCur, seps);
 		/* DSP_RESOURCEREQMTS dspResourceReqmts */
 		pGenObj->objData.nodeObj.ndbProps.dspResourceReqmts.cbStruct =
 				(u32) Atoi(token);
-		token = CSL_Strtokr(NULL, seps, &pszCur);
+		token = strsep(&pszCur, seps);
 
 		pGenObj->objData.nodeObj.ndbProps.dspResourceReqmts.
 			uStaticDataSize = Atoi(token);
-		token = CSL_Strtokr(NULL, seps, &pszCur);
+		token = strsep(&pszCur, seps);
 		pGenObj->objData.nodeObj.ndbProps.dspResourceReqmts.
 			uGlobalDataSize = Atoi(token);
-		token = CSL_Strtokr(NULL, seps, &pszCur);
+		token = strsep(&pszCur, seps);
 		pGenObj->objData.nodeObj.ndbProps.dspResourceReqmts.
 			uProgramMemSize = Atoi(token);
-		token = CSL_Strtokr(NULL, seps, &pszCur);
+		token = strsep(&pszCur, seps);
 		pGenObj->objData.nodeObj.ndbProps.dspResourceReqmts.
 			uWCExecutionTime = Atoi(token);
-		token = CSL_Strtokr(NULL, seps, &pszCur);
+		token = strsep(&pszCur, seps);
 		pGenObj->objData.nodeObj.ndbProps.dspResourceReqmts.
 			uWCPeriod = Atoi(token);
-		token = CSL_Strtokr(NULL, seps, &pszCur);
+		token = strsep(&pszCur, seps);
 
 		pGenObj->objData.nodeObj.ndbProps.dspResourceReqmts.
 			uWCDeadline = Atoi(token);
-		token = CSL_Strtokr(NULL, seps, &pszCur);
+		token = strsep(&pszCur, seps);
 
 		pGenObj->objData.nodeObj.ndbProps.dspResourceReqmts.
 			uAvgExectionTime = Atoi(token);
-		token = CSL_Strtokr(NULL, seps, &pszCur);
+		token = strsep(&pszCur, seps);
 
 		pGenObj->objData.nodeObj.ndbProps.dspResourceReqmts.
 			uMinimumPeriod = Atoi(token);
-		token = CSL_Strtokr(NULL, seps, &pszCur);
+		token = strsep(&pszCur, seps);
 
 		/* s32 iPriority */
 		pGenObj->objData.nodeObj.ndbProps.iPriority = Atoi(token);
-		token = CSL_Strtokr(NULL, seps, &pszCur);
+		token = strsep(&pszCur, seps);
 
 		/* u32 uStackSize */
 		pGenObj->objData.nodeObj.ndbProps.uStackSize = Atoi(token);
-		token = CSL_Strtokr(NULL, seps, &pszCur);
+		token = strsep(&pszCur, seps);
 
 		/* u32 uSysStackSize */
 		pGenObj->objData.nodeObj.ndbProps.uSysStackSize = Atoi(token);
-		token = CSL_Strtokr(NULL, seps, &pszCur);
+		token = strsep(&pszCur, seps);
 
 		/* u32 uStackSeg */
 		pGenObj->objData.nodeObj.ndbProps.uStackSeg = Atoi(token);
-		token = CSL_Strtokr(NULL, seps, &pszCur);
+		token = strsep(&pszCur, seps);
 
 		/* u32 uMessageDepth */
 		pGenObj->objData.nodeObj.ndbProps.uMessageDepth = Atoi(token);
-		token = CSL_Strtokr(NULL, seps, &pszCur);
+		token = strsep(&pszCur, seps);
 
 		/* u32 uNumInputStreams */
 		pGenObj->objData.nodeObj.ndbProps.uNumInputStreams =
 			Atoi(token);
-		token = CSL_Strtokr(NULL, seps, &pszCur);
+		token = strsep(&pszCur, seps);
 
 		/* u32 uNumOutputStreams */
 		pGenObj->objData.nodeObj.ndbProps.uNumOutputStreams =
 			Atoi(token);
-		token = CSL_Strtokr(NULL, seps, &pszCur);
+		token = strsep(&pszCur, seps);
 
 		/* u32 uTimeout */
 		pGenObj->objData.nodeObj.ndbProps.uTimeout =
 			Atoi(token);
-		token = CSL_Strtokr(NULL, seps, &pszCur);
+		token = strsep(&pszCur, seps);
 
 		/* char * pstrCreatePhaseFxn */
 		DBC_Require(token);
@@ -1247,7 +1247,7 @@ static DSP_STATUS GetAttrsFromBuf(char *pszBuf, u32 ulBufSize,
 		strncpy(pGenObj->objData.nodeObj.pstrCreatePhaseFxn,
 			token, cLen);
 		pGenObj->objData.nodeObj.pstrCreatePhaseFxn[cLen] = '\0';
-		token = CSL_Strtokr(NULL, seps, &pszCur);
+		token = strsep(&pszCur, seps);
 
 		/* char * pstrExecutePhaseFxn */
 		DBC_Require(token);
@@ -1257,7 +1257,7 @@ static DSP_STATUS GetAttrsFromBuf(char *pszBuf, u32 ulBufSize,
 		strncpy(pGenObj->objData.nodeObj.pstrExecutePhaseFxn,
 			token, cLen);
 		pGenObj->objData.nodeObj.pstrExecutePhaseFxn[cLen] = '\0';
-		token = CSL_Strtokr(NULL, seps, &pszCur);
+		token = strsep(&pszCur, seps);
 
 		/* char * pstrDeletePhaseFxn */
 		DBC_Require(token);
@@ -1267,15 +1267,15 @@ static DSP_STATUS GetAttrsFromBuf(char *pszBuf, u32 ulBufSize,
 		strncpy(pGenObj->objData.nodeObj.pstrDeletePhaseFxn,
 			token, cLen);
 		pGenObj->objData.nodeObj.pstrDeletePhaseFxn[cLen] = '\0';
-		token = CSL_Strtokr(NULL, seps, &pszCur);
+		token = strsep(&pszCur, seps);
 
 		/* Segment id for message buffers */
 		pGenObj->objData.nodeObj.uMsgSegid = Atoi(token);
-		token = CSL_Strtokr(NULL, seps, &pszCur);
+		token = strsep(&pszCur, seps);
 
 		/* Message notification type */
 		pGenObj->objData.nodeObj.uMsgNotifyType = Atoi(token);
-		token = CSL_Strtokr(NULL, seps, &pszCur);
+		token = strsep(&pszCur, seps);
 
 		/* char * pstrIAlgName */
 		if (token) {
@@ -1285,25 +1285,25 @@ static DSP_STATUS GetAttrsFromBuf(char *pszBuf, u32 ulBufSize,
 			strncpy(pGenObj->objData.nodeObj.pstrIAlgName,
 				token, cLen);
 			pGenObj->objData.nodeObj.pstrIAlgName[cLen] = '\0';
-			token = CSL_Strtokr(NULL, seps, &pszCur);
+			token = strsep(&pszCur, seps);
 		}
 
 		/* Load type (static, dynamic, or overlay) */
 		if (token) {
 			pGenObj->objData.nodeObj.usLoadType = Atoi(token);
-			token = CSL_Strtokr(NULL, seps, &pszCur);
+			token = strsep(&pszCur, seps);
 		}
 
 		/* Dynamic load data requirements */
 		if (token) {
 			pGenObj->objData.nodeObj.ulDataMemSegMask = Atoi(token);
-			token = CSL_Strtokr(NULL, seps, &pszCur);
+			token = strsep(&pszCur, seps);
 		}
 
 		/* Dynamic load code requirements */
 		if (token) {
 			pGenObj->objData.nodeObj.ulCodeMemSegMask = Atoi(token);
-			token = CSL_Strtokr(NULL, seps, &pszCur);
+			token = strsep(&pszCur, seps);
 		}
 
 		/* Extract node profiles into node properties */
@@ -1313,7 +1313,7 @@ static DSP_STATUS GetAttrsFromBuf(char *pszBuf, u32 ulBufSize,
 				Atoi(token);
 			for (i = 0; i < pGenObj->objData.nodeObj.ndbProps.
 			    uCountProfiles; i++) {
-				token = CSL_Strtokr(NULL, seps, &pszCur);
+				token = strsep(&pszCur, seps);
 				if (token) {
 					/* Heap Size for the node */
 					pGenObj->objData.nodeObj.ndbProps.
@@ -1322,7 +1322,7 @@ static DSP_STATUS GetAttrsFromBuf(char *pszBuf, u32 ulBufSize,
 				}
 			}
 		}
-		token = CSL_Strtokr(NULL, seps, &pszCur);
+		token = strsep(&pszCur, seps);
 		if (token) {
 			pGenObj->objData.nodeObj.ndbProps.uStackSegName =
 				(u32)(token);
@@ -1335,34 +1335,35 @@ static DSP_STATUS GetAttrsFromBuf(char *pszBuf, u32 ulBufSize,
 		 * Parse COFF sect buffer to retrieve individual tokens used
 		 * to fill in object attrs.
 		 */
-		token = CSL_Strtokr(pszBuf, seps, &pszCur);
+		pszCur = pszBuf;
+		token = strsep(&pszCur, seps);
 
 		pGenObj->objData.procObj.cbStruct = Atoi(token);
-		token = CSL_Strtokr(NULL, seps, &pszCur);
+		token = strsep(&pszCur, seps);
 
 		pGenObj->objData.procObj.uProcessorFamily = Atoi(token);
-		token = CSL_Strtokr(NULL, seps, &pszCur);
+		token = strsep(&pszCur, seps);
 
 		pGenObj->objData.procObj.uProcessorType = Atoi(token);
-		token = CSL_Strtokr(NULL, seps, &pszCur);
+		token = strsep(&pszCur, seps);
 
 		pGenObj->objData.procObj.uClockRate = Atoi(token);
-		token = CSL_Strtokr(NULL, seps, &pszCur);
+		token = strsep(&pszCur, seps);
 
 		pGenObj->objData.procObj.ulInternalMemSize = Atoi(token);
-		token = CSL_Strtokr(NULL, seps, &pszCur);
+		token = strsep(&pszCur, seps);
 
 		pGenObj->objData.procObj.ulExternalMemSize = Atoi(token);
-		token = CSL_Strtokr(NULL, seps, &pszCur);
+		token = strsep(&pszCur, seps);
 
 		pGenObj->objData.procObj.uProcessorID = Atoi(token);
-		token = CSL_Strtokr(NULL, seps, &pszCur);
+		token = strsep(&pszCur, seps);
 
 		pGenObj->objData.procObj.tyRunningRTOS = Atoi(token);
-		token = CSL_Strtokr(NULL, seps, &pszCur);
+		token = strsep(&pszCur, seps);
 
 		pGenObj->objData.procObj.nNodeMinPriority = Atoi(token);
-		token = CSL_Strtokr(NULL, seps, &pszCur);
+		token = strsep(&pszCur, seps);
 
 		pGenObj->objData.procObj.nNodeMaxPriority = Atoi(token);
 
@@ -1370,11 +1371,11 @@ static DSP_STATUS GetAttrsFromBuf(char *pszBuf, u32 ulBufSize,
 		/* Proc object may contain additional(extended) attributes. */
 		/* attr must match proc.hxx */
 		for (iEntry = 0; iEntry < 7; iEntry++) {
-			token = CSL_Strtokr(NULL, seps, &pszCur);
+			token = strsep(&pszCur, seps);
 			pGenObj->objData.extProcObj.tyTlb[iEntry].ulGppPhys =
 				Atoi(token);
 
-			token = CSL_Strtokr(NULL, seps, &pszCur);
+			token = strsep(&pszCur, seps);
 			pGenObj->objData.extProcObj.tyTlb[iEntry].ulDspVirt =
 				Atoi(token);
 		}
@@ -1553,8 +1554,8 @@ static DSP_STATUS GetDepLibInfo(IN struct DCD_MANAGER *hDcdMgr,
 	/* Compress and format DSP buffer to conform to PC format. */
 	CompressBuf(pszCoffBuf, ulLen, DSPWORDSIZE);
 	/* Read from buffer */
-	pToken = CSL_Strtokr(pszCoffBuf, seps, &pszCur);
-	while (pToken != NULL) {
+	pszCur = pszCoffBuf;
+	while ((pToken = strsep(&pszCur, seps)) && *pToken != '\0') {
 		if (fGetUuids) {
 			if (nDepLibs >= *pNumLibs) {
 				/* Gone beyond the limit */
@@ -1564,21 +1565,19 @@ static DSP_STATUS GetDepLibInfo(IN struct DCD_MANAGER *hDcdMgr,
 				UUID_UuidFromString(pToken,
 						 &(pDepLibUuids[nDepLibs]));
 				/* Is this library persistent? */
-				pToken = CSL_Strtokr(NULL, seps, &pszCur);
+				pToken = strsep(&pszCur, seps);
 				pPersistentDepLibs[nDepLibs] = Atoi(pToken);
 				nDepLibs++;
 			}
 		} else {
 			/* Advanc to next token */
-			pToken = CSL_Strtokr(NULL, seps, &pszCur);
+			pToken = strsep(&pszCur, seps);
 			if (Atoi(pToken))
 				(*pNumPersLibs)++;
 
 			/* Just counting number of dependent libraries */
 			(*pNumLibs)++;
 		}
-		/* Get next token */
-		pToken = CSL_Strtokr(NULL, seps, &pszCur);
 	}
 func_cont:
 	if (lib)
diff --git a/drivers/dsp/bridge/rmgr/node.c b/drivers/dsp/bridge/rmgr/node.c
index 3242325..a12cc0f 100644
--- a/drivers/dsp/bridge/rmgr/node.c
+++ b/drivers/dsp/bridge/rmgr/node.c
@@ -1002,8 +1002,6 @@ DSP_STATUS NODE_Connect(struct NODE_OBJECT *hNode1, u32 uStream1,
 {
 	struct NODE_MGR *hNodeMgr;
 	char *pstrDevName = NULL;
-	char *pstrDevName1;
-	char *pstrDevName2;
 	enum NODE_TYPE node1Type = NODE_TASK;
 	enum NODE_TYPE node2Type = NODE_TASK;
 	struct NODE_STRMDEF *pstrmDef;
@@ -1145,15 +1143,9 @@ DSP_STATUS NODE_Connect(struct NODE_OBJECT *hNode1, u32 uStream1,
 				status = DSP_EMEMORY;
 			} else {
 				/* Copy "/dbpipe<pipId>" name to device names */
-				pstrDevName1 = pOutput->szDevice;
-				strncpy(pstrDevName1, PIPEPREFIX,
-					   sizeof(PIPEPREFIX));
-				pstrDevName1 += strlen(pstrDevName1);
-				CSL_NumToAscii(pstrDevName1, pipeId);
-				pstrDevName1 = pOutput->szDevice;
-				pstrDevName2 = pInput->szDevice;
-				strncpy(pstrDevName2, pstrDevName1,
-					   PIPENAMELEN);
+				sprintf(pOutput->szDevice, "%s%d",
+						PIPEPREFIX, pipeId);
+				strcpy(pInput->szDevice, pOutput->szDevice);
 			}
 		}
 	}
@@ -1227,9 +1219,7 @@ func_cont2:
 				hNode1->outputs[uStream1].devId = chnlId;
 				pOutput->szDevice = pstrDevName;
 			}
-			strncpy(pstrDevName, HOSTPREFIX, sizeof(HOSTPREFIX));
-			pstrDevName += strlen(pstrDevName);
-			CSL_NumToAscii(pstrDevName, chnlId);
+			sprintf(pstrDevName, "%s%d", HOSTPREFIX, chnlId);
 		}
 	}
 	/* Connecting task node to device node? */
-- 
1.5.4.3

