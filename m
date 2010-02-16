From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 09/18] DSPBRIDGE: Remove excessive debug statements for rmgr
Date: Tue, 16 Feb 2010 02:42:19 -0600
Message-ID: <1266309748-11714-10-git-send-email-omar.ramirez@ti.com>
References: <1266309748-11714-1-git-send-email-omar.ramirez@ti.com>
 <1266309748-11714-2-git-send-email-omar.ramirez@ti.com>
 <1266309748-11714-3-git-send-email-omar.ramirez@ti.com>
 <1266309748-11714-4-git-send-email-omar.ramirez@ti.com>
 <1266309748-11714-5-git-send-email-omar.ramirez@ti.com>
 <1266309748-11714-6-git-send-email-omar.ramirez@ti.com>
 <1266309748-11714-7-git-send-email-omar.ramirez@ti.com>
 <1266309748-11714-8-git-send-email-omar.ramirez@ti.com>
 <1266309748-11714-9-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:57626 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755492Ab0BPIaG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Feb 2010 03:30:06 -0500
In-Reply-To: <1266309748-11714-9-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Ameya Palande <ameya.palande@nokia.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>, Nishanth Menon <nm@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>

Removed debug statements that print redundant errors where
returned statuses should be enough in case of failure.

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 drivers/dsp/bridge/rmgr/dbdcd.c  |   64 +--------
 drivers/dsp/bridge/rmgr/disp.c   |  102 ++-------------
 drivers/dsp/bridge/rmgr/drv.c    |   16 ---
 drivers/dsp/bridge/rmgr/dspdrv.c |   11 +-
 drivers/dsp/bridge/rmgr/mgr.c    |   40 +-----
 drivers/dsp/bridge/rmgr/nldr.c   |   28 +----
 drivers/dsp/bridge/rmgr/node.c   |   92 +------------
 drivers/dsp/bridge/rmgr/proc.c   |  268 +++++---------------------------------
 drivers/dsp/bridge/rmgr/rmm.c    |   15 +--
 drivers/dsp/bridge/rmgr/strm.c   |   56 ++-------
 10 files changed, 83 insertions(+), 609 deletions(-)

diff --git a/drivers/dsp/bridge/rmgr/dbdcd.c b/drivers/dsp/bridge/rmgr/dbdcd.c
index 0a59a62..5e07abd 100644
--- a/drivers/dsp/bridge/rmgr/dbdcd.c
+++ b/drivers/dsp/bridge/rmgr/dbdcd.c
@@ -96,15 +96,12 @@ DSP_STATUS DCD_AutoRegister(IN struct DCD_MANAGER *hDcdMgr,
 
 	DBC_Require(cRefs > 0);
 
-	if (IsValidHandle(hDcdMgr)) {
+	if (IsValidHandle(hDcdMgr))
 		status = DCD_GetObjects(hDcdMgr, pszCoffPath,
 					(DCD_REGISTERFXN)DCD_RegisterObject,
 					(void *)pszCoffPath);
-	} else {
+	else
 		status = DSP_EHANDLE;
-		GT_0trace(curTrace, GT_6CLASS,
-			 "DCD_AutoRegister: invalid DCD manager handle.\n");
-	}
 
 	return status;
 }
@@ -121,15 +118,11 @@ DSP_STATUS DCD_AutoUnregister(IN struct DCD_MANAGER *hDcdMgr,
 
 	DBC_Require(cRefs > 0);
 
-	if (IsValidHandle(hDcdMgr)) {
+	if (IsValidHandle(hDcdMgr))
 		status = DCD_GetObjects(hDcdMgr, pszCoffPath,
 				(DCD_REGISTERFXN)DCD_RegisterObject, NULL);
-	} else {
+	else
 		status = DSP_EHANDLE;
-		GT_0trace(curTrace, GT_6CLASS,
-			 "DCD_AutoUnregister: invalid DCD manager"
-			 " handle.\n");
-	}
 
 	return status;
 }
