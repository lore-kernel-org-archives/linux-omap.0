From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 02/12] DSPBRIDGE: Change custom GT_trace for dev_dbg
Date: Thu, 18 Feb 2010 15:37:53 -0600
Message-ID: <1266529083-2358-3-git-send-email-omar.ramirez@ti.com>
References: <1266529083-2358-1-git-send-email-omar.ramirez@ti.com>
 <1266529083-2358-2-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:54601 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755710Ab0BRVZ3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Feb 2010 16:25:29 -0500
In-Reply-To: <1266529083-2358-2-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Ameya Palande <ameya.palande@nokia.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>, Nishanth Menon <nm@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>

Remove GT_Trace custom debugging mechanism and use dev_dbg.

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 drivers/dsp/bridge/rmgr/dbdcd.c         |   29 ++++-----
 drivers/dsp/bridge/rmgr/disp.c          |   58 ++++++------------
 drivers/dsp/bridge/rmgr/drv.c           |   91 ++++++++++++----------------
 drivers/dsp/bridge/rmgr/drv_interface.c |   27 ++++-----
 drivers/dsp/bridge/rmgr/dspdrv.c        |    8 +--
 drivers/dsp/bridge/rmgr/mgr.c           |   21 ++-----
 drivers/dsp/bridge/rmgr/nldr.c          |   26 +++-----
 drivers/dsp/bridge/rmgr/node.c          |   97 ++++++++++++------------------
 drivers/dsp/bridge/rmgr/proc.c          |   60 +++++++------------
 drivers/dsp/bridge/rmgr/strm.c          |   34 ++++++------
 10 files changed, 182 insertions(+), 269 deletions(-)
 create mode 100644 drivers/dsp/bridge/uTimeout

diff --git a/drivers/dsp/bridge/rmgr/dbdcd.c b/drivers/dsp/bridge/rmgr/dbdcd.c
index 5e07abd..067f7a0 100644
--- a/drivers/dsp/bridge/rmgr/dbdcd.c
+++ b/drivers/dsp/bridge/rmgr/dbdcd.c
@@ -473,8 +473,7 @@ DSP_STATUS DCD_GetObjectDef(IN struct DCD_MANAGER *hDcdMgr,
 		status = COD_ReadSection(lib, szSectName, pszCoffBuf, ulLen);
 	} else {
 		status = COD_ReadSection(lib, szSectName, pszCoffBuf, ulLen);
-		GT_0trace(curTrace, GT_4CLASS,
-			 "Skipped Byte swap for IVA !!\n");
+		dev_dbg(bridge, "%s: Skipped Byte swap for IVA!!\n", __func__);
 	}
 #else
 	status = COD_ReadSection(lib, szSectName, pszCoffBuf, ulLen);
@@ -485,8 +484,8 @@ DSP_STATUS DCD_GetObjectDef(IN struct DCD_MANAGER *hDcdMgr,
 			CompressBuf(pszCoffBuf, ulLen, DSPWORDSIZE);
 		} else {
 			CompressBuf(pszCoffBuf, ulLen, 1);
-			GT_0trace(curTrace, GT_4CLASS, "Compressing IVA "
-				 "COFF buffer by 1 for IVA !!\n");
+			dev_dbg(bridge, "%s: Compressing IVA COFF buffer by 1 "
+						"for IVA!!\n", __func__);
 		}
 
 		/* Parse the content of the COFF buffer. */
@@ -554,7 +553,7 @@ DSP_STATUS DCD_GetObjects(IN struct DCD_MANAGER *hDcdMgr, IN char *pszCoffPath,
 		status = COD_ReadSection(lib, DCD_REGISTER_SECTION,
 					pszCoffBuf, ulLen);
 	} else {
-		GT_0trace(curTrace, GT_4CLASS, "Skipped Byte swap for IVA!!\n");
+		dev_dbg(bridge, "%s: Skipped Byte swap for IVA!!\n", __func__);
 		status = COD_ReadSection(lib, DCD_REGISTER_SECTION,
 					pszCoffBuf, ulLen);
 	}
@@ -567,8 +566,8 @@ DSP_STATUS DCD_GetObjects(IN struct DCD_MANAGER *hDcdMgr, IN char *pszCoffPath,
 			CompressBuf(pszCoffBuf, ulLen, DSPWORDSIZE);
 		} else {
 			CompressBuf(pszCoffBuf, ulLen, 1);
-			GT_0trace(curTrace, GT_4CLASS, "Compress COFF buffer "
-				 "with 1 word for IVA !!\n");
+			dev_dbg(bridge, "%s: Compress COFF buffer with 1 word "
+						"for IVA!!\n", __func__);
 		}
 
 		/* Read from buffer and register object in buffer. */
