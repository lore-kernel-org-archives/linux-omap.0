From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 1/6] DSPBRIDGE: Rename DEBUG define to use menuconfig style
Date: Tue, 19 Jan 2010 14:54:04 -0600
Message-ID: <1263934449-16891-2-git-send-email-omar.ramirez@ti.com>
References: <1263934449-16891-1-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:36996 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755495Ab0ASUoD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 Jan 2010 15:44:03 -0500
In-Reply-To: <1263934449-16891-1-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Ameya Palande <ameya.palande@nokia.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>, Nishanth Menon <nm@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>

Rename DEBUG to CONFIG_BRIDGE_DEBUG on preprocessor conditions
that trigger debug statements.

This was conflicting with pr_debug/dev_dbg definitions.

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 arch/arm/plat-omap/include/dspbridge/dbg.h |    4 ++--
 drivers/dsp/bridge/Makefile                |    2 +-
 drivers/dsp/bridge/gen/_gt_para.c          |    2 +-
 drivers/dsp/bridge/gen/gt.c                |    2 +-
 drivers/dsp/bridge/rmgr/drv_interface.c    |    4 ++--
 drivers/dsp/bridge/rmgr/nldr.c             |    4 ++--
 drivers/dsp/bridge/rmgr/node.c             |   10 +++++-----
 drivers/dsp/bridge/rmgr/proc.c             |   18 +++++++++---------
 drivers/dsp/bridge/services/cfg.c          |   14 +++++++-------
 drivers/dsp/bridge/services/dbg.c          |    4 ++--
 drivers/dsp/bridge/services/mem.c          |    2 +-
 drivers/dsp/bridge/wmd/io_sm.c             |    6 +++---
 12 files changed, 36 insertions(+), 36 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/dbg.h b/arch/arm/plat-omap/include/dspbridge/dbg.h
index 5945c29..2f61dab 100644
--- a/arch/arm/plat-omap/include/dspbridge/dbg.h
+++ b/arch/arm/plat-omap/include/dspbridge/dbg.h
@@ -31,7 +31,7 @@
 #define DBG_LEVEL6  (u8)(0x40)	/* Warn SERVICES Failures */
 #define DBG_LEVEL7  (u8)(0x80)	/* Warn Critical Errors */
 
-#if (defined(DEBUG) || defined(DDSP_DEBUG_PRODUCT)) && GT_TRACE
+#if (defined(CONFIG_BRIDGE_DEBUG) || defined(DDSP_DEBUG_PRODUCT)) && GT_TRACE
 
 /*
  *  ======== DBG_Exit ========
@@ -84,6 +84,6 @@
 #define DBG_Init(void) true
 #define DBG_Trace(bLevel, pstrFormat, args...)
 
-#endif	     /* (defined(DEBUG) || defined(DDSP_DEBUG_PRODUCT)) && GT_TRACE */
+#endif	/* (CONFIG_BRIDGE_DEBUG || DDSP_DEBUG_PRODUCT) && GT_TRACE */
 
 #endif				/* DBG_ */
diff --git a/drivers/dsp/bridge/Makefile b/drivers/dsp/bridge/Makefile
index df870c9..0fa9245 100644
--- a/drivers/dsp/bridge/Makefile
+++ b/drivers/dsp/bridge/Makefile
@@ -22,7 +22,7 @@ bridgedriver-objs = $(libgen) $(libservices) $(libwmd) $(libpmgr) $(librmgr) \
 
 # Debug
 ifeq ($(CONFIG_BRIDGE_DEBUG),y)
-ccflags-y += -DGT_TRACE -DDEBUG
+ccflags-y += -DGT_TRACE
 endif
 
 #Machine dependent
diff --git a/drivers/dsp/bridge/gen/_gt_para.c b/drivers/dsp/bridge/gen/_gt_para.c
index f676d3f..1bb82b1 100644
--- a/drivers/dsp/bridge/gen/_gt_para.c
+++ b/drivers/dsp/bridge/gen/_gt_para.c
@@ -80,7 +80,7 @@ static void error(char *fmt, ...)
 	pr_err("ERROR: ");
 	printk(fmt, arg1, arg2, arg3, arg4, arg5, arg6);
 
