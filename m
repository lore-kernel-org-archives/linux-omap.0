From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH] DSPBRIDGE: Resource clean up always enabled.
Date: Tue,  2 Feb 2010 14:18:07 -0600
Message-ID: <1265141887-8329-1-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:52038 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751532Ab0BBUGx (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 2 Feb 2010 15:06:53 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Ameya Palande <ameya.palande@nokia.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>, Nishanth Menon <nm@ti.com>, Ernesto Ramos <ernesto@ti.com>

From: Ernesto Ramos <ernesto@ti.com>

Remove flag RES_CLEANUP_DISABLE to have dspbridge
resource cleanup allways enabled.

Signed-off-by: Ernesto Ramos <ernesto@ti.com>
Acked-by: Ameya Palande <ameya.palande@nokia.com>
---
 arch/arm/plat-omap/include/dspbridge/_dcd.h        |    3 --
 arch/arm/plat-omap/include/dspbridge/drv.h         |    3 +-
 .../plat-omap/include/dspbridge/resourcecleanup.h  |    2 -
 arch/arm/plat-omap/include/dspbridge/wcdioctl.h    |    5 +---
 drivers/dsp/bridge/pmgr/wcd.c                      |    8 ------
 drivers/dsp/bridge/rmgr/drv.c                      |    4 ---
 drivers/dsp/bridge/rmgr/drv_interface.c            |    4 ---
 drivers/dsp/bridge/rmgr/node.c                     |   14 +---------
 drivers/dsp/bridge/rmgr/proc.c                     |   12 +-------
 drivers/dsp/bridge/rmgr/strm.c                     |   27 ++++++--------------
 drivers/dsp/bridge/wmd/chnl_sm.c                   |    2 -
 11 files changed, 14 insertions(+), 70 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/_dcd.h b/arch/arm/plat-omap/include/dspbridge/_dcd.h
index 160c873..c6bc61d 100644
--- a/arch/arm/plat-omap/include/dspbridge/_dcd.h
+++ b/arch/arm/plat-omap/include/dspbridge/_dcd.h
@@ -96,11 +96,8 @@
 	extern u32 MGRWRAP_WaitForBridgeEvents(union Trapped_Args *args,
 			void *pr_ctxt);
 
-#ifndef RES_CLEANUP_DISABLE
 	extern u32 MGRWRAP_GetProcessResourcesInfo(union Trapped_Args *args,
 			void *pr_ctxt);
-#endif
-
 
 /* CPRC (Processor) wrapper Functions */
 	extern u32 PROCWRAP_Attach(union Trapped_Args *args, void *pr_ctxt);
diff --git a/arch/arm/plat-omap/include/dspbridge/drv.h b/arch/arm/plat-omap/include/dspbridge/drv.h
index e4e91f3..b6a5fd2 100644
--- a/arch/arm/plat-omap/include/dspbridge/drv.h
+++ b/arch/arm/plat-omap/include/dspbridge/drv.h
@@ -78,7 +78,6 @@
 #define OMAP_PRCM_VDD1_DOMAIN 1
 #define OMAP_PRCM_VDD2_DOMAIN 2
 
-#ifndef RES_CLEANUP_DISABLE
 
 /* GPP PROCESS CLEANUP Data structures */
 
@@ -148,7 +147,7 @@ struct PROCESS_CONTEXT{
 	/* Stream resources */
 	struct STRM_RES_OBJECT *pSTRMList;
 } ;
-#endif
+
 
 /*
  *  ======== DRV_Create ========
diff --git a/arch/arm/plat-omap/include/dspbridge/resourcecleanup.h b/arch/arm/plat-omap/include/dspbridge/resourcecleanup.h
index 9e78170..ffbcf5e 100644
--- a/arch/arm/plat-omap/include/dspbridge/resourcecleanup.h
+++ b/arch/arm/plat-omap/include/dspbridge/resourcecleanup.h
@@ -14,7 +14,6 @@
  * WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR A PARTICULAR PURPOSE.
  */
 
-#ifndef RES_CLEANUP_DISABLE
 
 #include <dspbridge/nodepriv.h>
 #include <dspbridge/drv.h>
@@ -74,4 +73,3 @@ extern DSP_STATUS DRV_RemoveAllSTRMResElements(HANDLE pCtxt);
 
 extern enum NODE_STATE NODE_GetState(HANDLE hNode);
 
-#endif
diff --git a/arch/arm/plat-omap/include/dspbridge/wcdioctl.h b/arch/arm/plat-omap/include/dspbridge/wcdioctl.h
index bd84bf0..4da45d7 100644
--- a/arch/arm/plat-omap/include/dspbridge/wcdioctl.h
+++ b/arch/arm/plat-omap/include/dspbridge/wcdioctl.h
@@ -101,10 +101,7 @@ union Trapped_Args {
 	struct {
 		DSP_HPROCESSOR hProcessor;
 		u8 __user *pBuf;
-
-	#ifndef RES_CLEANUP_DISABLE
-	    u8 __user *pSize;
-    #endif
+		u8 __user *pSize;
 		u32 uMaxSize;
 	} ARGS_PROC_GETTRACE;
 
diff --git a/drivers/dsp/bridge/pmgr/wcd.c b/drivers/dsp/bridge/pmgr/wcd.c
index b92386a..9e34af1 100644
--- a/drivers/dsp/bridge/pmgr/wcd.c
+++ b/drivers/dsp/bridge/pmgr/wcd.c
@@ -59,9 +59,7 @@
 #include <dspbridge/_dcd.h>
 #include <dspbridge/dbdcd.h>
 
-#ifndef RES_CLEANUP_DISABLE
 #include <dspbridge/resourcecleanup.h>
-#endif
 
 /*  ----------------------------------- Defines, Data Structures, Typedefs */
 #define MAX_TRACEBUFLEN 255
@@ -99,11 +97,7 @@ static struct WCD_Cmd mgr_cmd[] = {
 	{MGRWRAP_RegisterObject},		/* MGR_REGISTEROBJECT */
 	{MGRWRAP_UnregisterObject},		/* MGR_UNREGISTEROBJECT */
 	{MGRWRAP_WaitForBridgeEvents},		/* MGR_WAIT */
-#ifndef RES_CLEANUP_DISABLE
 	{MGRWRAP_GetProcessResourcesInfo},	/* MGR_GET_PROC_RES */
-#else
-	{NULL},
-#endif
 };
 
 /* PROC wrapper functions */
@@ -624,7 +618,6 @@ u32 MGRWRAP_WaitForBridgeEvents(union Trapped_Args *args, void *pr_ctxt)
 }
 
 
-#ifndef RES_CLEANUP_DISABLE
 /*
  * ======== MGRWRAP_GetProcessResourceInfo ========
  */
@@ -634,7 +627,6 @@ u32 __deprecated MGRWRAP_GetProcessResourcesInfo(union Trapped_Args *args,
 	pr_err("%s: deprecated dspbridge ioctl\n", __func__);
 	return DSP_SOK;
 }
-#endif
 
 
 /*
diff --git a/drivers/dsp/bridge/rmgr/drv.c b/drivers/dsp/bridge/rmgr/drv.c
index ca14908..122727d 100644
--- a/drivers/dsp/bridge/rmgr/drv.c
+++ b/drivers/dsp/bridge/rmgr/drv.c
@@ -38,14 +38,12 @@
 #include <dspbridge/drv.h>
 #include <dspbridge/dev.h>
 
-#ifndef RES_CLEANUP_DISABLE
 #include <dspbridge/node.h>
 #include <dspbridge/proc.h>
 #include <dspbridge/strm.h>
 #include <dspbridge/nodepriv.h>
 #include <dspbridge/wmdchnl.h>
 #include <dspbridge/resourcecleanup.h>
-#endif
 
 /*  ----------------------------------- Defines, Data Structures, Typedefs */
 #define SIGNATURE   0x5f52474d	/* "DRV_" (in reverse) */
@@ -76,7 +74,6 @@ extern struct GT_Mask curTrace;
 static DSP_STATUS RequestBridgeResources(u32 dwContext, s32 fRequest);
 static DSP_STATUS RequestBridgeResourcesDSP(u32 dwContext, s32 fRequest);
 
-#ifndef RES_CLEANUP_DISABLE
 /* GPP PROCESS CLEANUP CODE */
 
 static DSP_STATUS DRV_ProcFreeNodeRes(HANDLE hPCtxt);
@@ -554,7 +551,6 @@ DSP_STATUS DRV_ProcUpdateSTRMRes(u32 uNumBufs, HANDLE hSTRMRes)
 }
 
 /* GPP PROCESS CLEANUP CODE END */
