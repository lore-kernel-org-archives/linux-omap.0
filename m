From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 12/12] DSPBRIDGE: Remove unused instances of CONFIG_BRIDGE_DEBUG
Date: Thu, 18 Feb 2010 15:38:03 -0600
Message-ID: <1266529083-2358-13-git-send-email-omar.ramirez@ti.com>
References: <1266529083-2358-1-git-send-email-omar.ramirez@ti.com>
 <1266529083-2358-2-git-send-email-omar.ramirez@ti.com>
 <1266529083-2358-3-git-send-email-omar.ramirez@ti.com>
 <1266529083-2358-4-git-send-email-omar.ramirez@ti.com>
 <1266529083-2358-5-git-send-email-omar.ramirez@ti.com>
 <1266529083-2358-6-git-send-email-omar.ramirez@ti.com>
 <1266529083-2358-7-git-send-email-omar.ramirez@ti.com>
 <1266529083-2358-8-git-send-email-omar.ramirez@ti.com>
 <1266529083-2358-9-git-send-email-omar.ramirez@ti.com>
 <1266529083-2358-10-git-send-email-omar.ramirez@ti.com>
 <1266529083-2358-11-git-send-email-omar.ramirez@ti.com>
 <1266529083-2358-12-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:54602 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755850Ab0BRVZ3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Feb 2010 16:25:29 -0500
In-Reply-To: <1266529083-2358-12-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Ameya Palande <ameya.palande@nokia.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>, Nishanth Menon <nm@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>

Remove unused instances of CONFIG_BRIDGE_DEBUG.

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 drivers/dsp/bridge/rmgr/drv_interface.c |    2 --
 drivers/dsp/bridge/rmgr/nldr.c          |    2 --
 drivers/dsp/bridge/rmgr/node.c          |   10 ----------
 drivers/dsp/bridge/rmgr/proc.c          |   23 +++++------------------
 drivers/dsp/bridge/services/cfg.c       |   13 +------------
 drivers/dsp/bridge/wmd/io_sm.c          |    5 -----
 drivers/dsp/bridge/wmd/tiomap3430_pwr.c |   14 --------------
 7 files changed, 6 insertions(+), 63 deletions(-)

diff --git a/drivers/dsp/bridge/rmgr/drv_interface.c b/drivers/dsp/bridge/rmgr/drv_interface.c
index 74478dd..373a33c 100644
--- a/drivers/dsp/bridge/rmgr/drv_interface.c
+++ b/drivers/dsp/bridge/rmgr/drv_interface.c
@@ -112,10 +112,8 @@ static int omap34xxbridge_suspend_lockout(
 }
 #endif
 
-#ifdef CONFIG_BRIDGE_DEBUG
 module_param(dsp_debug, int, 0);
 MODULE_PARM_DESC(dsp_debug, "Wait after loading DSP image. default = false");
-#endif
 
 module_param(dsp_test_sleepstate, int, 0);
 MODULE_PARM_DESC(dsp_test_sleepstate, "DSP Sleep state = 0");
diff --git a/drivers/dsp/bridge/rmgr/nldr.c b/drivers/dsp/bridge/rmgr/nldr.c
index 9e9dfc8..481a1bc 100644
--- a/drivers/dsp/bridge/rmgr/nldr.c
+++ b/drivers/dsp/bridge/rmgr/nldr.c
@@ -535,11 +535,9 @@ DSP_STATUS NLDR_Create(OUT struct NLDR_OBJECT **phNldr,
 				rmmSegs[i].length = (pMemInfo + i)->len;
 				rmmSegs[i].space = 0;
 				pNldr->segTable[i] = (pMemInfo + i)->type;
-#ifdef CONFIG_BRIDGE_DEBUG
 				dev_dbg(bridge, "(proc) DLL MEMSEGMENT: %d, "
 					"Base: 0x%x, Length: 0x%x\n", i,
 					rmmSegs[i].base, rmmSegs[i].length);
-#endif
 			}
 		}
 	}
