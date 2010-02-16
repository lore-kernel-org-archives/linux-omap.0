From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 05/18] DSPBRIDGE: Remove debug statements for success in rmgr
Date: Tue, 16 Feb 2010 02:42:15 -0600
Message-ID: <1266309748-11714-6-git-send-email-omar.ramirez@ti.com>
References: <1266309748-11714-1-git-send-email-omar.ramirez@ti.com>
 <1266309748-11714-2-git-send-email-omar.ramirez@ti.com>
 <1266309748-11714-3-git-send-email-omar.ramirez@ti.com>
 <1266309748-11714-4-git-send-email-omar.ramirez@ti.com>
 <1266309748-11714-5-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:57622 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755487Ab0BPIaG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Feb 2010 03:30:06 -0500
In-Reply-To: <1266309748-11714-5-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Ameya Palande <ameya.palande@nokia.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>, Nishanth Menon <nm@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>

This patch removes debug statements used to print a successful
status or printed during normal execution, as they just polute
the logs if trying to look for a failure.

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 drivers/dsp/bridge/rmgr/dbdcd.c         |   14 +-------
 drivers/dsp/bridge/rmgr/disp.c          |    6 +---
 drivers/dsp/bridge/rmgr/drv.c           |   45 +++--------------------
 drivers/dsp/bridge/rmgr/drv_interface.c |   17 ++-------
 drivers/dsp/bridge/rmgr/dspdrv.c        |    9 +----
 drivers/dsp/bridge/rmgr/mgr.c           |    2 -
 drivers/dsp/bridge/rmgr/node.c          |   60 ++++++-------------------------
 drivers/dsp/bridge/rmgr/proc.c          |   42 +++-------------------
 8 files changed, 29 insertions(+), 166 deletions(-)

