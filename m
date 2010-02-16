From: Ameya Palande <ameya.palande@nokia.com>
Subject: [PATCH 2/2] DSPBRIDGE: New reserved memory accounting framework
Date: Tue, 16 Feb 2010 15:20:09 +0200
Message-ID: <21ed5f939111b381f877fd335b3adc2e779ce8ac.1266326009.git.ameya.palande@nokia.com>
References: <cover.1266326009.git.ameya.palande@nokia.com>
 <f966f5c490999696e567486ded3b08c4c01f366f.1266326009.git.ameya.palande@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:26592 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756174Ab0BPNVM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Feb 2010 08:21:12 -0500
In-Reply-To: <f966f5c490999696e567486ded3b08c4c01f366f.1266326009.git.ameya.palande@nokia.com>
In-Reply-To: <cover.1266326009.git.ameya.palande@nokia.com>
References: <cover.1266326009.git.ameya.palande@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: felipe.contreras@nokia.com, nm@ti.com, deepak.chitriki@ti.com, omar.ramirez@ti.com, x0095840@ti.com

DSP_RSV_OBJECT is introduced to track reserved memory accounting information.
This will allow us to do proper cleanup for memory reserved using
PROC_ReserveMemory().

Signed-off-by: Ameya Palande <ameya.palande@nokia.com>
---
 arch/arm/plat-omap/include/dspbridge/drv.h  |   13 ++++++
 arch/arm/plat-omap/include/dspbridge/proc.h |    5 +-
 drivers/dsp/bridge/pmgr/dmm.c               |    3 +-
 drivers/dsp/bridge/pmgr/wcd.c               |    7 ++-
 drivers/dsp/bridge/rmgr/drv.c               |   27 +++++++++---
 drivers/dsp/bridge/rmgr/drv_interface.c     |    7 ++-
 drivers/dsp/bridge/rmgr/node.c              |    5 +-
 drivers/dsp/bridge/rmgr/proc.c              |   58 +++++++++++++++++++++-----
 8 files changed, 97 insertions(+), 28 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/drv.h b/arch/arm/plat-omap/include/dspbridge/drv.h
index 3069e74..6e8187d 100644
--- a/arch/arm/plat-omap/include/dspbridge/drv.h
+++ b/arch/arm/plat-omap/include/dspbridge/drv.h
@@ -101,6 +101,15 @@ struct DMM_MAP_OBJECT {
 	struct DMM_MAP_OBJECT  *next;
 } ;
 
+/*
+ * New structure (member of process context) used for accounting of DMM
+ * reserved memory information
+ */
+struct DMM_RSV_OBJECT {
+	struct	list_head	link;
+	u32	dsp_reserved_addr;
+};
+
 /* New structure (member of process context) abstracts DMM resource info */
 struct DSPHEAP_RES_OBJECT {
 	s32            heapAllocated; /* DMM status */
@@ -141,6 +150,10 @@ struct PROCESS_CONTEXT{
 	/* DMM mapped memory resources */
 	struct DMM_MAP_OBJECT *dmm_map_list;
 
+	/* DMM reserved memory resources */
+	struct list_head dmm_rsv_list;
+	spinlock_t dmm_rsv_list_lock;
+
 	/* DSP Heap resources */
 	struct DSPHEAP_RES_OBJECT *pDSPHEAPList;
 
diff --git a/arch/arm/plat-omap/include/dspbridge/proc.h b/arch/arm/plat-omap/include/dspbridge/proc.h
index 8dbdaac..558c053 100644
--- a/arch/arm/plat-omap/include/dspbridge/proc.h
+++ b/arch/arm/plat-omap/include/dspbridge/proc.h
@@ -560,7 +560,7 @@
  *  Details:
  */
 	extern DSP_STATUS PROC_ReserveMemory(DSP_HPROCESSOR hProcessor,
-					     u32 ulSize, void **ppRsvAddr);
+		u32 ulSize, void **ppRsvAddr, struct PROCESS_CONTEXT *pr_ctxt);
 
 /*
  *  ======== PROC_UnMap ========
@@ -604,6 +604,7 @@
  *  Details:
  */
 	extern DSP_STATUS PROC_UnReserveMemory(DSP_HPROCESSOR hProcessor,
-					       void *pRsvAddr);
+			void *pRsvAddr, struct PROCESS_CONTEXT *pr_ctxt,
+			int cleanup);
 
 #endif				/* PROC_ */
