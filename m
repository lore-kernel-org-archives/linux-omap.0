From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 2/7] DSPBRIDGE: Define pr_ctxt as a parameter in low level functions
Date: Wed, 16 Dec 2009 21:45:53 -0600
Message-ID: <1261021558-19036-3-git-send-email-omar.ramirez@ti.com>
References: <1261021558-19036-1-git-send-email-omar.ramirez@ti.com>
 <1261021558-19036-2-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:45488 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932293AbZLQDis (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 16 Dec 2009 22:38:48 -0500
In-Reply-To: <1261021558-19036-2-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Ameya Palande <ameya.palande@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>, Fernando Guzman <x0095840@ti.com>, Ernesto Ramos <ernesto@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>

From: Ameya Palande <ameya.palande@nokia.com>

As part of resource cleanup changes, this patch continues with the
next level of modifications required to use filp->private to store
PROCESS_CONTEXT structure.

Signed-off-by: Ameya Palande <ameya.palande@nokia.com>
[ orl: split into logical patch set, patch description ]
Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
Acked-by: Fernando Guzman Lugo <x0095840@ti.com>
---
 arch/arm/plat-omap/include/dspbridge/node.h |    7 +++++--
 arch/arm/plat-omap/include/dspbridge/proc.h |   13 +++++++++----
 arch/arm/plat-omap/include/dspbridge/strm.h |   13 +++++++++----
 drivers/dsp/bridge/pmgr/wcd.c               |   25 +++++++++++--------------
 drivers/dsp/bridge/rmgr/drv.c               |   15 +++++++++------
 drivers/dsp/bridge/rmgr/drv_interface.c     |    4 ++--
 drivers/dsp/bridge/rmgr/node.c              |   23 ++++++++++++++---------
 drivers/dsp/bridge/rmgr/proc.c              |   14 +++++++++-----
 drivers/dsp/bridge/rmgr/strm.c              |   14 +++++++++-----
 9 files changed, 77 insertions(+), 51 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/node.h b/arch/arm/plat-omap/include/dspbridge/node.h
index d253962..e8952f5 100644
--- a/arch/arm/plat-omap/include/dspbridge/node.h
+++ b/arch/arm/plat-omap/include/dspbridge/node.h
@@ -68,6 +68,7 @@
 #include <dspbridge/nodedefs.h>
 #include <dspbridge/dispdefs.h>
 #include <dspbridge/nldrdefs.h>
+#include <dspbridge/drv.h>
 
 /*
  *  ======== NODE_Allocate ========
@@ -104,7 +105,8 @@
 					*pArgs,
 					OPTIONAL IN CONST struct DSP_NODEATTRIN
 					*pAttrIn,
-					OUT struct NODE_OBJECT **phNode);
+					OUT struct NODE_OBJECT **phNode,
+					struct PROCESS_CONTEXT *pr_ctxt);
 
 /*
  *  ======== NODE_AllocMsgBuf ========
@@ -307,7 +309,8 @@
  *  Ensures:
  *      DSP_SOK:            hNode is invalid.
  */
-	extern DSP_STATUS NODE_Delete(struct NODE_OBJECT *hNode);
+	extern DSP_STATUS NODE_Delete(struct NODE_OBJECT *hNode,
+			struct PROCESS_CONTEXT *pr_ctxt);
 
 /*
  *  ======== NODE_DeleteMgr ========
diff --git a/arch/arm/plat-omap/include/dspbridge/proc.h b/arch/arm/plat-omap/include/dspbridge/proc.h
index 486652e..f5b0c50 100644
--- a/arch/arm/plat-omap/include/dspbridge/proc.h
+++ b/arch/arm/plat-omap/include/dspbridge/proc.h
@@ -64,6 +64,7 @@
 
 #include <dspbridge/cfgdefs.h>
 #include <dspbridge/devdefs.h>
+#include <dspbridge/drv.h>
 
 /*
  *  ======== PROC_Attach ========
@@ -94,7 +95,8 @@
 	extern DSP_STATUS PROC_Attach(u32 uProcessor,
 				      OPTIONAL CONST struct DSP_PROCESSORATTRIN
 				      *pAttrIn,
-				      OUT DSP_HPROCESSOR *phProcessor);
+				      OUT DSP_HPROCESSOR *phProcessor,
+				      struct PROCESS_CONTEXT *pr_ctxt);
 
 /*
  *  ======== PROC_AutoStart =========
@@ -161,7 +163,8 @@
  *  Ensures:
  *      PROC Object is destroyed.
  */
-	extern DSP_STATUS PROC_Detach(DSP_HPROCESSOR hProcessor);
+	extern DSP_STATUS PROC_Detach(DSP_HPROCESSOR hProcessor,
+			struct PROCESS_CONTEXT *pr_ctxt);
 
 /*
  *  ======== PROC_EnumNodes ========
@@ -578,7 +581,8 @@
 				   void *pMpuAddr,
 				   u32 ulSize,
 				   void *pReqAddr,
-				   void **ppMapAddr, u32 ulMapAttr);
+				   void **ppMapAddr, u32 ulMapAttr,
+				   struct PROCESS_CONTEXT *pr_ctxt);
 
 /*
  *  ======== PROC_ReserveMemory ========
@@ -621,7 +625,8 @@
  *  Ensures:
  *  Details:
  */
-	extern DSP_STATUS PROC_UnMap(DSP_HPROCESSOR hProcessor, void *pMapAddr);
+	extern DSP_STATUS PROC_UnMap(DSP_HPROCESSOR hProcessor, void *pMapAddr,
+			struct PROCESS_CONTEXT *pr_ctxt);
 
 /*
  *  ======== PROC_UnReserveMemory ========
diff --git a/arch/arm/plat-omap/include/dspbridge/strm.h b/arch/arm/plat-omap/include/dspbridge/strm.h
index 5825615..bedc715 100644
--- a/arch/arm/plat-omap/include/dspbridge/strm.h
+++ b/arch/arm/plat-omap/include/dspbridge/strm.h
@@ -59,6 +59,7 @@
 #include <dspbridge/dev.h>
 
 #include <dspbridge/strmdefs.h>
+#include <dspbridge/proc.h>
 
 /*
  *  ======== STRM_AllocateBuffer ========
@@ -83,7 +84,8 @@
 	extern DSP_STATUS STRM_AllocateBuffer(struct STRM_OBJECT *hStrm,
 					      u32 uSize,
 					      OUT u8 **apBuffer,
-					      u32 uNumBufs);
+					      u32 uNumBufs,
+					      struct PROCESS_CONTEXT *pr_ctxt);
 
 /*
  *  ======== STRM_Close ========
@@ -101,7 +103,8 @@
  *      STRM_Init(void) called.
  *  Ensures:
  */
-	extern DSP_STATUS STRM_Close(struct STRM_OBJECT *hStrm);
+	extern DSP_STATUS STRM_Close(struct STRM_OBJECT *hStrm,
+				struct PROCESS_CONTEXT *pr_ctxt);
 
 /*
  *  ======== STRM_Create ========
@@ -172,7 +175,8 @@
  *  Ensures:
  */
 	extern DSP_STATUS STRM_FreeBuffer(struct STRM_OBJECT *hStrm,
-					  u8 **apBuffer, u32 uNumBufs);
+					  u8 **apBuffer, u32 uNumBufs,
+					  struct PROCESS_CONTEXT *pr_ctxt);
 
 /*
  *  ======== STRM_GetEventHandle ========
@@ -307,7 +311,8 @@
  */
 	extern DSP_STATUS STRM_Open(struct NODE_OBJECT *hNode, u32 uDir,
 				    u32 uIndex, IN struct STRM_ATTR *pAttr,
-				    OUT struct STRM_OBJECT **phStrm);
+				    OUT struct STRM_OBJECT **phStrm,
+				    struct PROCESS_CONTEXT *pr_ctxt);
 
 /*
  *  ======== STRM_PrepareBuffer ========
diff --git a/drivers/dsp/bridge/pmgr/wcd.c b/drivers/dsp/bridge/pmgr/wcd.c
index 3fa7336..0d027ec 100644
--- a/drivers/dsp/bridge/pmgr/wcd.c
+++ b/drivers/dsp/bridge/pmgr/wcd.c
@@ -680,7 +680,7 @@ u32 PROCWRAP_Attach(union Trapped_Args *args, void *pr_ctxt)
 
 	}
 	status = PROC_Attach(args->ARGS_PROC_ATTACH.uProcessor, pAttrIn,
-			    &processor);
+			    &processor, pr_ctxt);
 	cp_to_usr(args->ARGS_PROC_ATTACH.phProcessor, &processor, status, 1);
 func_end:
 	return status;
@@ -740,7 +740,7 @@ u32 PROCWRAP_Detach(union Trapped_Args *args, void *pr_ctxt)
 	GT_1trace(WCD_debugMask, GT_ENTER,
 		 "PROCWRAP_Detach: entered args\n0x%x "
 		 "hProceesor \n", args->ARGS_PROC_DETACH.hProcessor);
-	retVal = PROC_Detach(args->ARGS_PROC_DETACH.hProcessor);
+	retVal = PROC_Detach(args->ARGS_PROC_DETACH.hProcessor, pr_ctxt);
 
 	return retVal;
 }
@@ -1019,7 +1019,7 @@ u32 PROCWRAP_Map(union Trapped_Args *args, void *pr_ctxt)
 			 args->ARGS_PROC_MAPMEM.pMpuAddr,
 			 args->ARGS_PROC_MAPMEM.ulSize,
 			 args->ARGS_PROC_MAPMEM.pReqAddr, &pMapAddr,
-			 args->ARGS_PROC_MAPMEM.ulMapAttr);
+			 args->ARGS_PROC_MAPMEM.ulMapAttr, pr_ctxt);
 	if (DSP_SUCCEEDED(status)) {
 		if (put_user(pMapAddr, args->ARGS_PROC_MAPMEM.ppMapAddr))
 			status = DSP_EINVALIDARG;
@@ -1090,7 +1090,7 @@ u32 PROCWRAP_UnMap(union Trapped_Args *args, void *pr_ctxt)
 
 	GT_0trace(WCD_debugMask, GT_ENTER, "PROCWRAP_UnMap: entered\n");
 	status = PROC_UnMap(args->ARGS_PROC_UNMAPMEM.hProcessor,
-			   args->ARGS_PROC_UNMAPMEM.pMapAddr);
+			   args->ARGS_PROC_UNMAPMEM.pMapAddr, pr_ctxt);
 	return status;
 }
 
@@ -1166,7 +1166,7 @@ u32 NODEWRAP_Allocate(union Trapped_Args *args, void *pr_ctxt)
 	if (DSP_SUCCEEDED(status)) {
 		status = NODE_Allocate(args->ARGS_NODE_ALLOCATE.hProcessor,
 				      &nodeId, (struct DSP_CBDATA *)pArgs,
-				      pAttrIn, &hNode);
+				      pAttrIn, &hNode, pr_ctxt);
 	}
 	cp_to_usr(args->ARGS_NODE_ALLOCATE.phNode, &hNode, status, 1);
 func_cont:
@@ -1292,7 +1292,7 @@ u32 NODEWRAP_Delete(union Trapped_Args *args, void *pr_ctxt)
 	u32 retVal;
 
 	GT_0trace(WCD_debugMask, GT_ENTER, "NODEWRAP_Delete: entered\n");
-	retVal = NODE_Delete(args->ARGS_NODE_DELETE.hNode);
+	retVal = NODE_Delete(args->ARGS_NODE_DELETE.hNode, pr_ctxt);
 
 	return retVal;
 }
@@ -1494,7 +1494,7 @@ u32 STRMWRAP_AllocateBuffer(union Trapped_Args *args, void *pr_ctxt)
 
 	status = STRM_AllocateBuffer(args->ARGS_STRM_ALLOCATEBUFFER.hStream,
 				     args->ARGS_STRM_ALLOCATEBUFFER.uSize,
-				     apBuffer, uNumBufs);
+				     apBuffer, uNumBufs, pr_ctxt);
 	cp_to_usr(args->ARGS_STRM_ALLOCATEBUFFER.apBuffer, apBuffer, status,
 		 uNumBufs);
 	if (apBuffer)
@@ -1508,11 +1508,7 @@ u32 STRMWRAP_AllocateBuffer(union Trapped_Args *args, void *pr_ctxt)
  */
 u32 STRMWRAP_Close(union Trapped_Args *args, void *pr_ctxt)
 {
-	u32 retVal;
-
-	retVal = STRM_Close(args->ARGS_STRM_CLOSE.hStream);
-
-	return retVal;
+	return STRM_Close(args->ARGS_STRM_CLOSE.hStream, pr_ctxt);
 }
 
 /*
@@ -1533,7 +1529,7 @@ u32 STRMWRAP_FreeBuffer(union Trapped_Args *args, void *pr_ctxt)
 
 	if (DSP_SUCCEEDED(status)) {
 		status = STRM_FreeBuffer(args->ARGS_STRM_FREEBUFFER.hStream,
-					 apBuffer, uNumBufs);
+					 apBuffer, uNumBufs, pr_ctxt);
 	}
 	cp_to_usr(args->ARGS_STRM_FREEBUFFER.apBuffer, apBuffer, status,
 		 uNumBufs);
@@ -1627,7 +1623,8 @@ u32 STRMWRAP_Open(union Trapped_Args *args, void *pr_ctxt)
 	}
 	status = STRM_Open(args->ARGS_STRM_OPEN.hNode,
 			  args->ARGS_STRM_OPEN.uDirection,
-			  args->ARGS_STRM_OPEN.uIndex, &attr, &pStrm);
+			  args->ARGS_STRM_OPEN.uIndex, &attr, &pStrm,
+			  pr_ctxt);
 	cp_to_usr(args->ARGS_STRM_OPEN.phStream, &pStrm, status, 1);
 	return status;
 }
diff --git a/drivers/dsp/bridge/rmgr/drv.c b/drivers/dsp/bridge/rmgr/drv.c
index 74388d5..a00598b 100644
--- a/drivers/dsp/bridge/rmgr/drv.c
+++ b/drivers/dsp/bridge/rmgr/drv.c
@@ -449,13 +449,15 @@ static DSP_STATUS DRV_ProcFreeNodeRes(HANDLE hPCtxt)
 					GT_1trace(curTrace, GT_5CLASS,
 						 "Calling Node_Delete for Node:"
 						 " 0x%x\n", pNodeRes->hNode);
-					status = NODE_Delete(pNodeRes->hNode);
+					status = NODE_Delete(pNodeRes->hNode,
+							pCtxt);
 					GT_1trace(curTrace, GT_5CLASS,
 					"the status after the NodeDelete %x\n",
 					status);
 				} else if ((nState == NODE_ALLOCATED)
 					|| (nState == NODE_CREATED))
-					status = NODE_Delete(pNodeRes->hNode);
+					status = NODE_Delete(pNodeRes->hNode,
+							pCtxt);
 			}
 		}
 	}
@@ -567,7 +569,7 @@ DSP_STATUS  DRV_ProcFreeDMMRes(HANDLE hPCtxt)
 		pDMMList = pDMMList->next;
 		if (pDMMRes->dmmAllocated) {
 			status = PROC_UnMap(pDMMRes->hProcessor,
-				 (void *)pDMMRes->ulDSPResAddr);
+				 (void *)pDMMRes->ulDSPResAddr, pCtxt);
 			status = PROC_UnReserveMemory(pDMMRes->hProcessor,
 				 (void *)pDMMRes->ulDSPResAddr);
 			pDMMRes->dmmAllocated = 0;
@@ -782,17 +784,18 @@ static DSP_STATUS  DRV_ProcFreeSTRMRes(HANDLE hPCtxt)
 			apBuffer = MEM_Alloc((pSTRMRes->uNumBufs *
 					    sizeof(u8 *)), MEM_NONPAGED);
 			status = STRM_FreeBuffer(pSTRMRes->hStream, apBuffer,
-						pSTRMRes->uNumBufs);
+						pSTRMRes->uNumBufs, pCtxt);
 			MEM_Free(apBuffer);
 		}
-		status = STRM_Close(pSTRMRes->hStream);
+		status = STRM_Close(pSTRMRes->hStream, pCtxt);
 		if (DSP_FAILED(status)) {
 			if (status == DSP_EPENDING) {
 				status = STRM_Reclaim(pSTRMRes->hStream,
 						     &pBufPtr, &ulBytes,
 						     (u32 *)&ulBufSize, &dwArg);
 				if (DSP_SUCCEEDED(status))
-					status = STRM_Close(pSTRMRes->hStream);
+					status = STRM_Close(pSTRMRes->hStream,
+							pCtxt);
 
 			}
 		}
diff --git a/drivers/dsp/bridge/rmgr/drv_interface.c b/drivers/dsp/bridge/rmgr/drv_interface.c
index a34d156..a8ddf7c 100644
--- a/drivers/dsp/bridge/rmgr/drv_interface.c
+++ b/drivers/dsp/bridge/rmgr/drv_interface.c
@@ -445,7 +445,7 @@ static int __devexit omap34xx_bridge_remove(struct platform_device *pdev)
 		GT_1trace(driverTrace, GT_5CLASS, "***Cleanup of "
 			 "process***%d\n", pCtxtclosed->pid);
 		DRV_RemoveAllResources(pCtxtclosed);
-		PROC_Detach(pCtxtclosed->hProcessor);
+		PROC_Detach(pCtxtclosed->hProcessor, pCtxtclosed);
 		pTmp = pCtxtclosed->next;
 		DRV_RemoveProcContext((struct DRV_OBJECT *)hDrvObject,
 				     pCtxtclosed, (void *)pCtxtclosed->pid);
@@ -593,7 +593,7 @@ static int bridge_release(struct inode *ip, struct file *filp)
 			flush_signals(current);
 			DRV_RemoveAllResources(pr_ctxt);
 			if (pr_ctxt->hProcessor)
-				PROC_Detach(pr_ctxt->hProcessor);
+				PROC_Detach(pr_ctxt->hProcessor, pr_ctxt);
 			DRV_RemoveProcContext((struct DRV_OBJECT *)hDrvObject,
 					pr_ctxt, (void *)pr_ctxt->pid);
 		} else {
diff --git a/drivers/dsp/bridge/rmgr/node.c b/drivers/dsp/bridge/rmgr/node.c
index 550a83d..d36dccc 100644
--- a/drivers/dsp/bridge/rmgr/node.c
+++ b/drivers/dsp/bridge/rmgr/node.c
@@ -320,7 +320,8 @@ static struct DSP_BUFFERATTR NODE_DFLTBUFATTRS = {
 	0, 			/* uAlignment */
 };
 