diff --git a/drivers/dsp/bridge/rmgr/dbdcd.c b/drivers/dsp/bridge/rmgr/dbdcd.c
index 4e5e7f9..0a59a62 100644
--- a/drivers/dsp/bridge/rmgr/dbdcd.c
+++ b/drivers/dsp/bridge/rmgr/dbdcd.c
@@ -165,10 +165,6 @@ DSP_STATUS DCD_CreateManager(IN char *pszZlDllName,
 
 		/* Return handle to this DCD interface. */
 		*phDcdMgr = pDcdMgr;
-
-		GT_2trace(curTrace, GT_5CLASS,
-			 "DCD_CreateManager: pDcdMgr 0x%x, "
-			 " hCodMgr 0x%x", pDcdMgr, hCodMgr);
 	} else {
 		status = DSP_EMEMORY;
 
@@ -607,8 +603,6 @@ DSP_STATUS DCD_GetObjects(IN struct DCD_MANAGER *hDcdMgr, IN char *pszCoffPath,
 #endif
 	if (DSP_SUCCEEDED(status)) {
 		/* Compress DSP buffer to conform to PC format. */
-		GT_0trace(curTrace, GT_4CLASS,
-			 "Successfully read section !!\n");
 		if (strstr(pszCoffPath, "iva") == NULL) {
 			CompressBuf(pszCoffBuf, ulLen, DSPWORDSIZE);
 		} else {
@@ -637,14 +631,8 @@ DSP_STATUS DCD_GetObjects(IN struct DCD_MANAGER *hDcdMgr, IN char *pszCoffPath,
 			 *  2) Unregister found DCD object (when handle == NULL)
 			 *  3) Add overlay node.
 			 */
-			GT_1trace(curTrace, GT_4CLASS, "Registering objtype "
-				 "%d \n", cObjectType);
 			status = registerFxn(&dspUuid, cObjectType, handle);
-			if (DSP_SUCCEEDED(status)) {
-				GT_1trace(curTrace, GT_5CLASS,
-					 "DCD_GetObjects: status 0x%x\n",
-					 status);
-			} else {
+			if (DSP_FAILED(status)) {
 				GT_0trace(curTrace, GT_6CLASS,
 					 "DCD_GetObjects: "
 					 "registration() failed\n");
diff --git a/drivers/dsp/bridge/rmgr/disp.c b/drivers/dsp/bridge/rmgr/disp.c
index ac2af3c..4d7a2da 100644
--- a/drivers/dsp/bridge/rmgr/disp.c
+++ b/drivers/dsp/bridge/rmgr/disp.c
@@ -144,8 +144,7 @@ DSP_STATUS DISP_Create(OUT struct DISP_OBJECT **phDispObject,
 		goto func_cont;
 
 	status = DEV_GetDevType(hDevObject, &devType);
-	GT_1trace(DISP_DebugMask, GT_6CLASS, "DISP_Create: Creating DISP for "
-		 "device = 0x%x\n", devType);
+
 	if (DSP_FAILED(status))
 		goto func_cont;
 
@@ -330,9 +329,6 @@ DSP_STATUS DISP_NodeCreate(struct DISP_OBJECT *hDisp, struct NODE_OBJECT *hNode,
 
 	status = DEV_GetDevType(hDisp->hDevObject, &devType);
 
-	GT_1trace(DISP_DebugMask, GT_6CLASS, "DISP_Create: Creating DISP "
-		 "for device = 0x%x\n", devType);
-
 	if (DSP_FAILED(status))
 		goto func_end;
 
diff --git a/drivers/dsp/bridge/rmgr/drv.c b/drivers/dsp/bridge/rmgr/drv.c
index d3c5df8..dbe1581 100644
--- a/drivers/dsp/bridge/rmgr/drv.c
+++ b/drivers/dsp/bridge/rmgr/drv.c
@@ -148,25 +148,14 @@ static DSP_STATUS DRV_ProcFreeNodeRes(HANDLE hPCtxt)
 		pNodeList = pNodeList->next;
 		if (pNodeRes->nodeAllocated) {
 			nState = NODE_GetState(pNodeRes->hNode) ;
-			GT_1trace(curTrace, GT_5CLASS,
-				"DRV_ProcFreeNodeRes: Node state %x\n", nState);
 			if (nState <= NODE_DELETING) {
 				if ((nState == NODE_RUNNING) ||
 					(nState == NODE_PAUSED) ||
 					(nState == NODE_TERMINATING)) {
-					GT_1trace(curTrace, GT_5CLASS,
-					"Calling Node_Terminate for Node:"
-					" 0x%x\n", pNodeRes->hNode);
 					status = NODE_Terminate
 						(pNodeRes->hNode, &status);
-					GT_1trace(curTrace, GT_5CLASS,
-						 "Calling Node_Delete for Node:"
-						 " 0x%x\n", pNodeRes->hNode);
 					status = NODE_Delete(pNodeRes->hNode,
 							pCtxt);
-					GT_1trace(curTrace, GT_5CLASS,
-					"the status after the NodeDelete %x\n",
-					status);
 				} else if ((nState == NODE_ALLOCATED)
 					|| (nState == NODE_CREATED))
 					status = NODE_Delete(pNodeRes->hNode,
@@ -188,14 +177,11 @@ DSP_STATUS DRV_InsertDMMResElement(HANDLE hDMMRes, HANDLE hPCtxt)
 
 	*pDMMRes = (struct DMM_RES_OBJECT *)
 		    MEM_Calloc(1 * sizeof(struct DMM_RES_OBJECT), MEM_PAGED);
-	if (*pDMMRes == NULL) {
-		GT_0trace(curTrace, GT_5CLASS, "DRV_InsertDMMResElement: 2");
+	if (*pDMMRes == NULL)
 		status = DSP_EHANDLE;
-	}
+
 	if (DSP_SUCCEEDED(status)) {
 		if (pCtxt->pDMMList != NULL) {
-			GT_0trace(curTrace, GT_5CLASS,
-				 "DRV_InsertDMMResElement: 3");
 			pTempDMMRes = pCtxt->pDMMList;
 			while (pTempDMMRes->next != NULL)
 				pTempDMMRes = pTempDMMRes->next;
@@ -203,8 +189,6 @@ DSP_STATUS DRV_InsertDMMResElement(HANDLE hDMMRes, HANDLE hPCtxt)
 			pTempDMMRes->next = *pDMMRes;
 		} else {
 			pCtxt->pDMMList = *pDMMRes;
-			GT_0trace(curTrace, GT_5CLASS,
-				 "DRV_InsertDMMResElement: 4");
 		}
 	}
 
@@ -575,9 +559,6 @@ DSP_STATUS DRV_Create(OUT struct DRV_OBJECT **phDRVObject)
 	if (DSP_SUCCEEDED(status))
 		status = CFG_SetObject((u32) pDRVObject, REG_DRV_OBJECT);
 	if (DSP_SUCCEEDED(status)) {
-		GT_1trace(curTrace, GT_1CLASS,
-			 "DRV Obj Created pDrvObject 0x%x\n ",
-			 pDRVObject);
 		*phDRVObject = pDRVObject;
 	} else {
 		kfree(pDRVObject->devList);
@@ -931,13 +912,10 @@ DSP_STATUS DRV_ReleaseResources(u32 dwContext, struct DRV_OBJECT *hDrvObject)
 	struct DRV_EXT *pszdevNode;
 
 	if (!(strcmp((char *)((struct DRV_EXT *)dwContext)->szString,
-	   "TIOMAP1510"))) {
-		GT_0trace(curTrace, GT_1CLASS,
-			 " Releasing DSP-Bridge resources \n");
+	   "TIOMAP1510")))
 		status = RequestBridgeResources(dwContext, DRV_RELEASE);
-	} else {
+	else
 		GT_0trace(curTrace, GT_1CLASS, " Unknown device\n");
-	}
 
 	if (DSP_FAILED(status))
 		GT_0trace(curTrace, GT_1CLASS,
@@ -998,9 +976,6 @@ static DSP_STATUS RequestBridgeResources(u32 dwContext, s32 bRequest)
 				status = CFG_E_RESOURCENOTAVAIL;
 				GT_0trace(curTrace, GT_1CLASS,
 					 "REG_GetValue Failed \n");
-			} else {
-				GT_0trace(curTrace, GT_1CLASS,
-					 "REG_GetValue Succeeded \n");
 			}
 
 			dwBuffSize = sizeof(shm_size);
@@ -1115,11 +1090,7 @@ static DSP_STATUS RequestBridgeResources(u32 dwContext, s32 bRequest)
 		dwBuffSize = sizeof(struct CFG_HOSTRES);
 		status = REG_SetValue(CURRENTCONFIG, (u8 *)pResources,
 						sizeof(struct CFG_HOSTRES));
-		if (DSP_SUCCEEDED(status)) {
-			GT_0trace(curTrace, GT_1CLASS,
-				 " Successfully set the registry "
-				 "value for CURRENTCONFIG\n");
-		} else {
+		if (DSP_FAILED(status)) {
 			GT_0trace(curTrace, GT_7CLASS,
 				 " Failed to set the registry "
 				 "value for CURRENTCONFIG\n");
@@ -1235,11 +1206,7 @@ static DSP_STATUS RequestBridgeResourcesDSP(u32 dwContext, s32 bRequest)
 			dwBuffSize = sizeof(struct CFG_HOSTRES);
 			status = REG_SetValue(CURRENTCONFIG, (u8 *)pResources,
 					     sizeof(struct CFG_HOSTRES));
-			if (DSP_SUCCEEDED(status)) {
-				GT_0trace(curTrace, GT_1CLASS,
-					 " Successfully set the registry"
-					 " value for CURRENTCONFIG\n");
-			} else {
+			if (DSP_FAILED(status)) {
 				GT_0trace(curTrace, GT_7CLASS,
 					 " Failed to set the registry value"
 					 " for CURRENTCONFIG\n");
diff --git a/drivers/dsp/bridge/rmgr/drv_interface.c b/drivers/dsp/bridge/rmgr/drv_interface.c
index 4a909a9..8f9e626 100644
--- a/drivers/dsp/bridge/rmgr/drv_interface.c
+++ b/drivers/dsp/bridge/rmgr/drv_interface.c
@@ -331,17 +331,11 @@ static int __devinit omap34xx_bridge_probe(struct platform_device *pdev)
 			pdata->mpu_speed[i] = vdd1_rate_table_bridge[i].rate;
 
 		clk_handle = clk_get(NULL, "iva2_ck");
-		if (!clk_handle) {
+		if (!clk_handle)
 			GT_0trace(driverTrace, GT_7CLASS,
 			"clk_get failed to get iva2_ck \n");
-		} else {
-			GT_0trace(driverTrace, GT_7CLASS,
-			"clk_get PASS to get iva2_ck \n");
-		}
-		if (!clk_notifier_register(clk_handle, &iva_clk_notifier)) {
-			GT_0trace(driverTrace, GT_7CLASS,
-			"clk_notifier_register PASS for iva2_ck \n");
-		} else {
+
+		if (clk_notifier_register(clk_handle, &iva_clk_notifier)) {
 			GT_0trace(driverTrace, GT_7CLASS,
 			"clk_notifier_register FAIL for iva2_ck \n");
 		}
@@ -380,10 +374,7 @@ static int __devexit omap34xx_bridge_remove(struct platform_device *pdev)
 		goto func_cont;
 
 #ifdef CONFIG_BRIDGE_DVFS
-	if (!clk_notifier_unregister(clk_handle, &iva_clk_notifier)) {
-		GT_0trace(driverTrace, GT_7CLASS,
-		"clk_notifier_unregister PASS for iva2_ck \n");
-	} else {
+	if (clk_notifier_unregister(clk_handle, &iva_clk_notifier)) {
 		GT_0trace(driverTrace, GT_7CLASS,
 		"clk_notifier_unregister FAILED for iva2_ck \n");
 	}
diff --git a/drivers/dsp/bridge/rmgr/dspdrv.c b/drivers/dsp/bridge/rmgr/dspdrv.c
index 522da73..dae61e2 100644
--- a/drivers/dsp/bridge/rmgr/dspdrv.c
+++ b/drivers/dsp/bridge/rmgr/dspdrv.c
@@ -71,7 +71,6 @@ u32 DSP_Init(OUT u32 *initStatus)
 		WCD_Exit();
 		goto func_cont;
 	}		/* End DRV_Create */
-	GT_0trace(curTrace, GT_5CLASS, "DSP_Init:DRV Created \r\n");
 
 	/* Request Resources */
 	status = DRV_RequestResources((u32)&devNode, &deviceNodeString);
@@ -79,12 +78,7 @@ u32 DSP_Init(OUT u32 *initStatus)
 		/* Attempt to Start the Device */
 		status = DEV_StartDevice((struct CFG_DEVNODE *)
 							deviceNodeString);
-		if (DSP_SUCCEEDED(status)) {
-			/* Retreive the DevObject from the Registry */
-			GT_1trace(curTrace, GT_1CLASS,
-				 "DSP_Init Succeeded for Device1 value: %x\n",
-				 deviceNodeString);
-		} else {
+		if (DSP_FAILED(status)) {
 			GT_0trace(curTrace, GT_7CLASS,
 				 "DSP_Init:DEV_StartDevice Failed\n");
 			(void)DRV_ReleaseResources
@@ -123,7 +117,6 @@ func_cont:
 		 * correct one. We should not propagate that error
 		 * into the device loader. */
 		(void)WCD_InitComplete2();
-		GT_0trace(curTrace, GT_1CLASS, "DSP_Init Succeeded\n");
 	} else {
 		GT_0trace(curTrace, GT_7CLASS, "DSP_Init Failed\n");
 	}			/* End WCD_InitComplete2 */
diff --git a/drivers/dsp/bridge/rmgr/mgr.c b/drivers/dsp/bridge/rmgr/mgr.c
index 1f2fa48..d7118da 100644
--- a/drivers/dsp/bridge/rmgr/mgr.c
+++ b/drivers/dsp/bridge/rmgr/mgr.c
@@ -79,8 +79,6 @@ DSP_STATUS MGR_Create(OUT struct MGR_OBJECT **phMgrObject,
 							REG_MGR_OBJECT);
 			if (DSP_SUCCEEDED(status)) {
 				*phMgrObject = pMgrObject;
-				GT_0trace(MGR_DebugMask, GT_1CLASS,
-					 "MGR_Create:MGR Created\r\n");
 			} else {
 				GT_0trace(MGR_DebugMask, GT_7CLASS,
 					 "MGR_Create:CFG_SetObject "
diff --git a/drivers/dsp/bridge/rmgr/node.c b/drivers/dsp/bridge/rmgr/node.c
index d974cda..78770fc 100644
--- a/drivers/dsp/bridge/rmgr/node.c
+++ b/drivers/dsp/bridge/rmgr/node.c
@@ -477,17 +477,12 @@ DSP_STATUS NODE_Allocate(struct PROC_OBJECT *hProcessor,
 			pNode->createArgs.asa.taskArgs.uHeapSize,
 			(void *)pNode->createArgs.asa.taskArgs.uDSPHeapResAddr,
 			(void **)&pMappedAddr, mapAttrs, pr_ctxt);
-	if (DSP_FAILED(status)) {
+	if (DSP_FAILED(status))
 		GT_1trace(NODE_debugMask, GT_5CLASS,
 			 "NODE_Allocate: Failed to map memory"
 			 " for Heap: 0x%x\n", status);
-	} else {
-		pNode->createArgs.asa.taskArgs.uDSPHeapAddr =
-			(u32) pMappedAddr;
-		GT_1trace(NODE_debugMask, GT_5CLASS,
-			 "NODE_Allocate:DSPProcessor_Map"
-			 " successful: 0x%x\n", status);
-	}
+	else
+		pNode->createArgs.asa.taskArgs.uDSPHeapAddr = (u32)pMappedAddr;
 
 func_cont:
 	(void)SYNC_LeaveCS(hNodeMgr->hSync);
@@ -1240,15 +1235,8 @@ DSP_STATUS NODE_Create(struct NODE_OBJECT *hNode)
 		/* If node's create function is not loaded, load it */
 		/* Boost the OPP level to max level that DSP can be requested */
 #if defined(CONFIG_BRIDGE_DVFS) && !defined(CONFIG_CPU_FREQ)
-		if (pdata->cpu_set_freq) {
+		if (pdata->cpu_set_freq)
 			(*pdata->cpu_set_freq)(pdata->mpu_speed[VDD1_OPP3]);
-
-			if (pdata->dsp_get_opp) {
-				GT_1trace(NODE_debugMask, GT_4CLASS, "opp level"
-				"after setting to VDD1_OPP3 is %d\n",
-				(*pdata->dsp_get_opp)());
-			}
-		}
 #endif
 		status = hNodeMgr->nldrFxns.pfnLoad(hNode->hNldrNode,
 						   NLDR_CREATE);
@@ -1266,15 +1254,8 @@ DSP_STATUS NODE_Create(struct NODE_OBJECT *hNode)
 		}
 		/* Request the lowest OPP level*/
 #if defined(CONFIG_BRIDGE_DVFS) && !defined(CONFIG_CPU_FREQ)
-		if (pdata->cpu_set_freq) {
+		if (pdata->cpu_set_freq)
 			(*pdata->cpu_set_freq)(pdata->mpu_speed[VDD1_OPP1]);
-
-			if (pdata->dsp_get_opp) {
-				GT_1trace(NODE_debugMask, GT_4CLASS, "opp level"
-				"after setting to VDD1_OPP1 is %d\n",
-				(*pdata->dsp_get_opp)());
-			}
-		}
 #endif
 		/* Get address of iAlg functions, if socket node */
 		if (DSP_SUCCEEDED(status)) {
@@ -1445,11 +1426,9 @@ DSP_STATUS NODE_CreateMgr(OUT struct NODE_MGR **phNodeMgr,
 	}
 
 	/* Get loader functions and create loader */
-	if (DSP_SUCCEEDED(status)) {
-		GT_0trace(NODE_debugMask, GT_1CLASS,
-			 "NODE_CreateMgr: using dynamic loader\n");
+	if (DSP_SUCCEEDED(status))
 		pNodeMgr->nldrFxns = nldrFxns;	/* Dynamic loader functions */
-	}
+
 	if (DSP_SUCCEEDED(status)) {
 		nldrAttrs.pfnOvly = Ovly;
 		nldrAttrs.pfnWrite = Write;
@@ -1579,9 +1558,6 @@ func_cont1:
 			if (DSP_SUCCEEDED(status)) {
 				status = PROC_GetState(hProcessor, &procStatus,
 					sizeof(struct DSP_PROCESSORSTATE));
-				GT_1trace(NODE_debugMask, GT_4CLASS,
-						 "NODE_Delete: proc Status "
-						 "0x%x\n", procStatus.iState);
 				if (procStatus.iState != PROC_ERROR) {
 					status = DISP_NodeDelete(hDisp, hNode,
 					hNodeMgr->ulFxnAddrs[RMSDELETENODE],
@@ -1624,13 +1600,10 @@ func_cont1:
 		hNodeMgr->uNumCreated--;
 	 /*  Free host-side resources allocated by NODE_Create()
 	 *  DeleteNode() fails if SM buffers not freed by client!  */
-	if (DRV_GetNodeResElement(hNode, &nodeRes, pr_ctxt) != DSP_ENOTFOUND) {
-		GT_0trace(NODE_debugMask, GT_5CLASS, "\nNODE_Delete12:\n");
+	if (DRV_GetNodeResElement(hNode, &nodeRes, pr_ctxt) != DSP_ENOTFOUND)
 		DRV_ProcNodeUpdateStatus(nodeRes, false);
-	}
 	DeleteNode(hNode, pr_ctxt);
 
-	GT_0trace(NODE_debugMask, GT_5CLASS, "\nNODE_Delete2:\n ");
 	DRV_RemoveNodeResElement(nodeRes, pr_ctxt);
 	/* Exit critical section */
 	(void)SYNC_LeaveCS(hNodeMgr->hSync);
@@ -2518,9 +2491,6 @@ DSP_STATUS NODE_Terminate(struct NODE_OBJECT *hNode, OUT DSP_STATUS *pStatus)
 		 *  Send exit message. Do not change state to NODE_DONE
 		 *  here. That will be done in callback.
 		 */
-		GT_1trace(NODE_debugMask, GT_5CLASS,
-			 "NODE_Terminate: env = 0x%x\n", hNode->nodeEnv);
-
 		status = PROC_GetState(pNode->hProcessor, &procStatus,
 					sizeof(struct DSP_PROCESSORSTATE));
 		if (DSP_FAILED(status))
@@ -2685,26 +2655,18 @@ static void DeleteNode(struct NODE_OBJECT *hNode,
 			status = PROC_UnMap(hNode->hProcessor,
 					   (void *)taskArgs.uDSPHeapAddr,
 					   pr_ctxt);
-			if (DSP_SUCCEEDED(status)) {
-				GT_0trace(NODE_debugMask, GT_5CLASS,
-					 "DSPProcessor_UnMap succeeded.\n");
-			} else {
+			if (DSP_FAILED(status))
 				GT_1trace(NODE_debugMask, GT_5CLASS,
 					 "DSPProcessor_UnMap failed."
 					 " Status = 0x%x\n", (u32)status);
-			}
+
 			status = PROC_UnReserveMemory(hNode->hProcessor,
 					(void *)taskArgs.uDSPHeapResAddr);
-			if (DSP_SUCCEEDED(status)) {
-				GT_0trace(NODE_debugMask, GT_5CLASS,
-					 "DSPProcessor_UnReserveMemory "
-					 "succeeded.\n");
-			} else {
+			if (DSP_FAILED(status))
 				GT_1trace(NODE_debugMask, GT_5CLASS,
 					 "DSPProcessor_UnReserveMemory "
 					 "failed. Status = 0x%x\n",
 					 (u32)status);
-			}
 #ifdef DSP_DMM_DEBUG
 			status = DMM_GetHandle(pProcObject, &hDmmMgr);
 			if (DSP_SUCCEEDED(status))
diff --git a/drivers/dsp/bridge/rmgr/proc.c b/drivers/dsp/bridge/rmgr/proc.c
index 7c0264e..f451244 100644
--- a/drivers/dsp/bridge/rmgr/proc.c
+++ b/drivers/dsp/bridge/rmgr/proc.c
@@ -226,12 +226,8 @@ PROC_Attach(u32 uProcessor, OPTIONAL CONST struct DSP_PROCESSORATTRIN *pAttrIn,
 					     (u32)pProcObject,
 					     &pProcObject->bIsAlreadyAttached);
 		if (DSP_SUCCEEDED(status)) {
-			if (pProcObject->bIsAlreadyAttached) {
+			if (pProcObject->bIsAlreadyAttached)
 				status = DSP_SALREADYATTACHED;
-				GT_0trace(PROC_DebugMask, GT_1CLASS,
-					 "PROC_Attach: Processor "
-					 "Already Attached!\n");
-			}
 		} else {
 			if (pProcObject->hNtfy)
 				NTFY_Delete(pProcObject->hNtfy);
@@ -246,9 +242,6 @@ PROC_Attach(u32 uProcessor, OPTIONAL CONST struct DSP_PROCESSORATTRIN *pAttrIn,
 			pr_ctxt->hProcessor = *phProcessor;
 			(void)PROC_NotifyClients(pProcObject,
 						 DSP_PROCESSORATTACH);
-			GT_0trace(PROC_DebugMask, GT_1CLASS,
-				 "PROC_Attach: Processor "
-				 "Attach Success!\n");
 		}
 	} else {
 		/* Don't leak memory if DSP_FAILED */
@@ -333,7 +326,6 @@ DSP_STATUS PROC_AutoStart(struct CFG_DEVNODE *hDevNode,
 		status = DSP_EMEMORY;
 		goto func_end;
 	}
-	GT_0trace(PROC_DebugMask, GT_1CLASS, "NTFY Created \n");
 	pProcObject->hDevObject = hDevObject;
 	pProcObject->hMgrObject = hMgrObject;
 	hProcObject = pProcObject;
@@ -382,11 +374,7 @@ DSP_STATUS PROC_AutoStart(struct CFG_DEVNODE *hDevNode,
 		status = PROC_Load(hProcObject, 1, (CONST char **)argv, NULL);
 		if (DSP_SUCCEEDED(status)) {
 			status = PROC_Start(hProcObject);
-			if (DSP_SUCCEEDED(status)) {
-				GT_0trace(PROC_DebugMask, GT_1CLASS,
-					  "PROC_AutoStart: Processor started "
-					  "running\n");
-			} else {
+			if (DSP_FAILED(status)) {
 				GT_0trace(PROC_DebugMask, GT_7CLASS,
 					  "PROC_AutoStart: DSP_FAILED To "
 					  "Start \n");
@@ -963,11 +951,6 @@ DSP_STATUS PROC_Load(DSP_HPROCESSOR hProcessor, IN CONST s32 iArgc,
 			 "PROC_Load: Invalid Processor Handle..\n");
 		goto func_end;
 	}
-	if (pProcObject->bIsAlreadyAttached) {
-		GT_0trace(PROC_DebugMask, GT_7CLASS,
-			 "PROC_Load GPP "
-			 "Client is already attached status  \n");
-	}
 	if (DSP_FAILED(DEV_GetCodMgr(pProcObject->hDevObject, &hCodMgr))) {
 		status = DSP_EFAIL;
 		GT_1trace(PROC_DebugMask, GT_7CLASS, "PROC_Load: DSP_FAILED in "
@@ -1464,8 +1447,6 @@ DSP_STATUS PROC_Start(DSP_HPROCESSOR hProcessor)
 			PROC_NotifyClients(pProcObject,
 					  DSP_PROCESSORSTATECHANGE);
 		}
-		GT_0trace(PROC_DebugMask, GT_1CLASS, "PROC_Start: Processor "
-			 "Started and running \n");
 	} else {
 		/* Failed to Create Node Manager and DISP Object
 		 * Stop the Processor from running. Put it in STOPPED State */
@@ -1553,11 +1534,8 @@ DSP_STATUS PROC_Stop(DSP_HPROCESSOR hProcessor)
 #ifdef CONFIG_BRIDGE_DEBUG
 			if (DSP_SUCCEEDED((*pProcObject->pIntfFxns->
 			   pfnBrdStatus)(pProcObject->hWmdContext,
-			   &uBrdState))) {
-				GT_0trace(PROC_DebugMask, GT_1CLASS,
-					 "PROC_Monitor:Processor Stopped \n");
+			   &uBrdState)))
 				DBC_Assert(uBrdState == BRD_STOPPED);
-			}
 #endif
 		} else {
 			GT_0trace(PROC_DebugMask, GT_7CLASS,
@@ -1620,9 +1598,6 @@ DSP_STATUS PROC_UnMap(DSP_HPROCESSOR hProcessor, void *pMapAddr,
 			 (pProcObject->hWmdContext, vaAlign, sizeAlign);
 	}
 	(void)SYNC_LeaveCS(hProcLock);
-	GT_1trace(PROC_DebugMask, GT_ENTER,
-		   "PROC_UnMap DRV_GetDMMResElement "
-		   "pMapAddr:[0x%x]", pMapAddr);
 	if (DSP_FAILED(status))
 		goto func_end;
 
@@ -1716,13 +1691,10 @@ static DSP_STATUS PROC_Monitor(struct PROC_OBJECT *hProcObject)
 		status = DSP_SOK;
 #ifdef CONFIG_BRIDGE_DEBUG
 		if (DSP_SUCCEEDED((*pProcObject->pIntfFxns->pfnBrdStatus)
-		   (pProcObject->hWmdContext, &uBrdState))) {
-			GT_0trace(PROC_DebugMask, GT_1CLASS,
-				 "PROC_Monitor:Processor in "
-				 "Monitor State\n");
+		   (pProcObject->hWmdContext, &uBrdState)))
 			DBC_Assert(uBrdState == BRD_IDLE);
-		}
 #endif
+
 	} else {
 		/* Monitor Failure */
 		GT_0trace(PROC_DebugMask, GT_7CLASS,
@@ -1804,8 +1776,6 @@ DSP_STATUS PROC_NotifyClients(DSP_HPROCESSOR hProc, u32 uEvents)
 	}
 
 	NTFY_Notify(pProcObject->hNtfy, uEvents);
-	GT_0trace(PROC_DebugMask, GT_1CLASS,
-		 "PROC_NotifyClients :Signaled. \n");
 func_end:
 	return status;
 }
@@ -1833,8 +1803,6 @@ DSP_STATUS PROC_NotifyAllClients(DSP_HPROCESSOR hProc, u32 uEvents)
 
 	DEV_NotifyClients(pProcObject->hDevObject, uEvents);
 
-	GT_0trace(PROC_DebugMask, GT_1CLASS,
-		 "PROC_NotifyAllClients :Signaled. \n");
 func_end:
 	return status;
 }
-- 
1.6.2.4