diff --git a/drivers/dsp/bridge/pmgr/dmm.c b/drivers/dsp/bridge/pmgr/dmm.c
index d5a7275..72aee60 100644
--- a/drivers/dsp/bridge/pmgr/dmm.c
+++ b/drivers/dsp/bridge/pmgr/dmm.c
@@ -386,9 +386,10 @@ DSP_STATUS DMM_ReserveMemory(struct DMM_OBJECT *hDmmMgr, u32 size,
 		node->MappedSize = 0;
 		/* Return the chunk's starting address */
 		*pRsvAddr = rsvAddr;
-	} else
+	} else {
 		/*dSP chunk of given size is not available */
 		status = DSP_EMEMORY;
+	}
 
 	SYNC_LeaveCS(pDmmObj->hDmmLock);
 	GT_3trace(DMM_debugMask, GT_4CLASS,
diff --git a/drivers/dsp/bridge/pmgr/wcd.c b/drivers/dsp/bridge/pmgr/wcd.c
index beea23b..747d069 100644
--- a/drivers/dsp/bridge/pmgr/wcd.c
+++ b/drivers/dsp/bridge/pmgr/wcd.c
@@ -1054,12 +1054,13 @@ u32 PROCWRAP_ReserveMemory(union Trapped_Args *args, void *pr_ctxt)
 
 	GT_0trace(WCD_debugMask, GT_ENTER, "PROCWRAP_ReserveMemory: entered\n");
 	status = PROC_ReserveMemory(args->ARGS_PROC_RSVMEM.hProcessor,
-				   args->ARGS_PROC_RSVMEM.ulSize, &pRsvAddr);
+				   args->ARGS_PROC_RSVMEM.ulSize, &pRsvAddr,
+				   pr_ctxt);
 	if (DSP_SUCCEEDED(status)) {
 		if (put_user(pRsvAddr, args->ARGS_PROC_RSVMEM.ppRsvAddr)) {
 			status = DSP_EINVALIDARG;
 			PROC_UnReserveMemory(args->ARGS_PROC_RSVMEM.hProcessor,
-				pRsvAddr);
+				pRsvAddr, pr_ctxt, 1);
 		}
 	}
 	return status;
@@ -1100,7 +1101,7 @@ u32 PROCWRAP_UnReserveMemory(union Trapped_Args *args, void *pr_ctxt)
 	GT_0trace(WCD_debugMask, GT_ENTER,
 		 "PROCWRAP_UnReserveMemory: entered\n");
 	status = PROC_UnReserveMemory(args->ARGS_PROC_UNRSVMEM.hProcessor,
-				     args->ARGS_PROC_UNRSVMEM.pRsvAddr);
+			args->ARGS_PROC_UNRSVMEM.pRsvAddr, pr_ctxt, 1);
 	return status;
 }
 
diff --git a/drivers/dsp/bridge/rmgr/drv.c b/drivers/dsp/bridge/rmgr/drv.c
index 3dc38d0..9d5c077 100644
--- a/drivers/dsp/bridge/rmgr/drv.c
+++ b/drivers/dsp/bridge/rmgr/drv.c
@@ -277,25 +277,20 @@ DSP_STATUS  DRV_ProcFreeDMMRes(HANDLE hPCtxt)
 			if (DSP_FAILED(status))
 				pr_debug("%s: PROC_UnMap failed! status ="
 						" 0x%xn", __func__, status);
-			status = PROC_UnReserveMemory(pDMMRes->hProcessor,
-				 (void *)pDMMRes->ulDSPResAddr);
-			if (DSP_FAILED(status))
-				pr_debug("%s: PROC_UnReserveMemory failed!"
-					" status = 0x%xn", __func__, status);
 			pDMMRes->dmmAllocated = 0;
 		}
 	}
 	return status;
 }
 
-/* Release all DMM resources and its context
-* This is called from .bridge_release. */
+/* Release all Mapped and Reserved DMM resources */
 DSP_STATUS DRV_RemoveAllDMMResElements(HANDLE hPCtxt)
 {
 	struct PROCESS_CONTEXT *pCtxt = (struct PROCESS_CONTEXT *)hPCtxt;
 	DSP_STATUS status = DSP_SOK;
 	struct DMM_MAP_OBJECT *pTempDMMRes2 = NULL;
 	struct DMM_MAP_OBJECT *pTempDMMRes = NULL;
+	struct DMM_RSV_OBJECT *temp, *rsv_obj;
 
 	DRV_ProcFreeDMMRes(pCtxt);
 	pTempDMMRes = pCtxt->dmm_map_list;
@@ -305,6 +300,24 @@ DSP_STATUS DRV_RemoveAllDMMResElements(HANDLE hPCtxt)
 		kfree(pTempDMMRes2);
 	}
 	pCtxt->dmm_map_list = NULL;