-static void DeleteNode(struct NODE_OBJECT *hNode);
+static void DeleteNode(struct NODE_OBJECT *hNode,
+		struct PROCESS_CONTEXT *pr_ctxt);
 static void DeleteNodeMgr(struct NODE_MGR *hNodeMgr);
 static void FillStreamConnect(struct NODE_OBJECT *hNode1,
 			     struct NODE_OBJECT *hNode2, u32 uStream1,
@@ -387,7 +388,8 @@ DSP_STATUS NODE_Allocate(struct PROC_OBJECT *hProcessor,
 			IN CONST struct DSP_UUID *pNodeId,
 			OPTIONAL IN CONST struct DSP_CBDATA *pArgs,
 			OPTIONAL IN CONST struct DSP_NODEATTRIN *pAttrIn,
-			OUT struct NODE_OBJECT **phNode)
+			OUT struct NODE_OBJECT **phNode,
+			struct PROCESS_CONTEXT *pr_ctxt)
 {
 	struct NODE_MGR *hNodeMgr;
 	struct DEV_OBJECT *hDevObject;
@@ -561,7 +563,7 @@ func_cont:
 	status = PROC_Map(hProcessor, (void *)pAttrIn->pGPPVirtAddr,
 			pNode->createArgs.asa.taskArgs.uHeapSize,
 			(void *)pNode->createArgs.asa.taskArgs.uDSPHeapResAddr,
-			(void **)&pMappedAddr, mapAttrs);
+			(void **)&pMappedAddr, mapAttrs, pr_ctxt);
 	if (DSP_FAILED(status)) {
 		GT_1trace(NODE_debugMask, GT_5CLASS,
 			 "NODE_Allocate: Failed to map memory"
@@ -774,7 +776,7 @@ func_cont2:
 	} else {
 		/* Cleanup */
 		if (pNode)
-			DeleteNode(pNode);
+			DeleteNode(pNode, pr_ctxt);
 
 	}
 
@@ -1621,7 +1623,8 @@ DSP_STATUS NODE_CreateMgr(OUT struct NODE_MGR **phNodeMgr,
  *      Loads the node's delete function if necessary. Free GPP side resources
  *      after node's delete function returns.
  */
-DSP_STATUS NODE_Delete(struct NODE_OBJECT *hNode)
+DSP_STATUS NODE_Delete(struct NODE_OBJECT *hNode,
+		struct PROCESS_CONTEXT *pr_ctxt)
 {
 	struct NODE_OBJECT *pNode = (struct NODE_OBJECT *)hNode;
 	struct NODE_MGR *hNodeMgr;
@@ -1783,7 +1786,7 @@ func_cont1:
 #endif
 func_cont:
 	GT_0trace(NODE_debugMask, GT_ENTER, "\nNODE_Delete13:\n ");
-	DeleteNode(hNode);
+	DeleteNode(hNode, pr_ctxt);
 #ifndef RES_CLEANUP_DISABLE
 	GT_0trace(NODE_debugMask, GT_5CLASS, "\nNODE_Delete2:\n ");
 	if (pCtxt != NULL)
@@ -2795,7 +2798,8 @@ func_end:
  *  Purpose:
  *      Free GPP resources allocated in NODE_Allocate() or NODE_Connect().
  */
-static void DeleteNode(struct NODE_OBJECT *hNode)
+static void DeleteNode(struct NODE_OBJECT *hNode,
+		struct PROCESS_CONTEXT *pr_ctxt)
 {
 	struct NODE_MGR *hNodeMgr;
 	struct CMM_XLATOROBJECT *hXlator;
@@ -2875,7 +2879,8 @@ static void DeleteNode(struct NODE_OBJECT *hNode)
 		}
 		if (taskArgs.uDSPHeapResAddr) {
 			status = PROC_UnMap(hNode->hProcessor,
-					   (void *)taskArgs.uDSPHeapAddr);
+					   (void *)taskArgs.uDSPHeapAddr,
+					   pr_ctxt);
 			if (DSP_SUCCEEDED(status)) {
 				GT_0trace(NODE_debugMask, GT_5CLASS,
 					 "DSPProcessor_UnMap succeeded.\n");
@@ -2976,7 +2981,7 @@ static void DeleteNodeMgr(struct NODE_MGR *hNodeMgr)
 			while ((hNode =
 				(struct NODE_OBJECT *)LST_GetHead(hNodeMgr->
 				nodeList)))
-					DeleteNode(hNode);
+					DeleteNode(hNode, NULL);
 
 			DBC_Assert(LST_IsEmpty(hNodeMgr->nodeList));
 			LST_Delete(hNodeMgr->nodeList);
diff --git a/drivers/dsp/bridge/rmgr/proc.c b/drivers/dsp/bridge/rmgr/proc.c
index f4f756c..270d022 100644
--- a/drivers/dsp/bridge/rmgr/proc.c
+++ b/drivers/dsp/bridge/rmgr/proc.c
@@ -220,7 +220,8 @@ DSP_STATUS PROC_CleanupAllResources(void)
 				 "***Cleanup of "
 				 "process***%d\n", pCtxtclosed->pid);
 			if (pCtxtclosed->hProcessor)
-				PROC_Detach(pCtxtclosed->hProcessor);
+				PROC_Detach(pCtxtclosed->hProcessor,
+						pCtxtclosed);
 		}
 		pCtxtclosed = pCtxtclosed->next;
 	}
@@ -237,7 +238,7 @@ func_end:
  */
 DSP_STATUS
 PROC_Attach(u32 uProcessor, OPTIONAL CONST struct DSP_PROCESSORATTRIN *pAttrIn,
-       OUT DSP_HPROCESSOR *phProcessor)
+       OUT DSP_HPROCESSOR *phProcessor, struct PROCESS_CONTEXT *pr_ctxt)
 {
 	DSP_STATUS status = DSP_SOK;
 	struct DEV_OBJECT *hDevObject;
@@ -635,7 +636,8 @@ DSP_STATUS PROC_Ctrl(DSP_HPROCESSOR hProcessor, u32 dwCmd,
  *      Destroys the  Processor Object. Removes the notification from the Dev
  *      List.
  */
-DSP_STATUS PROC_Detach(DSP_HPROCESSOR hProcessor)
+DSP_STATUS PROC_Detach(DSP_HPROCESSOR hProcessor,
+		struct PROCESS_CONTEXT *pr_ctxt)
 {
 	DSP_STATUS status = DSP_SOK;
 	struct PROC_OBJECT *pProcObject = (struct PROC_OBJECT *)hProcessor;
@@ -1416,7 +1418,8 @@ func_end:
  *      Maps a MPU buffer to DSP address space.
  */
 DSP_STATUS PROC_Map(DSP_HPROCESSOR hProcessor, void *pMpuAddr, u32 ulSize,
-		   void *pReqAddr, void **ppMapAddr, u32 ulMapAttr)
+		   void *pReqAddr, void **ppMapAddr, u32 ulMapAttr,
+		   struct PROCESS_CONTEXT *pr_ctxt)
 {
 	u32 vaAlign;
 	u32 paAlign;
@@ -1809,7 +1812,8 @@ func_end:
  *  Purpose:
  *      Removes a MPU buffer mapping from the DSP address space.
  */
-DSP_STATUS PROC_UnMap(DSP_HPROCESSOR hProcessor, void *pMapAddr)
+DSP_STATUS PROC_UnMap(DSP_HPROCESSOR hProcessor, void *pMapAddr,
+		struct PROCESS_CONTEXT *pr_ctxt)
 {
 	DSP_STATUS status = DSP_SOK;
 	struct PROC_OBJECT *pProcObject = (struct PROC_OBJECT *)hProcessor;
diff --git a/drivers/dsp/bridge/rmgr/strm.c b/drivers/dsp/bridge/rmgr/strm.c
index a9a1500..d0bbf6a 100644
--- a/drivers/dsp/bridge/rmgr/strm.c
+++ b/drivers/dsp/bridge/rmgr/strm.c
@@ -153,7 +153,8 @@ static void DeleteStrmMgr(struct STRM_MGR *hStrmMgr);
  *      Allocates buffers for a stream.
  */
 DSP_STATUS STRM_AllocateBuffer(struct STRM_OBJECT *hStrm, u32 uSize,
-				OUT u8 **apBuffer, u32 uNumBufs)
+				OUT u8 **apBuffer, u32 uNumBufs,
+				struct PROCESS_CONTEXT *pr_ctxt)
 {
 	DSP_STATUS status = DSP_SOK;
 	u32 uAllocated = 0;
@@ -196,7 +197,7 @@ DSP_STATUS STRM_AllocateBuffer(struct STRM_OBJECT *hStrm, u32 uSize,
 		}
 	}
 	if (DSP_FAILED(status))
-		STRM_FreeBuffer(hStrm, apBuffer, uAllocated);
+		STRM_FreeBuffer(hStrm, apBuffer, uAllocated, pr_ctxt);
 
 #ifndef RES_CLEANUP_DISABLE
 	if (DSP_FAILED(status))
@@ -227,7 +228,8 @@ func_end:
  *  Purpose:
  *      Close a stream opened with STRM_Open().
  */
-DSP_STATUS STRM_Close(struct STRM_OBJECT *hStrm)
+DSP_STATUS STRM_Close(struct STRM_OBJECT *hStrm,
+		struct PROCESS_CONTEXT *pr_ctxt)
 {
 	struct WMD_DRV_INTERFACE *pIntfFxns;
 	struct CHNL_INFO chnlInfo;
@@ -393,7 +395,7 @@ void STRM_Exit(void)
  *      Frees the buffers allocated for a stream.
  */
 DSP_STATUS STRM_FreeBuffer(struct STRM_OBJECT *hStrm, u8 **apBuffer,
-			  u32 uNumBufs)
+		u32 uNumBufs, struct PROCESS_CONTEXT *pr_ctxt)
 {
 	DSP_STATUS status = DSP_SOK;
 	u32 i = 0;
@@ -625,7 +627,9 @@ DSP_STATUS STRM_Issue(struct STRM_OBJECT *hStrm, IN u8 *pBuf, u32 ulBytes,
  *      XDAIS socket node on the DSP.
  */
 DSP_STATUS STRM_Open(struct NODE_OBJECT *hNode, u32 uDir, u32 uIndex,
-		    IN struct STRM_ATTR *pAttr, OUT struct STRM_OBJECT **phStrm)
+		IN struct STRM_ATTR *pAttr,
+		OUT struct STRM_OBJECT **phStrm,
+		struct PROCESS_CONTEXT *pr_ctxt)
 {
 	struct STRM_MGR *hStrmMgr;
 	struct WMD_DRV_INTERFACE *pIntfFxns;
-- 
1.6.2.4