-#if defined(DEBUG) || defined(DDSP_DEBUG_PRODUCT)
+#if defined(CONFIG_BRIDGE_DEBUG) || defined(DDSP_DEBUG_PRODUCT)
 	if (in_interrupt()) {
 		printk(KERN_INFO "Not stopping after error since ISR/DPC "
 			"are disabled\n");
diff --git a/drivers/dsp/bridge/gen/gt.c b/drivers/dsp/bridge/gen/gt.c
index f2fbea1..40bed53 100644
--- a/drivers/dsp/bridge/gen/gt.c
+++ b/drivers/dsp/bridge/gen/gt.c
@@ -226,7 +226,7 @@ s32 _GT_trace(struct GT_Mask *mask, char *format, ...)
 	arg6 = va_arg(va, s32);
 
 	va_end(va);
-#ifdef DEBUG
+#ifdef CONFIG_BRIDGE_DEBUG
 	if (GT->PIDFXN == NULL) {
 		printk(GT_1format, mask->modName, GT->TIDFXN ?
 		(*GT->TIDFXN)() : 0);
diff --git a/drivers/dsp/bridge/rmgr/drv_interface.c b/drivers/dsp/bridge/rmgr/drv_interface.c
index d8fe250..a02a32a 100644
--- a/drivers/dsp/bridge/rmgr/drv_interface.c
+++ b/drivers/dsp/bridge/rmgr/drv_interface.c
@@ -121,7 +121,7 @@ static int omap34xxbridge_suspend_lockout(
 }
 #endif
 
-#ifdef DEBUG
+#ifdef CONFIG_BRIDGE_DEBUG
 module_param(GT_str, charp, 0);
 MODULE_PARM_DESC(GT_str, "GT string, default = NULL");
 
@@ -274,7 +274,7 @@ static int __devinit omap34xx_bridge_probe(struct platform_device *pdev)
 	GT_init();
 	GT_create(&driverTrace, "LD");
 
-#ifdef DEBUG
+#ifdef CONFIG_BRIDGE_DEBUG
 	if (GT_str)
 		GT_set(GT_str);
 #elif defined(DDSP_DEBUG_PRODUCT) && GT_TRACE
diff --git a/drivers/dsp/bridge/rmgr/nldr.c b/drivers/dsp/bridge/rmgr/nldr.c
index 19861bd..8d136ae 100644
--- a/drivers/dsp/bridge/rmgr/nldr.c
+++ b/drivers/dsp/bridge/rmgr/nldr.c
@@ -24,7 +24,7 @@
 
 #include <dspbridge/dbc.h>
 #include <dspbridge/gt.h>
-#ifdef DEBUG
+#ifdef CONFIG_BRIDGE_DEBUG
 #include <dspbridge/dbg.h>
 #endif
 
@@ -563,7 +563,7 @@ DSP_STATUS NLDR_Create(OUT struct NLDR_OBJECT **phNldr,
 				rmmSegs[i].length = (pMemInfo + i)->len;
 				rmmSegs[i].space = 0;
 				pNldr->segTable[i] = (pMemInfo + i)->type;
-#ifdef DEBUG
+#ifdef CONFIG_BRIDGE_DEBUG
 				DBG_Trace(DBG_LEVEL7,
 				    "** (proc) DLL MEMSEGMENT: %d, Base: 0x%x, "
 				    "Length: 0x%x\n", i, rmmSegs[i].base,
diff --git a/drivers/dsp/bridge/rmgr/node.c b/drivers/dsp/bridge/rmgr/node.c
index 7fd9977..2e24923 100644
--- a/drivers/dsp/bridge/rmgr/node.c
+++ b/drivers/dsp/bridge/rmgr/node.c
@@ -54,7 +54,7 @@
 
 /*  ----------------------------------- Others */
 #include <dspbridge/gb.h>
-#ifdef DEBUG
+#ifdef CONFIG_BRIDGE_DEBUG
 #include <dspbridge/uuidutil.h>
 #include <dspbridge/dbg.h>
 #endif
@@ -3086,7 +3086,7 @@ static DSP_STATUS GetNodeProps(struct DCD_MANAGER *hDcdMgr,
 	enum NODE_TYPE nodeType = NODE_TASK;
 	struct DSP_NDBPROPS *pndbProps = &(pdcdProps->objData.nodeObj.ndbProps);
 	DSP_STATUS status = DSP_SOK;
-#ifdef DEBUG
+#ifdef CONFIG_BRIDGE_DEBUG
 	char szUuid[MAXUUIDLEN];
 #endif
 
@@ -3096,7 +3096,7 @@ static DSP_STATUS GetNodeProps(struct DCD_MANAGER *hDcdMgr,
 	if (DSP_SUCCEEDED(status)) {
 		hNode->nType = nodeType = pndbProps->uNodeType;
 
-#ifdef DEBUG
+#ifdef CONFIG_BRIDGE_DEBUG
 		/* Create UUID value to set in registry. */
 		UUID_UuidToString((struct DSP_UUID *)pNodeId, szUuid,
 				 MAXUUIDLEN);
@@ -3110,7 +3110,7 @@ static DSP_STATUS GetNodeProps(struct DCD_MANAGER *hDcdMgr,
 			pMsgArgs->uNotifyType = pdcdProps->objData.nodeObj.
 						uMsgNotifyType;
 			pMsgArgs->uMaxMessages = pndbProps->uMessageDepth;
-#ifdef DEBUG
+#ifdef CONFIG_BRIDGE_DEBUG
 			DBG_Trace(DBG_LEVEL7,
 				 "** (node) Max Number of Messages: 0x%x\n",
 				 pMsgArgs->uMaxMessages);
@@ -3137,7 +3137,7 @@ static DSP_STATUS GetNodeProps(struct DCD_MANAGER *hDcdMgr,
 			pTaskArgs->uStackSize = pndbProps->uStackSize;
 			pTaskArgs->uSysStackSize = pndbProps->uSysStackSize;
 			pTaskArgs->uStackSeg = pndbProps->uStackSeg;
-#ifdef DEBUG
+#ifdef CONFIG_BRIDGE_DEBUG
 			DBG_Trace(DBG_LEVEL7,
 				"** (node) Priority: 0x%x\n" "** (node) Stack"
 				" Size: 0x%x words\n" "** (node) System Stack"
diff --git a/drivers/dsp/bridge/rmgr/proc.c b/drivers/dsp/bridge/rmgr/proc.c
index fd8fdbc..cd32561 100644
--- a/drivers/dsp/bridge/rmgr/proc.c
+++ b/drivers/dsp/bridge/rmgr/proc.c
@@ -948,7 +948,7 @@ DSP_STATUS PROC_Load(DSP_HPROCESSOR hProcessor, IN CONST s32 iArgc,
 	struct DMM_OBJECT *hDmmMgr;
 	u32 dwExtEnd;
 	u32 uProcId;
-#ifdef DEBUG
+#ifdef CONFIG_BRIDGE_DEBUG
 	BRD_STATUS uBrdState;
 #endif
 
@@ -1202,7 +1202,7 @@ DSP_STATUS PROC_Load(DSP_HPROCESSOR hProcessor, IN CONST s32 iArgc,
 	/* Restore the original argv[0] */
 	MEM_Free(newEnvp);
 	aArgv[0] = pargv0;
-#ifdef DEBUG
+#ifdef CONFIG_BRIDGE_DEBUG
 	if (DSP_SUCCEEDED(status)) {
 		if (DSP_SUCCEEDED((*pProcObject->pIntfFxns->pfnBrdStatus)
 		   (pProcObject->hWmdContext, &uBrdState))) {
@@ -1213,7 +1213,7 @@ DSP_STATUS PROC_Load(DSP_HPROCESSOR hProcessor, IN CONST s32 iArgc,
 	}
 #endif
 func_end:
-#ifdef DEBUG
+#ifdef CONFIG_BRIDGE_DEBUG
 	if (DSP_FAILED(status)) {
 		GT_0trace(PROC_DebugMask, GT_1CLASS, "PROC_Load: "
 			 "Processor Load Failed.\n");
@@ -1441,7 +1441,7 @@ DSP_STATUS PROC_Start(DSP_HPROCESSOR hProcessor)
 	struct PROC_OBJECT *pProcObject = (struct PROC_OBJECT *)hProcessor;
 	struct COD_MANAGER *hCodMgr;	/* Code manager handle    */
 	u32 dwDspAddr;	/* Loaded code's entry point.    */
-#ifdef DEBUG
+#ifdef CONFIG_BRIDGE_DEBUG
 	BRD_STATUS uBrdState;
 #endif
 	DBC_Require(cRefs > 0);
@@ -1505,7 +1505,7 @@ DSP_STATUS PROC_Start(DSP_HPROCESSOR hProcessor)
 			 "Failed to Create the Node Manager\n");
 	}
 func_cont:
-#ifdef DEBUG
+#ifdef CONFIG_BRIDGE_DEBUG
 	if (DSP_SUCCEEDED(status)) {
 		if (DSP_SUCCEEDED((*pProcObject->pIntfFxns->pfnBrdStatus)
 		   (pProcObject->hWmdContext, &uBrdState))) {
@@ -1583,7 +1583,7 @@ DSP_STATUS PROC_Stop(DSP_HPROCESSOR hProcessor)
 				MSG_Delete(hMsgMgr);
 				DEV_SetMsgMgr(pProcObject->hDevObject, NULL);
 			}
-#ifdef DEBUG
+#ifdef CONFIG_BRIDGE_DEBUG
 			if (DSP_SUCCEEDED((*pProcObject->pIntfFxns->
 			   pfnBrdStatus)(pProcObject->hWmdContext,
 			   &uBrdState))) {
@@ -1729,7 +1729,7 @@ static DSP_STATUS PROC_Monitor(struct PROC_OBJECT *hProcObject)
 	DSP_STATUS status = DSP_EFAIL;
 	struct PROC_OBJECT *pProcObject = (struct PROC_OBJECT *)hProcObject;
 	struct MSG_MGR *hMsgMgr;
-#ifdef DEBUG
+#ifdef CONFIG_BRIDGE_DEBUG
 	BRD_STATUS uBrdState;
 #endif
 
@@ -1753,7 +1753,7 @@ static DSP_STATUS PROC_Monitor(struct PROC_OBJECT *hProcObject)
 	if (DSP_SUCCEEDED((*pProcObject->pIntfFxns->pfnBrdMonitor)
 	   (pProcObject->hWmdContext))) {
 		status = DSP_SOK;
-#ifdef DEBUG
+#ifdef CONFIG_BRIDGE_DEBUG
 		if (DSP_SUCCEEDED((*pProcObject->pIntfFxns->pfnBrdStatus)
 		   (pProcObject->hWmdContext, &uBrdState))) {
 			GT_0trace(PROC_DebugMask, GT_1CLASS,
@@ -1771,7 +1771,7 @@ static DSP_STATUS PROC_Monitor(struct PROC_OBJECT *hProcObject)
 	GT_1trace(PROC_DebugMask, GT_ENTER,
 		 "Exiting PROC_Monitor, status  0x%x\n",
 		 status);
-#ifdef DEBUG
+#ifdef CONFIG_BRIDGE_DEBUG
 	DBC_Ensure((DSP_SUCCEEDED(status) && uBrdState == BRD_IDLE) ||
 		  DSP_FAILED(status));
 #endif
diff --git a/drivers/dsp/bridge/services/cfg.c b/drivers/dsp/bridge/services/cfg.c
index 4cdc4a3..7df98d1 100644
--- a/drivers/dsp/bridge/services/cfg.c
+++ b/drivers/dsp/bridge/services/cfg.c
@@ -76,7 +76,7 @@ DSP_STATUS CFG_GetAutoStart(struct CFG_DEVNODE *hDevNode,
 		if (DSP_FAILED(status))
 			status = CFG_E_RESOURCENOTAVAIL;
 	}
-#ifdef DEBUG
+#ifdef CONFIG_BRIDGE_DEBUG
 	if (DSP_SUCCEEDED(status)) {
 		GT_0trace(CFG_debugMask, GT_1CLASS,
 			 "CFG_GetAutoStart SUCCESS \n");
@@ -125,7 +125,7 @@ DSP_STATUS CFG_GetDevObject(struct CFG_DEVNODE *hDevNode, OUT u32 *pdwValue)
 				  "Failed to Identify the Device to Fetch \n");
 		}
 	}
-#ifdef DEBUG
+#ifdef CONFIG_BRIDGE_DEBUG
 	if (DSP_SUCCEEDED(status)) {
 		GT_1trace(CFG_debugMask, GT_1CLASS,
 			  "CFG_GetDevObject SUCCESS DevObject"
@@ -168,7 +168,7 @@ DSP_STATUS CFG_GetDSPResources(struct CFG_DEVNODE *hDevNode,
 		GT_0trace(CFG_debugMask, GT_6CLASS,
 			  "CFG_GetDSPResources Failed \n");
 	}
-#ifdef DEBUG
+#ifdef CONFIG_BRIDGE_DEBUG
 	/* assert that resource values are reasonable */
 	DBC_Assert(pDSPResTable->uChipType < 256);
 	DBC_Assert(pDSPResTable->uWordSize > 0);
@@ -206,7 +206,7 @@ DSP_STATUS CFG_GetExecFile(struct CFG_DEVNODE *hDevNode, u32 ulBufSize,
 			status = DSP_ESIZE;
 
 	}
-#ifdef DEBUG
+#ifdef CONFIG_BRIDGE_DEBUG
 	if (DSP_SUCCEEDED(status)) {
 		GT_1trace(CFG_debugMask, GT_1CLASS,
 			  "CFG_GetExecFile SUCCESS Exec File"
@@ -248,7 +248,7 @@ DSP_STATUS CFG_GetHostResources(struct CFG_DEVNODE *hDevNode,
 			status = CFG_E_RESOURCENOTAVAIL;
 		}
 	}
-#ifdef DEBUG
+#ifdef CONFIG_BRIDGE_DEBUG
 	if (DSP_SUCCEEDED(status)) {
 		GT_0trace(CFG_debugMask, GT_1CLASS,
 			  "CFG_GetHostResources SUCCESS \n");
@@ -361,7 +361,7 @@ DSP_STATUS CFG_SetDevObject(struct CFG_DEVNODE *hDevNode, u32 dwValue)
 				  "Failed to Register Device \n");
 		}
 	}
-#ifdef DEBUG
+#ifdef CONFIG_BRIDGE_DEBUG
 	if (DSP_SUCCEEDED(status)) {
 		GT_0trace(CFG_debugMask, GT_1CLASS,
 			  "CFG_SetDevObject SUCCESS \n");
@@ -396,7 +396,7 @@ DSP_STATUS CFG_SetObject(u32 dwValue, u32 dwType)
 	default:
 		break;
 	}
-#ifdef DEBUG
+#ifdef CONFIG_BRIDGE_DEBUG
 	if (DSP_SUCCEEDED(status))
 		GT_0trace(CFG_debugMask, GT_1CLASS, "CFG_SetObject SUCCESS \n");
 	else
diff --git a/drivers/dsp/bridge/services/dbg.c b/drivers/dsp/bridge/services/dbg.c
index bc5c8cd..93fd817 100644
--- a/drivers/dsp/bridge/services/dbg.c
+++ b/drivers/dsp/bridge/services/dbg.c
@@ -33,7 +33,7 @@
 static struct GT_Mask DBG_debugMask = { NULL, NULL };	/* GT trace var. */
 #endif
 
-#if (defined(DEBUG) || defined(DDSP_DEBUG_PRODUCT)) && GT_TRACE
+#if (defined(CONFIG_BRIDGE_DEBUG) || defined(DDSP_DEBUG_PRODUCT)) && GT_TRACE
 
 /*
  *  ======== DBG_Init ========
@@ -87,4 +87,4 @@ void DBG_Exit(void)
 	GT_0trace(DBG_debugMask, GT_5CLASS, "DBG_Exit\n");
 }
 
-#endif	/* (defined(DEBUG) || defined(DDSP_DEBUG_PRODUCT)) && GT_TRACE */
+#endif	/* (CONFIG_BRIDGE_DEBUG || DDSP_DEBUG_PRODUCT) && GT_TRACE */
diff --git a/drivers/dsp/bridge/services/mem.c b/drivers/dsp/bridge/services/mem.c
index 79d32f5..2aff2d2 100644
--- a/drivers/dsp/bridge/services/mem.c
+++ b/drivers/dsp/bridge/services/mem.c
@@ -36,7 +36,7 @@
 #define MEM_512MB   0x1fffffff
 #define memInfoSign 0x464E494D	/* "MINF" (in reverse). */
 
-#ifdef DEBUG
+#ifdef CONFIG_BRIDGE_DEBUG
 #define MEM_CHECK		/* Use to detect source of memory leaks */
 #endif
 
diff --git a/drivers/dsp/bridge/wmd/io_sm.c b/drivers/dsp/bridge/wmd/io_sm.c
index edb83c1..d267cab 100644
--- a/drivers/dsp/bridge/wmd/io_sm.c
+++ b/drivers/dsp/bridge/wmd/io_sm.c
@@ -1952,7 +1952,7 @@ void PrintDSPDebugTrace(struct IO_MGR *hIOMgr)
  *      There are no more than ulNumWords extra characters needed (the number of
  *      linefeeds minus the number of NULLS in the input buffer).
  */
-#if (defined(DEBUG) || defined(DDSP_DEBUG_PRODUCT)) && GT_TRACE
+#if (defined(CONFIG_BRIDGE_DEBUG) || defined(DDSP_DEBUG_PRODUCT)) && GT_TRACE
 static DSP_STATUS PackTraceBuffer(char *lpBuf, u32 nBytes, u32 ulNumWords)
 {
 	DSP_STATUS status = DSP_SOK;
@@ -2000,7 +2000,7 @@ static DSP_STATUS PackTraceBuffer(char *lpBuf, u32 nBytes, u32 ulNumWords)
 
 	return status;
 }
-#endif    /* (defined(DEBUG) || defined(DDSP_DEBUG_PRODUCT)) && GT_TRACE */
+#endif    /* (CONFIG_BRIDGE_DEBUG || DDSP_DEBUG_PRODUCT) && GT_TRACE */
 
 /*
  *  ======== PrintDspTraceBuffer ========
@@ -2018,7 +2018,7 @@ DSP_STATUS PrintDspTraceBuffer(struct WMD_DEV_CONTEXT *hWmdContext)
 {
 	DSP_STATUS status = DSP_SOK;
 
-#if (defined(DEBUG) || defined(DDSP_DEBUG_PRODUCT)) && GT_TRACE
+#if (defined(CONFIG_BRIDGE_DEBUG) || defined(DDSP_DEBUG_PRODUCT)) && GT_TRACE
 	struct COD_MANAGER *hCodMgr;
 	u32 ulTraceEnd;
 	u32 ulTraceBegin;
-- 
1.6.2.4

