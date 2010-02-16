From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 14/18] DSPBRIDGE: change critical error statements to pr_err in rmgr
Date: Tue, 16 Feb 2010 02:42:24 -0600
Message-ID: <1266309748-11714-15-git-send-email-omar.ramirez@ti.com>
References: <1266309748-11714-1-git-send-email-omar.ramirez@ti.com>
 <1266309748-11714-2-git-send-email-omar.ramirez@ti.com>
 <1266309748-11714-3-git-send-email-omar.ramirez@ti.com>
 <1266309748-11714-4-git-send-email-omar.ramirez@ti.com>
 <1266309748-11714-5-git-send-email-omar.ramirez@ti.com>
 <1266309748-11714-6-git-send-email-omar.ramirez@ti.com>
 <1266309748-11714-7-git-send-email-omar.ramirez@ti.com>
 <1266309748-11714-8-git-send-email-omar.ramirez@ti.com>
 <1266309748-11714-9-git-send-email-omar.ramirez@ti.com>
 <1266309748-11714-10-git-send-email-omar.ramirez@ti.com>
 <1266309748-11714-11-git-send-email-omar.ramirez@ti.com>
 <1266309748-11714-12-git-send-email-omar.ramirez@ti.com>
 <1266309748-11714-13-git-send-email-omar.ramirez@ti.com>
 <1266309748-11714-14-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:60006 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755355Ab0BPIaH (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 16 Feb 2010 03:30:07 -0500
In-Reply-To: <1266309748-11714-14-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Ameya Palande <ameya.palande@nokia.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>, Nishanth Menon <nm@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>

Print to console if:
    - Driver is not succesfully installed.
    - Baseimage is not correctly loaded.
    - Processor can't be stopped or started.
    - Node can't be allocated, created, executed or deleted.

This will help to quick diagnose most common bridge errors.

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 drivers/dsp/bridge/rmgr/drv.c           |    3 +-
 drivers/dsp/bridge/rmgr/drv_interface.c |   32 ++++------
 drivers/dsp/bridge/rmgr/node.c          |   98 +++++++++++-------------------
 drivers/dsp/bridge/rmgr/proc.c          |   21 +++----
 4 files changed, 58 insertions(+), 96 deletions(-)

diff --git a/drivers/dsp/bridge/rmgr/drv.c b/drivers/dsp/bridge/rmgr/drv.c
index c334f9e..44208b7 100644
--- a/drivers/dsp/bridge/rmgr/drv.c
+++ b/drivers/dsp/bridge/rmgr/drv.c
@@ -1165,8 +1165,7 @@ static DSP_STATUS RequestBridgeResourcesDSP(u32 dwContext, s32 bRequest)
 							&dmaAddr);
 			if (pResources->dwMemBase[1] == 0) {
 				status = DSP_EMEMORY;
-				GT_0trace(curTrace, GT_7CLASS,
-					 "SHM reservation Failed\n");
+				pr_err("SHM reservation Failed\n");
 			} else {
 				pResources->dwMemLength[1] = shm_size;
 				pResources->dwMemPhys[1] = dmaAddr;
diff --git a/drivers/dsp/bridge/rmgr/drv_interface.c b/drivers/dsp/bridge/rmgr/drv_interface.c
index a002e01..cff2877 100644
--- a/drivers/dsp/bridge/rmgr/drv_interface.c
+++ b/drivers/dsp/bridge/rmgr/drv_interface.c
@@ -232,8 +232,7 @@ static int __devinit omap34xx_bridge_probe(struct platform_device *pdev)
 	/* use 2.6 device model */
 	result = alloc_chrdev_region(&dev, 0, 1, driver_name);
 	if (result < 0) {
-		GT_1trace(driverTrace, GT_7CLASS, "bridge_init: "
-				"Can't get Major %d \n", driver_major);
+		pr_err("%s: Can't get major %d\n", __func__, driver_major);
 		goto err1;
 	}
 
@@ -244,8 +243,7 @@ static int __devinit omap34xx_bridge_probe(struct platform_device *pdev)
 
 	status = cdev_add(&bridge_cdev, dev, 1);
 	if (status) {
-		GT_0trace(driverTrace, GT_7CLASS,
-				"Failed to add the bridge device \n");
+		pr_err("%s: Failed to add bridge device\n", __func__);
 		goto err2;
 	}
 
@@ -253,8 +251,7 @@ static int __devinit omap34xx_bridge_probe(struct platform_device *pdev)
 	bridge_class = class_create(THIS_MODULE, "ti_bridge");
 
 	if (IS_ERR(bridge_class))
-		GT_0trace(driverTrace, GT_7CLASS,
-				"Error creating bridge class \n");
+		pr_err("%s: Error creating bridge class\n", __func__);
 
 	device_create(bridge_class, NULL, MKDEV(driver_major, 0),
 			NULL, "DspBridge");
@@ -298,8 +295,7 @@ static int __devinit omap34xx_bridge_probe(struct platform_device *pdev)
 	} else {
 		initStatus = DSP_EINVALIDARG;
 		status = -1;
-		GT_0trace(driverTrace, GT_7CLASS,
-			  "SHM size must be at least 64 KB\n");
+		pr_err("%s: SHM size must be at least 64 KB\n", __func__);
 	}
 	GT_1trace(driverTrace, GT_7CLASS,
 		 "requested shm_size = 0x%x\n", shm_size);