@@ -633,10 +632,9 @@ DSP_STATUS DCD_GetLibraryName(IN struct DCD_MANAGER *hDcdMgr,
 	DBC_Require(pdwSize != NULL);
 	DBC_Require(IsValidHandle(hDcdMgr));
 
-	GT_4trace(curTrace, GT_ENTER,
-		 "DCD_GetLibraryName: hDcdMgr 0x%x, pUuid 0x%x, "
-		 " pstrLibName 0x%x, pdwSize 0x%x\n", hDcdMgr, pUuid,
-		 pstrLibName, pdwSize);
+	dev_dbg(bridge, "%s: hDcdMgr %p, pUuid %p, pstrLibName %p, pdwSize "
+					"%p\n", __func__, hDcdMgr, pUuid,
+					pstrLibName, pdwSize);
 
 	/*
 	 *  Pre-determine final key length. It's length of DCD_REGKEY +
@@ -783,8 +781,8 @@ DSP_STATUS DCD_RegisterObject(IN struct DSP_UUID *pUuid,
 			(objType == DSP_DCDEXECUTELIBTYPE) ||
 			(objType == DSP_DCDDELETELIBTYPE));
 
-	GT_3trace(curTrace, GT_ENTER, "DCD_RegisterObject: object UUID 0x%x, "
-		 "objType %d, szPathName %s\n", pUuid, objType, pszPathName);
+	dev_dbg(bridge, "%s: object UUID %p, objType %d, szPathName %s\n",
+					__func__, pUuid, objType, pszPathName);
 
 	/*
 	 * Pre-determine final key length. It's length of DCD_REGKEY +
@@ -832,9 +830,8 @@ DSP_STATUS DCD_RegisterObject(IN struct DSP_UUID *pUuid,
 		/* Add new reg value (UUID+objType) with COFF path info */
 		dwPathSize = strlen(pszPathName) + 1;
 		status = REG_SetValue(szRegKey, (u8 *)pszPathName, dwPathSize);
-		GT_2trace(curTrace, GT_6CLASS, "REG_SetValue  "
-			  "(u8 *)pszPathName=%s, dwPathSize=%d\n",
-			  pszPathName, dwPathSize);
+		dev_dbg(bridge, "%s: pszPathName=%s, dwPathSize=%d\n", __func__,
+						pszPathName, dwPathSize);
 	} else {
 		/* Deregister an existing object */
 		status = REG_DeleteValue(szRegKey);
diff --git a/drivers/dsp/bridge/rmgr/disp.c b/drivers/dsp/bridge/rmgr/disp.c
index 795856b..8c05593 100644
--- a/drivers/dsp/bridge/rmgr/disp.c
+++ b/drivers/dsp/bridge/rmgr/disp.c
@@ -304,9 +304,8 @@ DSP_STATUS DISP_NodeCreate(struct DISP_OBJECT *hDisp, struct NODE_OBJECT *hNode,
 		goto func_end;
 
 	if (devType != DSP_UNIT) {
-		GT_1trace(DISP_DebugMask, GT_7CLASS,
-			 "DISP_NodeCreate unknown device "
-			 "type = 0x%x\n", devType);
+		dev_dbg(bridge, "%s: unknown device type = 0x%x\n",
+							__func__, devType);
 		goto func_end;
 	}
 	DBC_Require(pArgs != NULL);
@@ -323,10 +322,8 @@ DSP_STATUS DISP_NodeCreate(struct DISP_OBJECT *hDisp, struct NODE_OBJECT *hNode,
 		/ sizeof(RMS_WORD)  - 1 + dwLength;
 	if (total >= max) {
 		status = DSP_EFAIL;
-		GT_2trace(DISP_DebugMask, GT_6CLASS,
-			"DISP_NodeCreate: Message args too"
-			" large for buffer! Message args size = %d, max = %d\n",
-			total, max);
+		dev_dbg(bridge, "%s: Message args too large for buffer! size "
+				"= %d, max = %d\n", __func__, total, max);
 	}
 	/*
 	 *  Fill in buffer to send to RMS.
@@ -423,10 +420,9 @@ DSP_STATUS DISP_NodeCreate(struct DISP_OBJECT *hDisp, struct NODE_OBJECT *hNode,
 			pMoreTaskArgs->numInputStreams = taskArgs.uNumInputs;
 			total +=
 			    sizeof(struct RMS_MoreTaskArgs) / sizeof(RMS_WORD);
-			GT_2trace(DISP_DebugMask, GT_7CLASS,
-				 "DISP::::uDSPHeapAddr %x, "
-				 "uHeapSize %x\n", taskArgs.uDSPHeapAddr,
-				 taskArgs.uHeapSize);
+			dev_dbg(bridge, "%s: uDSPHeapAddr %x, uHeapSize %x\n",
+					__func__, taskArgs.uDSPHeapAddr,
+					taskArgs.uHeapSize);
 			/* Keep track of pSIOInDef[] and pSIOOutDef[]
 			 * positions in the buffer, since this needs to be
 			 * filled in later.  */
@@ -477,13 +473,9 @@ DSP_STATUS DISP_NodeCreate(struct DISP_OBJECT *hDisp, struct NODE_OBJECT *hNode,
 			 * on the DSP-side
 			 */
 			status = (((RMS_WORD *)(hDisp->pBuf))[0]);
-			if (DSP_FAILED(status)) {
-				GT_1trace(DISP_DebugMask, GT_6CLASS,
-					 "DISP_NodeCreate, "
-					 "DSP-side Node Create failed: 0x%x\n",
-					 status);
-			}
-
+			if (DSP_FAILED(status))
+				dev_dbg(bridge, "%s: DSP-side failed: 0x%x\n",
+							__func__, status);
 		}
 	}
 func_end:
@@ -532,12 +524,9 @@ DSP_STATUS DISP_NodeDelete(struct DISP_OBJECT *hDisp, struct NODE_OBJECT *hNode,
 				 * function on the DSP-side
 				 */
 				status = (((RMS_WORD *)(hDisp->pBuf))[0]);
-				if (DSP_FAILED(status)) {
-					GT_1trace(DISP_DebugMask, GT_6CLASS,
-					 "DISP_NodeDelete, "
-					 "DSP-side Node Delete failed: 0x%x\n",
-					 status);
-				}
+				if (DSP_FAILED(status))
+					dev_dbg(bridge, "%s: DSP-side failed: "
+						"0x%x\n", __func__, status);
 			}
 
 
@@ -587,12 +576,9 @@ DSP_STATUS DISP_NodeRun(struct DISP_OBJECT *hDisp, struct NODE_OBJECT *hNode,
 				 * function on the DSP-side
 				 */
 				status = (((RMS_WORD *)(hDisp->pBuf))[0]);
-				if (DSP_FAILED(status)) {
-					GT_1trace(DISP_DebugMask, GT_6CLASS,
-						"DISP_NodeRun, DSP-side Node "
-						"Execute failed: 0x%x\n",
-						status);
-		}
+				if (DSP_FAILED(status))
+					dev_dbg(bridge, "%s: DSP-side failed: "
+						"0x%x\n", __func__, status);
 		}
 
 	}
@@ -621,19 +607,15 @@ static void DeleteDisp(struct DISP_OBJECT *hDisp)
 			status = (*pIntfFxns->pfnChnlClose)
 				 (hDisp->hChnlFromDsp);
 			if (DSP_FAILED(status)) {
-				GT_1trace(DISP_DebugMask, GT_6CLASS,
-					 "DISP_Delete: Failed to "
-					 "close channel from RMS: 0x%x\n",
-					 status);
+				dev_dbg(bridge, "%s: Failed to close channel "
+					"from RMS: 0x%x\n", __func__, status);
 			}
 		}
 		if (hDisp->hChnlToDsp) {
 			status = (*pIntfFxns->pfnChnlClose)(hDisp->hChnlToDsp);
 			if (DSP_FAILED(status)) {
-				GT_1trace(DISP_DebugMask, GT_6CLASS,
-					 "DISP_Delete: Failed to "
-					 "close channel to RMS: 0x%x\n",
-					 status);
+				dev_dbg(bridge, "%s: Failed to close channel to"
+					" RMS: 0x%x\n", __func__, status);
 			}
 		}
 		kfree(hDisp->pBuf);
diff --git a/drivers/dsp/bridge/rmgr/drv.c b/drivers/dsp/bridge/rmgr/drv.c
index 44208b7..f3e2632 100644
--- a/drivers/dsp/bridge/rmgr/drv.c
+++ b/drivers/dsp/bridge/rmgr/drv.c
@@ -861,24 +861,23 @@ DSP_STATUS DRV_RequestResources(u32 dwContext, u32 *pDevNodeString)
 			*pDevNodeString = 0;
 		}
 	} else {
-		GT_0trace(curTrace, GT_7CLASS,
-			 "Failed to get Driver Object from Registry");
+		dev_dbg(bridge, "%s: Failed to get Driver Object from Registry",
+								__func__);
 		*pDevNodeString = 0;
 	}
 
 	if (!(strcmp((char *) dwContext, "TIOMAP1510"))) {
-		GT_0trace(curTrace, GT_1CLASS,
-			  " Allocating resources for UMA \n");
+		dev_dbg(bridge, "%s: Allocating resources for UMA\n", __func__);
 		status = RequestBridgeResourcesDSP(dwContext, DRV_ASSIGN);
 	} else {
 		status = DSP_EFAIL;
-		GT_0trace(curTrace, GT_7CLASS, "Unknown Device ");
+		dev_dbg(bridge, "%s: Unknown Device\n", __func__);
 	}
 
-	if (DSP_FAILED(status)) {
-		GT_0trace(curTrace, GT_7CLASS,
-			 "Failed to reserve bridge resources ");
-	}
+	if (DSP_FAILED(status))
+		dev_dbg(bridge, "%s: Failed to reserve bridge resources\n",
+								__func__);
+
 	DBC_Ensure((DSP_SUCCEEDED(status) && pDevNodeString != NULL &&
 		  !LST_IsEmpty(pDRVObject->devNodeString)) ||
 		  (DSP_FAILED(status) && *pDevNodeString == 0));
@@ -901,11 +900,11 @@ DSP_STATUS DRV_ReleaseResources(u32 dwContext, struct DRV_OBJECT *hDrvObject)
 	   "TIOMAP1510")))
 		status = RequestBridgeResources(dwContext, DRV_RELEASE);
 	else
-		GT_0trace(curTrace, GT_1CLASS, " Unknown device\n");
+		dev_dbg(bridge, "%s: Unknown device\n", __func__);
 
 	if (DSP_FAILED(status))
-		GT_0trace(curTrace, GT_1CLASS,
-			 "Failed to relese bridge resources\n");
+		dev_dbg(bridge, "%s: Failed to relese bridge resources\n",
+								__func__);
 
 	/*
 	 *  Irrespective of the status go ahead and clean it
@@ -973,10 +972,9 @@ static DSP_STATUS RequestBridgeResources(u32 dwContext, s32 bRequest)
 					shm_size);
 				}
 			} else {
-				GT_1trace(curTrace, GT_7CLASS,
-					"Error getting SHM size from registry: "
-					"%x. Not calling MEM_FreePhysMem\n",
-					status);
+				dev_dbg(bridge, "%s: Error getting SHM size "
+					"from registry: %x. Not calling "
+					"MEM_FreePhysMem\n", __func__, status);
 			}
 			pResources->dwMemBase[1] = 0;
 			pResources->dwMemPhys[1] = 0;
@@ -1044,20 +1042,16 @@ static DSP_STATUS RequestBridgeResources(u32 dwContext, s32 bRequest)
 							OMAP_MBOX_SIZE);
 		pResources->dwSysCtrlBase = ioremap(OMAP_SYSC_BASE,
 							OMAP_SYSC_SIZE);
-		GT_1trace(curTrace, GT_2CLASS, "dwMemBase[0] 0x%x\n",
-			 pResources->dwMemBase[0]);
-		GT_1trace(curTrace, GT_2CLASS, "dwMemBase[3] 0x%x\n",
-			 pResources->dwMemBase[3]);
-		GT_1trace(curTrace, GT_2CLASS, "dwPrmBase 0x%x\n",
-							pResources->dwPrmBase);
-		GT_1trace(curTrace, GT_2CLASS, "dwCmBase 0x%x\n",
-							pResources->dwCmBase);
-		GT_1trace(curTrace, GT_2CLASS, "dwWdTimerDspBase 0x%x\n",
+		dev_dbg(bridge, "dwMemBase[0] 0x%x\n",
+						pResources->dwMemBase[0]);
+		dev_dbg(bridge, "dwMemBase[3] 0x%x\n",
+						pResources->dwMemBase[3]);
+		dev_dbg(bridge, "dwPrmBase %p\n", pResources->dwPrmBase);
+		dev_dbg(bridge, "dwCmBase %p\n", pResources->dwCmBase);
+		dev_dbg(bridge, "dwWdTimerDspBase %p\n",
 						pResources->dwWdTimerDspBase);
-		GT_1trace(curTrace, GT_2CLASS, "dwMboxBase 0x%x\n",
-						pResources->dwMboxBase);
-		GT_1trace(curTrace, GT_2CLASS, "dwDmmuBase 0x%x\n",
-						pResources->dwDmmuBase);
+		dev_dbg(bridge, "dwMboxBase %p\n", pResources->dwMboxBase);
+		dev_dbg(bridge, "dwDmmuBase %p\n", pResources->dwDmmuBase);
 
 		/* for 24xx base port is not mapping the mamory for DSP
 		 * internal memory TODO Do a ioremap here */