-#endif
 
 /*
  *  ======== = DRV_Create ======== =
diff --git a/drivers/dsp/bridge/rmgr/drv_interface.c b/drivers/dsp/bridge/rmgr/drv_interface.c
index ce6a340..6fe6cbe 100644
--- a/drivers/dsp/bridge/rmgr/drv_interface.c
+++ b/drivers/dsp/bridge/rmgr/drv_interface.c
@@ -56,7 +56,6 @@
 /*  ----------------------------------- This */
 #include <drv_interface.h>
 
-#ifndef RES_CLEANUP_DISABLE
 #include <dspbridge/cfg.h>
 #include <dspbridge/resourcecleanup.h>
 #include <dspbridge/chnl.h>
@@ -64,7 +63,6 @@
 #include <dspbridge/dev.h>
 #include <dspbridge/drvdefs.h>
 #include <dspbridge/drv.h>
-#endif
 
 #ifdef CONFIG_BRIDGE_DVFS
 #include <mach-omap2/omap3-opp.h>
@@ -621,7 +619,6 @@ static int bridge_mmap(struct file *filp, struct vm_area_struct *vma)
 	return status;
 }
 
-#ifndef RES_CLEANUP_DISABLE
 /* To remove all process resources before removing the process from the
  * process context list*/
 DSP_STATUS DRV_RemoveAllResources(HANDLE hPCtxt)