@@ -332,19 +328,16 @@ static int __devinit omap34xx_bridge_probe(struct platform_device *pdev)
 
 		clk_handle = clk_get(NULL, "iva2_ck");
 		if (!clk_handle)
-			GT_0trace(driverTrace, GT_7CLASS,
-			"clk_get failed to get iva2_ck \n");
+			pr_err("%s: clk_get failed to get iva2_ck\n", __func__);
 
-		if (clk_notifier_register(clk_handle, &iva_clk_notifier)) {
-			GT_0trace(driverTrace, GT_7CLASS,
-			"clk_notifier_register FAIL for iva2_ck \n");
-		}
+		if (clk_notifier_register(clk_handle, &iva_clk_notifier))
+			pr_err("%s: clk_notifier_register failed for iva2_ck\n",
+								__func__);
 #endif
 		driverContext = DSP_Init(&initStatus);
 		if (DSP_FAILED(initStatus)) {
 			status = -1;
-			GT_0trace(driverTrace, GT_7CLASS,
-				 "DSP/BIOS Bridge initialization Failed\n");
+			pr_err("DSP Bridge driver initialization failed\n");
 		} else {
 			pr_info("DSP Bridge driver loaded\n");
 		}
@@ -373,10 +366,9 @@ static int __devexit omap34xx_bridge_remove(struct platform_device *pdev)
 		goto func_cont;
 
 #ifdef CONFIG_BRIDGE_DVFS