+
+	/* Free DMM reserved memory resources */
+	spin_lock(&pCtxt->dmm_rsv_list_lock);
+	list_for_each_entry_safe(rsv_obj, temp, &pCtxt->dmm_rsv_list, link) {
+		/*
+		 * Since we have already acquired spin lock for dmm_rsv_list,
+		 * we don't want to perform cleanup in PROC_UnReserveMemory.
+		 */
+		status = PROC_UnReserveMemory(pCtxt->hProcessor,
+				(void *)rsv_obj->dsp_reserved_addr, pCtxt, 0);
+		if (DSP_FAILED(status))
+			pr_err("%s: PROC_UnReserveMemory failed!"
+					" status = 0x%xn", __func__, status);
+		list_del(&rsv_obj->link);
+		kfree(rsv_obj);
+	}
+	spin_unlock(&pCtxt->dmm_rsv_list_lock);
+
 	return status;
 }
 
diff --git a/drivers/dsp/bridge/rmgr/drv_interface.c b/drivers/dsp/bridge/rmgr/drv_interface.c
index 0ce9a5f..ef078cf 100644
--- a/drivers/dsp/bridge/rmgr/drv_interface.c
+++ b/drivers/dsp/bridge/rmgr/drv_interface.c
@@ -497,10 +497,13 @@ static int bridge_open(struct inode *ip, struct file *filp)
 	 * process context list.
 	 */
 	pr_ctxt = MEM_Calloc(sizeof(struct PROCESS_CONTEXT), MEM_PAGED);
-	if (pr_ctxt)
+	if (pr_ctxt) {
 		pr_ctxt->resState = PROC_RES_ALLOCATED;
-	else
+		spin_lock_init(&pr_ctxt->dmm_rsv_list_lock);
+		INIT_LIST_HEAD(&pr_ctxt->dmm_rsv_list);
+	} else {
 		status = -ENOMEM;
+	}
 
 	filp->private_data = pr_ctxt;
 
diff --git a/drivers/dsp/bridge/rmgr/node.c b/drivers/dsp/bridge/rmgr/node.c
index b60d1ed..f85b4b8 100644
--- a/drivers/dsp/bridge/rmgr/node.c
+++ b/drivers/dsp/bridge/rmgr/node.c
@@ -454,7 +454,7 @@ DSP_STATUS NODE_Allocate(struct PROC_OBJECT *hProcessor,
 	status = PROC_ReserveMemory(hProcessor,
 			pNode->createArgs.asa.taskArgs.uHeapSize + PAGE_SIZE,
 			(void **)&(pNode->createArgs.asa.taskArgs.
-				uDSPHeapResAddr));
+				uDSPHeapResAddr), pr_ctxt);
 	if (DSP_FAILED(status)) {
 		GT_1trace(NODE_debugMask, GT_5CLASS,
 			 "NODE_Allocate:Failed to reserve "
@@ -2726,7 +2726,8 @@ static void DeleteNode(struct NODE_OBJECT *hNode,
 					 " Status = 0x%x\n", (u32)status);
 			}
 			status = PROC_UnReserveMemory(hNode->hProcessor,
-					(void *)taskArgs.uDSPHeapResAddr);
+					(void *)taskArgs.uDSPHeapResAddr,
+					pr_ctxt, 1);
 			if (DSP_SUCCEEDED(status)) {
 				GT_0trace(NODE_debugMask, GT_5CLASS,
 					 "DSPProcessor_UnReserveMemory "
diff --git a/drivers/dsp/bridge/rmgr/proc.c b/drivers/dsp/bridge/rmgr/proc.c
index 2ccbc9b..2ef2e37 100644
--- a/drivers/dsp/bridge/rmgr/proc.c
+++ b/drivers/dsp/bridge/rmgr/proc.c
@@ -1430,11 +1430,12 @@ func_end:
  *      Reserve a virtually contiguous region of DSP address space.
  */
 DSP_STATUS PROC_ReserveMemory(DSP_HPROCESSOR hProcessor, u32 ulSize,
-			     void **ppRsvAddr)
+		void **ppRsvAddr, struct PROCESS_CONTEXT *pr_ctxt)
 {
 	struct DMM_OBJECT *hDmmMgr;
 	DSP_STATUS status = DSP_SOK;
 	struct PROC_OBJECT *pProcObject = (struct PROC_OBJECT *)hProcessor;
+	struct DMM_RSV_OBJECT *rsv_obj;
 
 	GT_3trace(PROC_DebugMask, GT_ENTER,
 		 "Entered PROC_ReserveMemory, args:\n\t"
@@ -1446,16 +1447,29 @@ DSP_STATUS PROC_ReserveMemory(DSP_HPROCESSOR hProcessor, u32 ulSize,
 			 "InValid Processor Handle \n");
 		goto func_end;
 	}
+
 	status = DMM_GetHandle(pProcObject, &hDmmMgr);
 	if (DSP_FAILED(status)) {
 		GT_1trace(PROC_DebugMask, GT_7CLASS, "PROC_ReserveMemory: "
 			 "Failed to get DMM Mgr handle: 0x%x\n", status);
-	} else
-		status = DMM_ReserveMemory(hDmmMgr, ulSize, (u32 *)ppRsvAddr);
+		goto func_end;
+	}
+
+	status = DMM_ReserveMemory(hDmmMgr, ulSize, (u32 *)ppRsvAddr);
+	if (status != DSP_SOK)
+		goto func_end;
+
+	rsv_obj = kmalloc(sizeof(struct DMM_RSV_OBJECT), GFP_KERNEL);
+	if (rsv_obj) {
+		rsv_obj->dsp_reserved_addr = (u32) *ppRsvAddr;
+		spin_lock(&pr_ctxt->dmm_rsv_list_lock);
+		list_add(&rsv_obj->link, &pr_ctxt->dmm_rsv_list);
+		spin_unlock(&pr_ctxt->dmm_rsv_list_lock);
+	}
 
+func_end:
 	GT_1trace(PROC_DebugMask, GT_ENTER, "Leaving PROC_ReserveMemory [0x%x]",
 		 status);
-func_end:
 	return status;
 }
 