@@ -634,7 +631,6 @@ DSP_STATUS DRV_RemoveAllResources(HANDLE hPCtxt)
 	pCtxt->resState = PROC_RES_FREED;
 	return status;
 }
-#endif
 
 /* Bridge driver initialization and de-initialization functions */
 module_init(bridge_init);
diff --git a/drivers/dsp/bridge/rmgr/node.c b/drivers/dsp/bridge/rmgr/node.c
index 71e5695..6b33662 100644
--- a/drivers/dsp/bridge/rmgr/node.c
+++ b/drivers/dsp/bridge/rmgr/node.c
@@ -67,11 +67,9 @@
 #include <dspbridge/dbll.h>
 #include <dspbridge/nldr.h>
 
-#ifndef RES_CLEANUP_DISABLE
 #include <dspbridge/drv.h>
 #include <dspbridge/drvdefs.h>
 #include <dspbridge/resourcecleanup.h>
-#endif
 
 
 #define NODE_SIGNATURE      0x45444f4e	/* "EDON" */
@@ -338,9 +336,7 @@ DSP_STATUS NODE_Allocate(struct PROC_OBJECT *hProcessor,
 	struct PROC_OBJECT *pProcObject = (struct PROC_OBJECT *)hProcessor;
 #endif
 
-#ifndef RES_CLEANUP_DISABLE
 	HANDLE nodeRes;
-#endif
 
 	DBC_Require(cRefs > 0);
 	DBC_Require(hProcessor != NULL);
@@ -696,13 +692,11 @@ func_cont:
 
 	}
 
-#ifndef RES_CLEANUP_DISABLE
 	if (DSP_SUCCEEDED(status)) {
 		DRV_InsertNodeResElement(*phNode, &nodeRes, pr_ctxt);
 		DRV_ProcNodeUpdateHeapStatus(nodeRes, true);
 		DRV_ProcNodeUpdateStatus(nodeRes, true);
 	}
-#endif
 	DBC_Ensure((DSP_FAILED(status) && (*phNode == NULL)) ||
 		  (DSP_SUCCEEDED(status)
 		    && MEM_IsValidHandle((*phNode), NODE_SIGNATURE)));
