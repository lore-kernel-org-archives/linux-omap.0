From: Ameya Palande <ameya.palande@nokia.com>
Subject: [PATCH 4/4] DSPBRIDGE: Improved mapped memory cleanup
Date: Thu, 18 Feb 2010 16:40:53 +0200
Message-ID: <d4615a96b803472a13d249bcf7faf3ce5d315346.1266503387.git.ameya.palande@nokia.com>
References: <cover.1266503387.git.ameya.palande@nokia.com>
 <a04c367d97579eefc30bc1d2c4dd98a53bc468ac.1266503387.git.ameya.palande@nokia.com>
 <0fd274366a6ad4fda3d20103f52a314bb6ebef57.1266503387.git.ameya.palande@nokia.com>
 <9fb63d8737768758ac367ff242c4142f38ce7427.1266503387.git.ameya.palande@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:36539 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757628Ab0BROly (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Feb 2010 09:41:54 -0500
In-Reply-To: <9fb63d8737768758ac367ff242c4142f38ce7427.1266503387.git.ameya.palande@nokia.com>
In-Reply-To: <cover.1266503387.git.ameya.palande@nokia.com>
References: <cover.1266503387.git.ameya.palande@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: felipe.contreras@nokia.com, nm@ti.com, deepak.chitriki@ti.com, x0095840@ti.com, omar.ramirez@ti.com

This patch improves current mapped memory cleanup mechanism by using linux
native list implementation. As a side effect we also get following benefits:

1. Unnecessary data members in DMM_MAP_OBJECT are removed which results in
   memory saving.

2. Following functions are removed as they are not needed anymore:
   DRV_ProcFreeDMMRes()
   DRV_UpdateDMMResElement()
   DRV_InsertDMMResElement()
   DRV_GetDMMResElement()
   DRV_RemoveDMMResElement()

Signed-off-by: Ameya Palande <ameya.palande@nokia.com>
---
 arch/arm/plat-omap/include/dspbridge/drv.h         |   30 +---
 .../plat-omap/include/dspbridge/resourcecleanup.h  |   11 --
 drivers/dsp/bridge/rmgr/drv.c                      |  161 ++------------------
 drivers/dsp/bridge/rmgr/drv_interface.c            |    3 +-
 drivers/dsp/bridge/rmgr/proc.c                     |   43 ++++--
 5 files changed, 54 insertions(+), 194 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/drv.h b/arch/arm/plat-omap/include/dspbridge/drv.h
index f7d0e3e..854923a 100644
--- a/arch/arm/plat-omap/include/dspbridge/drv.h
+++ b/arch/arm/plat-omap/include/dspbridge/drv.h
@@ -90,16 +90,11 @@ struct NODE_RES_OBJECT {
 	struct NODE_RES_OBJECT         *next;
 } ;
 
-/* Abstracts DMM resource info */
+/* Used for DMM mapped memory accounting */
 struct DMM_MAP_OBJECT {
-	s32            dmmAllocated; /* DMM status */
-	u32           ulMpuAddr;
-	u32           ulDSPAddr;
-	u32           ulDSPResAddr;
-	u32           size;
-	HANDLE          hProcessor;
-	struct DMM_MAP_OBJECT  *next;
-} ;
+	struct	list_head	link;
+	u32	dsp_addr;
+};
 
 /* Used for DMM reserved memory accounting */
 struct DMM_RSV_OBJECT {
@@ -146,8 +141,8 @@ struct PROCESS_CONTEXT{
 	struct mutex node_mutex;
 
 	/* DMM mapped memory resources */
-	struct DMM_MAP_OBJECT *dmm_map_list;
-	struct mutex dmm_map_mutex;
+	struct list_head dmm_map_list;
+	spinlock_t dmm_map_lock;
 
 	/* DMM reserved memory resources */
 	struct list_head dmm_rsv_list;
@@ -398,17 +393,4 @@ struct PROCESS_CONTEXT{
 	extern DSP_STATUS DRV_ReleaseResources(IN u32 dwContext,
 					       struct DRV_OBJECT *hDrvObject);
 
-/*
- *  ======== DRV_ProcFreeDMMRes ========
- *  Purpose:
- *       Actual DMM De-Allocation.
- *  Parameters:
- *      hPCtxt:      Path to the driver Registry Key.
- *  Returns:
- *      DSP_SOK if success;
- */
-
-
-	extern DSP_STATUS  DRV_ProcFreeDMMRes(HANDLE hPCtxt);
-
 #endif				/* DRV_ */
diff --git a/arch/arm/plat-omap/include/dspbridge/resourcecleanup.h b/arch/arm/plat-omap/include/dspbridge/resourcecleanup.h
index ffbcf5e..2bb756a 100644
--- a/arch/arm/plat-omap/include/dspbridge/resourcecleanup.h
+++ b/arch/arm/plat-omap/include/dspbridge/resourcecleanup.h
@@ -48,17 +48,6 @@ extern DSP_STATUS DRV_RemoveNodeResElement(HANDLE nodeRes, HANDLE status);
 
 extern void DRV_ProcNodeUpdateStatus(HANDLE hNodeRes, s32 status);
 
-extern DSP_STATUS DRV_UpdateDMMResElement(HANDLE dmmRes, u32 pMpuAddr,
-					  u32 ulSize, u32 pReqAddr,
-					  u32 ppMapAddr, HANDLE hProcesso);
-
-extern DSP_STATUS DRV_InsertDMMResElement(HANDLE dmmRes, HANDLE pCtxt);
-
-extern DSP_STATUS DRV_GetDMMResElement(u32 pMapAddr, HANDLE dmmRes,
-				       HANDLE pCtxt);
-
-extern DSP_STATUS DRV_RemoveDMMResElement(HANDLE dmmRes, HANDLE pCtxt);
-
 extern DSP_STATUS DRV_ProcUpdateSTRMRes(u32 uNumBufs, HANDLE STRMRes);
 
 extern DSP_STATUS DRV_ProcInsertSTRMResElement(HANDLE hStrm, HANDLE STRMRes,
diff --git a/drivers/dsp/bridge/rmgr/drv.c b/drivers/dsp/bridge/rmgr/drv.c
index b88b5a3..bb6c246 100644
--- a/drivers/dsp/bridge/rmgr/drv.c
+++ b/drivers/dsp/bridge/rmgr/drv.c
@@ -193,129 +193,27 @@ static DSP_STATUS DRV_ProcFreeNodeRes(HANDLE hPCtxt)
 	return status;
 }
 
-/* Allocate the DMM resource element
-* This is called from Proc_Map. after the actual resource is allocated */
-DSP_STATUS DRV_InsertDMMResElement(HANDLE hDMMRes, HANDLE hPCtxt)
-{
-	struct PROCESS_CONTEXT *pCtxt = (struct PROCESS_CONTEXT *)hPCtxt;
-	struct DMM_MAP_OBJECT **pDMMRes = (struct DMM_MAP_OBJECT **)hDMMRes;
-	DSP_STATUS	status = DSP_SOK;
-	struct DMM_MAP_OBJECT *pTempDMMRes = NULL;
-
-	*pDMMRes = (struct DMM_MAP_OBJECT *)
-		    MEM_Calloc(1 * sizeof(struct DMM_MAP_OBJECT), MEM_PAGED);
-	GT_0trace(curTrace, GT_ENTER, "DRV_InsertDMMResElement: 1");
-	if (*pDMMRes == NULL) {
-		GT_0trace(curTrace, GT_5CLASS, "DRV_InsertDMMResElement: 2");
-		status = DSP_EHANDLE;
-	}
-	if (DSP_SUCCEEDED(status)) {
-		if (mutex_lock_interruptible(&pCtxt->dmm_map_mutex)) {
-			kfree(*pDMMRes);
-			return DSP_EFAIL;
-		}
-
-		if (pCtxt->dmm_map_list) {
-			GT_0trace(curTrace, GT_5CLASS,
-				 "DRV_InsertDMMResElement: 3");
-			pTempDMMRes = pCtxt->dmm_map_list;
-			while (pTempDMMRes->next)
-				pTempDMMRes = pTempDMMRes->next;
-
-			pTempDMMRes->next = *pDMMRes;
-		} else {
-			pCtxt->dmm_map_list = *pDMMRes;
-			GT_0trace(curTrace, GT_5CLASS,
-				 "DRV_InsertDMMResElement: 4");
-		}
-		mutex_unlock(&pCtxt->dmm_map_mutex);
-	}
-	GT_0trace(curTrace, GT_ENTER, "DRV_InsertDMMResElement: 5");
-	return status;
-}
-
-/* Release DMM resource element context
-* This is called from Proc_UnMap. after the actual resource is freed */
-DSP_STATUS DRV_RemoveDMMResElement(HANDLE hDMMRes, HANDLE hPCtxt)
-{
-	struct PROCESS_CONTEXT *pCtxt = (struct PROCESS_CONTEXT *)hPCtxt;
-	struct DMM_MAP_OBJECT *pDMMRes = (struct DMM_MAP_OBJECT *)hDMMRes;
-	struct DMM_MAP_OBJECT *pTempDMMRes = NULL;
-	DSP_STATUS status = DSP_SOK;
-
-	if (mutex_lock_interruptible(&pCtxt->dmm_map_mutex))
-		return DSP_EFAIL;
-	pTempDMMRes = pCtxt->dmm_map_list;
-	if (pCtxt->dmm_map_list == pDMMRes) {
-		pCtxt->dmm_map_list = pDMMRes->next;
-	} else {
-		while (pTempDMMRes && pTempDMMRes->next != pDMMRes)
-			pTempDMMRes = pTempDMMRes->next;
-		if (!pTempDMMRes)
-			status = DSP_ENOTFOUND;
-		else
-			pTempDMMRes->next = pDMMRes->next;
-	}
-	mutex_unlock(&pCtxt->dmm_map_mutex);
-	kfree(pDMMRes);
-	return status;
-}
-
-/* Update DMM resource status */
-DSP_STATUS DRV_UpdateDMMResElement(HANDLE hDMMRes, u32 pMpuAddr, u32 ulSize,
-				  u32 pReqAddr, u32 pMapAddr,
-				  HANDLE hProcessor)
-{
-	struct DMM_MAP_OBJECT *pDMMRes = (struct DMM_MAP_OBJECT *)hDMMRes;
-	DSP_STATUS status = DSP_SOK;
-
-	DBC_Assert(hDMMRes != NULL);
-	pDMMRes->ulMpuAddr = pMpuAddr;
-	pDMMRes->ulDSPAddr = pMapAddr;
-	pDMMRes->ulDSPResAddr = pReqAddr;
-	pDMMRes->size = ulSize;
-	pDMMRes->hProcessor = hProcessor;
-	pDMMRes->dmmAllocated = 1;
-
-	return status;
-}
-
-/* Actual DMM De-Allocation */
-DSP_STATUS  DRV_ProcFreeDMMRes(HANDLE hPCtxt)
-{
-	struct PROCESS_CONTEXT *pCtxt = (struct PROCESS_CONTEXT *)hPCtxt;
-	DSP_STATUS status = DSP_SOK;
-	struct DMM_MAP_OBJECT *pDMMList = pCtxt->dmm_map_list;
-	struct DMM_MAP_OBJECT *pDMMRes = NULL;
-
-	GT_0trace(curTrace, GT_ENTER, "\nDRV_ProcFreeDMMRes: 1\n");
-	while (pDMMList) {
-		pDMMRes = pDMMList;
-		pDMMList = pDMMList->next;
-		if (pDMMRes->dmmAllocated) {
-			/* PROC_UnMap will free pDMMRes pointer */
-			status = PROC_UnMap(pDMMRes->hProcessor,
-				 (void *)pDMMRes->ulDSPAddr, pCtxt);
-			if (DSP_FAILED(status))
-				pr_debug("%s: PROC_UnMap failed! status ="
-						" 0x%xn", __func__, status);
-		}
-	}
-	return status;
-}
-
 /* Release all Mapped and Reserved DMM resources */
 DSP_STATUS DRV_RemoveAllDMMResElements(HANDLE hPCtxt)
 {
 	struct PROCESS_CONTEXT *pCtxt = (struct PROCESS_CONTEXT *)hPCtxt;
 	DSP_STATUS status = DSP_SOK;
-	struct DMM_RSV_OBJECT *temp, *rsv_obj;
-
-	DRV_ProcFreeDMMRes(pCtxt);
-	pCtxt->dmm_map_list = NULL;
+	struct DMM_MAP_OBJECT *temp_map, *map_obj;
+	struct DMM_RSV_OBJECT *temp_rsv, *rsv_obj;
+
+	/* Free DMM mapped memory resources */
+	list_for_each_entry_safe(map_obj, temp_map, &pCtxt->dmm_map_list,
+			link) {
+		status = PROC_UnMap(pCtxt->hProcessor,
+				(void *)map_obj->dsp_addr, pCtxt);
+		if (DSP_FAILED(status))
+			pr_err("%s: PROC_UnMap failed!"
+					" status = 0x%xn", __func__, status);
+	}
 
 	/* Free DMM reserved memory resources */
-	list_for_each_entry_safe(rsv_obj, temp, &pCtxt->dmm_rsv_list, link) {
+	list_for_each_entry_safe(rsv_obj, temp_rsv, &pCtxt->dmm_rsv_list,
+			link) {
 		status = PROC_UnReserveMemory(pCtxt->hProcessor,
 				(void *)rsv_obj->dsp_reserved_addr, pCtxt);
 		if (DSP_FAILED(status))
@@ -325,37 +223,6 @@ DSP_STATUS DRV_RemoveAllDMMResElements(HANDLE hPCtxt)
 	return status;
 }
 
-DSP_STATUS DRV_GetDMMResElement(u32 pMapAddr, HANDLE hDMMRes, HANDLE hPCtxt)
-{
-	struct PROCESS_CONTEXT *pCtxt = (struct PROCESS_CONTEXT *)hPCtxt;
-	struct DMM_MAP_OBJECT **pDMMRes = (struct DMM_MAP_OBJECT **)hDMMRes;
-	DSP_STATUS status = DSP_SOK;
-	struct DMM_MAP_OBJECT *pTempDMM = NULL;
-
-	if (mutex_lock_interruptible(&pCtxt->dmm_map_mutex))
-		return DSP_EFAIL;
-
-	pTempDMM = pCtxt->dmm_map_list;
-	while (pTempDMM && (pTempDMM->ulDSPAddr != pMapAddr)) {
-		GT_3trace(curTrace, GT_ENTER,
-			 "DRV_GetDMMResElement: 2 pTempDMM:%x "
-			 "pTempDMM->ulDSPAddr:%x pMapAddr:%x\n", pTempDMM,
-			 pTempDMM->ulDSPAddr, pMapAddr);
-		pTempDMM = pTempDMM->next;
-	}
-
-	mutex_unlock(&pCtxt->dmm_map_mutex);
-
-	if (pTempDMM) {
-		GT_0trace(curTrace, GT_ENTER, "DRV_GetDMMResElement: 3");
-		*pDMMRes = pTempDMM;
-	} else {
-		status = DSP_ENOTFOUND;
-		GT_0trace(curTrace, GT_ENTER, "DRV_GetDMMResElement: 4");
-	}
-	return status;
-}
-
 /* Update Node allocation status */
 void DRV_ProcNodeUpdateStatus(HANDLE hNodeRes, s32 status)
 {
diff --git a/drivers/dsp/bridge/rmgr/drv_interface.c b/drivers/dsp/bridge/rmgr/drv_interface.c
index 80b8c7e..800ed61 100644
--- a/drivers/dsp/bridge/rmgr/drv_interface.c
+++ b/drivers/dsp/bridge/rmgr/drv_interface.c
@@ -499,7 +499,8 @@ static int bridge_open(struct inode *ip, struct file *filp)
 	pr_ctxt = MEM_Calloc(sizeof(struct PROCESS_CONTEXT), MEM_PAGED);
 	if (pr_ctxt) {
 		pr_ctxt->resState = PROC_RES_ALLOCATED;
-		mutex_init(&pr_ctxt->dmm_map_mutex);
+		spin_lock_init(&pr_ctxt->dmm_map_lock);
+		INIT_LIST_HEAD(&pr_ctxt->dmm_map_list);
 		spin_lock_init(&pr_ctxt->dmm_rsv_lock);
 		INIT_LIST_HEAD(&pr_ctxt->dmm_rsv_list);
 		mutex_init(&pr_ctxt->node_mutex);
diff --git a/drivers/dsp/bridge/rmgr/proc.c b/drivers/dsp/bridge/rmgr/proc.c
index b8e0334..5ddfff6 100644
--- a/drivers/dsp/bridge/rmgr/proc.c
+++ b/drivers/dsp/bridge/rmgr/proc.c
@@ -1286,8 +1286,7 @@ DSP_STATUS PROC_Map(DSP_HPROCESSOR hProcessor, void *pMpuAddr, u32 ulSize,
 	u32 sizeAlign;
 	DSP_STATUS status = DSP_SOK;
 	struct PROC_OBJECT *pProcObject = (struct PROC_OBJECT *)hProcessor;
-
-       HANDLE        dmmRes;
+	struct DMM_MAP_OBJECT *map_obj;
 
 	GT_6trace(PROC_DebugMask, GT_ENTER, "Entered PROC_Map, args:\n\t"
 		 "hProcessor %x, pMpuAddr %x, ulSize %x, pReqAddr %x, "
@@ -1334,11 +1333,22 @@ DSP_STATUS PROC_Map(DSP_HPROCESSOR hProcessor, void *pMpuAddr, u32 ulSize,
 	}
 	(void)SYNC_LeaveCS(hProcLock);
 
-	if (DSP_SUCCEEDED(status)) {
-		DRV_InsertDMMResElement(&dmmRes, pr_ctxt);
-		DRV_UpdateDMMResElement(dmmRes, (u32)pMpuAddr, ulSize,
-				(u32)pReqAddr, (u32)*ppMapAddr, hProcessor);
+	if (DSP_FAILED(status))
+		goto func_end;
+
+	/*
+	 * A successful map should be followed by insertion of map_obj
+	 * into dmm_map_list, so that mapped memory resource tracking
+	 * remains uptodate
+	 */
+	map_obj = kmalloc(sizeof(struct DMM_MAP_OBJECT), GFP_KERNEL);
+	if (map_obj) {
+		map_obj->dsp_addr = (u32)*ppMapAddr;
+		spin_lock(&pr_ctxt->dmm_map_lock);
+		list_add(&map_obj->link, &pr_ctxt->dmm_map_list);
+		spin_unlock(&pr_ctxt->dmm_map_lock);
 	}
+
 func_end:
 	GT_1trace(PROC_DebugMask, GT_ENTER, "Leaving PROC_Map [0x%x]", status);
 	return status;
@@ -1669,8 +1679,7 @@ DSP_STATUS PROC_UnMap(DSP_HPROCESSOR hProcessor, void *pMapAddr,
 	struct DMM_OBJECT *hDmmMgr;
 	u32 vaAlign;
 	u32 sizeAlign;
-
-	HANDLE	      dmmRes;
+	struct DMM_MAP_OBJECT *map_obj;
 
 	GT_2trace(PROC_DebugMask, GT_ENTER,
 		 "Entered PROC_UnMap, args:\n\thProcessor:"
@@ -1710,9 +1719,21 @@ DSP_STATUS PROC_UnMap(DSP_HPROCESSOR hProcessor, void *pMapAddr,
 	if (DSP_FAILED(status))
 		goto func_end;
 
-	if (DRV_GetDMMResElement((u32)pMapAddr, &dmmRes, pr_ctxt)
-							!= DSP_ENOTFOUND)
-		DRV_RemoveDMMResElement(dmmRes, pr_ctxt);
+	/*
+	 * A successful unmap should be followed by removal of map_obj
+	 * from dmm_map_list, so that mapped memory resource tracking
+	 * remains uptodate
+	 */
+	spin_lock(&pr_ctxt->dmm_map_lock);
+	list_for_each_entry(map_obj, &pr_ctxt->dmm_map_list, link) {
+		if (map_obj->dsp_addr == (u32)pMapAddr) {
+			list_del(&map_obj->link);
+			kfree(map_obj);
+			break;
+		}
+	}
+	spin_unlock(&pr_ctxt->dmm_map_lock);
+
 func_end:
 	GT_1trace(PROC_DebugMask, GT_ENTER,
 		 "Leaving PROC_UnMap [0x%x]", status);
-- 
1.6.3.3