diff --git a/drivers/dsp/bridge/rmgr/node.c b/drivers/dsp/bridge/rmgr/node.c
index 4eb6582..f4bb675 100644
--- a/drivers/dsp/bridge/rmgr/node.c
+++ b/drivers/dsp/bridge/rmgr/node.c
@@ -53,9 +53,7 @@
 
 /*  ----------------------------------- Others */
 #include <dspbridge/gb.h>
-#ifdef CONFIG_BRIDGE_DEBUG
 #include <dspbridge/uuidutil.h>
-#endif
 
 /*  ----------------------------------- This */
 #include <dspbridge/nodepriv.h>
@@ -2853,9 +2851,7 @@ static DSP_STATUS GetNodeProps(struct DCD_MANAGER *hDcdMgr,
 	enum NODE_TYPE nodeType = NODE_TASK;
 	struct DSP_NDBPROPS *pndbProps = &(pdcdProps->objData.nodeObj.ndbProps);
 	DSP_STATUS status = DSP_SOK;
-#ifdef CONFIG_BRIDGE_DEBUG
 	char szUuid[MAXUUIDLEN];
-#endif
 
 	status = DCD_GetObjectDef(hDcdMgr, (struct DSP_UUID *)pNodeId,
 				 DSP_DCDNODETYPE, pdcdProps);
@@ -2863,12 +2859,10 @@ static DSP_STATUS GetNodeProps(struct DCD_MANAGER *hDcdMgr,
 	if (DSP_SUCCEEDED(status)) {
 		hNode->nType = nodeType = pndbProps->uNodeType;
 
-#ifdef CONFIG_BRIDGE_DEBUG
 		/* Create UUID value to set in registry. */
 		UUID_UuidToString((struct DSP_UUID *)pNodeId, szUuid,
 				 MAXUUIDLEN);
 		dev_dbg(bridge, "(node) UUID: %s\n", szUuid);
-#endif
 
 		/* Fill in message args that come from NDB */
 		if (nodeType != NODE_DEVICE) {
@@ -2877,10 +2871,8 @@ static DSP_STATUS GetNodeProps(struct DCD_MANAGER *hDcdMgr,
 			pMsgArgs->uNotifyType = pdcdProps->objData.nodeObj.
 						uMsgNotifyType;
 			pMsgArgs->uMaxMessages = pndbProps->uMessageDepth;
-#ifdef CONFIG_BRIDGE_DEBUG
 			dev_dbg(bridge, "(node) Max Number of Messages: 0x%x\n",
 				 pMsgArgs->uMaxMessages);
-#endif
 		} else {
 			/* Copy device name */
 			DBC_Require(pndbProps->acName);
@@ -2903,7 +2895,6 @@ static DSP_STATUS GetNodeProps(struct DCD_MANAGER *hDcdMgr,
 			pTaskArgs->uStackSize = pndbProps->uStackSize;
 			pTaskArgs->uSysStackSize = pndbProps->uSysStackSize;
 			pTaskArgs->uStackSeg = pndbProps->uStackSeg;
-#ifdef CONFIG_BRIDGE_DEBUG
 			dev_dbg(bridge, "(node) Priority: 0x%x Stack Size: "
 				"0x%x words System Stack Size: 0x%x words "
 				"Stack Segment: 0x%x profile count : 0x%x\n",
@@ -2911,7 +2902,6 @@ static DSP_STATUS GetNodeProps(struct DCD_MANAGER *hDcdMgr,
 				pTaskArgs->uSysStackSize,
 				pTaskArgs->uStackSeg,
 				pndbProps->uCountProfiles);
-#endif
 		}
 	}
 
diff --git a/drivers/dsp/bridge/rmgr/proc.c b/drivers/dsp/bridge/rmgr/proc.c
index c5f4577..38d6640 100644
--- a/drivers/dsp/bridge/rmgr/proc.c
+++ b/drivers/dsp/bridge/rmgr/proc.c
@@ -817,9 +817,8 @@ DSP_STATUS PROC_Load(DSP_HPROCESSOR hProcessor, IN CONST s32 iArgc,
 	struct DMM_OBJECT *hDmmMgr;
 	u32 dwExtEnd;
 	u32 uProcId;
-#ifdef CONFIG_BRIDGE_DEBUG
 	BRD_STATUS uBrdState;
-#endif
+
 
 #ifdef OPT_LOAD_TIME_INSTRUMENTATION
 	struct timeval tv1;
@@ -1015,7 +1014,6 @@ DSP_STATUS PROC_Load(DSP_HPROCESSOR hProcessor, IN CONST s32 iArgc,
 	/* Restore the original argv[0] */
 	kfree(newEnvp);
 	aArgv[0] = pargv0;
-#ifdef CONFIG_BRIDGE_DEBUG
 	if (DSP_SUCCEEDED(status)) {
 		if (DSP_SUCCEEDED((*pProcObject->pIntfFxns->pfnBrdStatus)
 		   (pProcObject->hWmdContext, &uBrdState))) {
@@ -1023,12 +1021,11 @@ DSP_STATUS PROC_Load(DSP_HPROCESSOR hProcessor, IN CONST s32 iArgc,
 			DBC_Assert(uBrdState == BRD_LOADED);
 		}
 	}
-#endif
+
 func_end:
-#ifdef CONFIG_BRIDGE_DEBUG
 	if (DSP_FAILED(status))
 		pr_err("%s: Processor failed to load\n", __func__);
-#endif
+
 	DBC_Ensure((DSP_SUCCEEDED(status) && pProcObject->sState == PROC_LOADED)
 		   || DSP_FAILED(status));
 #ifdef OPT_LOAD_TIME_INSTRUMENTATION
@@ -1218,9 +1215,8 @@ DSP_STATUS PROC_Start(DSP_HPROCESSOR hProcessor)
 	struct PROC_OBJECT *pProcObject = (struct PROC_OBJECT *)hProcessor;
 	struct COD_MANAGER *hCodMgr;	/* Code manager handle    */
 	u32 dwDspAddr;	/* Loaded code's entry point.    */
-#ifdef CONFIG_BRIDGE_DEBUG
 	BRD_STATUS uBrdState;
-#endif
+
 	DBC_Require(cRefs > 0);
 	if (!MEM_IsValidHandle(pProcObject, PROC_SIGNATURE)) {
 		status = DSP_EHANDLE;
@@ -1264,7 +1260,6 @@ DSP_STATUS PROC_Start(DSP_HPROCESSOR hProcessor)
 		pProcObject->sState = PROC_STOPPED;
 	}
 func_cont:
-#ifdef CONFIG_BRIDGE_DEBUG
 	if (DSP_SUCCEEDED(status)) {
 		if (DSP_SUCCEEDED((*pProcObject->pIntfFxns->pfnBrdStatus)
 		   (pProcObject->hWmdContext, &uBrdState))) {
@@ -1274,7 +1269,7 @@ func_cont:
 	} else {
 		pr_err("%s: Failed to start the dsp\n", __func__);
 	}
-#endif
+
 func_end:
 	DBC_Ensure((DSP_SUCCEEDED(status) && pProcObject->sState ==
 		  PROC_RUNNING)	|| DSP_FAILED(status));
@@ -1334,12 +1329,10 @@ DSP_STATUS PROC_Stop(DSP_HPROCESSOR hProcessor)
 				MSG_Delete(hMsgMgr);
 				DEV_SetMsgMgr(pProcObject->hDevObject, NULL);
 			}
-#ifdef CONFIG_BRIDGE_DEBUG
 			if (DSP_SUCCEEDED((*pProcObject->pIntfFxns->
 			   pfnBrdStatus)(pProcObject->hWmdContext,
 			   &uBrdState)))
 				DBC_Assert(uBrdState == BRD_STOPPED);
-#endif
 		}
 	} else {
 		pr_err("%s: Failed to stop the processor\n", __func__);
@@ -1447,9 +1440,7 @@ static DSP_STATUS PROC_Monitor(struct PROC_OBJECT *hProcObject)
 	DSP_STATUS status = DSP_EFAIL;
 	struct PROC_OBJECT *pProcObject = (struct PROC_OBJECT *)hProcObject;
 	struct MSG_MGR *hMsgMgr;
-#ifdef CONFIG_BRIDGE_DEBUG
 	BRD_STATUS uBrdState;
-#endif
 
 	DBC_Require(cRefs > 0);
 	DBC_Require(MEM_IsValidHandle(pProcObject, PROC_SIGNATURE));
@@ -1469,17 +1460,13 @@ static DSP_STATUS PROC_Monitor(struct PROC_OBJECT *hProcObject)
 	if (DSP_SUCCEEDED((*pProcObject->pIntfFxns->pfnBrdMonitor)
 	   (pProcObject->hWmdContext))) {
 		status = DSP_SOK;
-#ifdef CONFIG_BRIDGE_DEBUG
 		if (DSP_SUCCEEDED((*pProcObject->pIntfFxns->pfnBrdStatus)
 		   (pProcObject->hWmdContext, &uBrdState)))
 			DBC_Assert(uBrdState == BRD_IDLE);
-#endif
 	}
 
-#ifdef CONFIG_BRIDGE_DEBUG
 	DBC_Ensure((DSP_SUCCEEDED(status) && uBrdState == BRD_IDLE) ||
 		  DSP_FAILED(status));
-#endif
 	return status;
 }
 
diff --git a/drivers/dsp/bridge/services/cfg.c b/drivers/dsp/bridge/services/cfg.c
index 1b7e0ea..4f8896a 100644
--- a/drivers/dsp/bridge/services/cfg.c
+++ b/drivers/dsp/bridge/services/cfg.c
@@ -99,10 +99,8 @@ DSP_STATUS CFG_GetDevObject(struct CFG_DEVNODE *hDevNode, OUT u32 *pdwValue)
 			status = REG_GetValue("DEVICE_DSP", (u8 *)pdwValue,
 					      &dwBufSize);
 	}
-#ifdef CONFIG_BRIDGE_DEBUG
 	if (DSP_FAILED(status))
 		pr_err("%s: Failed, status 0x%x\n", __func__, status);
-#endif
 	return status;
 }
 
@@ -129,14 +127,12 @@ DSP_STATUS CFG_GetDSPResources(struct CFG_DEVNODE *hDevNode,
 		status = CFG_E_RESOURCENOTAVAIL;
 		pr_err("%s: Failed, status 0x%x\n", __func__, status);
 	}
-#ifdef CONFIG_BRIDGE_DEBUG
 	/* assert that resource values are reasonable */
 	DBC_Assert(pDSPResTable->uChipType < 256);
 	DBC_Assert(pDSPResTable->uWordSize > 0);
 	DBC_Assert(pDSPResTable->uWordSize < 32);
 	DBC_Assert(pDSPResTable->cChips > 0);
 	DBC_Assert(pDSPResTable->cChips < 256);
-#endif
 	return status;
 }
 
@@ -164,10 +160,8 @@ DSP_STATUS CFG_GetExecFile(struct CFG_DEVNODE *hDevNode, u32 ulBufSize,
 			status = DSP_ESIZE;
 
 	}
-#ifdef CONFIG_BRIDGE_DEBUG
 	if (DSP_FAILED(status))
 		pr_err("%s: Failed, status 0x%x\n", __func__, status);
-#endif
 	DBC_Ensure(((status == DSP_SOK) &&
 		(strlen(pstrExecFile) <= ulBufSize)) || (status != DSP_SOK));
 	return status;
@@ -197,10 +191,8 @@ DSP_STATUS CFG_GetHostResources(struct CFG_DEVNODE *hDevNode,
 			status = CFG_E_RESOURCENOTAVAIL;
 		}
 	}
-#ifdef CONFIG_BRIDGE_DEBUG
 	if (DSP_FAILED(status))
 		dev_dbg(bridge, "%s Failed, status 0x%x\n", __func__, status);
-#endif
 	return status;
 }
 
@@ -284,10 +276,9 @@ DSP_STATUS CFG_SetDevObject(struct CFG_DEVNODE *hDevNode, u32 dwValue)
 						dwBuffSize);
 		}
 	}