@@ -1516,9 +1510,8 @@ DSP_STATUS NODE_Delete(struct NODE_OBJECT *hNode,
 	u32 procId;
 	struct WMD_DRV_INTERFACE *pIntfFxns;
 
-#ifndef RES_CLEANUP_DISABLE
 	HANDLE		nodeRes;
-#endif
+
 	struct DSP_PROCESSORSTATE procStatus;
 	DBC_Require(cRefs > 0);
 	GT_1trace(NODE_debugMask, GT_ENTER, "NODE_Delete: hNode: 0x%x\n",
@@ -1642,18 +1635,15 @@ func_cont1:
 		hNodeMgr->uNumCreated--;
 	 /*  Free host-side resources allocated by NODE_Create()
 	 *  DeleteNode() fails if SM buffers not freed by client!  */
-#ifndef RES_CLEANUP_DISABLE
 	if (DRV_GetNodeResElement(hNode, &nodeRes, pr_ctxt) != DSP_ENOTFOUND) {
 		GT_0trace(NODE_debugMask, GT_5CLASS, "\nNODE_Delete12:\n");
 		DRV_ProcNodeUpdateStatus(nodeRes, false);
 	}
-#endif
 	GT_0trace(NODE_debugMask, GT_ENTER, "\nNODE_Delete13:\n ");
 	DeleteNode(hNode, pr_ctxt);
-#ifndef RES_CLEANUP_DISABLE
+
 	GT_0trace(NODE_debugMask, GT_5CLASS, "\nNODE_Delete2:\n ");
 	DRV_RemoveNodeResElement(nodeRes, pr_ctxt);
-#endif
 	GT_0trace(NODE_debugMask, GT_ENTER, "\nNODE_Delete3:\n ");
 	/* Exit critical section */
 	(void)SYNC_LeaveCS(hNodeMgr->hSync);
diff --git a/drivers/dsp/bridge/rmgr/proc.c b/drivers/dsp/bridge/rmgr/proc.c
index d458ac7..e50eb52 100644
--- a/drivers/dsp/bridge/rmgr/proc.c
+++ b/drivers/dsp/bridge/rmgr/proc.c
@@ -59,9 +59,7 @@
 #include <dspbridge/proc.h>
 #include <dspbridge/pwr.h>
 
-#ifndef RES_CLEANUP_DISABLE
 #include <dspbridge/resourcecleanup.h>
-#endif
 /*  ----------------------------------- Defines, Data Structures, Typedefs */
 #define PROC_SIGNATURE	   0x434F5250	/* "PROC" (in reverse). */
 #define MAXCMDLINELEN       255
@@ -1288,9 +1286,7 @@ DSP_STATUS PROC_Map(DSP_HPROCESSOR hProcessor, void *pMpuAddr, u32 ulSize,
 	DSP_STATUS status = DSP_SOK;
 	struct PROC_OBJECT *pProcObject = (struct PROC_OBJECT *)hProcessor;
 
-#ifndef RES_CLEANUP_DISABLE
        HANDLE        dmmRes;
-#endif
 
 	GT_6trace(PROC_DebugMask, GT_ENTER, "Entered PROC_Map, args:\n\t"
 		 "hProcessor %x, pMpuAddr %x, ulSize %x, pReqAddr %x, "
@@ -1337,13 +1333,11 @@ DSP_STATUS PROC_Map(DSP_HPROCESSOR hProcessor, void *pMpuAddr, u32 ulSize,
 	}
 	(void)SYNC_LeaveCS(hProcLock);
 
-#ifndef RES_CLEANUP_DISABLE
 	if (DSP_SUCCEEDED(status)) {
 		DRV_InsertDMMResElement(&dmmRes, pr_ctxt);
 		DRV_UpdateDMMResElement(dmmRes, (u32)pMpuAddr, ulSize,
 				(u32)pReqAddr, (u32)*ppMapAddr, hProcessor);
 	}
-#endif
 func_end:
 	GT_1trace(PROC_DebugMask, GT_ENTER, "Leaving PROC_Map [0x%x]", status);
 	return status;
@@ -1655,9 +1649,9 @@ DSP_STATUS PROC_UnMap(DSP_HPROCESSOR hProcessor, void *pMapAddr,
 	struct DMM_OBJECT *hDmmMgr;
 	u32 vaAlign;
 	u32 sizeAlign;
-#ifndef RES_CLEANUP_DISABLE
+
 	HANDLE	      dmmRes;
-#endif
+
 	GT_2trace(PROC_DebugMask, GT_ENTER,
 		 "Entered PROC_UnMap, args:\n\thProcessor:"
 		 "0x%x pMapAddr: 0x%x\n", hProcessor, pMapAddr);
@@ -1690,7 +1684,6 @@ DSP_STATUS PROC_UnMap(DSP_HPROCESSOR hProcessor, void *pMapAddr,
 			 (pProcObject->hWmdContext, vaAlign, sizeAlign);
 	}
 	(void)SYNC_LeaveCS(hProcLock);
-#ifndef RES_CLEANUP_DISABLE
 	GT_1trace(PROC_DebugMask, GT_ENTER,
 		   "PROC_UnMap DRV_GetDMMResElement "
 		   "pMapAddr:[0x%x]", pMapAddr);
@@ -1700,7 +1693,6 @@ DSP_STATUS PROC_UnMap(DSP_HPROCESSOR hProcessor, void *pMapAddr,
 	if (DRV_GetDMMResElement((u32)pMapAddr, &dmmRes, pr_ctxt)
 							!= DSP_ENOTFOUND)
 		DRV_RemoveDMMResElement(dmmRes, pr_ctxt);
-#endif
 func_end:
 	GT_1trace(PROC_DebugMask, GT_ENTER,
 		 "Leaving PROC_UnMap [0x%x]", status);
diff --git a/drivers/dsp/bridge/rmgr/strm.c b/drivers/dsp/bridge/rmgr/strm.c
index febb6c2..6be8083 100644
--- a/drivers/dsp/bridge/rmgr/strm.c
+++ b/drivers/dsp/bridge/rmgr/strm.c
@@ -44,10 +44,8 @@
 /*  ----------------------------------- This */
 #include <dspbridge/strm.h>
 
-#ifndef RES_CLEANUP_DISABLE
 #include <dspbridge/cfg.h>
 #include <dspbridge/resourcecleanup.h>
-#endif
 
 /*  ----------------------------------- Defines, Data Structures, Typedefs */
 #define STRM_SIGNATURE      0x4d525453	/* "MRTS" */
@@ -114,9 +112,9 @@ DSP_STATUS STRM_AllocateBuffer(struct STRM_OBJECT *hStrm, u32 uSize,
 	DSP_STATUS status = DSP_SOK;
 	u32 uAllocated = 0;
 	u32 i;
-#ifndef RES_CLEANUP_DISABLE
+
 	HANDLE hSTRMRes;
-#endif
+
 	DBC_Require(cRefs > 0);
 	DBC_Require(apBuffer != NULL);
 
@@ -152,14 +150,13 @@ DSP_STATUS STRM_AllocateBuffer(struct STRM_OBJECT *hStrm, u32 uSize,
 	if (DSP_FAILED(status))
 		STRM_FreeBuffer(hStrm, apBuffer, uAllocated, pr_ctxt);
 
-#ifndef RES_CLEANUP_DISABLE
 	if (DSP_FAILED(status))
 		goto func_end;
 
 	if (DRV_GetSTRMResElement(hStrm, &hSTRMRes, pr_ctxt) !=
 			DSP_ENOTFOUND)
 		DRV_ProcUpdateSTRMRes(uNumBufs, hSTRMRes);
-#endif
+
 func_end:
 	return status;
 }
@@ -176,9 +173,7 @@ DSP_STATUS STRM_Close(struct STRM_OBJECT *hStrm,
 	struct CHNL_INFO chnlInfo;
 	DSP_STATUS status = DSP_SOK;
 
-#ifndef RES_CLEANUP_DISABLE
-    HANDLE	      hSTRMRes;
-#endif
+	HANDLE	      hSTRMRes;
 
 	DBC_Require(cRefs > 0);
 
@@ -198,7 +193,7 @@ DSP_STATUS STRM_Close(struct STRM_OBJECT *hStrm,
 		else
 			status = DeleteStrm(hStrm);
 	}
-#ifndef RES_CLEANUP_DISABLE
+
 	if (DSP_FAILED(status))
 		goto func_end;
 
@@ -206,7 +201,6 @@ DSP_STATUS STRM_Close(struct STRM_OBJECT *hStrm,
 			DSP_ENOTFOUND)
 		DRV_ProcRemoveSTRMResElement(hSTRMRes, pr_ctxt);
 func_end:
-#endif
 	DBC_Ensure(status == DSP_SOK || status == DSP_EHANDLE ||
 		  status == DSP_EPENDING || status == DSP_EFAIL);
 
@@ -312,9 +306,8 @@ DSP_STATUS STRM_FreeBuffer(struct STRM_OBJECT *hStrm, u8 **apBuffer,
 	DSP_STATUS status = DSP_SOK;
 	u32 i = 0;
 
-#ifndef RES_CLEANUP_DISABLE
 	HANDLE hSTRMRes = NULL;
-#endif
+
 	DBC_Require(cRefs > 0);
 	DBC_Require(apBuffer != NULL);
 
@@ -337,11 +330,10 @@ DSP_STATUS STRM_FreeBuffer(struct STRM_OBJECT *hStrm, u8 **apBuffer,
 			apBuffer[i] = NULL;
 		}
 	}
-#ifndef RES_CLEANUP_DISABLE
 	if (DRV_GetSTRMResElement(hStrm, hSTRMRes, pr_ctxt) !=
 			DSP_ENOTFOUND)
 		DRV_ProcUpdateSTRMRes(uNumBufs-i, hSTRMRes);
-#endif
+
 	return status;
 }
 
@@ -529,9 +521,8 @@ DSP_STATUS STRM_Open(struct NODE_OBJECT *hNode, u32 uDir, u32 uIndex,
 	DSP_STATUS status = DSP_SOK;
 	struct CMM_OBJECT *hCmmMgr = NULL;	/* Shared memory manager hndl */
 
-#ifndef RES_CLEANUP_DISABLE
 	HANDLE hSTRMRes;
-#endif
+
 	DBC_Require(cRefs > 0);
 	DBC_Require(phStrm != NULL);
 	DBC_Require(pAttr != NULL);
@@ -666,9 +657,7 @@ func_cont:
 	else
 		(void)DeleteStrm(pStrm);
 
-#ifndef RES_CLEANUP_DISABLE
 	DRV_ProcInsertSTRMResElement(*phStrm, &hSTRMRes, pr_ctxt);
-#endif
 
 	 /* ensure we return a documented error code */
 	DBC_Ensure((DSP_SUCCEEDED(status) &&
diff --git a/drivers/dsp/bridge/wmd/chnl_sm.c b/drivers/dsp/bridge/wmd/chnl_sm.c
index 99c876d..b64e7c0 100644
--- a/drivers/dsp/bridge/wmd/chnl_sm.c
+++ b/drivers/dsp/bridge/wmd/chnl_sm.c
@@ -689,7 +689,6 @@ DSP_STATUS WMD_CHNL_GetIOC(struct CHNL_OBJECT *hChnl, u32 dwTimeOut,
 
 		/*pHostUserBuf */
 		status = copy_to_user(ioc.pBuf, pHostSysBuf, ioc.cBytes);
-#ifndef RES_CLEANUP_DISABLE
 		if (status) {
 			if (current->flags & PF_EXITING) {
 				DBG_Trace(DBG_LEVEL7,
@@ -704,7 +703,6 @@ DSP_STATUS WMD_CHNL_GetIOC(struct CHNL_OBJECT *hChnl, u32 dwTimeOut,
 					 current->flags);
 			}
 		}
-#endif
 		if (status) {
 			DBG_Trace(DBG_LEVEL7,
 				 "Error copying kernel buffer to user, %d"
-- 
1.6.2.4