@@ -1075,9 +1069,8 @@ static DSP_STATUS RequestBridgeResources(u32 dwContext, s32 bRequest)
 		status = REG_SetValue(CURRENTCONFIG, (u8 *)pResources,
 						sizeof(struct CFG_HOSTRES));
 		if (DSP_FAILED(status)) {
-			GT_0trace(curTrace, GT_7CLASS,
-				 " Failed to set the registry "
-				 "value for CURRENTCONFIG\n");
+			dev_dbg(bridge, "%s: Failed to set the registry value "
+					"for CURRENTCONFIG\n", __func__);
 		}
 		kfree(pResources);
 	}
@@ -1135,26 +1128,22 @@ static DSP_STATUS RequestBridgeResourcesDSP(u32 dwContext, s32 bRequest)
 							OMAP_DMMU_SIZE);
 		pResources->dwWdTimerDspBase = NULL;
 
-		GT_1trace(curTrace, GT_2CLASS, "dwMemBase[0] 0x%x\n",
+		dev_dbg(bridge, "dwMemBase[0] 0x%x\n",
 						pResources->dwMemBase[0]);
-		GT_1trace(curTrace, GT_2CLASS, "dwMemBase[1] 0x%x\n",
+		dev_dbg(bridge, "dwMemBase[1] 0x%x\n",
 						pResources->dwMemBase[1]);
-		GT_1trace(curTrace, GT_2CLASS, "dwMemBase[2] 0x%x\n",
+		dev_dbg(bridge, "dwMemBase[2] 0x%x\n",
 						pResources->dwMemBase[2]);
-		GT_1trace(curTrace, GT_2CLASS, "dwMemBase[3] 0x%x\n",
+		dev_dbg(bridge, "dwMemBase[3] 0x%x\n",
 						pResources->dwMemBase[3]);
-		GT_1trace(curTrace, GT_2CLASS, "dwMemBase[4] 0x%x\n",
+		dev_dbg(bridge, "dwMemBase[4] 0x%x\n",
 						pResources->dwMemBase[4]);
-		GT_1trace(curTrace, GT_2CLASS, "dwPrmBase 0x%x\n",
-						pResources->dwPrmBase);
-		GT_1trace(curTrace, GT_2CLASS, "dwCmBase 0x%x\n",
-						pResources->dwCmBase);
-		GT_1trace(curTrace, GT_2CLASS, "dwWdTimerDspBase 0x%x\n",
+		dev_dbg(bridge, "dwPrmBase %p\n", pResources->dwPrmBase);
+		dev_dbg(bridge, "dwCmBase %p\n", pResources->dwCmBase);
+		dev_dbg(bridge, "dwWdTimerDspBase %p\n",
 						pResources->dwWdTimerDspBase);
-		GT_1trace(curTrace, GT_2CLASS, "dwMboxBase 0x%x\n",
-						pResources->dwMboxBase);
-		GT_1trace(curTrace, GT_2CLASS, "dwDmmuBase 0x%x\n",
-						pResources->dwDmmuBase);
+		dev_dbg(bridge, "dwMboxBase %p\n", pResources->dwMboxBase);
+		dev_dbg(bridge, "dwDmmuBase %p\n", pResources->dwDmmuBase);
 		dwBuffSize = sizeof(shm_size);
 		status = REG_GetValue(SHMSIZE, (u8 *)&shm_size, &dwBuffSize);
 		if (DSP_SUCCEEDED(status)) {
@@ -1170,9 +1159,8 @@ static DSP_STATUS RequestBridgeResourcesDSP(u32 dwContext, s32 bRequest)
 				pResources->dwMemLength[1] = shm_size;
 				pResources->dwMemPhys[1] = dmaAddr;
 
-				GT_3trace(curTrace, GT_1CLASS,
-					 "Bridge SHM address 0x%x dmaAddr"
-					 " %x size %x\n",
+				dev_dbg(bridge, "%s: Bridge SHM address 0x%x "
+					"dmaAddr %x size %x\n", __func__,
 					 pResources->dwMemBase[1],
 					 dmaAddr, shm_size);
 			}
@@ -1190,9 +1178,8 @@ static DSP_STATUS RequestBridgeResourcesDSP(u32 dwContext, s32 bRequest)
 			status = REG_SetValue(CURRENTCONFIG, (u8 *)pResources,
 					     sizeof(struct CFG_HOSTRES));
 			if (DSP_FAILED(status)) {
-				GT_0trace(curTrace, GT_7CLASS,
-					 " Failed to set the registry value"
-					 " for CURRENTCONFIG\n");
+				dev_dbg(bridge, "%s: Failed to set the registry"
+					" value for CURRENTCONFIG\n", __func__);
 			}
 		}
 		kfree(pResources);
diff --git a/drivers/dsp/bridge/rmgr/drv_interface.c b/drivers/dsp/bridge/rmgr/drv_interface.c
index cadb670..4045784 100644
--- a/drivers/dsp/bridge/rmgr/drv_interface.c
+++ b/drivers/dsp/bridge/rmgr/drv_interface.c
@@ -301,27 +301,26 @@ static int __devinit omap34xx_bridge_probe(struct platform_device *pdev)
 		status = -1;
 		pr_err("%s: SHM size must be at least 64 KB\n", __func__);
 	}
-	GT_1trace(driverTrace, GT_7CLASS,
-		 "requested shm_size = 0x%x\n", shm_size);
+	dev_dbg(bridge, "%s: requested shm_size = 0x%x\n", __func__, shm_size);
 
 	if (pdata->phys_mempool_base && pdata->phys_mempool_size) {
 		phys_mempool_base = pdata->phys_mempool_base;
 		phys_mempool_size = pdata->phys_mempool_size;
 	}
 
-	GT_1trace(driverTrace, GT_7CLASS, "phys_mempool_base = 0x%x \n",
-		 phys_mempool_base);
+	dev_dbg(bridge, "%s: phys_mempool_base = 0x%x \n", __func__,
+							phys_mempool_base);
 
-	GT_1trace(driverTrace, GT_7CLASS, "phys_mempool_size = 0x%x\n",
-		 phys_mempool_base);
+	dev_dbg(bridge, "%s: phys_mempool_size = 0x%x\n", __func__,
+							phys_mempool_base);
 	if ((phys_mempool_base > 0x0) && (phys_mempool_size > 0x0))
 		MEM_ExtPhysPoolInit(phys_mempool_base, phys_mempool_size);
 	if (tc_wordswapon) {
-		GT_0trace(driverTrace, GT_7CLASS, "TC Word Swap is enabled\n");
+		dev_dbg(bridge, "%s: TC Word Swap is enabled\n", __func__);
 		REG_SetValue(TCWORDSWAP, (u8 *)&tc_wordswapon,
 			    sizeof(tc_wordswapon));
 	} else {
-		GT_0trace(driverTrace, GT_7CLASS, "TC Word Swap is disabled\n");
+		dev_dbg(bridge, "%s: TC Word Swap is disabled\n", __func__);
 		REG_SetValue(TCWORDSWAP, (u8 *)&tc_wordswapon,
 			    sizeof(tc_wordswapon));
 	}
@@ -537,8 +536,8 @@ static long bridge_ioctl(struct file *filp, unsigned int code,
 		if (DSP_SUCCEEDED(status)) {
 			status = retval;
 		} else {
-			GT_1trace(driverTrace, GT_7CLASS,
-				 "IOCTL Failed, code : 0x%x\n", code);
+			dev_dbg(bridge, "%s: IOCTL Failed, code: 0x%x "
+				"status 0x%x\n", __func__, code, status);
 			status = -1;
 		}
 
@@ -561,10 +560,10 @@ static int bridge_mmap(struct file *filp, struct vm_area_struct *vma)
 	vma->vm_flags |= VM_RESERVED | VM_IO;
 	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
 
-	GT_6trace(driverTrace, GT_3CLASS,
-		 "vm filp %p offset %lx start %lx end %lx"
-		 " page_prot %lx flags %lx\n", filp, offset, vma->vm_start,
-		 vma->vm_end, vma->vm_page_prot, vma->vm_flags);
+	dev_dbg(bridge, "%s: vm filp %p offset %x start %lx end %lx page_prot "
+				"%lx flags %lx\n", __func__, filp, offset,
+				vma->vm_start, vma->vm_end, vma->vm_page_prot,
+				vma->vm_flags);
 
 	status = remap_pfn_range(vma, vma->vm_start, vma->vm_pgoff,
 				vma->vm_end - vma->vm_start, vma->vm_page_prot);
diff --git a/drivers/dsp/bridge/rmgr/dspdrv.c b/drivers/dsp/bridge/rmgr/dspdrv.c
index b6a9bc4..59c2ecb 100644
--- a/drivers/dsp/bridge/rmgr/dspdrv.c
+++ b/drivers/dsp/bridge/rmgr/dspdrv.c
@@ -80,8 +80,7 @@ u32 DSP_Init(OUT u32 *initStatus)
 			(void)DRV_ReleaseResources
 				((u32) deviceNodeString, drvObject);
 	} else {
-		GT_0trace(curTrace, GT_7CLASS,
-			 "DSP_Init:DRV_RequestResources Failed \r\n");
+		dev_dbg(bridge, "%s: DRV_RequestResources Failed\n", __func__);
 		status = DSP_EFAIL;
 	}
 
@@ -102,8 +101,7 @@ u32 DSP_Init(OUT u32 *initStatus)
 		(void)DRV_Destroy(drvObject);
 		drvObject = NULL;
 		WCD_Exit();
-		GT_0trace(curTrace, GT_7CLASS,
-			 "DSP_Init:Logical device Failed to Load\n");
+		dev_dbg(bridge, "%s: Logical device failed init\n", __func__);
 	}	/* Unwinding the loaded drivers */
 func_cont:
 	/* Attempt to Start the Board */
@@ -113,7 +111,7 @@ func_cont:
 		 * into the device loader. */
 		(void)WCD_InitComplete2();
 	} else {
-		GT_0trace(curTrace, GT_7CLASS, "DSP_Init Failed\n");
+		dev_dbg(bridge, "%s: Failed\n", __func__);
 	}			/* End WCD_InitComplete2 */
 	DBC_Ensure((DSP_SUCCEEDED(status) && drvObject != NULL) ||
 		  (DSP_FAILED(status) && drvObject == NULL));
diff --git a/drivers/dsp/bridge/rmgr/mgr.c b/drivers/dsp/bridge/rmgr/mgr.c
index b905906..73d7a66 100644
--- a/drivers/dsp/bridge/rmgr/mgr.c
+++ b/drivers/dsp/bridge/rmgr/mgr.c
@@ -238,9 +238,7 @@ DSP_STATUS MGR_EnumProcessorInfo(u32 uProcessor,
 	/* Get The Manager Object from the Registry */
 	if (DSP_FAILED(CFG_GetObject((u32 *)&pMgrObject,
 	   REG_MGR_OBJECT))) {
-		GT_0trace(MGR_DebugMask, GT_7CLASS,
-			 "Manager_EnumProcessorInfo: "
-			 "Failed To Get MGR Object from Registry\r\n");
+		dev_dbg(bridge, "%s: Failed to get MGR Object\n", __func__);
 		goto func_end;
 	}
 	DBC_Assert(MEM_IsValidHandle(pMgrObject, SIGNATURE));
@@ -274,10 +272,8 @@ DSP_STATUS MGR_EnumProcessorInfo(u32 uProcessor,
 						pProcessorInfo;
 				*pExtInfo = GenObj.objData.extProcObj;
 			}
-			GT_1trace(MGR_DebugMask, GT_7CLASS,
-				 "Manager_EnumProcessorInfo: Got"
-				 " Proctype  from DCD %x \r\n",
-				 pProcessorInfo->uProcessorType);
+			dev_dbg(bridge, "%s: Got proctype  from DCD %x\n",
+				__func__, pProcessorInfo->uProcessorType);
 			/* See if we got the needed processor */
 			if (devType == DSP_UNIT) {
 				if (pProcessorInfo->uProcessorType ==
@@ -293,18 +289,15 @@ DSP_STATUS MGR_EnumProcessorInfo(u32 uProcessor,
 			pProcessorInfo->uProcessorType =
 					 chipResources.uChipType;
 		} else {
-			GT_1trace(MGR_DebugMask, GT_7CLASS,
-				 "Manager_EnumProcessorInfo: "
-				 "Failed to Get DCD Processor Info %x \r\n",
-				 status2);
+			dev_dbg(bridge, "%s: Failed to get DCD processor info "
+						"%x\n", __func__, status2);
 			status = DSP_EFAIL;
 		}
 	}
 	*puNumProcs = uProcIndex;
 	if (procDetect == false) {
-		GT_0trace(MGR_DebugMask, GT_7CLASS,
-			 "Manager_EnumProcessorInfo: Failed"
-			 " to get Proc info from DCD , so use CFG registry\n");
+		dev_dbg(bridge, "%s: Failed to get proc info from DCD, so use "
+						"CFG registry\n", __func__);
 		pProcessorInfo->uProcessorType = chipResources.uChipType;
 	}
 func_end:
diff --git a/drivers/dsp/bridge/rmgr/nldr.c b/drivers/dsp/bridge/rmgr/nldr.c
index e964d4b..fb5a788 100644
--- a/drivers/dsp/bridge/rmgr/nldr.c
+++ b/drivers/dsp/bridge/rmgr/nldr.c
@@ -509,10 +509,8 @@ DSP_STATUS NLDR_Create(OUT struct NLDR_OBJECT **phNldr,
 			/* Ok to not have dynamic loading memory */
 			status = DSP_SOK;
 			ulLen = 0;
-			GT_1trace(NLDR_debugMask, GT_6CLASS,
-				 "NLDR_Create: DBLL_getSect "
-				 "failed (no dynamic loading mem segments): "
-				 "0x%lx\n", status);
+			dev_dbg(bridge, "%s: failed - no dynamic loading mem "
+					"segments: 0x%x\n", __func__, status);
 		}
 	}
 	if (DSP_SUCCEEDED(status) && ulLen > 0) {
@@ -543,10 +541,9 @@ DSP_STATUS NLDR_Create(OUT struct NLDR_OBJECT **phNldr,
 				rmmSegs[i].space = 0;
 				pNldr->segTable[i] = (pMemInfo + i)->type;
 #ifdef CONFIG_BRIDGE_DEBUG
-				DBG_Trace(DBG_LEVEL7,
-				    "** (proc) DLL MEMSEGMENT: %d, Base: 0x%x, "
-				    "Length: 0x%x\n", i, rmmSegs[i].base,
-				    rmmSegs[i].length);
+				dev_dbg(bridge, "(proc) DLL MEMSEGMENT: %d, "
+					"Base: 0x%x, Length: 0x%x\n", i,
+					rmmSegs[i].base, rmmSegs[i].length);
 #endif
 			}
 		}
@@ -1596,8 +1593,7 @@ static DSP_STATUS RemoteAlloc(void **pRef, u16 space, u32 size,
 	nWords = (size + hNldr->usDSPWordSize - 1) / hNldr->usDSPWordSize;
 	/* Modify memory 'align' to account for DSP cache line size */
 	align = findLcm(GEM_CACHE_LINE_SIZE, align);
-	GT_1trace(NLDR_debugMask, GT_7CLASS,
-		 "RemoteAlloc: memory align to 0x%x \n", align);
+	dev_dbg(bridge, "%s: memory align to 0x%x\n", __func__, align);
 	if (segmentId != -1) {
 		pRmmAddr->segid = segmentId;
 		segid = segmentId;
@@ -1642,9 +1638,8 @@ static DSP_STATUS RemoteAlloc(void **pRef, u16 space, u32 size,
 		pRmmAddr->segid = segid;
 		status = RMM_alloc(rmm, segid, nWords, align, dspAddr, false);
 		if (DSP_FAILED(status)) {
-			GT_1trace(NLDR_debugMask, GT_6CLASS,
-				 "RemoteAlloc:Unable allocate "
-				 "from segment %d.\n", segid);
+			dev_dbg(bridge, "%s: Unable allocate from segment %d\n",
+							__func__, segid);
 		}
 	} else {
 		/* segid > MAXSEGID ==> Internal or external memory */
@@ -1669,9 +1664,8 @@ static DSP_STATUS RemoteAlloc(void **pRef, u16 space, u32 size,
 func_cont:
 	/* Haven't found memory yet, attempt to find any segment that works */
 	if (status == DSP_EMEMORY && !fReq) {
-		GT_0trace(NLDR_debugMask, GT_6CLASS,
-			 "RemoteAlloc: Preferred segment "
-			 "unavailable, trying another segment.\n");
+		dev_dbg(bridge, "%s: Preferred segment unavailable, trying "
+							"another\n", __func__);
 		for (i = 0; i < hNldr->nSegs; i++) {
 			/* All bits of memType must be set */
 			if ((hNldr->segTable[i] & memType) != memType)
diff --git a/drivers/dsp/bridge/rmgr/node.c b/drivers/dsp/bridge/rmgr/node.c
index 1c8b4a5..48a7728 100644
--- a/drivers/dsp/bridge/rmgr/node.c
+++ b/drivers/dsp/bridge/rmgr/node.c
@@ -341,11 +341,6 @@ DSP_STATUS NODE_Allocate(struct PROC_OBJECT *hProcessor,
 	DBC_Require(phNode != NULL);
 	DBC_Require(pNodeId != NULL);
 
-	GT_5trace(NODE_debugMask, GT_ENTER, "NODE_Allocate: \thProcessor: "
-		"0x%x\tpNodeId: 0x%x\tpArgs: 0x%x\tpAttrIn: "
-		"0x%x\tphNode: 0x%x\n", hProcessor, pNodeId, pArgs, pAttrIn,
-		phNode);
-
 	*phNode = NULL;
 
 	status = PROC_GetProcessorId(hProcessor, &procId);
@@ -610,10 +605,9 @@ func_cont:
 			ulStackSegVal = (u32)*((REG_UWORD32 *)
 					((u32)(ulStackSegAddr)));
 
-			GT_1trace(NODE_debugMask, GT_5CLASS,
-				 "StackSegVal =0x%x\n", ulStackSegVal);
-			GT_1trace(NODE_debugMask, GT_5CLASS,
-				 "ulStackSegAddr = 0x%x\n", ulStackSegAddr);
+			dev_dbg(bridge, "%s: StackSegVal = 0x%x, StackSegAddr ="
+					" 0x%x\n", __func__, ulStackSegVal,
+					ulStackSegAddr);
 
 			pNode->createArgs.asa.taskArgs.uStackSeg =
 				ulStackSegVal;
@@ -665,6 +659,9 @@ func_cont:
 		  (DSP_SUCCEEDED(status)
 		    && MEM_IsValidHandle((*phNode), NODE_SIGNATURE)));
 func_end:
+	dev_dbg(bridge, "%s: hProcessor: %p pNodeId: %p pArgs: %p pAttrIn: %p "
+			"phNode: %p status: 0x%x\n", __func__, hProcessor,
+			pNodeId, pArgs, pAttrIn, phNode, status);
 	return status;
 }
 
@@ -841,10 +838,6 @@ DSP_STATUS NODE_Connect(struct NODE_OBJECT *hNode1, u32 uStream1,
 	u32 dwLength;
 	DSP_STATUS status = DSP_SOK;
 	DBC_Require(cRefs > 0);
-	GT_5trace(NODE_debugMask, GT_ENTER,
-		 "NODE_Connect: hNode1: 0x%x\tuStream1:"
-		 " %d\thNode2: 0x%x\tuStream2: %d\tpAttrs: 0x%x\n", hNode1,
-		 uStream1, hNode2, uStream2, pAttrs);
 
 	if ((hNode1 != (struct NODE_OBJECT *) DSP_HGPPNODE &&
 			!MEM_IsValidHandle(hNode1, NODE_SIGNATURE)) ||
@@ -1116,6 +1109,9 @@ func_cont:
 	/* Exit critical section */
 	(void)SYNC_LeaveCS(hNodeMgr->hSync);
 func_end:
+	dev_dbg(bridge, "%s: hNode1: %p uStream1: %d hNode2: %p uStream2: %d"
+				"pAttrs: %p status: 0x%x\n", __func__, hNode1,
+				uStream1, hNode2, uStream2, pAttrs, status);
 	return status;
 }
 
@@ -1143,8 +1139,6 @@ DSP_STATUS NODE_Create(struct NODE_OBJECT *hNode)
 #endif
 
 	DBC_Require(cRefs > 0);
-	GT_1trace(NODE_debugMask, GT_ENTER, "NODE_Create: hNode: 0x%x\n",
-		 hNode);
 	if (!MEM_IsValidHandle(pNode, NODE_SIGNATURE)) {
 		status = DSP_EHANDLE;
 		goto func_end;
@@ -1273,6 +1267,8 @@ func_end:
 		NTFY_Notify(hNode->hNtfy, DSP_NODESTATECHANGE);
 	}
 
+	dev_dbg(bridge, "%s: hNode: %p status: 0x%x\n", __func__,
+							hNode, status);
 	return status;
 }
 
@@ -1423,8 +1419,7 @@ DSP_STATUS NODE_Delete(struct NODE_OBJECT *hNode,
 
 	struct DSP_PROCESSORSTATE procStatus;
 	DBC_Require(cRefs > 0);
-	GT_1trace(NODE_debugMask, GT_ENTER, "NODE_Delete: hNode: 0x%x\n",
-		  hNode);
+
 	if (!MEM_IsValidHandle(hNode, NODE_SIGNATURE)) {
 		status = DSP_EHANDLE;
 		goto func_end;
@@ -1542,6 +1537,7 @@ func_cont1:
 	(void)SYNC_LeaveCS(hNodeMgr->hSync);
 	PROC_NotifyClients(hProcessor, DSP_NODESTATECHANGE);
 func_end:
+	dev_dbg(bridge, "%s: hNode: %p status 0x%x\n", __func__, hNode, status);
 	return status;
 }
 
@@ -1775,9 +1771,7 @@ DSP_STATUS NODE_GetMessage(struct NODE_OBJECT *hNode, OUT struct DSP_MSG *pMsg,
 
 	DBC_Require(cRefs > 0);
 	DBC_Require(pMsg != NULL);
-	GT_3trace(NODE_debugMask, GT_ENTER,
-		 "NODE_GetMessage: hNode: 0x%x\tpMsg: "
-		 "0x%x\tuTimeout: 0x%x\n", hNode, pMsg, uTimeout);
+
 	if (!MEM_IsValidHandle(hNode, NODE_SIGNATURE)) {
 		status = DSP_EHANDLE;
 		goto func_end;
@@ -1830,6 +1824,8 @@ DSP_STATUS NODE_GetMessage(struct NODE_OBJECT *hNode, OUT struct DSP_MSG *pMsg,
 		status = DSP_ETRANSLATE;
 	}
 func_end:
+	dev_dbg(bridge, "%s: hNode: %p pMsg: %p uTimeout: 0x%x\n", __func__,
+							hNode, pMsg, uTimeout);
 	return status;
 }
 
@@ -1881,9 +1877,7 @@ enum NLDR_LOADTYPE NODE_GetLoadType(struct NODE_OBJECT *hNode)
 	DBC_Require(cRefs > 0);
 	DBC_Require(MEM_IsValidHandle(hNode, NODE_SIGNATURE));
 	if (!MEM_IsValidHandle(hNode, NODE_SIGNATURE)) {
-		GT_1trace(NODE_debugMask, GT_5CLASS,
-			"NODE_GetLoadType: Failed. hNode:"
-			" 0x%x\n", hNode);
+		dev_dbg(bridge, "%s: Failed. hNode: %p\n", __func__, hNode);
 		return -1;
 	} else {
 		return hNode->dcdProps.objData.nodeObj.usLoadType;
@@ -1900,9 +1894,7 @@ u32 NODE_GetTimeout(struct NODE_OBJECT *hNode)
 	DBC_Require(cRefs > 0);
 	DBC_Require(MEM_IsValidHandle(hNode, NODE_SIGNATURE));
 	if (!MEM_IsValidHandle(hNode, NODE_SIGNATURE)) {
-		GT_1trace(NODE_debugMask, GT_5CLASS,
-			"NODE_GetTimeout: Failed. hNode:"
-			" 0x%x\n", hNode);
+		dev_dbg(bridge, "%s: failed. hNode: %p\n", __func__, hNode);
 		return 0;
 	} else {
 		return hNode->uTimeout;
@@ -1991,8 +1983,6 @@ DSP_STATUS NODE_Pause(struct NODE_OBJECT *hNode)
 
 	DBC_Require(cRefs > 0);
 
-	GT_1trace(NODE_debugMask, GT_ENTER, "NODE_Pause: hNode: 0x%x\n", hNode);
-
 	if (!MEM_IsValidHandle(hNode, NODE_SIGNATURE)) {
 		status = DSP_EHANDLE;
 	} else {
@@ -2055,6 +2045,7 @@ func_cont:
 		}
 	}
 func_end:
+	dev_dbg(bridge, "%s: hNode: %p status 0x%x\n", __func__, hNode, status);
 	return status;
 }
 
@@ -2080,9 +2071,7 @@ DSP_STATUS NODE_PutMessage(struct NODE_OBJECT *hNode,
 
 	DBC_Require(cRefs > 0);
 	DBC_Require(pMsg != NULL);
-	GT_3trace(NODE_debugMask, GT_ENTER,
-		 "NODE_PutMessage: hNode: 0x%x\tpMsg: "
-		 "0x%x\tuTimeout: 0x%x\n", hNode, pMsg, uTimeout);
+
 	if (!MEM_IsValidHandle(hNode, NODE_SIGNATURE)) {
 		status = DSP_EHANDLE;
 		goto func_end;
@@ -2154,6 +2143,8 @@ DSP_STATUS NODE_PutMessage(struct NODE_OBJECT *hNode,
 			 &newMsg, uTimeout);
 	}
 func_end:
+	dev_dbg(bridge, "%s: hNode: %p pMsg: %p uTimeout: 0x%x, "
+		"status 0x%x\n", __func__, hNode, pMsg, uTimeout, status);
 	return status;
 }
 
@@ -2172,11 +2163,6 @@ DSP_STATUS NODE_RegisterNotify(struct NODE_OBJECT *hNode, u32 uEventMask,
 	DBC_Require(cRefs > 0);
 	DBC_Require(hNotification != NULL);
 
-	GT_4trace(NODE_debugMask, GT_ENTER,
-		 "NODE_RegisterNotify: hNode: 0x%x\t"
-		 "uEventMask: 0x%x\tuNotifyType: 0x%x\thNotification: 0x%x\n",
-		 hNode, uEventMask, uNotifyType, hNotification);
-
 	if (!MEM_IsValidHandle(hNode, NODE_SIGNATURE)) {
 		status = DSP_EHANDLE;
 	} else {
@@ -2209,6 +2195,9 @@ DSP_STATUS NODE_RegisterNotify(struct NODE_OBJECT *hNode, u32 uEventMask,
 		}
 
 	}
+	dev_dbg(bridge, "%s: hNode: %p uEventMask: 0x%x uNotifyType: 0x%x "
+			"hNotification: %p status 0x%x\n", __func__, hNode,
+			uEventMask, uNotifyType, hNotification, status);
 	return status;
 }
 
@@ -2234,7 +2223,7 @@ DSP_STATUS NODE_Run(struct NODE_OBJECT *hNode)
 	struct PROC_OBJECT *hProcessor;
 
 	DBC_Require(cRefs > 0);
-	GT_1trace(NODE_debugMask, GT_ENTER, "NODE_Run: hNode: 0x%x\n", hNode);
+
 	if (!MEM_IsValidHandle(hNode, NODE_SIGNATURE)) {
 		status = DSP_EHANDLE;
 		goto func_end;
@@ -2330,6 +2319,7 @@ func_cont:
 		NTFY_Notify(hNode->hNtfy, DSP_NODESTATECHANGE);
 	}
 func_end:
+	dev_dbg(bridge, "%s: hNode: %p status 0x%x\n", __func__, hNode, status);
 	return status;
 }
 
@@ -2355,8 +2345,6 @@ DSP_STATUS NODE_Terminate(struct NODE_OBJECT *hNode, OUT DSP_STATUS *pStatus)
 	DBC_Require(cRefs > 0);
 	DBC_Require(pStatus != NULL);
 
-	GT_1trace(NODE_debugMask, GT_ENTER,
-		 "NODE_Terminate: hNode: 0x%x\n", hNode);
 	if (!MEM_IsValidHandle(hNode, NODE_SIGNATURE) || !hNode->hNodeMgr) {
 		status = DSP_EHANDLE;
 		goto func_end;
@@ -2470,9 +2458,8 @@ func_cont:
 			status = DSP_EFAIL;
 		} else {
 			*pStatus = hNode->nExitStatus;
-			GT_1trace(NODE_debugMask, GT_ENTER,
-				 "NODE_Terminate: env = 0x%x "
-				 "succeeded.\n", hNode->nodeEnv);
+			dev_dbg(bridge, "%s: hNode: %p env 0x%x status 0x%x\n",
+				__func__, hNode, hNode->nodeEnv, status);
 		}
 		(void)SYNC_LeaveCS(hNodeMgr->hSync);
 	}		/*End of SYNC_EnterCS */
@@ -2891,7 +2878,7 @@ static DSP_STATUS GetNodeProps(struct DCD_MANAGER *hDcdMgr,
 		/* Create UUID value to set in registry. */
 		UUID_UuidToString((struct DSP_UUID *)pNodeId, szUuid,
 				 MAXUUIDLEN);
-		DBG_Trace(DBG_LEVEL7, "\n** (node) UUID: %s\n", szUuid);
+		dev_dbg(bridge, "(node) UUID: %s\n", szUuid);
 #endif
 
 		/* Fill in message args that come from NDB */
@@ -2902,8 +2889,7 @@ static DSP_STATUS GetNodeProps(struct DCD_MANAGER *hDcdMgr,
 						uMsgNotifyType;
 			pMsgArgs->uMaxMessages = pndbProps->uMessageDepth;
 #ifdef CONFIG_BRIDGE_DEBUG
-			DBG_Trace(DBG_LEVEL7,
-				 "** (node) Max Number of Messages: 0x%x\n",
+			dev_dbg(bridge, "(node) Max Number of Messages: 0x%x\n",
 				 pMsgArgs->uMaxMessages);
 #endif
 		} else {
@@ -2929,12 +2915,9 @@ static DSP_STATUS GetNodeProps(struct DCD_MANAGER *hDcdMgr,
 			pTaskArgs->uSysStackSize = pndbProps->uSysStackSize;
 			pTaskArgs->uStackSeg = pndbProps->uStackSeg;
 #ifdef CONFIG_BRIDGE_DEBUG
-			DBG_Trace(DBG_LEVEL7,
-				"** (node) Priority: 0x%x\n" "** (node) Stack"
-				" Size: 0x%x words\n" "** (node) System Stack"
-				" Size: 0x%x words\n" "** (node) Stack"
-				" Segment: 0x%x\n\n",
-				"** (node) profile count : 0x%x \n \n",
+			dev_dbg(bridge, "(node) Priority: 0x%x Stack Size: "
+				"0x%x words System Stack Size: 0x%x words "
+				"Stack Segment: 0x%x profile count : 0x%x\n",
 				pTaskArgs->nPriority, pTaskArgs->uStackSize,
 				pTaskArgs->uSysStackSize,
 				pTaskArgs->uStackSeg,
@@ -3096,14 +3079,12 @@ static DSP_STATUS GetRMSFxns(struct NODE_MGR *hNodeMgr)
 				 *  May be loaded dynamically (in the future),
 				 *  but return an error for now.
 				 */
-				GT_1trace(NODE_debugMask, GT_6CLASS,
-					 "RMS function: %s "
-					 "currently not loaded\n", pszFxns[i]);
+				dev_dbg(bridge, "%s: RMS function: %s currently"
+					 " not loaded\n", __func__, pszFxns[i]);
 			} else {
-				GT_2trace(NODE_debugMask, GT_6CLASS,
-					 "GetRMSFxns: Symbol not "
-					 "found: %s\tstatus = 0x%x\n",
-					 pszFxns[i], status);
+				dev_dbg(bridge, "%s: Symbol not found: %s "
+						"status = 0x%x\n", __func__,
+						pszFxns[i], status);
 				break;
 			}
 		}
diff --git a/drivers/dsp/bridge/rmgr/proc.c b/drivers/dsp/bridge/rmgr/proc.c
index f372059..d8137c8 100644
--- a/drivers/dsp/bridge/rmgr/proc.c
+++ b/drivers/dsp/bridge/rmgr/proc.c
@@ -750,10 +750,8 @@ DSP_STATUS PROC_GetState(DSP_HPROCESSOR hProcessor,
 	} else {
 		status = DSP_EHANDLE;
 	}
-	GT_2trace(PROC_DebugMask, GT_ENTER,
-		 "Exiting PROC_GetState, results:\n\t"
-		 "status:  0x%x\n\tpProcStatus: 0x%x\n", status,
-		 pProcStatus->iState);
+	dev_dbg(bridge, "%s, results: status: 0x%x pProcStatus: 0x%x\n",
+					__func__, status, pProcStatus->iState);
 	return status;
 }
 
@@ -877,8 +875,8 @@ DSP_STATUS PROC_Load(DSP_HPROCESSOR hProcessor, IN CONST s32 iArgc,
 		status = snprintf(szProcID, MAXPROCIDLEN, PROC_ENVPROCID,
 				    nProcID);
 		if (status == -1) {
-			GT_0trace(PROC_DebugMask, GT_7CLASS, "PROC_Load: "
-				 "Proc ID string overflow \n");
+			dev_dbg(bridge, "%s: Proc ID string overflow\n",
+								__func__);
 			status = DSP_EFAIL;
 		} else {
 			newEnvp = PrependEnvp(newEnvp, (char **)aEnvp, cEnvp,
@@ -973,8 +971,8 @@ DSP_STATUS PROC_Load(DSP_HPROCESSOR hProcessor, IN CONST s32 iArgc,
 				     pProcObject->hDevObject, NULL);
 		if (DSP_FAILED(status)) {
 			if (status == COD_E_OPENFAILED) {
-				GT_0trace(PROC_DebugMask, GT_7CLASS,
-					"PROC_Load:Failure to Load the EXE\n");
+				dev_dbg(bridge,	"%s: Failure to Load the EXE\n",
+								__func__);
 			}
 			if (status == COD_E_SYMBOLNOTFOUND) {
 				pr_err("%s: Couldn't parse the file\n",
@@ -1048,8 +1046,7 @@ func_end:
 		tv2.tv_usec += 1000000;
 		tv2.tv_sec--;
 	}
-	GT_2trace(PROC_DebugMask, GT_1CLASS,
-			"Proc_Load: time to load %d sec and %d usec \n",
+	dev_dbg(bridge, "%s: time to load %d sec and %d usec\n", __func__,
 		    tv2.tv_sec - tv1.tv_sec, tv2.tv_usec - tv1.tv_usec);
 #endif
 	return status;
@@ -1073,19 +1070,12 @@ DSP_STATUS PROC_Map(DSP_HPROCESSOR hProcessor, void *pMpuAddr, u32 ulSize,
 
        HANDLE        dmmRes;
 
-	GT_6trace(PROC_DebugMask, GT_ENTER, "Entered PROC_Map, args:\n\t"
-		 "hProcessor %x, pMpuAddr %x, ulSize %x, pReqAddr %x, "
-		 "ulMapAttr %x, ppMapAddr %x\n", hProcessor, pMpuAddr, ulSize,
-		 pReqAddr, ulMapAttr, ppMapAddr);
 	/* Calculate the page-aligned PA, VA and size */
 	vaAlign = PG_ALIGN_LOW((u32) pReqAddr, PG_SIZE_4K);
 	paAlign = PG_ALIGN_LOW((u32) pMpuAddr, PG_SIZE_4K);
 	sizeAlign = PG_ALIGN_HIGH(ulSize + (u32)pMpuAddr - paAlign,
 				 PG_SIZE_4K);
 
-	GT_3trace(PROC_DebugMask, GT_ENTER, "PROC_Map: vaAlign %x, paAlign %x, "
-		 "sizeAlign %x\n", vaAlign, paAlign, sizeAlign);
-
 	if (!MEM_IsValidHandle(pProcObject, PROC_SIGNATURE)) {
 		status = DSP_EHANDLE;
 		goto func_end;
@@ -1118,7 +1108,12 @@ DSP_STATUS PROC_Map(DSP_HPROCESSOR hProcessor, void *pMpuAddr, u32 ulSize,
 				(u32)pReqAddr, (u32)*ppMapAddr, hProcessor);
 	}
 func_end:
-	GT_1trace(PROC_DebugMask, GT_ENTER, "Leaving PROC_Map [0x%x]", status);
+	dev_dbg(bridge, "%s: hProcessor %p, pMpuAddr %p, ulSize %x, "
+		"pReqAddr %p, ulMapAttr %x, ppMapAddr %p, vaAlign %x, "
+		"paAlign %x, sizeAlign %x status 0x%x\n", __func__, hProcessor,
+		pMpuAddr, ulSize, pReqAddr, ulMapAttr,  ppMapAddr, vaAlign,
+		paAlign, sizeAlign, status);
+
 	return status;
 }
 
@@ -1206,10 +1201,6 @@ DSP_STATUS PROC_ReserveMemory(DSP_HPROCESSOR hProcessor, u32 ulSize,
 	DSP_STATUS status = DSP_SOK;
 	struct PROC_OBJECT *pProcObject = (struct PROC_OBJECT *)hProcessor;
 
-	GT_3trace(PROC_DebugMask, GT_ENTER,
-		 "Entered PROC_ReserveMemory, args:\n\t"
-		 "hProcessor: 0x%x ulSize: 0x%x ppRsvAddr: 0x%x\n", hProcessor,
-		 ulSize, ppRsvAddr);
 	if (!MEM_IsValidHandle(pProcObject, PROC_SIGNATURE)) {
 		status = DSP_EHANDLE;
 		goto func_end;
@@ -1218,9 +1209,10 @@ DSP_STATUS PROC_ReserveMemory(DSP_HPROCESSOR hProcessor, u32 ulSize,
 	if (DSP_SUCCEEDED(status))
 		status = DMM_ReserveMemory(hDmmMgr, ulSize, (u32 *)ppRsvAddr);
 
-	GT_1trace(PROC_DebugMask, GT_ENTER, "Leaving PROC_ReserveMemory [0x%x]",
-		 status);
 func_end:
+	dev_dbg(bridge, "%s: hProcessor: 0x%p ulSize: 0x%x ppRsvAddr: 0x%p "
+					"status 0x%x\n", __func__, hProcessor,
+					ulSize, ppRsvAddr, status);
 	return status;
 }
 
@@ -1341,9 +1333,7 @@ DSP_STATUS PROC_Stop(DSP_HPROCESSOR hProcessor)
 	status = (*pProcObject->pIntfFxns->pfnBrdStop)(pProcObject->
 		 hWmdContext);
 	if (DSP_SUCCEEDED(status)) {
-		GT_0trace(PROC_DebugMask, GT_1CLASS,
-			 "PROC_Stop: Processor Stopped, "
-			 "i.e in standby mode \n");
+		dev_dbg(bridge, "%s: processor in standby mode\n", __func__);
 		pProcObject->sState = PROC_STOPPED;
 		/* Destory the Node Manager, MSG Manager */
 		if (DSP_SUCCEEDED(DEV_Destroy2(pProcObject->hDevObject))) {
@@ -1384,10 +1374,6 @@ DSP_STATUS PROC_UnMap(DSP_HPROCESSOR hProcessor, void *pMapAddr,
 
 	HANDLE	      dmmRes;
 
-	GT_2trace(PROC_DebugMask, GT_ENTER,
-		 "Entered PROC_UnMap, args:\n\thProcessor:"
-		 "0x%x pMapAddr: 0x%x\n", hProcessor, pMapAddr);
-
 	vaAlign = PG_ALIGN_LOW((u32) pMapAddr, PG_SIZE_4K);
 	if (!MEM_IsValidHandle(pProcObject, PROC_SIGNATURE)) {
 		status = DSP_EHANDLE;
@@ -1418,8 +1404,8 @@ DSP_STATUS PROC_UnMap(DSP_HPROCESSOR hProcessor, void *pMapAddr,
 							!= DSP_ENOTFOUND)
 		DRV_RemoveDMMResElement(dmmRes, pr_ctxt);
 func_end:
-	GT_1trace(PROC_DebugMask, GT_ENTER,
-		 "Leaving PROC_UnMap [0x%x]", status);
+	dev_dbg(bridge, "%s: hProcessor: 0x%p pMapAddr: 0x%p status: 0x%x\n",
+					__func__, hProcessor, pMapAddr, status);
 	return status;
 }
 
@@ -1434,9 +1420,6 @@ DSP_STATUS PROC_UnReserveMemory(DSP_HPROCESSOR hProcessor, void *pRsvAddr)
 	DSP_STATUS status = DSP_SOK;
 	struct PROC_OBJECT *pProcObject = (struct PROC_OBJECT *)hProcessor;
 
-	GT_2trace(PROC_DebugMask, GT_ENTER,
-		 "Entered PROC_UnReserveMemory, args:\n\t"
-		 "hProcessor: 0x%x pRsvAddr: 0x%x\n", hProcessor, pRsvAddr);
 	if (!MEM_IsValidHandle(pProcObject, PROC_SIGNATURE)) {
 		status = DSP_EHANDLE;
 		goto func_end;
@@ -1445,10 +1428,9 @@ DSP_STATUS PROC_UnReserveMemory(DSP_HPROCESSOR hProcessor, void *pRsvAddr)
 	if (DSP_SUCCEEDED(status))
 		status = DMM_UnReserveMemory(hDmmMgr, (u32) pRsvAddr);
 
-	GT_1trace(PROC_DebugMask, GT_ENTER,
-		 "Leaving PROC_UnReserveMemory [0x%x]",
-		 status);
 func_end:
+	dev_dbg(bridge, "%s: hProcessor: 0x%p pRsvAddr: 0x%p status: 0x%x\n",
+					__func__, hProcessor, pRsvAddr, status);
 	return status;
 }
 
diff --git a/drivers/dsp/bridge/rmgr/strm.c b/drivers/dsp/bridge/rmgr/strm.c
index 52b796f..909a2b1 100644
--- a/drivers/dsp/bridge/rmgr/strm.c
+++ b/drivers/dsp/bridge/rmgr/strm.c
@@ -171,8 +171,6 @@ DSP_STATUS STRM_Close(struct STRM_OBJECT *hStrm,
 
 	DBC_Require(cRefs > 0);
 
-	GT_1trace(STRM_debugMask, GT_ENTER, "STRM_Close: hStrm: 0x%x\n", hStrm);
-
 	if (!MEM_IsValidHandle(hStrm, STRM_SIGNATURE)) {
 		status = DSP_EHANDLE;
 	} else {
@@ -198,6 +196,8 @@ func_end:
 	DBC_Ensure(status == DSP_SOK || status == DSP_EHANDLE ||
 		  status == DSP_EPENDING || status == DSP_EFAIL);
 
+	dev_dbg(bridge, "%s: hStrm: %p, status 0x%x\n", __func__,
+							hStrm, status);
 	return status;
 }
 
@@ -387,9 +387,6 @@ DSP_STATUS STRM_Idle(struct STRM_OBJECT *hStrm, bool fFlush)
 
 	DBC_Require(cRefs > 0);
 
-	GT_2trace(STRM_debugMask, GT_ENTER, "STRM_Idle: hStrm: 0x%x\t"
-		 "fFlush: 0x%x\n", hStrm, fFlush);
-
 	if (!MEM_IsValidHandle(hStrm, STRM_SIGNATURE)) {
 		status = DSP_EHANDLE;
 	} else {
@@ -398,6 +395,9 @@ DSP_STATUS STRM_Idle(struct STRM_OBJECT *hStrm, bool fFlush)
 		status = (*pIntfFxns->pfnChnlIdle) (hStrm->hChnl,
 			 hStrm->uTimeout, fFlush);
 	}
+
+	dev_dbg(bridge, "%s: hStrm: %p fFlush: 0x%x status: 0x%x\n",
+					__func__, hStrm, fFlush, status);
 	return status;
 }
 
@@ -442,9 +442,6 @@ DSP_STATUS STRM_Issue(struct STRM_OBJECT *hStrm, IN u8 *pBuf, u32 ulBytes,
 	DBC_Require(cRefs > 0);
 	DBC_Require(pBuf != NULL);
 
-	GT_4trace(STRM_debugMask, GT_ENTER, "STRM_Issue: hStrm: 0x%x\tpBuf: "
-		 "0x%x\tulBytes: 0x%x\tdwArg: 0x%x\n", hStrm, pBuf, ulBytes,
-		 dwArg);
 	if (!MEM_IsValidHandle(hStrm, STRM_SIGNATURE)) {
 		status = DSP_EHANDLE;
 	} else {
@@ -465,6 +462,10 @@ DSP_STATUS STRM_Issue(struct STRM_OBJECT *hStrm, IN u8 *pBuf, u32 ulBytes,
 		if (status == CHNL_E_NOIORPS)
 			status = DSP_ESTREAMFULL;
 	}
+
+	dev_dbg(bridge, "%s: hStrm: %p pBuf: %p ulBytes: 0x%x dwArg: 0x%x "
+					"status: 0x%x\n", __func__, hStrm, pBuf,
+					ulBytes, dwArg, status);
 	return status;
 }
 
@@ -493,10 +494,6 @@ DSP_STATUS STRM_Open(struct NODE_OBJECT *hNode, u32 uDir, u32 uIndex,
 	DBC_Require(cRefs > 0);
 	DBC_Require(phStrm != NULL);
 	DBC_Require(pAttr != NULL);
-	GT_5trace(STRM_debugMask, GT_ENTER,
-		 "STRM_Open: hNode: 0x%x\tuDir: 0x%x\t"
-		 "uIndex: 0x%x\tpAttr: 0x%x\tphStrm: 0x%x\n",
-		 hNode, uDir, uIndex, pAttr, phStrm);
 	*phStrm = NULL;
 	if (uDir != DSP_TONODE && uDir != DSP_FROMNODE) {
 		status = DSP_EDIRECTION;
@@ -614,6 +611,10 @@ func_cont:
 		  (*phStrm == NULL && (status == DSP_EHANDLE ||
 		  status == DSP_EDIRECTION || status == DSP_EVALUE ||
 		  status == DSP_EFAIL)));
+
+	dev_dbg(bridge, "%s: hNode: %p uDir: 0x%x uIndex: 0x%x pAttr: %p "
+				"phStrm: %p status: 0x%x\n", __func__,
+				hNode, uDir, uIndex, pAttr, phStrm, status);
 	return status;
 }
 
@@ -635,11 +636,6 @@ DSP_STATUS STRM_Reclaim(struct STRM_OBJECT *hStrm, OUT u8 **pBufPtr,
 	DBC_Require(pulBytes != NULL);
 	DBC_Require(pdwArg != NULL);
 
-	GT_4trace(STRM_debugMask, GT_ENTER,
-		 "STRM_Reclaim: hStrm: 0x%x\tpBufPtr: 0x%x"
-		 "\tpulBytes: 0x%x\tpdwArg: 0x%x\n", hStrm, pBufPtr, pulBytes,
-		 pdwArg);
-
 	if (!MEM_IsValidHandle(hStrm, STRM_SIGNATURE)) {
 		status = DSP_EHANDLE;
 		goto func_end;
@@ -693,6 +689,10 @@ func_end:
 	DBC_Ensure(DSP_SUCCEEDED(status) || status == DSP_EHANDLE ||
 		  status == DSP_ETIMEOUT || status == DSP_ETRANSLATE ||
 		  status == DSP_EFAIL);
+
+	dev_dbg(bridge, "%s: hStrm: %p pBufPtr: %p pulBytes: %p pdwArg: %p "
+					"status 0x%x\n", __func__, hStrm,
+					pBufPtr, pulBytes, pdwArg, status);
 	return status;
 }
 
diff --git a/drivers/dsp/bridge/uTimeout b/drivers/dsp/bridge/uTimeout
new file mode 100644
index 0000000..e69de29
-- 
1.6.2.4