-	if (clk_notifier_unregister(clk_handle, &iva_clk_notifier)) {
-		GT_0trace(driverTrace, GT_7CLASS,
-		"clk_notifier_unregister FAILED for iva2_ck \n");
-	}
+	if (clk_notifier_unregister(clk_handle, &iva_clk_notifier))
+		pr_err("%s: clk_notifier_unregister failed for iva2_ck\n",
+								__func__);
 #endif /* #ifdef CONFIG_BRIDGE_DVFS */
 
 	if (driverContext) {
diff --git a/drivers/dsp/bridge/rmgr/node.c b/drivers/dsp/bridge/rmgr/node.c
index fe7d806..1c8b4a5 100644
--- a/drivers/dsp/bridge/rmgr/node.c
+++ b/drivers/dsp/bridge/rmgr/node.c
@@ -378,8 +378,7 @@ DSP_STATUS NODE_Allocate(struct PROC_OBJECT *hProcessor,
 	/* Assuming that 0 is not a valid function address */
 	if (hNodeMgr->ulFxnAddrs[0] == 0) {
 		/* No RMS on target - we currently can't handle this */
-		GT_0trace(NODE_debugMask, GT_5CLASS, "No RMS functions in base "
-			 "image. Node allocation fails.\n");
+		pr_err("%s: Failed, no RMS in base image\n", __func__);
 		status = DSP_EFAIL;
 	} else {
 		/* Validate pAttrIn fields, if non-NULL */
@@ -433,10 +432,8 @@ DSP_STATUS NODE_Allocate(struct PROC_OBJECT *hProcessor,
 
 	/* check for page aligned Heap size */
 	if (((pAttrIn->uHeapSize) & (PG_SIZE_4K - 1))) {
-		GT_1trace(NODE_debugMask, GT_7CLASS,
-			 "NODE_Allocate: node heap page size"
-			 " not aligned to 4K page, size=0x%x \n",
-			 pAttrIn->uHeapSize);
+		pr_err("%s: node heap size not aligned to 4K, size = 0x%x \n",
+						__func__, pAttrIn->uHeapSize);
 		status = DSP_EINVALIDARG;
 	} else {
 		pNode->createArgs.asa.taskArgs.uHeapSize = pAttrIn->uHeapSize;
@@ -451,10 +448,8 @@ DSP_STATUS NODE_Allocate(struct PROC_OBJECT *hProcessor,
 			(void **)&(pNode->createArgs.asa.taskArgs.
 				uDSPHeapResAddr));
 	if (DSP_FAILED(status)) {
-		GT_1trace(NODE_debugMask, GT_5CLASS,
-			 "NODE_Allocate:Failed to reserve "
-			 "memory for Heap: 0x%x\n", status);
-
+		pr_err("%s: Failed to reserve memory for heap: 0x%x\n",
+							__func__, status);
 		goto func_cont;
 	}
 #ifdef DSP_DMM_DEBUG
@@ -473,9 +468,8 @@ DSP_STATUS NODE_Allocate(struct PROC_OBJECT *hProcessor,
 			(void *)pNode->createArgs.asa.taskArgs.uDSPHeapResAddr,
 			(void **)&pMappedAddr, mapAttrs, pr_ctxt);
 	if (DSP_FAILED(status))
-		GT_1trace(NODE_debugMask, GT_5CLASS,
-			 "NODE_Allocate: Failed to map memory"
-			 " for Heap: 0x%x\n", status);
+		pr_err("%s: Failed to map memory for Heap: 0x%x\n",
+							__func__, status);
 	else
 		pNode->createArgs.asa.taskArgs.uDSPHeapAddr = (u32)pMappedAddr;
 
@@ -590,28 +584,23 @@ func_cont:
 		    STACKSEGLABEL) == 0) {
 			status = hNodeMgr->nldrFxns.pfnGetFxnAddr(pNode->
 				 hNldrNode, "DYNEXT_BEG", &dynextBase);
-			if (DSP_FAILED(status)) {
-				GT_1trace(NODE_debugMask, GT_5CLASS,
-				"NODE_Allocate: Failed to get Address for "
-				"DYNEXT_BEG: 0x%x\n", status);
-			}
+			if (DSP_FAILED(status))
+				pr_err("%s: Failed to get addr for DYNEXT_BEG"
+					" status = 0x%x\n", __func__, status);
 
 			status = hNodeMgr->nldrFxns.pfnGetFxnAddr(pNode->
 				 hNldrNode, "L1DSRAM_HEAP", &pulValue);
 
-			if (DSP_FAILED(status)) {
-				GT_1trace(NODE_debugMask, GT_5CLASS,
-				"NODE_Allocate: Failed to get Address for "
-				"L1DSRAM_HEAP: 0x%x\n", status);
-			}
+			if (DSP_FAILED(status))
+				pr_err("%s: Failed to get addr for L1DSRAM_HEAP"
+					" status = 0x%x\n", __func__, status);
 
 			status = CFG_GetHostResources((struct CFG_DEVNODE *)
 				 DRV_GetFirstDevExtension(), &hostRes);
 
 			if (DSP_FAILED(status)) {
-				GT_1trace(NODE_debugMask, GT_5CLASS,
-				"NODE_Allocate: Failed to get host resource "
-				"0x%x\n", status);
+				pr_err("%s: Failed to get host resource, status"
+						" = 0x%x\n", __func__, status);
 				goto func_end;
 			}
 
@@ -754,9 +743,8 @@ DBAPI NODE_AllocMsgBuf(struct NODE_OBJECT *hNode, u32 uSize,
 			(void)CMM_XlatorAllocBuf(pNode->hXlator, pBuffer,
 						 uSize);
 			if (*pBuffer == NULL) {
-				GT_0trace(NODE_debugMask, GT_7CLASS,
-					 "NODE_AllocMsgBuf: "
-					 "ERROR: Out of shared memory.\n");
+				pr_err("%s: error - Out of shared memory\n",
+								__func__);
 				status = DSP_EMEMORY;
 			}
 		}
@@ -1219,9 +1207,8 @@ DSP_STATUS NODE_Create(struct NODE_OBJECT *hNode)
 							CREATEPHASE);
 			}
 		} else {
-			GT_1trace(NODE_debugMask, GT_ENTER,
-				 "NODE_Create: failed to load"
-				 " create code: 0x%x\n", status);
+			pr_err("%s: failed to load create code: 0x%x\n",
+							__func__, status);
 		}
 		/* Request the lowest OPP level*/
 #if defined(CONFIG_BRIDGE_DVFS) && !defined(CONFIG_CPU_FREQ)
@@ -1263,11 +1250,9 @@ DSP_STATUS NODE_Create(struct NODE_OBJECT *hNode)
 						      NLDR_CREATE);
 		hNode->fLoaded = false;
 	}