@@ -1704,11 +1718,13 @@ func_end:
  *  Purpose:
  *      Frees a previously reserved region of DSP address space.
  */
-DSP_STATUS PROC_UnReserveMemory(DSP_HPROCESSOR hProcessor, void *pRsvAddr)
+DSP_STATUS PROC_UnReserveMemory(DSP_HPROCESSOR hProcessor, void *pRsvAddr,
+		struct PROCESS_CONTEXT *pr_ctxt, int cleanup)
 {
 	struct DMM_OBJECT *hDmmMgr;
 	DSP_STATUS status = DSP_SOK;
 	struct PROC_OBJECT *pProcObject = (struct PROC_OBJECT *)hProcessor;
+	struct DMM_RSV_OBJECT *temp, *rsv_obj;
 
 	GT_2trace(PROC_DebugMask, GT_ENTER,
 		 "Entered PROC_UnReserveMemory, args:\n\t"
@@ -1719,18 +1735,38 @@ DSP_STATUS PROC_UnReserveMemory(DSP_HPROCESSOR hProcessor, void *pRsvAddr)
 			 "InValid Processor Handle \n");
 		goto func_end;
 	}
+
 	status = DMM_GetHandle(pProcObject, &hDmmMgr);
-	if (DSP_FAILED(status))
+	if (DSP_FAILED(status)) {
 		GT_1trace(PROC_DebugMask, GT_7CLASS,
 			 "PROC_UnReserveMemory: Failed to get DMM Mgr "
 			 "handle: 0x%x\n", status);
-	else
-		status = DMM_UnReserveMemory(hDmmMgr, (u32) pRsvAddr);
+		goto func_end;
+	}
+
+	status = DMM_UnReserveMemory(hDmmMgr, (u32) pRsvAddr);
+
+	/*
+	 * cleanup flag handles the special case when this function
+	 * is called while doing clenaup from
+	 * DRV_RemoveAllDMMResElements
+	 */
+	if (status != DSP_SOK || !cleanup)
+		goto func_end;
+
+	spin_lock(&pr_ctxt->dmm_rsv_list_lock);
+	list_for_each_entry_safe(rsv_obj, temp, &pr_ctxt->dmm_rsv_list, link) {
+		if (rsv_obj->dsp_reserved_addr == (u32)pRsvAddr) {
+			list_del(&rsv_obj->link);
+			kfree(rsv_obj);
+			break;
+		}
+	}
+	spin_unlock(&pr_ctxt->dmm_rsv_list_lock);
 
-	GT_1trace(PROC_DebugMask, GT_ENTER,
-		 "Leaving PROC_UnReserveMemory [0x%x]",
-		 status);
 func_end:
+	GT_1trace(PROC_DebugMask, GT_ENTER,
+		 "Leaving PROC_UnReserveMemory [0x%x]", status);
 	return status;
 }
 
-- 
1.6.3.3