-#ifdef CONFIG_BRIDGE_DEBUG
 	if (DSP_FAILED(status))
 		pr_err("%s: Failed, status 0x%x\n", __func__, status);
-#endif
+
 	return status;
 }
 
@@ -312,9 +303,7 @@ DSP_STATUS CFG_SetObject(u32 dwValue, u32 dwType)
 	default:
 		break;
 	}
-#ifdef CONFIG_BRIDGE_DEBUG
 	if (DSP_FAILED(status))
 		pr_err("%s: Failed, status 0x%x\n", __func__, status);
-#endif
 	return status;
 }
diff --git a/drivers/dsp/bridge/wmd/io_sm.c b/drivers/dsp/bridge/wmd/io_sm.c
index e863478..46d5d8f 100644
--- a/drivers/dsp/bridge/wmd/io_sm.c
+++ b/drivers/dsp/bridge/wmd/io_sm.c
@@ -1875,7 +1875,6 @@ void PrintDSPDebugTrace(struct IO_MGR *hIOMgr)
  *      There are no more than ulNumWords extra characters needed (the number of
  *      linefeeds minus the number of NULLS in the input buffer).
  */
-#if (defined(CONFIG_BRIDGE_DEBUG) || defined(DDSP_DEBUG_PRODUCT)) && GT_TRACE
 static DSP_STATUS PackTraceBuffer(char *lpBuf, u32 nBytes, u32 ulNumWords)
 {
 	DSP_STATUS status = DSP_SOK;
@@ -1921,7 +1920,6 @@ static DSP_STATUS PackTraceBuffer(char *lpBuf, u32 nBytes, u32 ulNumWords)
 
 	return status;
 }