-	if (DSP_FAILED(status1)) {
-		GT_1trace(NODE_debugMask, GT_5CLASS,
-			 "NODE_Create: Failed to unload "
-			 "create code: 0x%x\n", status1);
-	}
+	if (DSP_FAILED(status1))
+		pr_err("%s: Failed to unload create code: 0x%x\n",
+							__func__, status1);
 func_cont2:
 	/* Update node state and node manager state */
 	if (DSP_SUCCEEDED(status)) {
@@ -1490,14 +1475,11 @@ DSP_STATUS NODE_Delete(struct NODE_OBJECT *hNode,
 			   hNode->fPhaseSplit) {
 				status = hNodeMgr->nldrFxns.pfnLoad(hNode->
 					 hNldrNode, NLDR_DELETE);
-				if (DSP_SUCCEEDED(status)) {
+				if (DSP_SUCCEEDED(status))
 					hNode->fLoaded = true;
-				} else {
-					GT_1trace(NODE_debugMask, GT_ENTER,
-						 "NODE_Delete: failed to "
-						 "load delete code: 0x%x\n",
-						 status);
-				}
+				else
+					pr_err("%s: fail - load delete code:"
+						" 0x%x\n", __func__, status);
 			}
 		}
 func_cont1:
@@ -1528,21 +1510,16 @@ func_cont1:
 					status1 = hNodeMgr->nldrFxns.pfnUnload(
 						hNode->hNldrNode, NLDR_EXECUTE);
 				}
-				if (DSP_FAILED(status1)) {
-					GT_1trace(NODE_debugMask, GT_ENTER,
-						  "NODE_Delete: failed to"
-						  "unload execute code: 0x%x\n",
-						  status1);
-				}
+				if (DSP_FAILED(status1))
+					pr_err("%s: fail - unload execute code:"
+						" 0x%x\n", __func__, status1);
+
 				status1 = hNodeMgr->nldrFxns.pfnUnload(
 					  hNode->hNldrNode, NLDR_DELETE);
 				hNode->fLoaded = false;
-				if (DSP_FAILED(status1)) {
-					GT_1trace(NODE_debugMask, GT_ENTER,
-						  "NODE_Delete: failed to"
-						  "unload delete code: 0x%x\n",
-						  status1);
-				}
+				if (DSP_FAILED(status1))
+					pr_err("%s: fail - unload delete code: "
+						"0x%x\n", __func__, status1);
 			}
 		}
 	}