@@ -150,12 +143,8 @@ DSP_STATUS DCD_CreateManager(IN char *pszZlDllName,
 	DBC_Require(phDcdMgr);
 
 	status = COD_Create(&hCodMgr, pszZlDllName, NULL);
-
-	if (DSP_FAILED(status)) {
-		GT_0trace(curTrace, GT_6CLASS,
-			 "DCD_CreateManager: COD_Create failed\n");
+	if (DSP_FAILED(status))
 		goto func_end;
-	}
 
 	/* Create a DCD object. */
 	MEM_AllocObject(pDcdMgr, struct DCD_MANAGER, SIGNATURE);
@@ -173,9 +162,6 @@ DSP_STATUS DCD_CreateManager(IN char *pszZlDllName,
 		 * COD manager.
 		 */
 		COD_Delete(hCodMgr);
-
-		GT_0trace(curTrace, GT_6CLASS,
-			 "DCD_CreateManager: MEM_AllocObject failed\n");
 	}
 
 	DBC_Ensure((DSP_SUCCEEDED(status)) || ((hCodMgr == NULL) &&
@@ -206,9 +192,6 @@ DSP_STATUS DCD_DestroyManager(IN struct DCD_MANAGER *hDcdMgr)
 		MEM_FreeObject(pDcdMgr);
 
 		status = DSP_SOK;
-	} else {
-		GT_0trace(curTrace, GT_6CLASS,
-			 "DCD_DestroyManager: invalid DCD manager handle.\n");
 	}
 
 	return status;
@@ -306,9 +289,6 @@ DSP_STATUS DCD_EnumerateObject(IN s32 cIndex, IN enum DSP_DCDOBJTYPE objType,
 			status = DSP_SENUMCOMPLETE;
 		} else {
 			status = DSP_EFAIL;
-			GT_1trace(curTrace, GT_6CLASS,
-				 "DCD_EnumerateObject: REG_EnumValue"
-				 " failed, status = 0x%x\n", status);
 		}
 	}
 
@@ -414,8 +394,6 @@ DSP_STATUS DCD_GetObjectDef(IN struct DCD_MANAGER *hDcdMgr,
 
 	if (!IsValidHandle(hDcdMgr)) {
 		status = DSP_EHANDLE;
-		GT_0trace(curTrace, GT_6CLASS, "DCD_GetObjectDef: invalid "
-			 "DCD manager handle.\n");
 		goto func_end;
 	}
 
@@ -461,8 +439,6 @@ DSP_STATUS DCD_GetObjectDef(IN struct DCD_MANAGER *hDcdMgr,
 
 	if (DSP_FAILED(status)) {
 		status = DSP_EUUID;
-		GT_0trace(curTrace, GT_6CLASS, "DCD_GetObjectDef: "
-			 "REG_GetValue() failed\n");
 		goto func_end;
 	}
 
@@ -470,8 +446,6 @@ DSP_STATUS DCD_GetObjectDef(IN struct DCD_MANAGER *hDcdMgr,
 	status = COD_Open(pDcdMgr->hCodMgr, szRegData, COD_NOLOAD, &lib);
 	if (DSP_FAILED(status)) {
 		status = DSP_EDCDLOADBASE;
-		GT_0trace(curTrace, GT_6CLASS, "DCD_GetObjectDef: "
-			 "COD_OpenBase() failed\n");
 		goto func_end;
 	}
 
@@ -488,8 +462,6 @@ DSP_STATUS DCD_GetObjectDef(IN struct DCD_MANAGER *hDcdMgr,
 	status = COD_GetSection(lib, szSectName, &ulAddr, &ulLen);
 	if (DSP_FAILED(status)) {
 		status = DSP_EDCDGETSECT;
-		GT_0trace(curTrace, GT_6CLASS, "DCD_GetObjectDef:"
-			 " COD_GetSection() failed\n");
 		goto func_end;
 	}
 
@@ -519,15 +491,10 @@ DSP_STATUS DCD_GetObjectDef(IN struct DCD_MANAGER *hDcdMgr,
 
 		/* Parse the content of the COFF buffer. */
 		status = GetAttrsFromBuf(pszCoffBuf, ulLen, objType, pObjDef);
-		if (DSP_FAILED(status)) {
+		if (DSP_FAILED(status))
 			status = DSP_EDCDPARSESECT;
-			GT_0trace(curTrace, GT_6CLASS, "DCD_GetObjectDef: "
-				 "GetAttrsFromBuf() failed\n");
-		}
 	} else {
 		status = DSP_EDCDREADSECT;
-		GT_0trace(curTrace, GT_6CLASS, "DCD_GetObjectDef: "
-			 "COD_ReadSection() failed\n");
 	}
 
 	/* Free the previously allocated dynamic buffer. */
@@ -562,8 +529,6 @@ DSP_STATUS DCD_GetObjects(IN struct DCD_MANAGER *hDcdMgr, IN char *pszCoffPath,
 	DBC_Require(cRefs > 0);
 	if (!IsValidHandle(hDcdMgr)) {
 		status = DSP_EHANDLE;
-		GT_0trace(curTrace, GT_6CLASS,
-			 "DCD_GetObjects: invalid DCD manager handle.\n");
 		goto func_end;
 	}
 
@@ -571,8 +536,6 @@ DSP_STATUS DCD_GetObjects(IN struct DCD_MANAGER *hDcdMgr, IN char *pszCoffPath,
 	status = COD_Open(pDcdMgr->hCodMgr, pszCoffPath, COD_NOLOAD, &lib);
 	if (DSP_FAILED(status)) {
 		status = DSP_EDCDLOADBASE;
-		GT_0trace(curTrace, GT_6CLASS,
-			 "DCD_AutoRegister: COD_Open() failed\n");
 		goto func_cont;
 	}
 
@@ -580,9 +543,6 @@ DSP_STATUS DCD_GetObjects(IN struct DCD_MANAGER *hDcdMgr, IN char *pszCoffPath,
 	status = COD_GetSection(lib, DCD_REGISTER_SECTION, &ulAddr, &ulLen);
 	if (DSP_FAILED(status) ||  !(ulLen > 0)) {
 		status = DSP_EDCDNOAUTOREGISTER;
-		GT_0trace(curTrace, GT_6CLASS,
-			 "DCD_GetObjects: COD_GetSection() "
-			 "- no auto register section\n");
 		goto func_cont;
 	}
 
@@ -633,17 +593,12 @@ DSP_STATUS DCD_GetObjects(IN struct DCD_MANAGER *hDcdMgr, IN char *pszCoffPath,
 			 */
 			status = registerFxn(&dspUuid, cObjectType, handle);
 			if (DSP_FAILED(status)) {
-				GT_0trace(curTrace, GT_6CLASS,
-					 "DCD_GetObjects: "
-					 "registration() failed\n");
 				/* if error occurs, break from while loop. */
 				break;
 			}
 		}
 	} else {
 		status = DSP_EDCDREADSECT;
-		GT_0trace(curTrace, GT_6CLASS, "DCD_GetObjects: "
-			 "COD_ReadSection() failed\n");
 	}
 
 	/* Free the previously allocated dynamic buffer. */
@@ -788,7 +743,6 @@ bool DCD_Init(void)
 
 		if (!fInitCOD) {
 			fInit = false;
-			GT_0trace(curTrace, GT_6CLASS, "DCD_Init failed\n");
 			/* Exit initialized modules. */
 			if (fInitCOD)
 				COD_Exit();
@@ -881,15 +835,9 @@ DSP_STATUS DCD_RegisterObject(IN struct DSP_UUID *pUuid,
 		GT_2trace(curTrace, GT_6CLASS, "REG_SetValue  "
 			  "(u8 *)pszPathName=%s, dwPathSize=%d\n",
 			  pszPathName, dwPathSize);
-		if (DSP_FAILED(status))
-			GT_0trace(curTrace, GT_6CLASS,
-				"DCD_RegisterObject: REG_SetValue failed!\n");
 	} else {
 		/* Deregister an existing object */
 		status = REG_DeleteValue(szRegKey);
-		if (DSP_FAILED(status))
-			GT_0trace(curTrace, GT_6CLASS, "DCD_UnregisterObject: "
-				"REG_DeleteValue failed!\n");
 	}
 
 
diff --git a/drivers/dsp/bridge/rmgr/disp.c b/drivers/dsp/bridge/rmgr/disp.c
index 4d7a2da..795856b 100644
--- a/drivers/dsp/bridge/rmgr/disp.c
+++ b/drivers/dsp/bridge/rmgr/disp.c
@@ -117,13 +117,10 @@ DSP_STATUS DISP_Create(OUT struct DISP_OBJECT **phDispObject,
 
 	/* Allocate Node Dispatcher object */
 	MEM_AllocObject(pDisp, struct DISP_OBJECT, DISP_SIGNATURE);
-	if (pDisp == NULL) {
+	if (pDisp == NULL)
 		status = DSP_EMEMORY;
-		GT_0trace(DISP_DebugMask, GT_6CLASS,
-			 "DISP_Create: MEM_AllocObject() failed!\n");
-	} else {
+	else
 		pDisp->hDevObject = hDevObject;
-	}
 
 	/* Get Channel manager and WMD function interface */
 	if (DSP_SUCCEEDED(status)) {
@@ -131,10 +128,6 @@ DSP_STATUS DISP_Create(OUT struct DISP_OBJECT **phDispObject,
 		if (DSP_SUCCEEDED(status)) {
 			(void) DEV_GetIntfFxns(hDevObject, &pIntfFxns);
 			pDisp->pIntfFxns = pIntfFxns;
-		} else {
-			GT_1trace(DISP_DebugMask, GT_6CLASS,
-				 "DISP_Create: Failed to get "
-				 "channel manager! status = 0x%x\n", status);
 		}
 	}
 
@@ -149,9 +142,6 @@ DSP_STATUS DISP_Create(OUT struct DISP_OBJECT **phDispObject,
 		goto func_cont;
 
 	if (devType != DSP_UNIT) {
-		GT_0trace(DISP_DebugMask, GT_6CLASS,
-			 "DISP_Create: Unkown device "
-			 "type in Device object !! \n");
 		status = DSP_EFAIL;
 		goto func_cont;
 	}
@@ -165,35 +155,20 @@ DSP_STATUS DISP_Create(OUT struct DISP_OBJECT **phDispObject,
 	ulChnlId = pDispAttrs->ulChnlOffset + CHNLTORMSOFFSET;
 	status = (*pIntfFxns->pfnChnlOpen)(&(pDisp->hChnlToDsp),
 		 pDisp->hChnlMgr, CHNL_MODETODSP, ulChnlId, &chnlAttrs);
-	if (DSP_FAILED(status))
-		GT_2trace(DISP_DebugMask, GT_6CLASS,
-			 "DISP_Create:  Channel to RMS "
-			 "open failed, chnl id = %d, status = 0x%x\n",
-			 ulChnlId, status);
 
 	if (DSP_SUCCEEDED(status)) {
 		ulChnlId = pDispAttrs->ulChnlOffset + CHNLFROMRMSOFFSET;
 		status = (*pIntfFxns->pfnChnlOpen)(&(pDisp->hChnlFromDsp),
 			 pDisp->hChnlMgr, CHNL_MODEFROMDSP, ulChnlId,
 			 &chnlAttrs);
-		if (DSP_FAILED(status)) {
-			GT_2trace(DISP_DebugMask, GT_6CLASS,
-				 "DISP_Create: Channel from RMS "
-				 "open failed, chnl id = %d, status = 0x%x\n",
-				 ulChnlId, status);
-		}
 	}
 	if (DSP_SUCCEEDED(status)) {
 		/* Allocate buffer for commands, replies */
 		pDisp->ulBufsize = pDispAttrs->ulChnlBufSize;
 		pDisp->ulBufsizeRMS = RMS_COMMANDBUFSIZE;
 		pDisp->pBuf = MEM_Calloc(pDisp->ulBufsize, MEM_PAGED);
-		if (pDisp->pBuf == NULL) {
+		if (pDisp->pBuf == NULL)
 			status = DSP_EMEMORY;
-			GT_0trace(DISP_DebugMask, GT_6CLASS,
-				 "DISP_Create: Failed "
-				 "to allocate channel buffer!\n");
-		}
 	}
 func_cont:
 	if (DSP_SUCCEEDED(status))
@@ -280,11 +255,7 @@ DSP_STATUS DISP_NodeChangePriority(struct DISP_OBJECT *hDisp,
 	pCommand->arg2 = nPriority;
 	status = SendMessage(hDisp, NODE_GetTimeout(hNode),
 		 sizeof(struct RMS_Command), &dwArg);
-	if (DSP_FAILED(status)) {
-		GT_1trace(DISP_DebugMask, GT_6CLASS,
-			 "DISP_NodeChangePriority failed! "
-			 "status = 0x%x\n", status);
-	}
+
 	return status;
 }
 
@@ -489,19 +460,9 @@ DSP_STATUS DISP_NodeCreate(struct DISP_OBJECT *hDisp, struct NODE_OBJECT *hNode,
 					 strmDef, max, uCharsInRMSWord);
 				offset = total;
 			}
-			if (DSP_FAILED(status)) {
-				GT_2trace(DISP_DebugMask, GT_6CLASS,
-				      "DISP_NodeCreate: Message"
-				      " args to large for buffer! Message args"
-				      " size = %d, max = %d\n", total, max);
-			}
 		} else {
 			/* Args won't fit */
 			status = DSP_EFAIL;
-			GT_2trace(DISP_DebugMask, GT_6CLASS,
-				 "DISP_NodeCreate: Message args "
-				 " too large for buffer! Message args size = %d"
-				 ", max = %d\n", total, max);
 		}
 	}
 	if (DSP_SUCCEEDED(status)) {
@@ -509,11 +470,7 @@ DSP_STATUS DISP_NodeCreate(struct DISP_OBJECT *hDisp, struct NODE_OBJECT *hNode,
 		DBC_Assert(ulBytes < (RMS_COMMANDBUFSIZE * sizeof(RMS_WORD)));
 		status = SendMessage(hDisp, NODE_GetTimeout(hNode),
 			 ulBytes, pNodeEnv);
-		if (DSP_FAILED(status)) {
-			GT_1trace(DISP_DebugMask, GT_6CLASS,
-				  "DISP_NodeCreate  failed! "
-				  "status = 0x%x\n", status);
-		} else {
+		if (DSP_SUCCEEDED(status)) {
 			/*
 			 * Message successfully received from RMS.
 			 * Return the status of the Node's create function
@@ -568,11 +525,7 @@ DSP_STATUS DISP_NodeDelete(struct DISP_OBJECT *hDisp, struct NODE_OBJECT *hNode,
 
 			status = SendMessage(hDisp, NODE_GetTimeout(hNode),
 					    sizeof(struct RMS_Command), &dwArg);
-			if (DSP_FAILED(status)) {
-				GT_1trace(DISP_DebugMask, GT_6CLASS,
-					 "DISP_NodeDelete failed!"
-					 "status = 0x%x\n", status);
-			} else {
+			if (DSP_SUCCEEDED(status)) {
 				/*
 				 * Message successfully received from RMS.
 				 * Return the status of the Node's delete
@@ -627,11 +580,7 @@ DSP_STATUS DISP_NodeRun(struct DISP_OBJECT *hDisp, struct NODE_OBJECT *hNode,
 
 			status = SendMessage(hDisp, NODE_GetTimeout(hNode),
 				 sizeof(struct RMS_Command), &dwArg);
-			if (DSP_FAILED(status)) {
-				GT_1trace(DISP_DebugMask, GT_6CLASS,
-					 "DISP_NodeRun failed!"
-					 "status = 0x%x\n", status);
-			} else {
+			if (DSP_SUCCEEDED(status)) {
 				/*
 				 * Message successfully received from RMS.
 				 * Return the status of the Node's execute
@@ -773,30 +722,17 @@ static DSP_STATUS SendMessage(struct DISP_OBJECT *hDisp, u32 dwTimeout,
 	/* Send the command */
 	status = (*pIntfFxns->pfnChnlAddIOReq) (hChnl, pBuf, ulBytes, 0,
 		 0L, dwArg);
-
-	if (DSP_FAILED(status)) {
-		GT_1trace(DISP_DebugMask, GT_6CLASS,
-			 "SendMessage: Channel AddIOReq to"
-			 " RMS failed! Status = 0x%x\n", status);
+	if (DSP_FAILED(status))
 		goto func_end;
-	}
+
 	status = (*pIntfFxns->pfnChnlGetIOC) (hChnl, dwTimeout, &chnlIOC);
 	if (DSP_SUCCEEDED(status)) {
 		if (!CHNL_IsIOComplete(chnlIOC)) {
-			if (CHNL_IsTimedOut(chnlIOC)) {
+			if (CHNL_IsTimedOut(chnlIOC))
 				status = DSP_ETIMEOUT;
-			} else {
-				GT_1trace(DISP_DebugMask, GT_6CLASS,
-					 "SendMessage failed! "
-					 "Channel IOC status = 0x%x\n",
-					 chnlIOC.status);
+			else
 				status = DSP_EFAIL;
-			}
 		}
-	} else {
-		GT_1trace(DISP_DebugMask, GT_6CLASS,
-			 "SendMessage: Channel GetIOC to"
-			 " RMS failed! Status = 0x%x\n", status);
 	}
 	/* Get the reply */
 	if (DSP_FAILED(status))
@@ -806,22 +742,15 @@ static DSP_STATUS SendMessage(struct DISP_OBJECT *hDisp, u32 dwTimeout,
 	ulBytes = REPLYSIZE;
 	status = (*pIntfFxns->pfnChnlAddIOReq)(hChnl, pBuf, ulBytes,
 		 0, 0L, dwArg);
-	if (DSP_FAILED(status)) {
-		GT_1trace(DISP_DebugMask, GT_6CLASS,
-			 "SendMessage: Channel AddIOReq "
-			 "from RMS failed! Status = 0x%x\n", status);
+	if (DSP_FAILED(status))
 		goto func_end;
-	}
+
 	status = (*pIntfFxns->pfnChnlGetIOC) (hChnl, dwTimeout, &chnlIOC);
 	if (DSP_SUCCEEDED(status)) {
 		if (CHNL_IsTimedOut(chnlIOC)) {
 			status = DSP_ETIMEOUT;
 		} else if (chnlIOC.cBytes < ulBytes) {
 			/* Did not get all of the reply from the RMS */
-			GT_1trace(DISP_DebugMask, GT_6CLASS,
-				 "SendMessage: Did not get all"
-				 "of reply from RMS! Bytes received: %d\n",
-				 chnlIOC.cBytes);
 			status = DSP_EFAIL;
 		} else {
 			if (CHNL_IsIOComplete(chnlIOC)) {
@@ -832,11 +761,6 @@ static DSP_STATUS SendMessage(struct DISP_OBJECT *hDisp, u32 dwTimeout,
 				status = DSP_EFAIL;
 			}
 		}
-	} else {
-		/* GetIOC failed */
-		GT_1trace(DISP_DebugMask, GT_6CLASS,
-			 "SendMessage: Failed to get "
-			 "reply from RMS! Status = 0x%x\n", status);
 	}
 func_end:
 	return status;
diff --git a/drivers/dsp/bridge/rmgr/drv.c b/drivers/dsp/bridge/rmgr/drv.c
index dbe1581..c334f9e 100644
--- a/drivers/dsp/bridge/rmgr/drv.c
+++ b/drivers/dsp/bridge/rmgr/drv.c
@@ -538,8 +538,6 @@ DSP_STATUS DRV_Create(OUT struct DRV_OBJECT **phDRVObject)
 				LST_LIST), MEM_NONPAGED);
 			if (!(pDRVObject->devNodeString)) {
 				status = DSP_EFAIL;
-				GT_0trace(curTrace, GT_7CLASS,
-					 "Failed to Create DRV_EXT list ");
 			} else {
 				INIT_LIST_HEAD(&pDRVObject->devNodeString->
 					head);
@@ -547,13 +545,9 @@ DSP_STATUS DRV_Create(OUT struct DRV_OBJECT **phDRVObject)
 			}
 		} else {
 			status = DSP_EMEMORY;
-			GT_0trace(curTrace, GT_7CLASS,
-				 "Failed to Create Dev List ");
 		}
 	} else {
 		status = DSP_EMEMORY;
-		GT_0trace(curTrace, GT_7CLASS,
-			 "Failed to Allocate Memory for DRV Obj");
 	}
 	/* Store the DRV Object in the Registry */
 	if (DSP_SUCCEEDED(status))
@@ -565,10 +559,6 @@ DSP_STATUS DRV_Create(OUT struct DRV_OBJECT **phDRVObject)
 		kfree(pDRVObject->devNodeString);
 		/* Free the DRV Object */
 		kfree(pDRVObject);
-		GT_0trace(curTrace, GT_7CLASS,
-			 "Failed to update the Registry with "
-				 "DRV Object ");
-
 	}
 
 	DBC_Ensure(DSP_FAILED(status) ||
@@ -647,8 +637,6 @@ DSP_STATUS DRV_GetDevObject(u32 uIndex, struct DRV_OBJECT *hDrvObject,
 	} else {
 		*phDevObject = NULL;
 		status = DSP_EFAIL;
-		GT_0trace(curTrace, GT_7CLASS,
-			 "DRV: Could not get the DevObject\n");
 	}
 
 	return status;
@@ -869,8 +857,6 @@ DSP_STATUS DRV_RequestResources(u32 dwContext, u32 *pDevNodeString)
 			LST_PutTail(pDRVObject->devNodeString,
 					(struct list_head *)pszdevNode);
 		} else {
-			GT_0trace(curTrace, GT_7CLASS,
-				"Failed to Allocate Memory devNodeString ");
 			status = DSP_EMEMORY;
 			*pDevNodeString = 0;
 		}
@@ -974,8 +960,6 @@ static DSP_STATUS RequestBridgeResources(u32 dwContext, s32 bRequest)
 			if (DSP_FAILED(REG_GetValue(CURRENTCONFIG,
 					(u8 *)pResources, &dwBuffSize))) {
 				status = CFG_E_RESOURCENOTAVAIL;
-				GT_0trace(curTrace, GT_1CLASS,
-					 "REG_GetValue Failed \n");
 			}
 
 			dwBuffSize = sizeof(shm_size);
diff --git a/drivers/dsp/bridge/rmgr/dspdrv.c b/drivers/dsp/bridge/rmgr/dspdrv.c
index dae61e2..b6a9bc4 100644
--- a/drivers/dsp/bridge/rmgr/dspdrv.c
+++ b/drivers/dsp/bridge/rmgr/dspdrv.c
@@ -61,13 +61,11 @@ u32 DSP_Init(OUT u32 *initStatus)
 
 	GT_create(&curTrace, "DD");
 
-	if (!WCD_Init()) {
-		GT_0trace(curTrace, GT_7CLASS, "DSP_Init Failed \n");
+	if (!WCD_Init())
 		goto func_cont;
-	}			/* End WCD_Exit */
+
 	status = DRV_Create(&drvObject);
 	if (DSP_FAILED(status)) {
-		GT_0trace(curTrace, GT_7CLASS, "DSP_Init:DRV_Create Failed \n");
 		WCD_Exit();
 		goto func_cont;
 	}		/* End DRV_Create */
@@ -78,12 +76,9 @@ u32 DSP_Init(OUT u32 *initStatus)
 		/* Attempt to Start the Device */
 		status = DEV_StartDevice((struct CFG_DEVNODE *)
 							deviceNodeString);
-		if (DSP_FAILED(status)) {
-			GT_0trace(curTrace, GT_7CLASS,
-				 "DSP_Init:DEV_StartDevice Failed\n");
+		if (DSP_FAILED(status))
 			(void)DRV_ReleaseResources
 				((u32) deviceNodeString, drvObject);
-		}
 	} else {
 		GT_0trace(curTrace, GT_7CLASS,
 			 "DSP_Init:DRV_RequestResources Failed \r\n");
diff --git a/drivers/dsp/bridge/rmgr/mgr.c b/drivers/dsp/bridge/rmgr/mgr.c
index d7118da..b905906 100644
--- a/drivers/dsp/bridge/rmgr/mgr.c
+++ b/drivers/dsp/bridge/rmgr/mgr.c
@@ -80,22 +80,15 @@ DSP_STATUS MGR_Create(OUT struct MGR_OBJECT **phMgrObject,
 			if (DSP_SUCCEEDED(status)) {
 				*phMgrObject = pMgrObject;
 			} else {
-				GT_0trace(MGR_DebugMask, GT_7CLASS,
-					 "MGR_Create:CFG_SetObject "
-					 "Failed\r\n");
 				DCD_DestroyManager(pMgrObject->hDcdMgr);
 				MEM_FreeObject(pMgrObject);
 			}
 		} else {
 			/* failed to Create DCD Manager */
-			GT_0trace(MGR_DebugMask, GT_7CLASS,
-				 "MGR_Create:DCD_ManagerCreate Failed\r\n");
 			MEM_FreeObject(pMgrObject);
 		}
 	} else {
 		status = DSP_EMEMORY;
-		GT_0trace(MGR_DebugMask, GT_7CLASS,
-			 "MGR_Create DSP_FAILED to allocate memory \n");
 	}
 
 	DBC_Ensure(DSP_FAILED(status) ||
@@ -152,12 +145,9 @@ DSP_STATUS MGR_EnumNodeInfo(u32 uNode, OUT struct DSP_NDBPROPS *pNDBProps,
 	*puNumNodes = 0;
 	/* Get The Manager Object from the Registry */
 	status = CFG_GetObject((u32 *)&pMgrObject, REG_MGR_OBJECT);
-	if (DSP_FAILED(status)) {
-		GT_0trace(MGR_DebugMask, GT_7CLASS,
-			 "Manager_EnumNodeInfo:Failed To Get"
-			 " MGR Object from Registry\r\n");
+	if (DSP_FAILED(status))
 		goto func_cont;
-	}
+
 	DBC_Assert(MEM_IsValidHandle(pMgrObject, SIGNATURE));
 	/* Forever loop till we hit failed or no more items in the
 	 * Enumeration. We will exit the loop other than DSP_SOK; */
@@ -174,9 +164,6 @@ DSP_STATUS MGR_EnumNodeInfo(u32 uNode, OUT struct DSP_NDBPROPS *pNDBProps,
 	if (DSP_SUCCEEDED(status)) {
 		if (uNode > (uNodeIndex - 1)) {
 			status = DSP_EINVALIDARG;
-			GT_0trace(MGR_DebugMask, GT_7CLASS,
-				 "Manager_EnumNodeInfo: uNode"
-				 " is Invalid \r\n");
 		} else {
 			status = DCD_GetObjectDef(pMgrObject->hDcdMgr,
 						(struct DSP_UUID *)&Uuid,
@@ -185,17 +172,10 @@ DSP_STATUS MGR_EnumNodeInfo(u32 uNode, OUT struct DSP_NDBPROPS *pNDBProps,
 				/* Get the Obj def */
 				*pNDBProps = GenObj.objData.nodeObj.ndbProps;
 				*puNumNodes = uNodeIndex;
-			} else {
-				GT_0trace(MGR_DebugMask, GT_7CLASS,
-					 "Manager_EnumNodeInfo: "
-					 "Failed to Get Node Info \r\n");
 			}
 		}
-	} else {
-		/* This could be changed during enum, EFAIL ... */
-		GT_0trace(MGR_DebugMask, GT_7CLASS, "Manager_EnumNodeInfo: "
-			 "Enumeration failure\r\n");
 	}
+
 func_cont:
 	DBC_Ensure((DSP_SUCCEEDED(status) && *puNumNodes > 0) ||
 		  (DSP_FAILED(status) && *puNumNodes == 0));
@@ -240,15 +220,12 @@ DSP_STATUS MGR_EnumProcessorInfo(u32 uProcessor,
 		if (DSP_SUCCEEDED(status)) {
 			status = DEV_GetDevType(hDevObject, (u32 *) &devType);
 			status = DEV_GetDevNode(hDevObject, &devNode);
-			if (devType == DSP_UNIT) {
+			if (devType == DSP_UNIT)
 				status = CFG_GetDSPResources(devNode,
 							 &chipResources);
-			} else {
+			else
 				status = DSP_EFAIL;
-				GT_1trace(MGR_DebugMask, GT_7CLASS,
-					 "Unsupported dev type gotten"
-					 "from device object %d\n", devType);
-			}
+
 			if (DSP_SUCCEEDED(status)) {
 				pProcessorInfo->uProcessorType =
 						chipResources.uChipType;
@@ -392,11 +369,8 @@ bool MGR_Init(void)
 		GT_create(&MGR_DebugMask, "MG");	/* "MG" for Manager */
 		fInitDCD = DCD_Init();	/*  DCD Module */
 
-		if (!fInitDCD) {
+		if (!fInitDCD)
 			fRetval = false;
-			GT_0trace(MGR_DebugMask, GT_6CLASS,
-				 "MGR_Init failed\n");
-		}
 	}
 
 	if (fRetval)
diff --git a/drivers/dsp/bridge/rmgr/nldr.c b/drivers/dsp/bridge/rmgr/nldr.c
index 71487be..e964d4b 100644
--- a/drivers/dsp/bridge/rmgr/nldr.c
+++ b/drivers/dsp/bridge/rmgr/nldr.c
@@ -353,8 +353,6 @@ DSP_STATUS NLDR_Allocate(struct NLDR_OBJECT *hNldr, void *pPrivRef,
 	MEM_AllocObject(pNldrNode, struct NLDR_NODEOBJECT, NLDR_NODESIGNATURE);
 
 	if (pNldrNode == NULL) {
-		GT_0trace(NLDR_debugMask, GT_6CLASS, "NLDR_Allocate: "
-			 "Memory allocation failed\n");
 		status = DSP_EMEMORY;
 	} else {
 		pNldrNode->pfPhaseSplit = pfPhaseSplit;
@@ -491,8 +489,6 @@ DSP_STATUS NLDR_Create(OUT struct NLDR_OBJECT **phNldr,
 			status = DSP_EMEMORY;
 
 	} else {
-		GT_0trace(NLDR_debugMask, GT_6CLASS, "NLDR_Create: "
-			 "Memory allocation failed\n");
 		status = DSP_EMEMORY;
 	}
 	/* Create the DCD Manager */
@@ -507,9 +503,6 @@ DSP_STATUS NLDR_Create(OUT struct NLDR_OBJECT **phNldr,
 			pszCoffBuf = MEM_Calloc(ulLen * pNldr->usDSPMauSize,
 						MEM_PAGED);
 			if (!pszCoffBuf) {
-				GT_0trace(NLDR_debugMask, GT_6CLASS,
-					 "NLDR_Create: Memory "
-					 "allocation failed\n");
 				status = DSP_EMEMORY;
 			}
 		} else {
@@ -526,21 +519,12 @@ DSP_STATUS NLDR_Create(OUT struct NLDR_OBJECT **phNldr,
 		/* Read section containing dynamic load mem segments */
 		status = pNldr->dbllFxns.readSectFxn(pNldr->baseLib, DYNMEMSECT,
 						    pszCoffBuf, ulLen);
-		if (DSP_FAILED(status)) {
-			GT_1trace(NLDR_debugMask, GT_6CLASS,
-				 "NLDR_Create: DBLL_read Section"
-				 "failed: 0x%lx\n", status);
-		}
 	}
 	if (DSP_SUCCEEDED(status) && ulLen > 0) {
 		/* Parse memory segment data */
 		nSegs = (u16)(*((u32 *)pszCoffBuf));
-		if (nSegs > MAXMEMSEGS) {
-			GT_1trace(NLDR_debugMask, GT_6CLASS,
-				 "NLDR_Create: Invalid number of "
-				 "dynamic load mem segments: 0x%lx\n", nSegs);
+		if (nSegs > MAXMEMSEGS)
 			status = DSP_ECORRUPTFILE;
-		}
 	}
 	/* Parse dynamic load memory segments */
 	if (DSP_SUCCEEDED(status) && nSegs > 0) {
@@ -780,14 +764,10 @@ DSP_STATUS NLDR_GetFxnAddr(struct NLDR_NODEOBJECT *hNldrNode, char *pstrFxn,
 		}
 	}
 
-	if (status1) {
+	if (status1)
 		*pulAddr = pSym->value;
-	} else {
-		GT_1trace(NLDR_debugMask, GT_6CLASS,
-			 "NLDR_GetFxnAddr: Symbol not found: "
-			 "%s\n", pstrFxn);
+	else
 		status = DSP_ESYMBOL;
-	}
 
 	return status;
 }
@@ -808,8 +788,6 @@ DSP_STATUS NLDR_GetRmmManager(struct NLDR_OBJECT *hNldrObject,
 	} else {
 		*phRmmMgr = NULL;
 		status = DSP_EHANDLE;
-		GT_0trace(NLDR_debugMask, GT_7CLASS,
-			 "NLDR_GetRmmManager:Invalid handle");
 	}
 
 	DBC_Ensure(DSP_SUCCEEDED(status) || ((phRmmMgr != NULL) &&
diff --git a/drivers/dsp/bridge/rmgr/node.c b/drivers/dsp/bridge/rmgr/node.c
index 78770fc..fe7d806 100644
--- a/drivers/dsp/bridge/rmgr/node.c
+++ b/drivers/dsp/bridge/rmgr/node.c
@@ -291,11 +291,9 @@ static struct NLDR_FXNS nldrFxns = {
 enum NODE_STATE NODE_GetState(HANDLE hNode)
 {
 	struct NODE_OBJECT *pNode = (struct NODE_OBJECT *)hNode;
-	if (!MEM_IsValidHandle(pNode, NODE_SIGNATURE)) {
-		GT_1trace(NODE_debugMask, GT_5CLASS,
-				"NODE_GetState:hNode 0x%x\n", pNode);
+	if (!MEM_IsValidHandle(pNode, NODE_SIGNATURE))
 		return  -1;
-	} else
+	else
 		return pNode->nState;
 }
 
@@ -373,9 +371,6 @@ DSP_STATUS NODE_Allocate(struct PROC_OBJECT *hProcessor,
 	/* If processor is in error state then don't attempt
 	    to send the message */
 	if (procStatus.iState == PROC_ERROR) {
-		GT_1trace(NODE_debugMask, GT_5CLASS,
-			"NODE_Allocate: proc Status 0x%x\n",
-			procStatus.iState);
 		status = DSP_EFAIL;
 		goto func_end;
 	}
@@ -540,21 +535,11 @@ func_cont:
 		if (DSP_SUCCEEDED(status)) {
 			/*Get the shared mem mgr for this nodes dev object */
 			status = CMM_GetHandle(hProcessor, &hCmmMgr);
-			if (DSP_FAILED(status)) {
-				GT_1trace(NODE_debugMask, GT_5CLASS,
-					 "NODE_Allocate: Failed to"
-					 " get CMM Mgr handle: 0x%x\n", status);
-			} else {
+			if (DSP_SUCCEEDED(status)) {
 				/* Allocate a SM addr translator for this node
 				 * w/ deflt attr */
 				status = CMM_XlatorCreate(&pNode->hXlator,
 					 hCmmMgr, NULL);
-				if (DSP_FAILED(status)) {
-					GT_1trace(NODE_debugMask, GT_5CLASS,
-						"NODE_Allocate: Failed to "
-						"create SM translator: 0x%x\n",
-						status);
-				}
 			}
 		}
 		if (DSP_SUCCEEDED(status)) {
@@ -591,11 +576,6 @@ func_cont:
 					     &pNode->dcdProps.objData.nodeObj,
 					     &pNode->hNldrNode,
 					     &pNode->fPhaseSplit);
-		if (DSP_FAILED(status)) {
-			GT_1trace(NODE_debugMask, GT_5CLASS,
-				 "NODE_Allocate: Failed to "
-				 "allocate NLDR node: 0x%x\n", status);
-		}
 	}
 
 	/* Compare value read from Node Properties and check if it is same as
@@ -748,11 +728,6 @@ DBAPI NODE_AllocMsgBuf(struct NODE_OBJECT *hNode, u32 uSize,
 		/* Set/get this node's translators virtual address base/size */
 		status = CMM_XlatorInfo(pNode->hXlator, pBuffer, uSize,
 					pAttr->uSegment, bSetInfo);
-		if (DSP_FAILED(status)) {
-			GT_1trace(NODE_debugMask, GT_7CLASS,
-				 "NODE_AllocMsgBuf "
-				 "failed: 0x%lx\n", status);
-		}
 	}
 	if (DSP_SUCCEEDED(status) && (!bVirtAddr)) {
 		if (pAttr->uSegment != 1) {
@@ -808,8 +783,6 @@ DSP_STATUS NODE_ChangePriority(struct NODE_OBJECT *hNode, s32 nPriority)
 	DBC_Require(cRefs > 0);
 
 	if (!MEM_IsValidHandle(hNode, NODE_SIGNATURE) || !hNode->hNodeMgr) {
-		GT_1trace(NODE_debugMask, GT_7CLASS,
-			 "Invalid NODE Handle: 0x%x\n", hNode);
 		status = DSP_EHANDLE;
 	} else {
 		hNodeMgr = hNode->hNodeMgr;
@@ -1196,8 +1169,6 @@ DSP_STATUS NODE_Create(struct NODE_OBJECT *hNode)
 	/* If processor is in error state then don't attempt to create
 	    new node */
 	if (procStatus.iState == PROC_ERROR) {
-		GT_1trace(NODE_debugMask, GT_4CLASS, "NODE_Create:"
-			"		proc Status 0x%x\n", procStatus.iState);
 		status = DSP_EFAIL;
 		goto func_end;
 	}
@@ -1351,17 +1322,12 @@ DSP_STATUS NODE_CreateMgr(OUT struct NODE_MGR **phNodeMgr,
 		if (pNodeMgr->nodeList == NULL || pNodeMgr->pipeMap == NULL ||
 		   pNodeMgr->pipeDoneMap == NULL) {
 			status = DSP_EMEMORY;
-			GT_0trace(NODE_debugMask, GT_6CLASS,
-				 "NODE_CreateMgr: Memory "
-				 "allocation failed\n");
 		} else {
 			INIT_LIST_HEAD(&pNodeMgr->nodeList->head);
 			status = NTFY_Create(&pNodeMgr->hNtfy);
 		}
 		pNodeMgr->uNumCreated = 0;
 	} else {
-		GT_0trace(NODE_debugMask, GT_6CLASS,
-			 "NODE_CreateMgr: Memory allocation failed\n");
 		status = DSP_EMEMORY;
 	}
 	/* get devNodeType */
@@ -1417,11 +1383,6 @@ DSP_STATUS NODE_CreateMgr(OUT struct NODE_MGR **phNodeMgr,
 		if (devType != IVA_UNIT) {
 			/* Get addresses of any RMS functions loaded */
 			status = GetRMSFxns(pNodeMgr);
-			if (DSP_FAILED(status)) {
-				GT_1trace(NODE_debugMask, GT_6CLASS,
-				"NODE_CreateMgr: Failed to"
-				" get RMS functions: status = 0x%x", status);
-			}
 		}
 	}
 
@@ -1437,11 +1398,6 @@ DSP_STATUS NODE_CreateMgr(OUT struct NODE_MGR **phNodeMgr,
 		pNodeMgr->fLoaderInit = pNodeMgr->nldrFxns.pfnInit();
 		status = pNodeMgr->nldrFxns.pfnCreate(&pNodeMgr->hNldr,
 						     hDevObject, &nldrAttrs);
-		if (DSP_FAILED(status)) {
-			GT_1trace(NODE_debugMask, GT_6CLASS,
-				 "NODE_CreateMgr: Failed to "
-				 "create loader: status = 0x%x\n", status);
-		}
 	}
 	if (DSP_SUCCEEDED(status))
 		*phNodeMgr = pNodeMgr;
@@ -1857,8 +1813,6 @@ DSP_STATUS NODE_GetMessage(struct NODE_OBJECT *hNode, OUT struct DSP_MSG *pMsg,
 	/* If processor is in error state then don't attempt to get the
 	    message */
 	if (procStatus.iState == PROC_ERROR) {
-		GT_1trace(NODE_debugMask, GT_4CLASS, "NODE_GetMessage:"
-			"		proc Status 0x%x\n", procStatus.iState);
 		status = DSP_EFAIL;
 		goto func_end;
 	}
@@ -1893,13 +1847,9 @@ DSP_STATUS NODE_GetMessage(struct NODE_OBJECT *hNode, OUT struct DSP_MSG *pMsg,
 			pMsg->dwArg1 = (u32) pTmpBuf;
 			pMsg->dwArg2 *= hNode->hNodeMgr->uDSPWordSize;
 		} else {
-			GT_0trace(NODE_debugMask, GT_7CLASS, "NODE_GetMessage: "
-				 "Failed SM translation!\n");
 			status = DSP_ETRANSLATE;
 		}
 	} else {
-		GT_0trace(NODE_debugMask, GT_7CLASS, "NODE_GetMessage: Failed "
-			 "SM Pa/Pa translation!\n");
 		status = DSP_ETRANSLATE;
 	}
 func_end:
@@ -2103,9 +2053,6 @@ DSP_STATUS NODE_Pause(struct NODE_OBJECT *hNode)
 			/* If processor is in error state then don't attempt
 			    to send the message */
 			if (procStatus.iState == PROC_ERROR) {
-				GT_1trace(NODE_debugMask, GT_4CLASS,
-					"NODE_Pause: proc Status 0x%x\n",
-					procStatus.iState);
 				status = DSP_EFAIL;
 				goto func_cont;
 			}
@@ -2117,13 +2064,8 @@ DSP_STATUS NODE_Pause(struct NODE_OBJECT *hNode)
 			}
 
 			/* Update state */
-			if (DSP_SUCCEEDED(status)) {
+			if (DSP_SUCCEEDED(status))
 				NODE_SetState(hNode, NODE_PAUSED);
-			} else {
-				GT_1trace(NODE_debugMask, GT_6CLASS,
-					 "NODE_Pause: Failed. hNode:"
-					 " 0x%x\n", hNode);
-			}
 		}
 func_cont:
 		/* End of SYNC_EnterCS */
@@ -2176,8 +2118,6 @@ DSP_STATUS NODE_PutMessage(struct NODE_OBJECT *hNode,
 	/* If processor is in bad state then don't attempt sending the
 	    message */
 	if (procStatus.iState == PROC_ERROR) {
-		GT_1trace(NODE_debugMask, GT_4CLASS, "NODE_PutMessage:"
-			"		proc Status 0x%x\n", procStatus.iState);
 		status = DSP_EFAIL;
 		goto func_end;
 	}
@@ -2230,9 +2170,6 @@ DSP_STATUS NODE_PutMessage(struct NODE_OBJECT *hNode,
 				status = DSP_EFAIL;	/* bad DSPWordSize */
 			}
 		} else {	/* failed to translate buffer address */
-			GT_0trace(NODE_debugMask, GT_7CLASS,
-				 "NODE_PutMessage: Failed to"
-				 " translate SM address\n");
 			status = DSP_ETRANSLATE;
 		}
 	}
@@ -2334,8 +2271,6 @@ DSP_STATUS NODE_Run(struct NODE_OBJECT *hNode)
 		goto func_end;
 	/* If processor is in error state then don't attempt to run the node */
 	if (procStatus.iState == PROC_ERROR) {
-		GT_1trace(NODE_debugMask, GT_4CLASS, "NODE_Run:"
-			"		proc Status 0x%x\n", procStatus.iState);
 		status = DSP_EFAIL;
 		goto func_end;
 	}
@@ -2453,9 +2388,7 @@ DSP_STATUS NODE_Terminate(struct NODE_OBJECT *hNode, OUT DSP_STATUS *pStatus)
 		goto func_end;
 	}
 	if (pNode->hProcessor == NULL) {
-		GT_1trace(NODE_debugMask, GT_4CLASS,
-		"NODE_Terminate: pNode->hProcessor = 0x%x\n",
-		pNode->hProcessor);
+		status = DSP_EHANDLE;
 		goto func_end;
 	}
 	status = PROC_GetProcessorId(pNode->hProcessor, &procId);
@@ -2498,8 +2431,6 @@ DSP_STATUS NODE_Terminate(struct NODE_OBJECT *hNode, OUT DSP_STATUS *pStatus)
 		/* If processor is in error state then don't attempt to send
 		 * A kill task command */
 		if (procStatus.iState == PROC_ERROR) {
-			GT_1trace(NODE_debugMask, GT_4CLASS, "NODE_Terminate:"
-				" proc Status 0x%x\n", procStatus.iState);
 			status = DSP_EFAIL;
 			goto func_cont;
 		}
@@ -2655,18 +2586,10 @@ static void DeleteNode(struct NODE_OBJECT *hNode,
 			status = PROC_UnMap(hNode->hProcessor,
 					   (void *)taskArgs.uDSPHeapAddr,
 					   pr_ctxt);
-			if (DSP_FAILED(status))
-				GT_1trace(NODE_debugMask, GT_5CLASS,
-					 "DSPProcessor_UnMap failed."
-					 " Status = 0x%x\n", (u32)status);
 
 			status = PROC_UnReserveMemory(hNode->hProcessor,
 					(void *)taskArgs.uDSPHeapResAddr);
-			if (DSP_FAILED(status))
-				GT_1trace(NODE_debugMask, GT_5CLASS,
-					 "DSPProcessor_UnReserveMemory "
-					 "failed. Status = 0x%x\n",
-					 (u32)status);
+
 #ifdef DSP_DMM_DEBUG
 			status = DMM_GetHandle(pProcObject, &hDmmMgr);
 			if (DSP_SUCCEEDED(status))
@@ -3119,9 +3042,6 @@ DSP_STATUS NODE_GetUUIDProps(DSP_HPROCESSOR hProcessor,
 	/* If processor is in error state then don't attempt
 	    to send the message */
 	if (procStatus.iState == PROC_ERROR) {
-		GT_1trace(NODE_debugMask, GT_5CLASS,
-			"NODE_GetUUIDProps: proc Status 0x%x\n",
-			procStatus.iState);
 		status = DSP_EFAIL;
 		goto func_end;
 	}
diff --git a/drivers/dsp/bridge/rmgr/proc.c b/drivers/dsp/bridge/rmgr/proc.c
index f451244..ed42a47 100644
--- a/drivers/dsp/bridge/rmgr/proc.c
+++ b/drivers/dsp/bridge/rmgr/proc.c
@@ -136,37 +136,16 @@ PROC_Attach(u32 uProcessor, OPTIONAL CONST struct DSP_PROCESSORATTRIN *pAttrIn,
 
 	/* Get the Driver and Manager Object Handles */
 	status = CFG_GetObject((u32 *)&hDrvObject, REG_DRV_OBJECT);
-	if (DSP_SUCCEEDED(status)) {
+	if (DSP_SUCCEEDED(status))
 		status = CFG_GetObject((u32 *)&hMgrObject, REG_MGR_OBJECT);
-		if (DSP_FAILED(status)) {
-			/* don't propogate CFG errors from this PROC function */
-			GT_1trace(PROC_DebugMask, GT_7CLASS,
-				 "PROC_Attach: DSP_FAILED to get"
-				 "the Manager Object.\n", status);
-		}
-	} else {
-		/* don't propogate CFG errors from this PROC function */
-		GT_1trace(PROC_DebugMask, GT_7CLASS,
-			 "PROC_Attach: failed to get the"
-			 " DriverObject, 0x%x!\n", status);
-	}
+
 	if (DSP_SUCCEEDED(status)) {
 		/* Get the Device Object */
 		status = DRV_GetDevObject(uProcessor, hDrvObject, &hDevObject);
-		if (DSP_FAILED(status)) {
-			GT_1trace(PROC_DebugMask, GT_7CLASS,
-				 "PROC_Attach: failed to get"
-				 " DevObject, 0x%x!\n", status);
-		}
 	}
-	if (DSP_SUCCEEDED(status)) {
+	if (DSP_SUCCEEDED(status))
 		status = DEV_GetDevType(hDevObject, &devType);
-		if (DSP_FAILED(status)) {
-			GT_1trace(PROC_DebugMask, GT_7CLASS,
-				 "PROC_Attach: failed to get"
-				 " DevType, 0x%x!\n", status);
-		}
-	}
+
 	if (DSP_FAILED(status))
 		goto func_end;
 
@@ -174,8 +153,6 @@ PROC_Attach(u32 uProcessor, OPTIONAL CONST struct DSP_PROCESSORATTRIN *pAttrIn,
 	MEM_AllocObject(pProcObject, struct PROC_OBJECT, PROC_SIGNATURE);
 	/* Fill out the Processor Object: */
 	if (pProcObject == NULL) {
-		GT_0trace(PROC_DebugMask, GT_7CLASS,
-			 "PROC_Attach:Out of memeory \n");
 		status = DSP_EMEMORY;
 		goto func_end;
 	}
@@ -196,18 +173,11 @@ PROC_Attach(u32 uProcessor, OPTIONAL CONST struct DSP_PROCESSORATTRIN *pAttrIn,
 	if (DSP_SUCCEEDED(status)) {
 		status = DEV_GetWMDContext(hDevObject,
 					 &pProcObject->hWmdContext);
-		if (DSP_FAILED(status)) {
-			GT_1trace(PROC_DebugMask, GT_7CLASS,
-				 "PROC_Attach Could not"
-				 " get the WMD Context.\n", status);
+		if (DSP_FAILED(status))
 			MEM_FreeObject(pProcObject);
-		}
-	} else {
-		GT_1trace(PROC_DebugMask, GT_7CLASS,
-			 "PROC_Attach Could not get"
-			 " the DEV_ Interface fxns.\n", status);
+	} else
 		MEM_FreeObject(pProcObject);
-	}
+
 	if (DSP_FAILED(status))
 		goto func_end;
 
@@ -233,9 +203,6 @@ PROC_Attach(u32 uProcessor, OPTIONAL CONST struct DSP_PROCESSORATTRIN *pAttrIn,
 				NTFY_Delete(pProcObject->hNtfy);
 
 			MEM_FreeObject(pProcObject);
-			GT_1trace(PROC_DebugMask, GT_7CLASS,
-				 "PROC_Attach: failed to insert "
-				 "Proc Object into DEV, 0x%x!\n", status);
 		}
 		if (DSP_SUCCEEDED(status)) {
 			*phProcessor = (DSP_HPROCESSOR)pProcObject;
@@ -245,9 +212,6 @@ PROC_Attach(u32 uProcessor, OPTIONAL CONST struct DSP_PROCESSORATTRIN *pAttrIn,
 		}
 	} else {
 		/* Don't leak memory if DSP_FAILED */
-		GT_0trace(PROC_DebugMask, GT_7CLASS,
-			 "PROC_Attach: Could not allocate "
-			 "storage for notification \n");
 		MEM_FreeObject(pProcObject);
 	}
 func_end:
@@ -312,17 +276,11 @@ DSP_STATUS PROC_AutoStart(struct CFG_DEVNODE *hDevNode,
 
 	/* Create a Dummy PROC Object */
 	status = CFG_GetObject((u32 *)&hMgrObject, REG_MGR_OBJECT);
-	if (DSP_FAILED(status)) {
-		GT_0trace(PROC_DebugMask, GT_7CLASS,
-			 "PROC_AutoStart: DSP_FAILED to "
-			 "Get MGR Object\n");
+	if (DSP_FAILED(status))
 		goto func_end;
-	}
+
 	MEM_AllocObject(pProcObject, struct PROC_OBJECT, PROC_SIGNATURE);
 	if (pProcObject == NULL) {
-		GT_0trace(PROC_DebugMask, GT_7CLASS,
-			 "PROC_AutoStart: DSP_FAILED "
-			 "to Create a dummy Processor\n");
 		status = DSP_EMEMORY;
 		goto func_end;
 	}
@@ -333,17 +291,11 @@ DSP_STATUS PROC_AutoStart(struct CFG_DEVNODE *hDevNode,
 	if (DSP_SUCCEEDED(status)) {
 		status = DEV_GetWMDContext(hDevObject,
 					&pProcObject->hWmdContext);
-		if (DSP_FAILED(status)) {
+		if (DSP_FAILED(status))
 			MEM_FreeObject(hProcObject);
-			GT_0trace(PROC_DebugMask, GT_7CLASS,
-				 "PROC_AutoStart: Failed "
-				 "to get WMD Context \n");
-		}
+
 	} else {
 		MEM_FreeObject(hProcObject);
-		GT_0trace(PROC_DebugMask, GT_7CLASS,
-			 "PROC_AutoStart: Failed to "
-			 "get IntFxns \n");
 	}
 	if (DSP_FAILED(status))
 		goto func_cont;
@@ -357,9 +309,6 @@ DSP_STATUS PROC_AutoStart(struct CFG_DEVNODE *hDevNode,
 	status = CFG_GetAutoStart(hDevNode, &dwAutoStart);
 	if (DSP_FAILED(status) || !dwAutoStart) {
 		status = DSP_EFAIL;
-		/* DSP_FAILED to Get s32 Fxn or Wmd Context */
-		GT_0trace(PROC_DebugMask, GT_1CLASS, "PROC_AutoStart: "
-			 "CFG_GetAutoStart DSP_FAILED \n");
 		goto func_cont;
 	}
 	/* Get the default executable for this board... */
@@ -372,20 +321,8 @@ DSP_STATUS PROC_AutoStart(struct CFG_DEVNODE *hDevNode,
 		argv[1] = NULL;
 		/* ...and try to load it: */
 		status = PROC_Load(hProcObject, 1, (CONST char **)argv, NULL);
-		if (DSP_SUCCEEDED(status)) {
+		if (DSP_SUCCEEDED(status))
 			status = PROC_Start(hProcObject);
-			if (DSP_FAILED(status)) {
-				GT_0trace(PROC_DebugMask, GT_7CLASS,
-					  "PROC_AutoStart: DSP_FAILED To "
-					  "Start \n");
-			}
-		} else {
-			GT_0trace(PROC_DebugMask, GT_7CLASS,
-				  "PROC_AutoStart: DSP_FAILED to Load\n");
-		}
-	} else {
-		GT_0trace(PROC_DebugMask, GT_7CLASS, "PROC_AutoStart: "
-			 "No Exec file found \n");
 	}
 func_cont:
 	kfree(hProcObject->g_pszLastCoff);
@@ -443,13 +380,9 @@ DSP_STATUS PROC_Ctrl(DSP_HPROCESSOR hProcessor, u32 dwCmd,
 			status = DSP_SOK;
 		} else {
 			status = DSP_EFAIL;
-			GT_0trace(PROC_DebugMask, GT_7CLASS,
-				 "PROC_Ctrl: Failed \n");
 		}
 	} else {
 		status = DSP_EHANDLE;
-		GT_0trace(PROC_DebugMask, GT_7CLASS,
-			 "PROC_Ctrl: InValid Processor Handle \n");
 	}
 
 	return status;
@@ -487,8 +420,6 @@ DSP_STATUS PROC_Detach(struct PROCESS_CONTEXT *pr_ctxt)
 		pr_ctxt->hProcessor = NULL;
 	} else {
 		status = DSP_EHANDLE;
-		GT_0trace(PROC_DebugMask, GT_7CLASS,
-			 "PROC_Detach: InValid Processor Handle \n");
 	}
 
 	return status;
@@ -525,8 +456,6 @@ DSP_STATUS PROC_EnumNodes(DSP_HPROCESSOR hProcessor, OUT DSP_HNODE *aNodeTab,
 		}
 	} else {
 		status = DSP_EHANDLE;
-		GT_0trace(PROC_DebugMask, GT_7CLASS, "PROC_EnumNodes: "
-			 "InValid Processor Handle \n");
 	}
 
 	return status;
@@ -615,8 +544,6 @@ static DSP_STATUS proc_memory_sync(DSP_HPROCESSOR hProcessor, void *pMpuAddr,
 	DBC_Require(cRefs > 0);
 
 	if (!MEM_IsValidHandle(pProcObject, PROC_SIGNATURE)) {
-		GT_1trace(PROC_DebugMask, GT_7CLASS,
-			  "%s: InValid Processor Handle\n", __func__);
 		status = DSP_EHANDLE;
 		goto err_out;
 	}
@@ -684,9 +611,6 @@ DSP_STATUS PROC_GetResourceInfo(DSP_HPROCESSOR hProcessor, u32 uResourceType,
 
 	if (!MEM_IsValidHandle(pProcObject, PROC_SIGNATURE)) {
 		status = DSP_EHANDLE;
-		GT_0trace(PROC_DebugMask, GT_7CLASS,
-			 "PROC_GetResourceInfo: InValid "
-			 "Processor Handle \n");
 		goto func_end;
 	}
 	switch (uResourceType) {
@@ -718,9 +642,6 @@ DSP_STATUS PROC_GetResourceInfo(DSP_HPROCESSOR hProcessor, u32 uResourceType,
 			status = pProcObject->pIntfFxns->pfnIOGetProcLoad(
 				hIOMgr, (struct DSP_PROCLOADSTAT *)&
 				(pResourceInfo->result.procLoadStat));
-		if (DSP_FAILED(status))
-			GT_1trace(PROC_DebugMask, GT_7CLASS,
-			"Error in procLoadStat function 0x%x\n", status);
 		break;
 	default:
 		status = DSP_EFAIL;
@@ -820,30 +741,14 @@ DSP_STATUS PROC_GetState(DSP_HPROCESSOR hProcessor,
 				status = DSP_EFAIL;
 				break;
 			}
-		} else {
-			GT_0trace(PROC_DebugMask, GT_7CLASS,
-				 "PROC_GetState: General Failure"
-				 " to read the PROC Status \n");
 		}
 		/* Next, retrieve error information, if any */
 		status = DEV_GetDehMgr(pProcObject->hDevObject, &hDehMgr);
-		if (DSP_SUCCEEDED(status) && hDehMgr) {
+		if (DSP_SUCCEEDED(status) && hDehMgr)
 			status = (*pProcObject->pIntfFxns->pfnDehGetInfo)
 				 (hDehMgr, &(pProcStatus->errInfo));
-			if (DSP_FAILED(status)) {
-				GT_0trace(PROC_DebugMask, GT_7CLASS,
-					 "PROC_GetState: Failed "
-					 "retrieve exception info.\n");
-			}
-		} else {
-			GT_0trace(PROC_DebugMask, GT_7CLASS,
-				 "PROC_GetState: Failed to "
-				 "retrieve DEH handle.\n");
-		}
 	} else {
 		status = DSP_EHANDLE;
-		GT_0trace(PROC_DebugMask, GT_7CLASS,
-			 "PROC_GetState:InValid Processor Handle \n");
 	}
 	GT_2trace(PROC_DebugMask, GT_ENTER,
 		 "Exiting PROC_GetState, results:\n\t"
@@ -947,33 +852,21 @@ DSP_STATUS PROC_Load(DSP_HPROCESSOR hProcessor, IN CONST s32 iArgc,
 	/* Call the WMD_BRD_Load Fxn */
 	if (!MEM_IsValidHandle(pProcObject, PROC_SIGNATURE)) {
 		status = DSP_EHANDLE;
-		GT_0trace(PROC_DebugMask, GT_1CLASS,
-			 "PROC_Load: Invalid Processor Handle..\n");
 		goto func_end;
 	}
 	if (DSP_FAILED(DEV_GetCodMgr(pProcObject->hDevObject, &hCodMgr))) {
 		status = DSP_EFAIL;
-		GT_1trace(PROC_DebugMask, GT_7CLASS, "PROC_Load: DSP_FAILED in "
-			 "DEV_GetCodMgr status 0x%x \n", status);
 		goto func_end;
 	}
 	status = PROC_Stop(hProcessor);
-	if (DSP_FAILED(status)) {
-		GT_1trace(PROC_DebugMask, GT_7CLASS,
-			 "PROC_Load: DSP_FAILED to Place the"
-			 " Processor in Stop Mode(PROC_STOP) status 0x%x \n",
-			 status);
+	if (DSP_FAILED(status))
 		goto func_end;
-	}
+
 	/* Place the board in the monitor state. */
 	status = PROC_Monitor(hProcessor);
-	if (DSP_FAILED(status)) {
-		GT_1trace(PROC_DebugMask, GT_7CLASS,
-			 "PROC_Load: DSP_FAILED to Place the"
-			 " Processor in Monitor Mode(PROC_IDLE) status 0x%x\n",
-			 status);
+	if (DSP_FAILED(status))
 		goto func_end;
-	}
+
 	/* Save ptr to  original argv[0]. */
 	pargv0 = (char *)aArgv[0];
 	/*Prepend "PROC_ID=<nProcID>"to envp array for target.*/
@@ -1013,15 +906,8 @@ DSP_STATUS PROC_Load(DSP_HPROCESSOR hProcessor, IN CONST s32 iArgc,
 			/* On success, do COD_OpenBase() */
 			status = COD_OpenBase(hCodMgr, (char *)aArgv[0],
 					     COD_SYMB);
-			if (DSP_FAILED(status)) {
-				GT_1trace(PROC_DebugMask, GT_7CLASS,
-					 "PROC_Load: COD_OpenBase "
-					 "failed (0x%x)\n", status);
-			}
 		}
 	} else {
-		GT_0trace(PROC_DebugMask, GT_7CLASS,
-			 " PROC_Load:Out of Memory \n");
 		status = DSP_EMEMORY;
 	}
 	if (DSP_SUCCEEDED(status)) {
@@ -1036,17 +922,11 @@ DSP_STATUS PROC_Load(DSP_HPROCESSOR hProcessor, IN CONST s32 iArgc,
 			 *  save the name of the COFF file for
 			 *  de-registration in the future.  */
 			status = DCD_AutoRegister(hDCDHandle, (char *)aArgv[0]);
-			if (status == DSP_EDCDNOAUTOREGISTER) {
-				GT_0trace(PROC_DebugMask, GT_7CLASS,
-					  "PROC_Load: No Auto "
-					  "Register section.  Proceeding..\n");
+			if (status == DSP_EDCDNOAUTOREGISTER)
 				status = DSP_SOK;
-			}
+
 			if (DSP_FAILED(status)) {
 				status = DSP_EFAIL;
-				GT_0trace(PROC_DebugMask, GT_7CLASS,
-					  "PROC_Load: Failed to "
-					  "Auto Register..\n");
 			} else {
 				DBC_Assert(pProcObject->g_pszLastCoff == NULL);
 				/* Allocate memory for pszLastCoff */
@@ -1079,16 +959,6 @@ DSP_STATUS PROC_Load(DSP_HPROCESSOR hProcessor, IN CONST s32 iArgc,
 		status = DEV_GetIOMgr(pProcObject->hDevObject, &hIOMgr);
 		DBC_Assert(DSP_SUCCEEDED(status));
 		status = (*pProcObject->pIntfFxns->pfnIOOnLoaded)(hIOMgr);
-		if (DSP_FAILED(status))
-			GT_1trace(PROC_DebugMask, GT_7CLASS,
-				  "PROC_Load: Failed to get shared "
-				  "memory or message buffer address "
-				  "from COFF status 0x%x\n", status);
-
-	} else {
-		GT_1trace(PROC_DebugMask, GT_7CLASS,
-			  "PROC_Load: DSP_FAILED in "
-			  "MSG_Create status 0x%x\n", status);
 	}
 	if (DSP_SUCCEEDED(status)) {
 		/* Now, attempt to load an exec: */
@@ -1109,10 +979,6 @@ DSP_STATUS PROC_Load(DSP_HPROCESSOR hProcessor, IN CONST s32 iArgc,
 			if (status == COD_E_SYMBOLNOTFOUND) {
 				GT_0trace(PROC_DebugMask, GT_7CLASS,
 					"PROC_Load:Could not parse the file\n");
-			} else {
-				GT_1trace(PROC_DebugMask, GT_7CLASS,
-					 "PROC_Load: DSP_FAILED in "
-					 "COD_Load  status 0x%x \n", status);
 			}
 		}
 	/* Requesting the lowest opp supported*/
@@ -1131,10 +997,6 @@ DSP_STATUS PROC_Load(DSP_HPROCESSOR hProcessor, IN CONST s32 iArgc,
 			if (pProcObject->hNtfy)
 				PROC_NotifyClients(pProcObject,
 						 DSP_PROCESSORSTATECHANGE);
-		} else {
-			GT_1trace(PROC_DebugMask, GT_7CLASS,
-				 "PROC_Load, pfnBrdSetState "
-				 "failed: 0x%x\n", status);
 		}
 	}
 	if (DSP_SUCCEEDED(status)) {
@@ -1142,16 +1004,10 @@ DSP_STATUS PROC_Load(DSP_HPROCESSOR hProcessor, IN CONST s32 iArgc,
 		if (uProcId == DSP_UNIT) {
 			/* Use all available DSP address space after EXTMEM
 			 * for DMM */
-			if (DSP_SUCCEEDED(status)) {
+			if (DSP_SUCCEEDED(status))
 				status = COD_GetSymValue(hCodMgr, EXTEND,
 								&dwExtEnd);
-				if (DSP_FAILED(status)) {
-					GT_1trace(PROC_DebugMask, GT_7CLASS,
-						 "PROC_Load: Failed on "
-						 "COD_GetSymValue %s.\n",
-						 EXTEND);
-				}
-			}
+
 			/* Reset DMM structs and add an initial free chunk*/
 			if (DSP_SUCCEEDED(status)) {
 				status = DEV_GetDmmMgr(pProcObject->hDevObject,
@@ -1236,20 +1092,14 @@ DSP_STATUS PROC_Map(DSP_HPROCESSOR hProcessor, void *pMpuAddr, u32 ulSize,
 
 	if (!MEM_IsValidHandle(pProcObject, PROC_SIGNATURE)) {
 		status = DSP_EHANDLE;
-		GT_0trace(PROC_DebugMask, GT_7CLASS, "PROC_Map: "
-			 "InValid Processor Handle \n");
 		goto func_end;
 	}
 	/* Critical section */
 	(void)SYNC_EnterCS(hProcLock);
 	status = DMM_GetHandle(pProcObject, &hDmmMgr);
-	if (DSP_FAILED(status)) {
-		GT_1trace(PROC_DebugMask, GT_7CLASS,
-			 "PROC_Map: Failed to get DMM Mgr "
-			 "handle: 0x%x\n", status);
-	} else {
+	if (DSP_SUCCEEDED(status))
 		status = DMM_MapMemory(hDmmMgr, vaAlign, sizeAlign);
-	}
+
 	/* Add mapping to the page tables. */
 	if (DSP_SUCCEEDED(status)) {
 
@@ -1295,9 +1145,6 @@ DSP_STATUS PROC_RegisterNotify(DSP_HPROCESSOR hProcessor, u32 uEventMask,
 	/* Check processor handle */
 	if (!MEM_IsValidHandle(pProcObject, PROC_SIGNATURE)) {
 		status = DSP_EHANDLE;
-		GT_1trace(PROC_DebugMask, GT_7CLASS,
-			 "PROC_RegsiterNotify Invalid "
-			 "ProcessorHandle 0x%x\n", hProcessor);
 		goto func_end;
 	}
 	/* Check if event mask is a valid processor related event */
@@ -1369,15 +1216,10 @@ DSP_STATUS PROC_ReserveMemory(DSP_HPROCESSOR hProcessor, u32 ulSize,
 		 ulSize, ppRsvAddr);
 	if (!MEM_IsValidHandle(pProcObject, PROC_SIGNATURE)) {
 		status = DSP_EHANDLE;
-		GT_0trace(PROC_DebugMask, GT_7CLASS, "PROC_Map: "
-			 "InValid Processor Handle \n");
 		goto func_end;
 	}
 	status = DMM_GetHandle(pProcObject, &hDmmMgr);
-	if (DSP_FAILED(status)) {
-		GT_1trace(PROC_DebugMask, GT_7CLASS, "PROC_ReserveMemory: "
-			 "Failed to get DMM Mgr handle: 0x%x\n", status);
-	} else
+	if (DSP_SUCCEEDED(status))
 		status = DMM_ReserveMemory(hDmmMgr, ulSize, (u32 *)ppRsvAddr);
 
 	GT_1trace(PROC_DebugMask, GT_ENTER, "Leaving PROC_ReserveMemory [0x%x]",
@@ -1403,38 +1245,26 @@ DSP_STATUS PROC_Start(DSP_HPROCESSOR hProcessor)
 	DBC_Require(cRefs > 0);
 	if (!MEM_IsValidHandle(pProcObject, PROC_SIGNATURE)) {
 		status = DSP_EHANDLE;
-		GT_0trace(PROC_DebugMask, GT_7CLASS,
-			 "PROC_Start :InValid Handle \n");
 		goto func_end;
 	}
 	/* Call the WMD_BRD_Start */
 	if (pProcObject->sState != PROC_LOADED) {
-		GT_0trace(PROC_DebugMask, GT_7CLASS,
-			 "PROC_Start :Wrong state \n");
 		status = DSP_EWRONGSTATE;
 		goto func_end;
 	}
 	status = DEV_GetCodMgr(pProcObject->hDevObject, &hCodMgr);
-	if (DSP_FAILED(status)) {
-		GT_1trace(PROC_DebugMask, GT_7CLASS,
-			 "Processor Start DSP_FAILED "
-			 "in Getting DEV_GetCodMgr status 0x%x\n", status);
+	if (DSP_FAILED(status))
 		goto func_cont;
-	}
+
 	status = COD_GetEntry(hCodMgr, &dwDspAddr);
-	if (DSP_FAILED(status)) {
-		GT_1trace(PROC_DebugMask, GT_7CLASS,
-			 "Processor Start  DSP_FAILED in "
-			 "Getting COD_GetEntry status 0x%x\n", status);
+	if (DSP_FAILED(status))
 		goto func_cont;
-	}
+
 	status = (*pProcObject->pIntfFxns->pfnBrdStart)
 		 (pProcObject->hWmdContext, dwDspAddr);
-	if (DSP_FAILED(status)) {
-		GT_0trace(PROC_DebugMask, GT_7CLASS,
-			 "PROC_Start Failed to Start the board\n");
+	if (DSP_FAILED(status))
 		goto func_cont;
-	}
+
 	/* Call DEV_Create2 */
 	status = DEV_Create2(pProcObject->hDevObject);
 	if (DSP_SUCCEEDED(status)) {
@@ -1453,8 +1283,6 @@ DSP_STATUS PROC_Start(DSP_HPROCESSOR hProcessor)
 		(void)(*pProcObject->pIntfFxns->pfnBrdStop)(pProcObject->
 			hWmdContext);
 		pProcObject->sState = PROC_STOPPED;
-		GT_0trace(PROC_DebugMask, GT_7CLASS, "PROC_Start "
-			 "Failed to Create the Node Manager\n");
 	}
 func_cont:
 #ifdef CONFIG_BRIDGE_DEBUG
@@ -1493,8 +1321,6 @@ DSP_STATUS PROC_Stop(DSP_HPROCESSOR hProcessor)
 	DBC_Require(cRefs > 0);
 	if (!MEM_IsValidHandle(pProcObject, PROC_SIGNATURE)) {
 		status = DSP_EHANDLE;
-		GT_0trace(PROC_DebugMask, GT_7CLASS,
-			 "PROC_Stop :InValid Handle \n");
 		goto func_end;
 	}
 	if (DSP_SUCCEEDED((*pProcObject->pIntfFxns->pfnBrdStatus)
@@ -1537,9 +1363,6 @@ DSP_STATUS PROC_Stop(DSP_HPROCESSOR hProcessor)
 			   &uBrdState)))
 				DBC_Assert(uBrdState == BRD_STOPPED);
 #endif
-		} else {
-			GT_0trace(PROC_DebugMask, GT_7CLASS,
-				 "PROC_Stop Couldn't delete node manager \n");
 		}
 	} else {
 		GT_0trace(PROC_DebugMask, GT_7CLASS,
@@ -1573,17 +1396,12 @@ DSP_STATUS PROC_UnMap(DSP_HPROCESSOR hProcessor, void *pMapAddr,
 	vaAlign = PG_ALIGN_LOW((u32) pMapAddr, PG_SIZE_4K);
 	if (!MEM_IsValidHandle(pProcObject, PROC_SIGNATURE)) {
 		status = DSP_EHANDLE;
-		GT_0trace(PROC_DebugMask, GT_7CLASS, "PROC_UnMap: "
-			 "InValid Processor Handle \n");
 		goto func_end;
 	}
 
 	status = DMM_GetHandle(hProcessor, &hDmmMgr);
-	if (DSP_FAILED(status)) {
-		GT_1trace(PROC_DebugMask, GT_7CLASS, "PROC_UnMap: "
-			"Failed to get DMM Mgr handle: 0x%x\n", status);
+	if (DSP_FAILED(status))
 		goto func_end;
-	}
 
 	/* Critical section */
 	(void)SYNC_EnterCS(hProcLock);
@@ -1626,16 +1444,10 @@ DSP_STATUS PROC_UnReserveMemory(DSP_HPROCESSOR hProcessor, void *pRsvAddr)
 		 "hProcessor: 0x%x pRsvAddr: 0x%x\n", hProcessor, pRsvAddr);
 	if (!MEM_IsValidHandle(pProcObject, PROC_SIGNATURE)) {
 		status = DSP_EHANDLE;
-		GT_0trace(PROC_DebugMask, GT_7CLASS, "PROC_UnMap: "
-			 "InValid Processor Handle \n");
 		goto func_end;
 	}
 	status = DMM_GetHandle(pProcObject, &hDmmMgr);
-	if (DSP_FAILED(status))
-		GT_1trace(PROC_DebugMask, GT_7CLASS,
-			 "PROC_UnReserveMemory: Failed to get DMM Mgr "
-			 "handle: 0x%x\n", status);
-	else
+	if (DSP_SUCCEEDED(status))
 		status = DMM_UnReserveMemory(hDmmMgr, (u32) pRsvAddr);
 
 	GT_1trace(PROC_DebugMask, GT_ENTER,
@@ -1694,12 +1506,6 @@ static DSP_STATUS PROC_Monitor(struct PROC_OBJECT *hProcObject)
 		   (pProcObject->hWmdContext, &uBrdState)))
 			DBC_Assert(uBrdState == BRD_IDLE);
 #endif
-
-	} else {
-		/* Monitor Failure */
-		GT_0trace(PROC_DebugMask, GT_7CLASS,
-			 "PROC_Monitor: Processor Could not"
-			 "be put in Monitor mode \n");
 	}
 
 #ifdef CONFIG_BRIDGE_DEBUG
@@ -1770,8 +1576,6 @@ DSP_STATUS PROC_NotifyClients(DSP_HPROCESSOR hProc, u32 uEvents)
 	DBC_Require(cRefs > 0);
 	if (!MEM_IsValidHandle(pProcObject, PROC_SIGNATURE)) {
 		status = DSP_EHANDLE;
-		GT_0trace(PROC_DebugMask, GT_7CLASS, "PROC_NotifyClients: "
-			 "InValid Processor Handle \n");
 		goto func_end;
 	}
 
@@ -1796,8 +1600,6 @@ DSP_STATUS PROC_NotifyAllClients(DSP_HPROCESSOR hProc, u32 uEvents)
 
 	if (!MEM_IsValidHandle(pProcObject, PROC_SIGNATURE)) {
 		status = DSP_EHANDLE;
-		GT_0trace(PROC_DebugMask, GT_7CLASS, "PROC_NotifyAllClients: "
-			 "InValid Processor Handle \n");
 		goto func_end;
 	}
 
@@ -1819,11 +1621,9 @@ DSP_STATUS PROC_GetProcessorId(DSP_HPROCESSOR hProc, u32 *procID)
 
 	if (MEM_IsValidHandle(pProcObject, PROC_SIGNATURE))
 		*procID = pProcObject->uProcessor;
-	else {
+	else
 		status = DSP_EHANDLE;
-		GT_0trace(PROC_DebugMask, GT_7CLASS, "PROC_GetProcessorId: "
-			 "InValid Processor Handle \n");
-	}
+
 	return status;
 }
 
diff --git a/drivers/dsp/bridge/rmgr/rmm.c b/drivers/dsp/bridge/rmgr/rmm.c
index be8017f..8cf66ce 100644
--- a/drivers/dsp/bridge/rmgr/rmm.c
+++ b/drivers/dsp/bridge/rmgr/rmm.c
@@ -189,11 +189,9 @@ DSP_STATUS RMM_create(struct RMM_TargetObj **pTarget,
 	/* Allocate DBL target object */
 	MEM_AllocObject(target, struct RMM_TargetObj, RMM_TARGSIGNATURE);
 
-	if (target == NULL) {
-		GT_0trace(RMM_debugMask, GT_6CLASS,
-			 "RMM_create: Memory allocation failed\n");
+	if (target == NULL)
 		status = DSP_EMEMORY;
-	}
+
 	if (DSP_FAILED(status))
 		goto func_cont;
 
@@ -205,8 +203,6 @@ DSP_STATUS RMM_create(struct RMM_TargetObj **pTarget,
 	target->freeList = MEM_Calloc(numSegs * sizeof(struct RMM_Header *),
 				     MEM_PAGED);
 	if (target->freeList == NULL) {
-		GT_0trace(RMM_debugMask, GT_6CLASS,
-			 "RMM_create: Memory allocation failed\n");
 		status = DSP_EMEMORY;
 	} else {
 		/* Allocate headers for each element on the free list */
@@ -215,9 +211,6 @@ DSP_STATUS RMM_create(struct RMM_TargetObj **pTarget,
 					MEM_Calloc(sizeof(struct RMM_Header),
 					MEM_PAGED);
 			if (target->freeList[i] == NULL) {
-				GT_0trace(RMM_debugMask, GT_6CLASS,
-					 "RMM_create: Memory "
-					 "allocation failed\n");
 				status = DSP_EMEMORY;
 				break;
 			}
@@ -226,8 +219,6 @@ DSP_STATUS RMM_create(struct RMM_TargetObj **pTarget,
 		target->segTab = MEM_Calloc(numSegs *
 				 sizeof(struct RMM_Segment), MEM_PAGED);
 		if (target->segTab == NULL) {
-			GT_0trace(RMM_debugMask, GT_6CLASS,
-				 "RMM_create: Memory allocation failed\n");
 			status = DSP_EMEMORY;
 		} else {
 			/* Initialize segment table and free list */
@@ -249,8 +240,6 @@ func_cont:
 		target->ovlyList = MEM_Calloc(sizeof(struct LST_LIST),
 			MEM_NONPAGED);
 		if (target->ovlyList == NULL) {
-			GT_0trace(RMM_debugMask, GT_6CLASS,
-				 "RMM_create: Memory allocation failed\n");
 			status = DSP_EMEMORY;
 		} else {
 			INIT_LIST_HEAD(&target->ovlyList->head);
diff --git a/drivers/dsp/bridge/rmgr/strm.c b/drivers/dsp/bridge/rmgr/strm.c
index 5d74819..52b796f 100644
--- a/drivers/dsp/bridge/rmgr/strm.c
+++ b/drivers/dsp/bridge/rmgr/strm.c
@@ -136,9 +136,6 @@ DSP_STATUS STRM_AllocateBuffer(struct STRM_OBJECT *hStrm, u32 uSize,
 		DBC_Assert(hStrm->hXlator != NULL);
 		(void)CMM_XlatorAllocBuf(hStrm->hXlator, &apBuffer[i], uSize);
 		if (apBuffer[i] == NULL) {
-			GT_0trace(STRM_debugMask, GT_7CLASS,
-				 "STRM_AllocateBuffer: "
-				 "DSP_FAILED to alloc shared memory.\n");
 			status = DSP_EMEMORY;
 			uAllocated = i;
 			break;
@@ -221,23 +218,17 @@ DSP_STATUS STRM_Create(OUT struct STRM_MGR **phStrmMgr, struct DEV_OBJECT *hDev)
 	*phStrmMgr = NULL;
 	/* Allocate STRM manager object */
 	MEM_AllocObject(pStrmMgr, struct STRM_MGR, STRMMGR_SIGNATURE);
-	if (pStrmMgr == NULL) {
+	if (pStrmMgr == NULL)
 		status = DSP_EMEMORY;
-		GT_0trace(STRM_debugMask, GT_6CLASS, "STRM_Create: "
-			 "MEM_AllocObject() failed!\n ");
-	} else {
+	else
 		pStrmMgr->hDev = hDev;
-	}
+
 	/* Get Channel manager and WMD function interface */
 	if (DSP_SUCCEEDED(status)) {
 		status = DEV_GetChnlMgr(hDev, &(pStrmMgr->hChnlMgr));
 		if (DSP_SUCCEEDED(status)) {
 			(void) DEV_GetIntfFxns(hDev, &(pStrmMgr->pIntfFxns));
 			DBC_Assert(pStrmMgr->pIntfFxns != NULL);
-		} else {
-			GT_1trace(STRM_debugMask, GT_6CLASS, "STRM_Create: "
-				 "Failed to get channel manager! status = "
-				 "0x%x\n", status);
 		}
 	}
 	if (DSP_SUCCEEDED(status))
@@ -307,12 +298,8 @@ DSP_STATUS STRM_FreeBuffer(struct STRM_OBJECT *hStrm, u8 **apBuffer,
 		for (i = 0; i < uNumBufs; i++) {
 			DBC_Assert(hStrm->hXlator != NULL);
 			status = CMM_XlatorFreeBuf(hStrm->hXlator, apBuffer[i]);
-			if (DSP_FAILED(status)) {
-				GT_0trace(STRM_debugMask, GT_7CLASS,
-					 "STRM_FreeBuffer: DSP_FAILED"
-					 " to free shared memory.\n");
+			if (DSP_FAILED(status))
 				break;
-			}
 			apBuffer[i] = NULL;
 		}
 	}
@@ -524,8 +511,6 @@ DSP_STATUS STRM_Open(struct NODE_OBJECT *hNode, u32 uDir, u32 uIndex,
 		MEM_AllocObject(pStrm, struct STRM_OBJECT, STRM_SIGNATURE);
 		if (pStrm == NULL) {
 			status = DSP_EMEMORY;
-			GT_0trace(STRM_debugMask, GT_6CLASS,
-				 "STRM_Open: MEM_AllocObject() failed!\n ");
 		} else {
 			pStrm->hStrmMgr = hStrmMgr;
 			pStrm->uDir = uDir;
@@ -575,27 +560,15 @@ DSP_STATUS STRM_Open(struct NODE_OBJECT *hNode, u32 uDir, u32 uIndex,
 	DBC_Assert(pStrm->lMode != STRMMODE_LDMA);	/* no System DMA */
 	/* Get the shared mem mgr for this streams dev object */
 	status = DEV_GetCmmMgr(hStrmMgr->hDev, &hCmmMgr);
-	if (DSP_FAILED(status)) {
-		GT_1trace(STRM_debugMask, GT_6CLASS, "STRM_Open: Failed to get "
-			 "CMM Mgr handle: 0x%x\n", status);
-	} else {
+	if (DSP_SUCCEEDED(status)) {
 		/*Allocate a SM addr translator for this strm.*/
 		status = CMM_XlatorCreate(&pStrm->hXlator, hCmmMgr, NULL);
-		if (DSP_FAILED(status)) {
-			GT_1trace(STRM_debugMask, GT_6CLASS,
-				 "STRM_Open: Failed to "
-				 "create SM translator: 0x%x\n", status);
-		} else {
+		if (DSP_SUCCEEDED(status)) {
 			DBC_Assert(pStrm->uSegment > 0);
 			/*  Set translators Virt Addr attributes */
 			status = CMM_XlatorInfo(pStrm->hXlator,
 				 (u8 **)&pAttr->pVirtBase, pAttr->ulVirtSize,
 				 pStrm->uSegment, true);
-			if (status != DSP_SOK) {
-				GT_0trace(STRM_debugMask, GT_6CLASS,
-					 "STRM_Open: ERROR: "
-					 "in setting CMM_XlatorInfo.\n");
-			}
 		}
 	}
 func_cont:
@@ -626,10 +599,6 @@ func_cont:
 					   status == CHNL_E_NOIORPS);
 				status = DSP_EFAIL;
 			}
-			GT_2trace(STRM_debugMask, GT_6CLASS,
-				  "STRM_Open: Channel open failed, "
-				  "chnl id = %d, status = 0x%x\n", ulChnlId,
-				  status);
 		}
 	}
 	if (DSP_SUCCEEDED(status))
@@ -679,11 +648,7 @@ DSP_STATUS STRM_Reclaim(struct STRM_OBJECT *hStrm, OUT u8 **pBufPtr,
 
 	status = (*pIntfFxns->pfnChnlGetIOC)(hStrm->hChnl, hStrm->uTimeout,
 		 &chnlIOC);
-	if (DSP_FAILED(status)) {
-		GT_1trace(STRM_debugMask, GT_6CLASS,
-			 "STRM_Reclaim: GetIOC failed! "
-			 "Status = 0x%x\n", status);
-	} else {
+	if (DSP_SUCCEEDED(status)) {
 		*pulBytes = chnlIOC.cBytes;
 		if (pulBufSize)
 			*pulBufSize = chnlIOC.cBufSize;
@@ -716,12 +681,9 @@ DSP_STATUS STRM_Reclaim(struct STRM_OBJECT *hStrm, OUT u8 **pBufPtr,
 				pTmpBuf = CMM_XlatorTranslate(hStrm->hXlator,
 					  pTmpBuf, CMM_PA2VA);
 			}
-			if (pTmpBuf == NULL) {
-				GT_0trace(STRM_debugMask, GT_7CLASS,
-					 "STRM_Reclaim: Failed "
-					 "SM translation!\n");
+			if (pTmpBuf == NULL)
 				status = DSP_ETRANSLATE;
-			}
+
 			chnlIOC.pBuf = pTmpBuf;
 		}
 		*pBufPtr = chnlIOC.pBuf;
-- 
1.6.2.4