-#endif    /* (CONFIG_BRIDGE_DEBUG || DDSP_DEBUG_PRODUCT) && GT_TRACE */
 
 /*
  *  ======== PrintDspTraceBuffer ========
@@ -1938,8 +1936,6 @@ static DSP_STATUS PackTraceBuffer(char *lpBuf, u32 nBytes, u32 ulNumWords)
 DSP_STATUS PrintDspTraceBuffer(struct WMD_DEV_CONTEXT *hWmdContext)
 {
 	DSP_STATUS status = DSP_SOK;
-
-#if (defined(CONFIG_BRIDGE_DEBUG) || defined(DDSP_DEBUG_PRODUCT)) && GT_TRACE
 	struct COD_MANAGER *hCodMgr;
 	u32 ulTraceEnd;
 	u32 ulTraceBegin;
@@ -2000,7 +1996,6 @@ DSP_STATUS PrintDspTraceBuffer(struct WMD_DEV_CONTEXT *hWmdContext)
 			  status = DSP_EMEMORY;
 		}
 	}
-#endif
 	return status;
 }
 
diff --git a/drivers/dsp/bridge/wmd/tiomap3430_pwr.c b/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
index 16e786a..9abe545 100644
--- a/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
+++ b/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
@@ -270,15 +270,6 @@ DSP_STATUS WakeDSP(struct WMD_DEV_CONTEXT *pDevContext, IN void *pArgs)
 {
 	DSP_STATUS status = DSP_SOK;
 #ifdef CONFIG_PM
-#ifdef CONFIG_BRIDGE_DEBUG
-	enum HW_PwrState_t pwrState;
-	struct CFG_HOSTRES resources;
-
-	status = CFG_GetHostResources(
-		 (struct CFG_DEVNODE *)DRV_GetFirstDevExtension(), &resources);
-	if (DSP_FAILED(status))
-		return status;
-#endif /* CONFIG_BRIDGE_DEBUG */
 
 	/* Check the BRD/WMD state, if it is not 'SLEEP' then return failure */
 	if (pDevContext->dwBrdState == BRD_RUNNING ||
@@ -291,11 +282,6 @@ DSP_STATUS WakeDSP(struct WMD_DEV_CONTEXT *pDevContext, IN void *pArgs)
 	/* Send a wakeup message to DSP */
 	CHNLSM_InterruptDSP2(pDevContext, MBX_PM_DSPWAKEUP);
 
-#ifdef CONFIG_BRIDGE_DEBUG
-	HW_PWR_IVA2StateGet(resources.dwPrmBase, HW_PWR_DOMAIN_DSP,
-			&pwrState);
-#endif /* CONFIG_BRIDGE_DEBUG */
-
 	/* Set the device state to RUNNIG */
 	pDevContext->dwBrdState = BRD_RUNNING;
 #endif /* CONFIG_PM */
-- 
1.6.2.4