@@ -2164,9 +2141,7 @@ DSP_STATUS NODE_PutMessage(struct NODE_OBJECT *hNode,
 				/* MAUs */
 				newMsg.dwArg2 /= hNode->hNodeMgr->uDSPWordSize;
 			} else {
-				GT_0trace(NODE_debugMask, GT_7CLASS,
-					 "NODE_PutMessage: "
-					 "uDSPWordSize is zero!\n");
+				pr_err("%s: uDSPWordSize is zero!\n", __func__);
 				status = DSP_EFAIL;	/* bad DSPWordSize */
 			}
 		} else {	/* failed to translate buffer address */
@@ -2312,9 +2287,8 @@ DSP_STATUS NODE_Run(struct NODE_OBJECT *hNode)
 			if (DSP_SUCCEEDED(status)) {
 				hNode->fLoaded = true;
 			} else {
-				GT_1trace(NODE_debugMask, GT_ENTER,
-					 "NODE_Run: failed to load "
-					 "execute code:0x%x\n", status);
+				pr_err("%s: fail - load execute code: 0x%x\n",
+							__func__, status);
 			}
 		}
 		if (DSP_SUCCEEDED(status)) {
diff --git a/drivers/dsp/bridge/rmgr/proc.c b/drivers/dsp/bridge/rmgr/proc.c
index b6ed886..f372059 100644
--- a/drivers/dsp/bridge/rmgr/proc.c
+++ b/drivers/dsp/bridge/rmgr/proc.c
@@ -977,8 +977,8 @@ DSP_STATUS PROC_Load(DSP_HPROCESSOR hProcessor, IN CONST s32 iArgc,
 					"PROC_Load:Failure to Load the EXE\n");
 			}
 			if (status == COD_E_SYMBOLNOTFOUND) {
-				GT_0trace(PROC_DebugMask, GT_7CLASS,
-					"PROC_Load:Could not parse the file\n");
+				pr_err("%s: Couldn't parse the file\n",
+								__func__);
 			}
 		}
 	/* Requesting the lowest opp supported*/
@@ -1037,11 +1037,8 @@ DSP_STATUS PROC_Load(DSP_HPROCESSOR hProcessor, IN CONST s32 iArgc,
 #endif
 func_end:
 #ifdef CONFIG_BRIDGE_DEBUG
-	if (DSP_FAILED(status)) {
-		GT_0trace(PROC_DebugMask, GT_1CLASS, "PROC_Load: "
-			 "Processor Load Failed.\n");
-
-	}
+	if (DSP_FAILED(status))
+		pr_err("%s: Processor failed to load\n", __func__);
 #endif
 	DBC_Ensure((DSP_SUCCEEDED(status) && pProcObject->sState == PROC_LOADED)
 		   || DSP_FAILED(status));
@@ -1291,6 +1288,8 @@ func_cont:
 			pr_info("%s: dsp in running state\n", __func__);
 			DBC_Assert(uBrdState != BRD_HIBERNATION);
 		}
+	} else {
+		pr_err("%s: Failed to start the dsp\n", __func__);
 	}
 #endif
 func_end:
@@ -1332,9 +1331,8 @@ DSP_STATUS PROC_Stop(DSP_HPROCESSOR hProcessor)
 		status = NODE_EnumNodes(hNodeMgr, &hNode, uNodeTabSize,
 					&uNumNodes, &uNodesAllocated);
 		if ((status == DSP_ESIZE) || (uNodesAllocated > 0)) {
-			GT_1trace(PROC_DebugMask, GT_7CLASS,
-				 "Can't stop device, Active "
-				 "nodes = 0x%x \n", uNodesAllocated);
+			pr_err("%s: Can't stop device, active nodes = %d \n",
+						__func__, uNodesAllocated);
 			return DSP_EWRONGSTATE;
 		}
 	}
@@ -1363,8 +1361,7 @@ DSP_STATUS PROC_Stop(DSP_HPROCESSOR hProcessor)
 #endif
 		}
 	} else {
-		GT_0trace(PROC_DebugMask, GT_7CLASS,
-			 "PROC_Stop Failed to Stop the processor/device \n");
+		pr_err("%s: Failed to stop the processor\n", __func__);
 	}
 func_end:
 
-- 
1.6.2.4

